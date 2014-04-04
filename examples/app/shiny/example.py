from bokeh.plotting import line

from bokeh.widgetobjects import (VBoxModelForm, HBox,
                                 ShinyApp, TextInput)
from bokeh.objects import Plot, ColumnDataSource
from bokeh.plotobject import PlotObject
from bokeh.properties import (Dict, Float, String, Instance)
import numpy as np

class MyModel(VBoxModelForm):
    offset = Float(1.0)
    scale = Float(1.0)
    input_specs = [
        {"widget" : TextInput,
         "name" : "offset",
         "value" : 1.0},
        {"widget" : TextInput,
         "name" : "scale",
         "value" : 1.0}
    ]
    
class MyApp(ShinyApp):
    plot = Instance(Plot, has_ref=True)
    source = Instance(ColumnDataSource, has_ref=True)
    
    def create(self, session):
        self.modelform = MyModel()
        session.add(self.modelform)        
        self.modelform.create_inputs(session)
        self.source = ColumnDataSource(data={'x':[], 'y':[]})
        self.update_data()
        self.plot = line('x', 'y', source=self.source,
                         plot_width=400, plot_height=400
        )
        self.children.append(self.modelform)
        self.children.append(self.plot)


    def update_data(self):
        N = 80
        x = np.linspace(0, 4*np.pi, N)
        y = np.sin(x)
        y = self.modelform.offset + y * self.modelform.scale
        self.source.data = {'x' : x, 'y' : y}
        
    def input_change(self, obj, attrname, old, new):
        self.update_data()
bokeh_url = "http://localhost:5006"
MyApp.add_route("/exampleapp", bokeh_url)