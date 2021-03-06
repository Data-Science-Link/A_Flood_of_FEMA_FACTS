
dashboardPage(
    skin = "green",
    dashboardHeader(title = 'FEMA Flood Claims', titleWidth = 350),
    dashboardSidebar(
        width = 350,
        sidebarMenu(
            menuItem(h3('Dashboard'), tabName = 'dashboard'), #, icon = icon('map')
            menuItem(h3('Data'), tabName = 'data') #, icon = icon('database')
        )
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tags$body(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName = 'dashboard', 
                    fluidRow(
                        tabBox(
                            title = "", id = "tabset1", width = '100%', 
                            
                            tabPanel(h3("Start Here"),
                                     fluidRow(img(src='Landscape_1.jpg', align = "left", height = '200px', width = '100%')),
                                     br(),
                                     h4(START_HERE_TEXT_pt1),
                                     br(),
                                     h4(START_HERE_TEXT_pt2),
                                     htmlOutput("text_blurb"),
                                     br(),
                                     h4(START_HERE_TEXT_pt3),
                                     br(),
                                     plotlyOutput('GG_Amount_PD'),
                                     status = 'success'
                                     ),
                            
                            tabPanel(h3("Our Nation"), 
                                     fluidRow(
                                         column(2, sliderInput("nation_slider", sep = "", label = h3("Date Range"), min = 1970, max = 2019, value = c(1970,2019))),
                                         column(2, radioButtons("nation_radio", label = h3("Filter"), choices = list("States" = 0, "Flood Zone" = 1, 'Census Region' = 2, 'Census Division' = 3), selected = 2))
                                     ),
                                     h4(OUR_NATION_TEXT_pt1),
                                     h4(OUR_NATION_TEXT_pt2),
                                     h4(OUR_NATION_TEXT_pt3),
                                     h4(OUR_NATION_TEXT_pt4),
                                     plotlyOutput("GG_Accumulation_for_Nation"),
                                     plotlyOutput("GG_Total_Nation_Summed_Claims"),
                                     plotlyOutput('GG_Summed_Claim_Cost_by_Top_10_States')
                                     ),
                            
                            tabPanel(h3("Our States"),
                                     fluidRow(
                                         column(2, sliderInput("state_slider", sep = "", label = h3("Date Range"), min = 1970, max = 2019, value = c(1970,2019))),
                                         column(1, radioButtons("state_radio", label = h3("Filter"), choices = list("Flood Zone" = 0), selected = 0)),
                                         column(2, selectizeInput("selected", "State Acronym", State_Names))
                                     ),
                                     h4(OUR_STATES_TEXT_pt1),
                                     h4(OUR_STATES_TEXT_pt2),
                                     h4(OUR_STATES_TEXT_pt3),
                                     h4(OUR_STATES_TEXT_pt4),
                                     plotlyOutput("GG_Accumulation_for_State"),
                                     plotlyOutput("GG_Total_State_Summed_Claims"),
                                     plotlyOutput('GG_Summed_Claim_Cost_by_Top_10_Counties')
                            ),
                            
                            tabPanel(h3("Our Story"), 
                                     h4(OUR_STORY_pt1),
                                     br(),
                                     h4(OUR_STORY_pt2),
                                     br(),
                                     h4(OUR_STORY_pt3),
                                     plotlyOutput('GG_Avg_PD_Losses'),
                                     br(),
                                     h4(OUR_STORY_pt4),
                                     fluidRow(
                                         column(1, radioButtons("regression", label = h3("Line Type"), choices = list("Linear" = 0, "Exponential" = 1, "Quadratic" = 2), selected = 1)),
                                         column(11, plotlyOutput('GG_Accumulation_for_Nation_Regression'),)
                                     ),
                                     br(),
                                     h4(OUR_STORY_pt5),
                                     plotlyOutput('GG_Accumulation_for_Nation_Standardized'),
                                     br(),
                                     h4(OUR_STORY_pt6),
                                     plotlyOutput('GG_Standardized_Accumulation_State'),
                                     br(),
                                     h4(OUR_STORY_pt7),
                                     br(),
                                     h4(OUR_STORY_pt8),
                                     br(),
                                     h4(OUR_STORY_pt9)
                                     )
                        )
                    )),
            tabItem(tabName = 'data',
                    fluidRow(
                        tabBox(
                            title = "",
                            # The id lets us use input$tabset1 on the server to find the current tab
                            id = "tabset1", width = '100%',
                            tabPanel(h3("Cleaned"), 
                                     h4(),
                                     box(DT::dataTableOutput("table_cleaned"), width = 12)),
                            tabPanel(h3("Manipulated"), 
                                     h4(),
                                     box(DT::dataTableOutput("table_manipulated"), width = 12)),
                            tabPanel(h3("Major Storms"), h4('FEMA Designated Major Storms:'),
                                     tags$a(href="https://www.fema.gov/significant-flood-events", h4("https://www.fema.gov/significant-flood-events")),
                                     box(DT::dataTableOutput("table_major_storms"), width = 12)),
                            tabPanel(h3("Raw"), 
                                     h4('FIMA NFIP Redacted Claims Data Set Download Link (Too Large to Host Online):'),
                                     tags$a(href="https://www.fema.gov/media-library/assets/documents/180374", h4("https://www.fema.gov/media-library/assets/documents/180374")))
                            )
                    )
            )
        )
    )
)


