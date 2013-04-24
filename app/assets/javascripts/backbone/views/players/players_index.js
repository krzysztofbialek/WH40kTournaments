PlayersIndex = Backbone.View.extend({
  template: JST['players/index'],
  className: 'players-list',
  
  
  initialize: function(){
    this.collection.on('add', this.addOne, this);
    this.collection.on('reset', this.render, this);
  },

  render: function(){
    this.$el.html(this.template());
    this.collection.forEach(this.addOne, this);
    $('.players-list .toggle-list').bind('click', function(){
      $('.players-list table').fadeToggle();
      if ($(this).hasClass('icon-minus')) { 
        $(this).text(' ( rozwiń listę )');
      } else {
        $(this).text(' ( zwiń listę )');
      }
      $(this).toggleClass('icon-plus icon-minus')
    });
  },
  
  addOne: function(player){
    var playerView = new PlayerView({model: player});
    playerView.render();
    this.$('tbody').append(playerView.el);
  },

});
