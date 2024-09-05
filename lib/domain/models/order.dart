import 'package:suhol_van_sales/domain/utils/easy_json.dart';

class Order {
  final String? enteredBy;
  final String? customerId;
  final String? paymentModeId;
  final String? parentMasterId;
  final String? approvedBy;
  final String? requestNo;
  final String? requestDate;
  final String? approvedDate;
  final String? receivedDate;
  final String? deliveryDate;
  final String? status;
  final String? prStatus;
  final String? remarks;
  final String? invoiceAmount;
  final String? discountAmount;
  final String? paidAmount;
  final String? balanceAmount;
  final String? cashMode;
  final String? customerVehicleNo;
  final String? customerName;
  final String? customerMobile;
  final String? mrCnt;
  final String? prefix;
  final String? sis;
  final String? print;

  const Order({
    this.enteredBy,
    this.customerId,
    this.paymentModeId,
    this.parentMasterId,
    this.approvedBy,
    this.requestNo,
    this.requestDate,
    this.approvedDate,
    this.receivedDate,
    this.deliveryDate,
    this.status,
    this.prStatus,
    this.remarks,
    this.invoiceAmount,
    this.discountAmount,
    this.paidAmount,
    this.balanceAmount,
    this.cashMode,
    this.customerVehicleNo,
    this.customerName,
    this.customerMobile,
    this.mrCnt,
    this.prefix,
    this.sis,
    this.print,
  });

  Order copyWith({
    String? enteredBy,
    String? customerId,
    String? paymentModeId,
    String? parentMasterId,
    String? approvedBy,
    String? requestNo,
    String? requestDate,
    String? approvedDate,
    String? receivedDate,
    String? deliveryDate,
    String? status,
    String? prStatus,
    String? remarks,
    String? invoiceAmount,
    String? discountAmount,
    String? paidAmount,
    String? balanceAmount,
    String? cashMode,
    String? customerVehicleNo,
    String? customerName,
    String? customerMobile,
    String? mrCnt,
    String? prefix,
    String? sis,
    String? print,
  }) =>
      Order(
        enteredBy: enteredBy ?? this.enteredBy,
        customerId: customerId ?? this.customerId,
        paymentModeId: paymentModeId ?? this.paymentModeId,
        parentMasterId: parentMasterId ?? this.parentMasterId,
        approvedBy: approvedBy ?? this.approvedBy,
        requestNo: requestNo ?? this.requestNo,
        requestDate: requestDate ?? this.requestDate,
        approvedDate: approvedDate ?? this.approvedDate,
        receivedDate: receivedDate ?? this.receivedDate,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        status: status ?? this.status,
        prStatus: prStatus ?? this.prStatus,
        remarks: remarks ?? this.remarks,
        invoiceAmount: invoiceAmount ?? this.invoiceAmount,
        discountAmount: discountAmount ?? this.discountAmount,
        paidAmount: paidAmount ?? this.paidAmount,
        balanceAmount: balanceAmount ?? this.balanceAmount,
        cashMode: cashMode ?? this.cashMode,
        customerVehicleNo: customerVehicleNo ?? this.customerVehicleNo,
        customerName: customerName ?? this.customerName,
        customerMobile: customerMobile ?? this.customerMobile,
        mrCnt: mrCnt ?? this.mrCnt,
        prefix: prefix ?? this.prefix,
        sis: sis ?? this.sis,
        print: print ?? this.print,
      );

  Map<String, dynamic> toJson() {
    return {
      "entered_by": this.enteredBy,
      "customer_id": this.customerId,
      "payment_mode_id": this.paymentModeId,
      "parent_master_id": this.parentMasterId,
      "approved_by": this.approvedBy,
      "request_no": this.requestNo,
      "request_date": this.requestDate,
      "approved_date": this.approvedDate,
      "received_date": this.receivedDate,
      "delivery_date": this.deliveryDate,
      "status": this.status,
      "pr_status": this.prStatus,
      "remarks": this.remarks,
      "invoice_amount": this.invoiceAmount,
      "discount_amount": this.discountAmount,
      "paid_amount": this.paidAmount,
      "balance_amount": this.balanceAmount,
      "cash_mode": this.cashMode,
      "customer_vehicle_no": this.customerVehicleNo,
      "customer_name": this.customerName,
      "customer_mobile": this.customerMobile,
      "mr_cnt": this.mrCnt,
      "prefix": this.prefix,
      "sis": this.sis,
      "print": this.print,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return EasyJson(const Order(), json)
        .retrieve(
          'entered_by',
          ifString: (value, model) => model.copyWith(enteredBy: value),
        )
        .retrieve(
          'customer_id',
          ifString: (value, model) => model.copyWith(customerId: value),
          ifInt: (value, model) => model.copyWith(customerId: value.toString()),
        )
        .retrieve(
          'payment_mode_id',
          ifString: (value, model) => model.copyWith(paymentModeId: value),
          ifInt: (value, model) =>
              model.copyWith(paymentModeId: value.toString()),
        )
        .retrieve(
          'parent_master_id',
          ifString: (value, model) => model.copyWith(parentMasterId: value),
          ifInt: (value, model) =>
              model.copyWith(parentMasterId: value.toString()),
        )
        .retrieve(
          'approved_by',
          ifString: (value, model) => model.copyWith(approvedBy: value),
        )
        .retrieve(
          'request_no',
          ifString: (value, model) => model.copyWith(requestNo: value),
          ifInt: (value, model) => model.copyWith(requestNo: value.toString()),
        )
        .retrieve(
          'request_date',
          ifString: (value, model) => model.copyWith(requestDate: value),
        )
        .retrieve(
          'approved_date',
          ifString: (value, model) => model.copyWith(approvedDate: value),
        )
        .retrieve(
          'received_date',
          ifString: (value, model) => model.copyWith(receivedDate: value),
        )
        .retrieve(
          'delivery_date',
          ifString: (value, model) => model.copyWith(deliveryDate: value),
        )
        .retrieve(
          'status',
          ifString: (value, model) => model.copyWith(status: value),
          ifBoolean: (value, model) => model.copyWith(status: value.toString()),
          ifInt: (value, model) => model.copyWith(status: value.toString()),
        )
        .retrieve(
          'pr_status',
          ifString: (value, model) => model.copyWith(prStatus: value),
          ifBoolean: (value, model) =>
              model.copyWith(prStatus: value.toString()),
          ifInt: (value, model) => model.copyWith(prStatus: value.toString()),
        )
        .retrieve(
          'remarks',
          ifString: (value, model) => model.copyWith(remarks: value),
        )
        .retrieve(
          'invoice_amount',
          ifString: (value, model) => model.copyWith(invoiceAmount: value),
          ifDouble: (value, model) =>
              model.copyWith(invoiceAmount: value.toString()),
        )
        .retrieve(
          'discount_amount',
          ifString: (value, model) => model.copyWith(discountAmount: value),
          ifDouble: (value, model) =>
              model.copyWith(discountAmount: value.toString()),
        )
        .retrieve(
          'paid_amount',
          ifString: (value, model) => model.copyWith(paidAmount: value),
          ifDouble: (value, model) =>
              model.copyWith(paidAmount: value.toString()),
        )
        .retrieve(
          'balance_amount',
          ifString: (value, model) => model.copyWith(balanceAmount: value),
          ifDouble: (value, model) =>
              model.copyWith(balanceAmount: value.toString()),
        )
        .retrieve(
          'cash_mode',
          ifString: (value, model) => model.copyWith(cashMode: value),
        )
        .retrieve(
          'customer_vehicle_no',
          ifString: (value, model) => model.copyWith(customerVehicleNo: value),
          ifInt: (value, model) =>
              model.copyWith(customerVehicleNo: value.toString()),
        )
        .retrieve(
          'customer_name',
          ifString: (value, model) => model.copyWith(customerName: value),
        )
        .retrieve(
          'customer_mobile',
          ifString: (value, model) => model.copyWith(customerMobile: value),
          ifInt: (value, model) =>
              model.copyWith(customerMobile: value.toString()),
        )
        .retrieve(
          'mr_cnt',
          ifString: (value, model) => model.copyWith(mrCnt: value),
        )
        .retrieve(
          'prefix',
          ifString: (value, model) => model.copyWith(prefix: value),
        )
        .retrieve(
          'sis',
          ifString: (value, model) => model.copyWith(sis: value),
        )
        .retrieve(
          'print',
          ifString: (value, model) => model.copyWith(print: value),
        )
        .done();
    return Order(
      enteredBy: json['entered_by'] as String,
      customerId: json['customer_id'] as String,
      paymentModeId: json['payment_mode_id'] as String,
      parentMasterId: json['parent_master_id'] as String,
      approvedBy: json['approved_by'] as String,
      requestNo: json['request_no'] as String,
      requestDate: json['request_date'] as String,
      approvedDate: json['approved_date'] as String,
      receivedDate: json['received_date'] as String,
      deliveryDate: json['delivery_date'] as String,
      status: json['status'] as String,
      prStatus: json['pr_status'] as String,
      remarks: json['remarks'] as String,
      invoiceAmount: json['invoice_amount'] as String,
      discountAmount: json['discount_amount'] as String,
      paidAmount: json['paid_amount'] as String,
      balanceAmount: json['balance_amount'] as String,
      cashMode: json['cash_mode'] as String,
      customerVehicleNo: json['customer_vehicle_no'] as String,
      customerName: json['customer_name'] as String,
      customerMobile: json['customer_mobile'] as String,
      mrCnt: json['mr_cnt'] as String,
      prefix: json['prefix'] as String,
      sis: json['sis'] as String,
      print: json['print'] as String,
    );
  }
}
