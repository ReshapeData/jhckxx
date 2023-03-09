# 0.01 add the 1st msg notification Menu----
headerMsg1<-  dropdownMenu(type = "messages",
                           messageItem(
                             from = msg[[1]]$from,
                             message = msg[[1]]$message
                           ),
                           messageItem(
                             from = msg[[2]]$from,
                             message = msg[[2]]$message,
                             icon = icon(msg[[2]]$icon),
                             time = msg[[2]]$time
                           ),
                           messageItem(
                             from = msg[[3]]$from,
                             message = msg[[3]]$message,
                             icon = icon(msg[[3]]$icon),
                             time = msg[[3]]$time
                           )
);



# 0.02 add the dynamic menu ----

dynamicMsgMenu <-dropdownMenuOutput("messageMenu")

# 0.03 Notification Menu ----

NotiMenuObj <-dropdownMenu(type = "notifications",
                           notificationItem(
                             text = "花名对照表需要更新",
                             icon("users")
                           ),
                           notificationItem(
                             text = "打卡数据优化班制",
                             icon("truck"),
                             status = "success"
                           )
                           
)
# 0.04 task menu bar ----
taskMenuObj <- dropdownMenu(type = "tasks", badgeStatus = "success",
                            taskItem(value = 90, color = "green",
                                     "Documentation"
                            ),
                            taskItem(value = 70, color = "aqua",
                                     "Project X"
                            ),
                            taskItem(value = 75, color = "yellow",
                                     "Server deployment"
                            ),
                            taskItem(value = 80, color = "red",
                                     "Overall project"
                            )
)
