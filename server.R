

#shinyserver start point----
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
     tsda::db_writeTable2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',table_name = 'RDS_JH_view_ExportDeclaration',r_object = data,append = TRUE)
     
     
     
     #end
     
   })
   
   #end of preview---------
   
   
   #update_erp--------
   
   shiny::observeEvent(input$btn_update,{
     
     #code here
     #begin
     sql ="SELECT F_QH_DECLARATIONNUMBER,
            			FCONTRACTNO ,
            			F_QH_EXPORTDATE 
           FROM RDS_JH_ExportDeclaration"
     data = tsda::sql_select2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql = sql)
     print(data)
     
     #update age
     
     sql_update = "
                  UPDATE A  SET A.F_QH_EXPORTDATE = B.出口日期,
            		 A.F_QH_DECLARATIONNUMBER = B.出口报关单号
            		FROM T_SAL_OUTSTOCK A
            		INNER JOIN  RDS_JH_view_ExportDeclaration  B
            		ON  A.FCONTRACTNO = B.合同号 
                 "
     tsda::sql_update2(token = 'C0426D23-1927-4314-8736-A74B2EF7A039',sql_str = sql_update)
     
     tsui::pop_notice('更新已成功')
     
     #end
     
     
   })
   
   #end of update erp-----
   
   
   
   
  
})
