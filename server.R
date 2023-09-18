

#shinyserver start point2----
shinyServer(function(input, output,session) {
  
  
  
  #preview--------------
  #读取文件
  var_file_expInfo = tsui::var_file(id = 'file_expInfo')
  
  shiny::observeEvent(input$btn_preview,{
    #预览----------------------
    #code here
    #begin
    #print(input$btn_preview)
    #获取文件名-----------------
    
    file_name = var_file_expInfo()
    # library(readxl)
    #读取excel------------------------------
    data <- readxl::read_excel(file_name)
    # print(data)
    #显示列表-----------------
    tsui::run_dataTable2(id = 'dt_expInfo',data = data)
    
    
    
    
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
    tsui::pop_notice("清除完成")
  })
  
  #update_erp--------
  
  shiny::observeEvent(input$btn_update,{
    
    file_name = var_file_expInfo()
    # library(readxl)
    #读取excel------------------------------
    data <- readxl::read_excel(file_name)
    #上传服务器----------------
    #src表：RDS_JH_ExportDeclaration-----------
    tsda::db_writeTable2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',table_name = 'RDS_JH_ExportDeclaration',r_object = data,append = TRUE)
    #
    #insert
    #把src表插入ods表---------------
    
    #添加了日期字段，对合同号字段进行了处理
    #新加的字段放在FBILLNO后面
    sql_insert = "
       INSERT  INTO RDS_JH_ODS_ExportDeclaration
			select
			FBILLNO,F_QH_DECLARATIONNUMBER,F_QH_DECLARATIONNUMBER1,F_QH_EXPORTDATE,F_NLJ_CJFS,F_NLJ_CJBZ,F_NLJ_WBJE,F_NLJ_WBHL, FDATE
			from (
			select
			F_QH_DECLARATIONNUMBER,LTRIM(substring(F_QH_DECLARATIONNUMBER1,0,CHARINDEX('&',F_QH_DECLARATIONNUMBER1)) )
			as F_QH_DECLARATIONNUMBER1,F_QH_EXPORTDATE,FBILLNO,F_NLJ_CJFS,F_NLJ_CJBZ,F_NLJ_WBJE,F_NLJ_WBHL
		    ,getdate() as FDATE
		    from RDS_JH_ExportDeclaration  where F_QH_DECLARATIONNUMBER1 like  '%&%'

		    union

		    select
		    F_QH_DECLARATIONNUMBER,LTRIM(substring(F_QH_DECLARATIONNUMBER1,CHARINDEX('&',F_QH_DECLARATIONNUMBER1)+1,len(F_QH_DECLARATIONNUMBER1)-CHARINDEX('&',F_QH_DECLARATIONNUMBER1)))
		    as F_QH_DECLARATIONNUMBER1,F_QH_EXPORTDATE,FBILLNO,F_NLJ_CJFS,F_NLJ_CJBZ,F_NLJ_WBJE,F_NLJ_WBHL,getdate() as FDATE
		    from RDS_JH_ExportDeclaration  where F_QH_DECLARATIONNUMBER1 like  '%&%'

		    union

		    SELECT
		  	F_QH_DECLARATIONNUMBER,
			F_QH_DECLARATIONNUMBER1,
		  	F_QH_EXPORTDATE	,FBILLNO ,F_NLJ_CJFS,F_NLJ_CJBZ,F_NLJ_WBJE,F_NLJ_WBHL,getdate() as FDATE
		    FROM RDS_JH_ExportDeclaration
		  	where F_QH_DECLARATIONNUMBER1 not like  '%&%' or F_QH_DECLARATIONNUMBER1 is null

		  	) A
		  	WHERE NOT EXISTS (
		  	SELECT F_QH_DECLARATIONNUMBER,F_QH_DECLARATIONNUMBER1,F_QH_EXPORTDATE ,FBILLNO,F_NLJ_CJFS,F_NLJ_CJBZ,F_NLJ_WBJE,F_NLJ_WBHL ,FDATE
			 FROM  RDS_JH_ODS_ExportDeclaration B
			 WHERE
			 A.F_QH_DECLARATIONNUMBER = B.F_QH_DECLARATIONNUMBER
			 AND A.F_QH_DECLARATIONNUMBER1 = B.F_QH_DECLARATIONNUMBER1
		   AND A.F_QH_EXPORTDATE = B.F_QH_EXPORTDATE
		   AND A.FBILLNO=B.FBILLNO)"
    tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql_str = sql_insert)
    
    
    
    #end
    
    #code here
    #begin
    # sql =" SELECT 
    #   			F_QH_DECLARATIONNUMBER,
    #   			F_QH_DECLARATIONNUMBER1,
    #   			F_QH_EXPORTDATE,
    #   			FBILLNO
    #   			FROM RDS_JH_ExportDeclaration 
    #       "
    # data = tsda::sql_select2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql = sql)
    # print(data)
    
    
    #update age
    
    sql_update0 = "UPDATE  
    A SET A.F_QH_EXPORTDATE = B.F_QH_EXPORTDATE,     
    A.F_QH_DECLARATIONNUMBER =  B.F_QH_DECLARATIONNUMBER ,
    A.F_QH_DECLARATIONNUMBER1 = B.F_QH_DECLARATIONNUMBER1,
		        A.F_NLJ_CJFS=B.F_NLJ_CJFS,  A.F_NLJ_CJBZ=B.F_NLJ_CJBZ,
		        A.F_NLJ_WBJE=B.F_NLJ_WBJE,A.F_NLJ_WBHL=B.F_NLJ_WBHL
                    FROM T_SAL_OUTSTOCK  A    
                    INNER JOIN  RDS_JH_ODS_ExportDeclaration   B    
                    ON   A.FBILLNO = B.FBILLNO  
                 "
    tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql_str = sql_update0)
    sql_update1="UPDATE A  SET A.F_QH_EXPORTDATE = B.F_QH_EXPORTDATE,    
    A.F_QH_DECLARATIONNUMBER = B.F_QH_DECLARATIONNUMBER   ,
		            A.F_NLJ_CJFS=B.F_NLJ_CJFS,		
		            A.F_NLJ_CJBZ=B.F_NLJ_CJBZ,A.F_NLJ_WBJE=B.F_NLJ_WBJE,		
		            A.F_NLJ_WBHL=B.F_NLJ_WBHL

	        FROM T_SAL_OUTSTOCK A      
    INNER JOIN  RDS_JH_ODS_ExportDeclaration B      
    ON  A.F_QH_DECLARATIONNUMBER1 = B.F_QH_DECLARATIONNUMBER1   "
    tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql_str = sql_update1)
    
    sql_update3="update a set 
                  a.F_NLJ_YSBGDH=b.F_QH_DECLARATIONNUMBER,
                  a.F_NLJ_YSHTXYH=b.F_QH_DECLARATIONNUMBER1,
                  a.F_NLJ_YSCKRQ=b.F_QH_EXPORTDATE,
                  a.F_NLJ_YSCJFS=b.F_NLJ_CJFS,
                  a.F_NLJ_YSCJBZ=b.F_NLJ_CJBZ,
                  a.F_NLJ_YSWBJE=b.F_NLJ_WBJE,
                  a.F_NLJ_YSWBHL=b.F_NLJ_WBHL
                 from t_AR_receivable a   inner join t_AR_receivableEntry c  
                 on a.FID=c.FID  inner join T_SAL_OUTSTOCK b
                  on c.FSOURCEBILLNO=b.FBILLNO
                                    where b.F_QH_DECLARATIONNUMBER!=' ' "
    tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql_str = sql_update3)
    
    tsui::pop_notice('更新已成功')
    
    #end
    
    
  })
  
  #end of update erp-----
  
})
