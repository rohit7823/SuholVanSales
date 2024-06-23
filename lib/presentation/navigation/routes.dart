enum Routes {
  home("/home"),
  dashboard("/home/dashboard"),
  creditSalesOrder('/home/credit_sales_order'),
  cashSalesOrder('/home/cash_sales_order'),
  createCreditOrder("/create_credit_order"),
  createCashOrder("/create_cash_order"),
  signup("/sign_up");

  final String name;
  const Routes(this.name);
}
