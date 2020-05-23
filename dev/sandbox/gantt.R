library(highcharter)
library(magrittr)
library(lubridate)
library(tibble)
library(dplyr)

options("highcharter.debug" = TRUE)
options("highcharter.verbose" = TRUE)


set.seed(1234)
size <- 6
df <- tibble(
  start = today() + days(sample(-20:20, size = size)),
  end = start + days(sample(1:3, size = size, replace = TRUE)),
  progress = round(runif(size), 1),
  name = letters[1:size],
  y =  rep(1:3, length.out = size) - 1,
  id =paste0(name, round(1000*runif(size)))
) %>%
  # needs to convert to highchart timestamp format
  mutate(
    start = highcharter::datetime_to_timestamp(start),
    end = highcharter::datetime_to_timestamp(end)
  )

highchart(type = 'gantt') %>% 
  hc_add_series(data = df)


highchart(type = 'gantt') %>% 
  hc_add_series(data = df) %>% 
  hc_xAxis(type = "datetime",
           currentDateIndicator = TRUE) %>% 
  hc_yAxis(categories = c("Protyping", "Dev", "Testing")) 









df = tibble::tribble(
  ~start,                                                 ~end,                     ~name,  ~category,   ~completed,                            
  lubridate::ymd('2019-11-01'),        lubridate::ymd('2020-01-02'),       'Prototyping',   0,              0.95,                             
  lubridate::ymd('2020-01-02'),        lubridate::ymd('2020-11-05'),       'Development',   1,              0.5,                             
  lubridate::ymd('2020-11-08'),        lubridate::ymd('2020-11-09'),       'Testing',       2,              0.15,                             
  lubridate::ymd('2020-11-09'),        lubridate::ymd('2020-11-19'),       'Development',   1,              list(amount= 0.3,fill= '#fa0'),                             
  lubridate::ymd('2020-11-10'),        lubridate::ymd('2020-11-23'),       'Testing',       2,              NA,                             
  lubridate::ymd_h('2020-11-10 08'),   lubridate::ymd_h('2020-11-23 16'),  'Release',       3,              NA,                             
) %>% 
  mutate(
    start = highcharter::datetime_to_timestamp(start),
    end = highcharter::datetime_to_timestamp(end)
  )

highchart(type = 'gantt') %>% 
  hc_add_series(data = df, name= 'My Project') %>% 
  hc_title(text = 'Gantt Chart with Navigation') %>% 
  hc_xAxis(type = "datetime",
           uniqueNames= TRUE,
           currentDateIndicator = TRUE) %>%
  hc_yAxis(uniqueNames = TRUE) %>% 
  hc_navigator(
    enabled= TRUE,
    liveRedraw= TRUE,
    series= list(
      type= 'gantt',
      pointPlacement= 0.5,
      pointPadding= 0.25
    ),
    yAxis = list(
      min= 0,
      max= 3,
      reversed= TRUE,
      categories = NULL
    )
  ) %>% 
  hc_scrollbar(
    enabled = TRUE
  ) %>% 
  hc_rangeSelector(
    enabled = TRUE,
    selected = 0
  )


















today = lubridate::force_tz(lubridate::round_date(Sys.time(), unit = 'day'), 'UTC')
day = 86400
df = tibble::tribble(
  ~start,	                        ~end,           	~name,	 ~milestone,	~dependency,	~id,	~y,
  today + 2 * day   ,	today + day * 5,	  'Prototype'     			,      NA,            NA , 'prototype'  ,    0,
  today + day * 6   ,               NA,   'Prototype done'     	,    TRUE,   'prototype' , 'proto_done' ,    0,
  today + day * 7   ,	today + day * 11,	  'Testing'     	      ,    	 NA,   'proto_done',        NA    ,    0,
  today + day * 5   ,	today + day * 8,	  'Product pages'     	,      NA,            NA ,        NA    ,    1,
  today + day * 9   ,	today + day * 10,	  'Newsletter'     			,      NA,            NA ,        NA    ,    1,
  today + day * 9   ,	today + day * 11,	  'Licensing'     	    ,      NA,            NA , 'testing'    ,    2,
  today + day * 11.5,	today + day * 12.5,	'Publish'     		    ,      NA,      'testing',	     NA     ,    2
) %>% 
  mutate(
    start = highcharter::datetime_to_timestamp(start),
    end = highcharter::datetime_to_timestamp(end)
  )




highchart(type = 'gantt') %>% 
  hc_add_dependency("modules/draggable-points.js") %>% 
  hc_add_dependency("plugins/draggable-points.js") %>% 
  hc_add_series(data = df, name= 'My Project') %>% 
  hc_title(text = 'Interactive Gantt Chart') %>% 
  hc_subtitle(text= 'Drag and drop points to edit') %>% 
  hc_chart(spacingLeft= 1) %>% 
  hc_plotOptions(
    gantt = list(
      animation= FALSE, # Do not animate dependency connectors
      dragDrop= list(
        draggableX= TRUE,
        draggableY= TRUE,
        dragMinY= 0,
        dragMaxY= 2,
        dragPrecisionX= 500*86400* 8/12, # Snap to 8 hours
        dragSensitivity = 10
      ),
      dataLabels= list(
        enabled= TRUE,
        format= '{point.name}',
        style= list(
          cursor= 'default',
          pointerEvents= 'none'
        )
      )
      # point= list(
      #   events= list(
      #     select= updateRemoveButtonStatus,
      #     unselect= updateRemoveButtonStatus,
      #     remove= updateRemoveButtonStatus
      #   )
      # )
    )
  ) %>% 
  hc_yAxis(
    type= 'category',
    categories= c('Tech', 'Marketing', 'Sales'),
    min= 0,
    max= 2
  ) %>% 
  hc_xAxis(
    currentDateIndicator= TRUE
  ) %>% 
  hc_tooltip(
    xDateFormat= '%a %b %d, %H:%M:%S'
  )






