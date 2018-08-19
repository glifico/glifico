var comapnyJSON={
		CompanyName:'Glifico',
		//VAT
		CompanyGSTIN:'IT0000000000',
		CompanyState:'Italy',
		CompanyAddressLine1:'ABCDEFGD HOUSE,IX/642-D',
		companyEmail:'info@glifico.com',
		companyPhone:'+3900000000000',
};

var customer_BillingInfoJSON={
		CustomerName:'Jhon Appleseed',
		CustomerGSTIN:'...',
		CustomerState:'...',
		CustomerPAN:'123',
		CustomerAddressLine1:'...',
		CustomerAddressLine2:'...',
		CustomerAddressLine3:'...',
		CustomerEmail:'abcd@xxx.com',
		CustomerPhone:'+918189457845',
};


var invoiceJSON={
		InvoiceNo:'INV-XXXXXX',
		InvoiceDate:'00-00-2000',
		TotalAmnt:'-1',
		SubTotalAmnt:'-1',
		InvoiceProduct:'translation'
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

getData= function(id, job, description, date, price) {
	var url = "getAgencyData.php?user="+getUsername()+"&token="+getToken();

	params={}

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText)[0];
			params={
				costumer:{
					CustomerName:data.CompanyName,
					CustomerGSTIN:'',
					CustomerState:data.Country,
					CustomerPAN:'',
					CustomerAddressLine1:data.City,
					CustomerAddressLine2:data.Street,
					CustomerAddressLine3:data.ZIP,
					CustomerEmail:data.EmailReferenceBilling,
					CustomerPhone:''
				},
				invoice:{
					InvoiceNo:id.toString(),
					InvoiceProduct: job,
					InvoiceDate: date.toString().slice(0,11),
					TotalAmnt: price.toString()+"Euro",
					SubTotalAmnt: price.toString()+"Euro",
				}
			}

			create_customPDF(params);
			
		}else{
			mostraDialogTimed('Error getting info from service');
		}
	}
	
	req.open("GET",url,true);
	req.send();
		
}

function generate_cutomPDF(id) {
	//GET info job
	var url = "getInvoiceData.php?id="+id+"&user="+getUsername()+"&token="+getToken();
	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			getData(data.id, data.Job, data.Description, data.Date, data.Price)	
		}
	}
	
	req.open("GET",url,true);
	req.send();
}

function create_customPDF(params){
	
	customer_BillingInfoJSON =  params.costumer;
	invoiceJSON = params.invoice;

	var doc = new jsPDF('p', 'pt');

	console.debug("jsPDFcreated")

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
	doc.textAlign("IVA", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
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
	doc.textAlign("VAT", {align: "left"}, startX, startY+=lineSpacing.NormalSpacing);
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
				4: {columnWidth: 'auto'}
			},
			startY: startY+=50
	};

	var columns = [
		{title: "ID", dataKey: "id",width: 100},
		{title: "Product", dataKey: "Product",width: 500},
		{title: "Qty", dataKey: "Qty",width: 200},
		{title: "Total", dataKey: "Total",width: 100},
		];
	
	var rows = [
		{"id": 1, "Product": invoiceJSON.InvoiceProduct, "Qty" : "1", "Total": invoiceJSON.SubTotalAmnt},
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

//	doc.setFontType('bold');
//	doc.textAlign("Sub Total,", {align: "left"}, rightcol1, startY+=lineSpacing.NormalSpacing);
//	doc.textAlign(invoiceJSON.SubTotalAmnt, {align: "left"}, rightcol2, startY);
//	doc.setFontSize(fontSizes.NormalFontSize);
//	doc.setFontType('normal');
	// var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;


	doc.setFontType('bold');
	doc.textAlign("Total: ", {align: "left"}, rightcol1, startY+=lineSpacing.NormalSpacing);
	doc.textAlign(invoiceJSON.SubTotalAmnt, {align: "left"}, rightcol2, startY);
	doc.setFontSize(fontSizes.NormalFontSize);
	doc.setFontType('normal');
	// var w = doc.getStringUnitWidth('GSTIN') * NormalFontSize;

	doc.save("Glifico_invoice.pdf");
}