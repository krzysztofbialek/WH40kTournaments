PlayerView = Backbone.View.extend({
  template: JST['players/player'],
  tagName: 'tr',

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
  }
});

