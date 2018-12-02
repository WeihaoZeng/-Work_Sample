shinyServer(function (input, output) {
  
  # Create our colors with a categorical color function
  color <- colorFactor("Blue",crime$OFFENSE)
  
  # Provide some content in the side bars when user selects a crime type.
  output$method <- renderPrint({table(subset(crime,OFFENSE == input$select)$METHOD) })
  output$shift <- renderPrint({table(subset(crime,OFFENSE == input$select)$SHIFT) })
  output$district <- renderPrint({table(subset(crime,OFFENSE == input$select)$DISTRICT) })
  output$sum <- renderPrint({ nrow(subset(crime,OFFENSE == input$select)) })
  
  output$map <- renderLeaflet({
    data <- subset(crime,OFFENSE == input$select)   # subset the data according to the choices
    leaflet(data) %>%
      setView(lng = -77.0369, lat = 38.9072, zoom = 11) %>%  # draw a map of dc
      addProviderTiles("CartoDB.Positron", options = providerTileOptions(noWrap = TRUE)) %>%
      addCircleMarkers(
        lng=~X, # Longitude coordinates
        lat=~Y, # Latitude coordinates
        radius=~2, 
        stroke=FALSE, # Circle stroke
        fillOpacity=0.7, # Circle Fill Opacity
        # Popup content
        popup=~paste(
          "<b>", ~OFFENSE, "</b><br/>",
          "count: ", as.character(1), "<br/>",
          "date: ", as.character(~REPORT_DAT)
        )
      ) %>%
      addLegend(
        "bottomleft", # Legend position
        pal = color,
        values=~OFFENSE, # legend values
        opacity = 0.7,
        title="Type of Crime Committed")
  })
})