enum Routes {
  home("/home"),
  dashboard("/home/dashboard"),
  creditSalesOrder('/home/credit_sales_order'),
  cashSalesOrder('/home/cash_sales_order');

  final String name;
  const Routes(this.name);
}
