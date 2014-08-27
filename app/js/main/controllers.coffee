define ['angular'], (angular) ->
  class HomeCtrl
    constructor: ->
      @interval = 5000
      @slides = [
        image: 'img/slide-1.jpg'
      ,
        image: 'img/slide-2.jpg'
      ,
        image: 'img/slide-3.jpg'
      ]
  angular
    .module 'main.controllers', []
    .controller 'HomeCtrl', [HomeCtrl]