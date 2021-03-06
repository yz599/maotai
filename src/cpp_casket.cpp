#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;
using namespace arma;

/*
 * 1. aux_shortestpath  : 'shortestpath'
 * 2. cppsub_2007Wang   : 'trio'
 * 3. gradF             : 'matderiv'
 * 4. dat2centers       : 'dpmeans'
 * 5. cpp_sylvester &
 *    cpp_lyapunov
 */

///////////////////////////////////////////////////////////////////
// 1. aux_shortestpath
//////////////////// Sub Routine
LogicalMatrix isweird(NumericMatrix x){
  const int n = x.nrow();
  LogicalMatrix out(n,n);
  
  for (int i=0;i<n;i++){
    for (int j=0;j<n;j++){
      out(i,j) = ((x(i,j)==R_NegInf)||(x(i,j)==R_PosInf)||(NumericVector::is_na(x(i,j))));
    }
  }
  return out;
}
//////////////////// Main Routine
// [[Rcpp::export]]
Rcpp::NumericMatrix aux_shortestpath(NumericMatrix& wmat){
  // 3-1. get ready
  const int v = wmat.nrow();
  NumericMatrix dist(v,v);
  for (int i=0;i<v;i++){
    for (int j=0;j<v;j++){
      dist(i,j) = R_PosInf;
    }
  }
  // 3-2. initialization
  LogicalMatrix checker = isweird(wmat);
  
  // 3-3. Floyd-Warshall algorithm
  // 3-3-1. vertex
  for (int i=0;i<v;i++){
    dist(i,i) = 0;
  }
  // 3-3-2. edge list
  for (int i=0;i<v;i++){
    for (int j=0;j<v;j++){
      if (checker(i,j)==false){
        dist(i,j) = wmat(i,j);
      }
    }
  }
  // 3-3-3. main iteration
  for (int k=0;k<v;k++){
    for (int i=0;i<v;i++){
      for (int j=0;j<v;j++){
        if (dist(i,j)>(dist(i,k)+dist(k,j))){
          dist(i,j)=dist(i,k)+dist(k,j);
        }
      }
    }
  }
  
  // 3-4. return output
  return(dist);
}

///////////////////////////////////////////////////////////////////
// 2. cppsub_2007Wang
// [[Rcpp::export]]
arma::mat cppsub_2007Wang(arma::mat V0, int mm, int d, arma::mat Spu, arma::mat Stu, int maxiter, double eps){
  // 1. preliminary setup
  double abstol = std::sqrt((static_cast<double>(mm*d))*eps);
  
  arma::mat Vold = V0;
  arma::mat Vnew(mm,d,fill::zeros);
  
  double lbdn = 0.0;
  double incV = 0.0;
  
  arma::vec Vval(mm,fill::zeros);
  arma::mat Vvec(mm,mm,fill::zeros);
  arma::mat Vtmp(mm,d,fill::zeros);
  
  arma::mat Stv(mm,mm,fill::zeros);
  
  // 2. do the iteration
  for (int i=0;i<maxiter;i++){
    // 2-1. compute the lambda
    lbdn = arma::trace(Vold.t()*Spu*Vold)/arma::trace(Vold.t()*Stu*Vold);
    // 2-2. solve the eigenvalue problem
    eig_sym(Vval,Vvec,(Spu-(lbdn*Stu)));
    // 2-3. extract Vtmp
    Vtmp = Vvec.tail_cols(d);
    // 2-4. update by readjusting
    Stv  = Vtmp*Vtmp.t()*Stu*Vtmp*Vtmp.t();
    eig_sym(Vval,Vvec,Stv);
    Vnew = Vvec.tail_cols(d);
    // 2-5. updating info and update
    incV = arma::norm(Vold-Vnew,"fro");
    Vold = Vnew;
    // 2-6. stop if the criterion is met
    if (incV < abstol){
      break;
    }
    // no need to print; Rcpp::Rcout << "* iteration " << i+1 << " complete.." << std::endl;
  }
  
  // 3. return the value
  return(Vold);
}

///////////////////////////////////////////////////////////////////
// 3. gradF
// [[Rcpp::export]]
arma::mat gradF(Function func, arma::mat xnow, double h){
  int m = xnow.n_rows;
  int n = xnow.n_cols;
  arma::mat dX(m,n,fill::zeros);
  arma::mat Xp = xnow;
  arma::mat Xm = xnow;
  for (int i=0;i<m;i++){
    for (int j=0;j<n;j++){
      Xp(i,j) = Xp(i,j) + h;
      Xm(i,j) = Xm(i,j) - h;
      dX(i,j) = (sum(as<NumericVector>(func(Xp)))- sum(as<NumericVector>(func(Xm))))/(2.0*h);
      Xp(i,j) = Xp(i,j) - h;
      Xm(i,j) = Xm(i,j) + h;
    }
  }
  
  return(dX);
}

///////////////////////////////////////////////////////////////////
// 4. dat2centers
// [[Rcpp::export]]
arma::vec dat2centers(arma::rowvec data, arma::mat &centers){
  // parameters
  int K = centers.n_rows;
  int p = data.n_cols;
  
  // compute
  arma::vec dic(K,fill::zeros);
  arma::rowvec diffvec(p,fill::zeros);
  for (int k=0;k<K;k++){
    diffvec = data-centers.row(k);
    dic(k)  = arma::dot(diffvec,diffvec);
  }
  
  // report
  return(dic);
}

///////////////////////////////////////////////////////////////////
// 5. cpp_sylvester & cpp_lyapunov
// [[Rcpp::export]]
arma::mat cpp_sylvester(arma::mat A, arma::mat B, arma::mat C){
  arma::mat solution;
  arma::syl(solution,A,B,C);
  return(solution);
}

// [[Rcpp::export]]
arma::mat solve_lyapunov(arma::mat A, arma::mat B, arma::mat C){
  // simply solve it !
  arma::mat solution;
  arma::syl(solution, A, B, C);
  return(solution);
}