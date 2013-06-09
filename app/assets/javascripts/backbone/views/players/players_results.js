PlayersResults = Backbone.View.extend({
  template: JST['players/results'],
  className: 'players-results',

  events: {
    'click input[type="checkbox"]' : 'togglePoints'
  },  
  
  initialize: function(){
    this.collection.bind('add', this.addOne, this);
    this.collection.bind('reset', this.render, this);
  },

  render: function(){
    this.$el.html(this.template());
    this.collection.forEach(function(element, index){
      this.addOne(element, index)}, this);
  },
  
  addOne: function(player, index){
    var playerResultView = new PlayerResultView({model: player, index: index});
    playerResultView.render();
    this.$('tbody').append(playerResultView.el);
  },

  togglePoints: function(event){
    var rows, extra, penalty, table;
    table = $('.players-results table')
    table.tablesorter()
    rows = $('label.toggle-extra-points').parents('.players-results').find('tr');
    $.each(rows, function(i, item){ 
      that = $(this);
      points = that.find('.player-points');
      if (points.data('points') == points.text()){
        extra = parseInt(that.find('.player-extra').text());
        penalty = parseInt(that.find('.player-penalty').text());
        points.text(parseInt(points.text()) + extra - penalty);
      } else {
        points.text(points.data('points'));
      }
    });
    table.tablesorter( {sortList: [[3,1], [2,1]]} );
  }

});
