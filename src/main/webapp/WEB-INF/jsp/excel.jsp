<head>

<script type="text/ecmascript" src="/js/jquery/jquery.min.js"></script>

<script type="text/ecmascript" src="/js/jquery/trirand/src/jquery.jqGrid.js"></script>

<script type="text/ecmascript" src="/js/jquery/i18n/grid.locale-en.js"></script>

<script type="text/javascript" src="/js/jquery/jszip.min.js"></script>

<link rel="stylesheet" type="text/css" href="/js/jquery/jquery-ui.css">

<link rel="stylesheet" type="text/css"	href="/js/jquery/ui.jqgrid.min.css">
</head>
<body>


    <table id="jqGrid"></table>
	<button id="export">Export to Excel</button>
	

	
  
	    <script type="text/javascript"> 
    
        $(document).ready(function () {
            $("#jqGrid").jqGrid({
                url: '/data.json',
                datatype: "json",
                colModel: [
					{ label: 'Category Name', name: 'CategoryName', width: 75 },
					{ label: 'Product Name', name: 'ProductName', width: 90 },
					{ label: 'Country', name: 'Country', width: 100 },
					{ label: 'Price', 
						name: 'Price', 
						width: 80, 
						sorttype: 'number', 
						//formatter: 'number',
						align: 'right'
					},
					{ label: 'Quantity', name: 'Quantity', width: 80, sorttype: 'integer' }                   
                ],
				loadonce: true,
				viewrecords: true,
                footerrow: true,
                userDataOnFooter: true, // use the userData parameter of the JSON response to display data on footer
                width: 780,
                height: 200,
                rowNum: 150
            });
			
			$("#export").on("click", function(){
				$("#jqGrid").jqGrid("exportToExcel",{
					includeLabels : true,
					includeGroupHeader : true,
					includeFooter: true,
					fileName : "jqGridExport.xlsx",
					maxlength : 40 // maxlength for visible string data 
				})
			})
        });

    </script>
    
</body>
</html>
