

#shinyserver start point2----
shinyServer(function(input, output,session) {
  
  
  
  #preview--------------
  #读取文件
  var_file_expInfo = tsui::var_file(id = 'file_expInfo')
  
  shiny::observeEvent(input$btn_preview,{
    
    #code here
    #begin
    print(input$btn_preview)
    #获取文件名
    file_name = var_file_expInfo()
    # library(readxl)
    #读取excel
    data <- readxl::read_excel(file_name)
    # print(data)
    #显示列表
    tsui::run_dataTable2(id = 'dt_expInfo',data = data)
    #上传服务器
    tsda::db_writeTable2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',table_name = 'RDS_JH_ExportDeclaration',r_object = data,append = TRUE)
    #  
    #insert 
    sql_insert = "
       INSERT  INTO RDS_JH_ODS_ExportDeclaration 
			select  F_QH_DECLARATIONNUMBER,
			  FCONTRACTNO, F_QH_EXPORTDATE ,FBILLNO ,FDATE 
			from  
			( select F_QH_DECLARATIONNUMBER,LTRIM(substring(FCONTRACTNO,0,CHARINDEX('&',FCONTRACTNO)) )   as FCONTRACTNO
		    ,F_QH_EXPORTDATE,FBILLNO
		    ,getdate() as FDATE
		    from RDS_JH_ExportDeclaration  where FCONTRACTNO like  '%&%'
		    union
		    select F_QH_DECLARATIONNUMBER ,
		    LTRIM(substring(FCONTRACTNO,CHARINDEX('&',FCONTRACTNO)+1,len(FCONTRACTNO)-CHARINDEX('&',FCONTRACTNO)))   as FCONTRACTNO
		    ,F_QH_EXPORTDATE,FBILLNO,getdate() as FDATE
		    from RDS_JH_ExportDeclaration  where FCONTRACTNO like  '%&%'
		    union
		    SELECT 
		  	F_QH_DECLARATIONNUMBER,
			FCONTRACTNO,
		  	F_QH_EXPORTDATE	,FBILLNO ,getdate() as FDATE
		    FROM RDS_JH_ExportDeclaration
		  	where FCONTRACTNO not like  '%&%' or FCONTRACTNO is null  )   A
			WHERE NOT EXISTS  
			(SELECT F_QH_DECLARATIONNUMBER,
			  FCONTRACTNO,
		  	  F_QH_EXPORTDATE ,FBILLNO ,FDATE 
			 FROM  RDS_JH_ODS_ExportDeclaration B
			 WHERE  A.F_QH_DECLARATIONNUMBER = B.F_QH_DECLARATIONNUMBER
			  AND A.FCONTRACTNO = B.FCONTRACTNO
		  	  AND A.F_QH_EXPORTDATE = B.F_QH_EXPORTDATE
			  	   )
             "
    tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql_str = sql_insert)
    
   
    
    #end
    
  })
  #end of preview---------
 
  shiny::observeEvent(input$btn_truncate,{
    
    #code here
    #begin
    #truncate 
    sql_truncate =" TRUNCATE TABLE RDS_JH_ExportDeclaration  
          "
    tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql = sql_truncate)
    #truncate2 
    sql_truncate2 =" TRUNCATE TABLE RDS_JH_ODS_ExportDeclaration  
          "
    tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql = sql_truncate2)
    })
  
  #update_erp--------
  
  shiny::observeEvent(input$btn_update,{
    
    #code here
    #begin
    sql =" SELECT 
      			F_QH_DECLARATIONNUMBER,
      			FCONTRACTNO,
      			F_QH_EXPORTDATE,
      			FBILLNO
      			FROM RDS_JH_ExportDeclaration 
          "
    data = tsda::sql_select2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql = sql)
    print(data)
   
   
    
   
    #update age1
    
    sql_update1 = "
                 UPDATE  A SET A.F_QH_EXPORTDATE = B.F_QH_EXPORTDATE,
            			A.F_QH_DECLARATIONNUMBER = 	B.F_QH_DECLARATIONNUMBER			
            			FROM T_SAL_OUTSTOCK  A
            			INNER JOIN  RDS_JH_ODS_ExportDeclaration   B
            			ON  A.FCONTRACTNO = B.FCONTRACTNO 
            			AND A.FBILLNO = B.FBILLNO
            			and A.FCONTRACTNO <> ' '
					      	WHERE B.FBILLNO IS not NULL
						      
                 "
    tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql_str = sql_update1)
    
    #end
    
    #update age
    
    sql_update = "
                     UPDATE A  SET A.F_QH_EXPORTDATE = B.F_QH_EXPORTDATE,
              			A.F_QH_DECLARATIONNUMBER = B.F_QH_DECLARATIONNUMBER
              			FROM T_SAL_OUTSTOCK A
              			INNER JOIN  RDS_JH_ODS_ExportDeclaration B
              			ON  A.FCONTRACTNO = B.FCONTRACTNO
              			WHERE B.FBILLNO IS  NULL
              			OR  B.FBILLNO = ' '	
                 "
    tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql_str = sql_update)
    
    tsui::pop_notice('更新已成功')
    
    #end
    
    
  })
  
  #end of update erp-----
  
  
  
  
  
})
