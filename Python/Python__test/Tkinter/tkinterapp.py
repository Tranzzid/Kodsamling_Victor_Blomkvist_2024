from tkinter import *
from tkinter import colorchooser

class tk_inter_app():
    def __init__(self):
        self.mainwindow = self.create_main_window()
        # hör kan vi lägga till kontroller
        self.draw_color ="#000000"
        self.color_chooser()
        self.canvas = self.create_canvas()
        self.empty_button = self.create_empty_button()
        self.mainwindow.mainloop()
    
    def create_main_window(self):
        main_window = Tk()
        main_window.title("This is the main window")
        
        
        return main_window
    
    
    def create_canvas(self):
        canvas = Canvas(width = 640, height = 480, background = "#ffaaaa")
        canvas.bind("<B1-Motion>", self.draw_on_canvas)
        canvas.grid(row = 0, column = 0, sticky = NW)
        
        return canvas
    
    
    def draw_on_canvas(self, event):
        x1, y1 = (event.x - 1), (event.y - 1)
        x2, y2 = (event.x + 1), (event.y + 1)
        self.canvas.create_oval(x1, y1, x2, y2, width = 0, fill = self.draw_color)
        
        
    def create_empty_button(self):
        button = Button(self.mainwindow, text = "Töm camvas", command = self.empty_canvas)
        button.grid(row = 0, column = 1, sticky = NE)
        
        return button
    
    
    def color_chooser(self):
        button = Button(self.mainwindow, text = "Välj färg", command = self.show_color_dialog)
        button.grid(row = 0, column = 1)
        
        
    def empty_canvas(self):
        self.canvas.delete("all")
        
        
    def show_color_dialog(self):
        # Visa dialog för färgväljare
        color = colorchooser.Chooser(self.mainwindow)
        chosen_color = color.show()
        self.draw_color = chosen_color[1]