enum Routes {
  home("/home"),
  dashboard("/home/dashboard"),
  creditSalesOrder('/home/credit_sales_order'),
  cashSalesOrder('/home/cash_sales_order'),
  createCreditOrder("/create_credit_order"),
  createCashOrder("/create_cash_order"),
  preorder("/pre_order"),
  createPreorder("/create_pre_order"),
  mrorder("/mr_order"),
  createMrorder("/create_mr_order"),
  signup("/sign_up");

  final String name;
  const Routes(this.name);
}
