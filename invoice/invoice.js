var comapnyJSON={
  CompanyName:'Glifico',
  CompanyGSTIN:'37B76C238B7E1Z5',
  CompanyState:'Italy',
  CompanyAddressLine1:'ABCDEFGD HOUSE,IX/642-D',
  companyEmail:'info@glifico.com',
  companyPhone:'+3900000000000',
};

var customer_BillingInfoJSON={
  CustomerName:'Jhon Appleseed',
  CustomerGSTIN:'37B76C238B7E1Z5',
  CustomerState:'KERALA (09)',
  CustomerPAN:'B76C238B7E',
  CustomerAddressLine1:'ABCDEFGD HOUSE,IX/642-D',
  CustomerAddressLine2:'ABCDEFGD P.O., NEDUMBASSERY',
  CustomerAddressLine3:'COCHIN',
  PIN: '683584',
  CustomerEmail:'abcd@gmail.com',
  CustomerPhone:'+918189457845',
};


var invoiceJSON={
  InvoiceNo:'INV-120152',
  InvoiceDate:'03-12-2017',
  RefNo:'REF-78445',
  TotalAmnt:'Rs.1,24,200',
  SubTotalAmnt:'Rs.1,04,200',
  TotalGST:'Rs.2,0000',
  TotalCGST:'Rs.1,0000',
  TotalSGST:'Rs.1,0000',
  TotalIGST:'Rs.0',
  TotalCESS:'Rs.0',
}

var company_logo = {
  // src1:''
  // src:'data:image/jpeg;base64,'
  // w: 80,
  // h: 50
};

var fontSizes={
  HeadTitleFontSize:18,
  Head2TitleFontSize:16,
  TitleFontSize:14,
  SubTitleFontSize:12,
  NormalFontSize:10,
  SmallFontSize:8
};

var lineSpacing={
  NormalSpacing:12,
};

function generate_cutomPDF() {

  var doc = new jsPDF('p', 'pt');

  var rightStartCol1=400;
  var rightStartCol2=480;


  var InitialstartX=40;
  var startX=40;
  var InitialstartY=50;
  var startY=0;

  var lineHeights=12;

  doc.setFontSize(fontSizes.SubTitleFontSize);
  doc.setFont('times');
  doc.setFontType('bold');

  //pdf.addImage(agency_logo.src, 'PNG', logo_sizes.centered_x, _y, logo_sizes.w, logo_sizes.h);
  //doc.addImage(company_logo.src, 'PNG', startX,startY+=50, company_logo.w,company_logo.h);


  //  doc.textAlign(comapnyJSON.CompanyName, {align: "left"}, startX, startY+=15+company_logo.h);
  doc.textAlign(comapnyJSON.CompanyName, {align: "left"}, startX, startY+=150);

  doc.setFontSize(fontSizes.NormalFontSize);
  doc.textAlign("GSTIN", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  // var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;
  doc.textAlign(comapnyJSON.CompanyGSTIN, {align: "left"}, 80, startY);

  doc.setFontType('bold');
  doc.textAlign("STATE", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(comapnyJSON.CompanyState, {align: "left"}, 80, startY);


  // doc.setFontType('bold');
  // doc.textAlign("Address", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  // doc.setFontType('normal');
  // doc.textAlign(comapnyJSON.CompanyAddressLine1, {align: "left"}, 80, startY);
  // doc.textAlign(comapnyJSON.CompanyAddressLine2, {align: "left"}, 80, startY+=lineSpacing.NormalSpacing);
  // doc.textAlign(comapnyJSON.CompanyAddressLine3, {align: "left"}, 80, startY+=lineSpacing.NormalSpacing);



  doc.setFontType('bold');
  doc.textAlign("EMAIL", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(comapnyJSON.companyEmail, {align: "left"}, 80, startY);

  doc.setFontType('bold');
  doc.textAlign("Phone: ", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(comapnyJSON.companyPhone, {align: "left"}, 80, startY);

  var tempY=InitialstartY;


  doc.setFontType('bold');
  doc.textAlign("INVOICE NO: ", {align: "left"},  rightStartCol1, tempY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(invoiceJSON.InvoiceNo, {align: "left"}, rightStartCol2, tempY);


  doc.setFontType('bold');
  doc.textAlign("INVOICE Date: ", {align: "left"},  rightStartCol1, tempY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(invoiceJSON.InvoiceDate, {align: "left"}, rightStartCol2, tempY);

  doc.setFontType('bold');
  doc.textAlign("Reference No: ", {align: "left"},  rightStartCol1, tempY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(invoiceJSON.RefNo, {align: "left"}, rightStartCol2, tempY);

  doc.setFontType('bold');
  doc.textAlign("Total: ", {align: "left"},  rightStartCol1, tempY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(invoiceJSON.TotalAmnt, {align: "left"}, rightStartCol2, tempY);
  // doc.writeText(0, tempY+=lineSpacing.NormalSpacing ,"INVOICE No  :  "+invoiceJSON.InvoiceNo + '     ', { align: 'right' });
  // doc.writeText(0, tempY+=lineSpacing.NormalSpacing ,"INVOICE Date: "+invoiceJSON.InvoiceDate + '     ', { align: 'right' });
  // doc.writeText(0, tempY+=lineSpacing.NormalSpacing ,"Reference No: "+invoiceJSON.RefNo + '     ', { align: 'right' });
  // doc.writeText(0, tempY+=lineSpacing.NormalSpacing ,"Total       :  Rs. "+invoiceJSON.TotalAmnt + '     ', { align: 'right' });

  doc.setFontType('normal');

  doc.setLineWidth(1);
  // doc.line(20, startY+lineSpacing.NormalSpacing, 580, startY+=lineSpacing.NormalSpacing);
  doc.line(20, startY+lineSpacing.NormalSpacing, 220, startY+lineSpacing.NormalSpacing);
  doc.line(380, startY+lineSpacing.NormalSpacing, 580, startY+lineSpacing.NormalSpacing);

  doc.setFontSize(fontSizes.Head2TitleFontSize);
  doc.setFontType('bold');
  doc.textAlign("TAX INVOICE", {align: "center"}, startX, startY+=lineSpacing.NormalSpacing+2);

  doc.setFontSize(fontSizes.NormalFontSize);
  doc.setFontType('bold');

  //-------Customer Info Billing---------------------
  var startBilling=startY;

  doc.textAlign("Billing Address,", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.textAlign(customer_BillingInfoJSON.CustomerName, {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontSize(fontSizes.NormalFontSize);
  doc.textAlign("GSTIN", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  // var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;
  doc.textAlign(customer_BillingInfoJSON.CustomerGSTIN, {align: "left"}, 80, startY);


  // doc.setFontType('bold');
  // doc.textAlign("PAN", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  // doc.setFontType('normal');
  // doc.textAlign(customer_BillingInfoJSON.CustomerPAN, {align: "left"}, 80, startY);

  doc.setFontType('bold');
  doc.textAlign("Address", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(customer_BillingInfoJSON.CustomerAddressLine1, {align: "left"}, 80, startY);
  doc.textAlign(customer_BillingInfoJSON.CustomerAddressLine2, {align: "left"}, 80, startY+=lineSpacing.NormalSpacing);
  doc.textAlign(customer_BillingInfoJSON.CustomerAddressLine3, {align: "left"}, 80, startY+=lineSpacing.NormalSpacing);

  doc.setFontType('bold');
  doc.textAlign("STATE", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(customer_BillingInfoJSON.CustomerState, {align: "left"}, 80, startY);

  doc.setFontType('bold');
  doc.textAlign("PIN", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(customer_BillingInfoJSON.PIN, {align: "left"}, 80, startY);

  doc.setFontType('bold');
  doc.textAlign("EMAIL", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(customer_BillingInfoJSON.CustomerEmail, {align: "left"}, 80, startY);

  doc.setFontType('bold');
  doc.textAlign("Phone: ", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  doc.textAlign(customer_BillingInfoJSON.CustomerPhone, {align: "left"}, 80, startY);





  var header = function(data) {
    doc.setFontSize(8);
    doc.setTextColor(40);
    doc.setFontStyle('normal');
    // doc.textAlign("TAX INVOICE", {align: "center"}, data.settings.margin.left, 50);

    //doc.addImage(headerImgData, 'JPEG', data.settings.margin.left, 20, 50, 50);
    // doc.text("Testing Report", 110, 50);
  };
  // doc.autoTable(res.columns, res.data, {margin: {top:  startY+=30}});
  doc.setFontSize(8);
  doc.setFontStyle('normal');

  var options = {
    beforePageContent: header,
    margin: {
      top: 50
    },
    styles: {
      overflow: 'linebreak',
      fontSize: 8,
      rowHeight: 'auto',
      columnWidth: 'wrap'
    },
    columnStyles: {
      1: {columnWidth: 'auto'},
      2: {columnWidth: 'auto'},
      3: {columnWidth: 'auto'},
      4: {columnWidth: 'auto'},
      5: {columnWidth: 'auto'},
      6: {columnWidth: 'auto'},
    },
    startY: startY+=50
  };

  var columns = [
    {title: "ID", dataKey: "id",width: 90},
    {title: "Product", dataKey: "Product",width: 40},
    {title: "Rate/Item", dataKey: "Rate/Item",width: 40},
    {title: "Qty", dataKey: "Qty",width: 40},
    {title: "Dsnt", dataKey: "Dsnt",width: 40},
    {title: "S.Total", dataKey: "STotal",width: 40},
    {title: "CGST", dataKey: "CGST",width: 40},
    {title: "SGST", dataKey: "SGST",width: 40},
    {title: "IGST", dataKey: "IGST",width: 40},
    {title: "CESS", dataKey: "CESS",width: 40},
    {title: "Total", dataKey: "Total",width: 40},
  ];
  var rows = [
    {"id": 1, "Product": "Translation", "Rate/Item": "10","Qty" : "1","Dsnt":"0","STotal":"10","CGST":20,"SGST":20,"IGST":0,"CESS":20,"Total":10},

  ];

  // columnStyles: {
  //   id: {fillColor: 255}
  // },

  doc.autoTable(columns, rows, options);   //From dynamic data.
  // doc.autoTable(res.columns, res.data, options); //From htmlTable



  //-------Invoice Footer---------------------
  var rightcol1=340;
  var rightcol2=430;

  startY=doc.autoTableEndPosY()+30;
  doc.setFontSize(fontSizes.NormalFontSize);

  doc.setFontType('bold');
  doc.textAlign("Sub Total,", {align: "left"}, rightcol1, startY+=lineSpacing.NormalSpacing);
  doc.textAlign(invoiceJSON.SubTotalAmnt, {align: "left"}, rightcol2, startY);
  doc.setFontSize(fontSizes.NormalFontSize);
  doc.setFontType('bold');
  doc.textAlign("CGST Rs.", {align: "left"}, rightcol1, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  // var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;
  doc.textAlign(invoiceJSON.TotalCGST, {align: "left"},rightcol2, startY);


  doc.setFontType('bold');
  doc.textAlign("SGST Rs.", {align: "left"}, rightcol1, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  // var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;
  doc.textAlign(invoiceJSON.TotalSGST, {align: "left"},rightcol2, startY);

  doc.setFontType('bold');
  doc.textAlign("IGST Rs.", {align: "left"}, rightcol1, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  // var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;
  doc.textAlign(invoiceJSON.TotalIGST, {align: "left"},rightcol2, startY);


  doc.setFontType('bold');
  doc.textAlign("CESS Rs.", {align: "left"}, rightcol1, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  // var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;
  doc.textAlign(invoiceJSON.TotalCESS, {align: "left"},rightcol2, startY);

  doc.setFontType('bold');
  doc.textAlign("Total GST Rs.", {align: "left"}, rightcol1, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  // var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;
  doc.textAlign(invoiceJSON.TotalGST, {align: "left"},rightcol2, startY);


  doc.setFontType('bold');
  doc.textAlign("Grand Total Rs.", {align: "left"}, rightcol1, startY+=lineSpacing.NormalSpacing);
  doc.setFontType('normal');
  // var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;
  doc.textAlign(invoiceJSON.TotalAmnt, {align: "left"},rightcol2, startY);
  doc.setFontType('bold');
  doc.textAlign('For '+comapnyJSON.CompanyName+',', {align: "center"},rightcol2, startY+=lineSpacing.NormalSpacing+50);
  doc.textAlign('Authorised Signatory', {align: "center"},rightcol2, startY+=lineSpacing.NormalSpacing+50);

  doc.save("invoice.pdf");
}