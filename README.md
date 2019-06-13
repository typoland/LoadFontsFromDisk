# LoadFontsFromDisk
test project to invastgate why CTFont behive different with NSFont

When I use fonts offered by FontManager everything is OK. But fonts loaded from disk causes infinity loop.
To reproduce this loop open font or folder via Open menu and apply filter in the bottom left corner of window.
Filter works nice for fonts loaded by Load System Fonts
