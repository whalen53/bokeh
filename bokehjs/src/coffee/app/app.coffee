define [
  "common/plot_widget",
  "common/has_parent",
  "common/continuum_view",
  "./app_template",
  "jquery_ui/slider",
], (PlotWidget, HasParent, ContinuumView, app_template, slider) ->

  class AppView extends ContinuumView.View
    template : app_template
    initialize : (options) ->
      super(options)
      @plot = @mget_obj('image_plot')
      @plot_view = new @plot.default_view('model' : @plot)
      @vert_plot = @mget_obj('vert_plot')
      @vert_plot_view = new @plot.default_view('model' : @vert_plot)
      @horiz_plot = @mget_obj('horiz_plot')
      @horiz_plot_view = new @plot.default_view('model' : @horiz_plot)
      @render()

    render : () ->
      super()
      @plot_view.$el.detach()
      @$el.html('')
      @$el.html(@template())
      @$(".image_plot").append(@plot_view.$el)
      @$(".vert_plot").append(@vert_plot_view.$el)
      @$(".horiz_plot").append(@horiz_plot_view.$el)
      max = 42
      min = 0
      @$el.find(".app_slider").slider(
        orientation: "vertical",
        animate: "fast",
        step: (max - min) / 50.0 ,
        min: min
        max: max
        value: min
        slide: ( event, ui ) =>
          remote = @mget_obj('remote_data_source')
          current_slice = remote.get('index_slice')
          new_slice = (x for x in current_slice)
          new_slice[2] = Math.round(ui.value)
          remote.set('index_slice', new_slice)
      )

      max = 4095
      min = 0
      @$el.find(".vert_slider").slider(
        orientation: "vertical",
        animate: "fast",
        step: (max - min) / 50.0 ,
        min: min
        max: max
        value: min
        slide: ( event, ui ) =>

          remote = @mget_obj('horiz_source')
          current_slice = remote.get('index_slice')
          new_slice = (x for x in current_slice)
          new_slice[0] = Math.round(ui.value)
          remote.set('index_slice', new_slice)

      )
      max = 8191
      min = 0
      @$el.find(".horiz_slider").slider(
        orientation: "horizontal",
        animate: "fast",
        step: (max - min) / 50.0 ,
        min: min
        max: max
        value: min
        slide: ( event, ui ) =>
          remote = @mget_obj('vert_source')
          current_slice = remote.get('index_slice')
          new_slice = (x for x in current_slice)
          new_slice[1] = Math.round(ui.value)
          remote.set('index_slice', new_slice)
      )

  class App extends HasParent
    type : "App"
    default_view : AppView

  class Apps extends Backbone.Collection
    model: App

  return {
    "Model": App
    "Collection": new Apps()
  }
