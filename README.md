# LoadFontsFromDisk
test project to invastgate why CTFont behive different than NSFont

When I use fonts offered by FontManager everything is OK. But fonts loaded from disk causes infinity loop.
To reproduce this loop open font or folder via Open menu and apply filter in the bottom left corner of window.
Filter works nice for fonts loaded by Load System Fonts
Stack looks like this when goes into infinity loop:
```
....
#261563	0x00007fff58dc7e63 in -[NSCTFont isEqual:] ()
#261564	0x00007fff3213d08c in _CFNonObjCEqual ()
#261565	0x00007fff58dc7e63 in -[NSCTFont isEqual:] ()
#261566	0x00007fff3213d08c in _CFNonObjCEqual ()
#261567	0x00007fff58dc7e63 in -[NSCTFont isEqual:] ()
#261568	0x00007fff3213d08c in _CFNonObjCEqual ()
#261569	0x00007fff58dc7e63 in -[NSCTFont isEqual:] ()
#261570	0x00007fff321a8887 in -[NSArray indexOfObject:] ()
#261571	0x00007fff2fa1f60a in -[NSArrayController _modifySelectedObjects:useExistingIndexesAsStartingPoint:avoidsEmptySelection:addOrRemove:sendObserverNotifications:forceUpdate:] ()
#261572	0x00007fff2fa1f072 in -[NSArrayController _arrangeObjectsWithSelectedObjects:avoidsEmptySelection:operationsMask:useBasis:] ()
#261573	0x00007fff2fa5790c in -[NSArrayController setFilterPredicate:] ()
#261574	0x0000000100007faa in AppDelegate.setFontNameFilter(_:) at /Users/lukasz/Documents/XCode/LoadFontsFromDisk2/LoadFontsFromDisk/AppDelegate.swift:71
#261575	0x00000001000082bc in @objc AppDelegate.setFontNameFilter(_:) ()
....
```
