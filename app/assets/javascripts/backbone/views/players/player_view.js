PlayerView = Backbone.View.extend({
  template: JST['players/player'],
  tagName: 'li',

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
  }
});

