menu_row <- tabItem(tabName = "row",
                    fluidRow(
                      column(width = 4,
                             box(
                               title = "操作区", width = NULL, solidHeader = TRUE, status = "primary",
                               tsui::uiTemplate(templateName = '出口报关单导入模板'),
                               tsui::mdl_file(id = 'file_expInfo',label ='请上传出口信息表' ),
                               tagList(   shiny::actionButton(inputId = 'btn_preview',label = '预览'),
                                           shiny::actionButton(inputId = 'btn_update',label = '更新ERP'))
                            
                             )
                             # ,
                             # box(
                             #   title = "Title 1", width = NULL, solidHeader = TRUE, status = "primary",
                             #   "Box content"
                             # ),
                             # box(
                             #   title = "Title 1", width = NULL, solidHeader = TRUE, status = "primary",
                             #   "Box content"
                             # )
                      ),
                      
                 
                      
                      column(width=8,
                             box(
                               title = "显示区", width = NULL, solidHeader = TRUE, status = "primary",
                               tsui::mdl_dataTable(id = 'dt_expInfo',label = '显示信息')
                             )
                             # ,
                             # box(
                             #   title = "Title 1", width = NULL, solidHeader = TRUE, status = "primary",
                             #   "Box content"
                             # ),
                             # box(
                             #   title = "Title 1", width = NULL, solidHeader = TRUE, status = "primary",
                             #   "Box content"
                             # )
                      )
                    )
)

