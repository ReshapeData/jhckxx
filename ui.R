


# 1.00  shinyUI start point----

shinyUI(dashboardPage(skin = "blue",
                    
                
                    
                    dashboardHeader(title = app_title,titleWidth = '300px',
                                   
                                    headerMsg1,
                                    dynamicMsgMenu,
                                   # NotiMenuObj,
                                    disable = F
                    ),
                    
                    #ui.sideBar----
                    dashboardSidebar(
                    
                       sidebarMenu
                    ),
                    
                    #ui.body----
                    dashboardBody(
                      workAreaSetting,
                      tsui::use_pop(),
                    )
)
)


