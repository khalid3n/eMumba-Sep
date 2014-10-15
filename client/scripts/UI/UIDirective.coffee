'use strict';

angular.module('app.ui.directives', [])

.directive('uiTime', [ ->
    return {
        restrict: 'A'
        link: (scope, ele) ->
            startTime = ->
                today = new Date()
                h = today.getHours()
                m = today.getMinutes()
                s = today.getSeconds()

                m = checkTime(m)
                s = checkTime(s)

                time = h+":"+m+":"+s
                ele.html(time)
                t = setTimeout(startTime,500)
            checkTime = (i) -> # add a zero in front of numbers<10
                if (i<10) then i = "0" + i
                return i

            startTime()
    }
])

.directive('uiWeather', [ ->
    return {
        restrict: 'A'
        link: (scope, ele, attrs) ->
            color = attrs.color
            # CLEAR_DAY, CLEAR_NIGHT, PARTLY_CLOUDY_DAY, PARTLY_CLOUDY_NIGHT, CLOUDY
            # RAIN, SLEET, SNOW, WIND, FOG
            icon = Skycons[attrs.icon]

            skycons = new Skycons({
                "color": color
                "resizeClear": true
            })

            skycons.add(ele[0], icon)
            skycons.play()
    }
])

.directive('uiColorpicker', [ ->
    return {
      restrict: "E"
      require: "ngModel"      
      template: "<span><input class='input-small' /></span>"
      link: (scope, element, attrs, ngModel) ->
        input = element.find("input")  
        console.log input      
        options = angular.extend(
          color: ngModel.$viewValue
          change: (color) ->
            scope.$apply ->
              ngModel.$setViewValue color.toHexString()

        , scope.$eval(attrs.options))
        ngModel.$render = ->
          input.spectrum "set", ngModel.$viewValue or ""          

        input.spectrum options
    }
])    


