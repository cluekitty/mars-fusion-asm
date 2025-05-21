; Edits to tilesets for corrections to room tiles

; Note, tilemaps appear to have their decompressed with a small header starting 02 00

; Tileset 0D - Recharge Rooms
.org readptr(TilesetEntry + (TilesetEntry_Size * 0Dh) + TilesetEntry_TilemapPointer)
.area 3588
    .skip 2
.incbin "data/tilemaps/0D-recharge-room.bin"
    .skip 2
.endarea

; Tileset 0D - Data Rooms
.org readptr(TilesetEntry + (TilesetEntry_Size * 0Fh) + TilesetEntry_TilemapPointer)
.area 4228
    .skip 2
.incbin "data/tilemaps/0F-data-room.bin"
    .skip 2
.endarea
