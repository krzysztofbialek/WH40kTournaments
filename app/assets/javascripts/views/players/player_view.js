PlayerView = Backbone.View.extend({
  template: _.template('<h3><%= first_name %></h3>'),
  tagName: 'li',

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
  }
});

