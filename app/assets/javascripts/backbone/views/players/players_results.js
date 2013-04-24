PlayersResults = Backbone.View.extend({
  template: JST['players/results'],
  className: 'players-results',

  events: {
    'click label.toggle-extra-points' : 'togglePoints'
  },  
  
  initialize: function(){
    this.collection.bind('add', this.addOne, this);
    this.collection.bind('reset', this.render, this);
  },

  render: function(){
    this.$el.html(this.template());
    this.collection.forEach(this.addOne, this);
  },
  
  addOne: function(player){
    var playerResultView = new PlayerResultView({model: player});
    playerResultView.render();
    this.$('tbody').append(playerResultView.el);
  },

  togglePoints: function(){
    var rows, extra, penalty;
    rows = $('label.toggle-extra-points').parents('.players-results').find('tr');
    console.log(rows)
    $.each(rows, function(i, item){
      points = item.find('.player-points');
      extra = parseInt(item.find('.player-extra').text());
      penalty = parseInt(item.find('.player-penalty').text());
      points.text(parseInt(points.text()) + extra - penalty);
    });
  }

});
