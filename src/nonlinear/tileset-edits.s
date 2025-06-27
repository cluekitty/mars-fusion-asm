; Edits to tilesets for corrections to room tiles

/* Notes:
* Tileset data is LZ compressed. You can export as RAW from MAGE, and then use
    MAGE's tools -> Compression -> LZ77 Compress File to compress it. If you do
    not care to save the original data, you may save over the orignal file.
    A user macro has been provided for ease of importing. See `inc/macros.inc`
    for more information.
```example
.org TilesetEntry + (TilesetEntry_Size * XXh) + TilesetEntry_RlebgGfxPointer
    tilesetgfx @LabelName, "path/to/data.gfx", YYYYh
```

* Tilemaps follow the following format, however it has been provided as a
    user macro as well.

; importing same size or smaller data
.org @TilemapXX ; readptr(TilesetEntry + (TilesetEntry_Size * XXh) + TilesetEntry_TilemapPointer)
.area YYYY      ; Size of original data
    ;header
    .db     02h             ;fixed value
    .db     tilemap_height  ; calculated as: (total number of 8x8 tiles) / 128
.incbin "path/to/data.bin"
    .dw     00              ; end of data marker
.endarea

    OR

    tilemap @LabelName, "path/to/data.bin", YYYYh ; importing and marking old data as free space. Add 4 bytes to tilemap data to include header/footer.
*/


; Tileset 08 - Main Deck Hallways
.org TilesetEntry + (TilesetEntry_Size * 08h) + TilesetEntry_RlebgGfxPointer
    tilesetgfx  @Tileset08RlebgGfx, "data/tilesets/tileset-08.gfx", 113Eh

.org TilesetEntry + (TilesetEntry_Size * 08h) + TilesetEntry_TilemapPointer
    tilemap @Tileset08Tilemap, "data/tilemaps/08-maindeck-hallways.bin", 900h


; Tileset 0D - Recharge Rooms
.org readptr(TilesetEntry + (TilesetEntry_Size * 0Dh) + TilesetEntry_TilemapPointer)
.area 3588
    .skip 2
.incbin "data/tilemaps/0D-recharge-room.bin"
    .skip 2
.endarea


; Tileset 0F - Data Rooms
.org readptr(TilesetEntry + (TilesetEntry_Size * 0Fh) + TilesetEntry_TilemapPointer)
.area 4228
    .skip 2
.incbin "data/tilemaps/0F-data-room.bin"
    .skip 2
.endarea


; Tileset 1B - Main Deck Dark Tunnels
.org TilesetEntry + (TilesetEntry_Size * 1Bh) + TilesetEntry_RlebgGfxPointer
    tilesetgfx  @Tileset1BRlebgGfx, "data/tilesets/tileset-1B.gfx", 1BB5h

.org TilesetEntry + (TilesetEntry_Size * 1Bh) + TilesetEntry_TilemapPointer
    tilemap @Tileset1BTilemap, "data/tilemaps/1B-maindeck-maintenance-tunnels.bin", 0D80h


; Tileset 20 - Sector 2 Lush Greenery
.org TilesetEntry + (TilesetEntry_Size * 20h) + TilesetEntry_RlebgGfxPointer
    tilesetgfx  @Tileset20RlebgGfx, "data/tilesets/tileset-20.gfx", 47DFh

.org TilesetEntry + (TilesetEntry_Size * 20h) + TilesetEntry_TilemapPointer
    tilemap @Tileset20Tilemap, "data/tilemaps/20-tro-lush-greenery.bin", 0C04h


; Tileset 29 - Main Deck Dark Tunnels
.org TilesetEntry + (TilesetEntry_Size * 29h) + TilesetEntry_RlebgGfxPointer
    tilesetgfx  @Tileset29RlebgGfx, "data/tilesets/tileset-29.gfx", 3112h

.org TilesetEntry + (TilesetEntry_Size * 29h) + TilesetEntry_TilemapPointer
    tilemap @Tileset29Tilemap, "data/tilemaps/29-srx-terrain.bin", 1084h


; Tileset 43 - Generic Blue Rooms
.org TilesetEntry + (TilesetEntry_Size * 43h) + TilesetEntry_RlebgGfxPointer
    tilesetgfx  @Tileset43RlebgGfx, "data/tilesets/tileset-43.gfx", 0DF2h

.org TilesetEntry + (TilesetEntry_Size * 43h) + TilesetEntry_TilemapPointer
    tilemap @Tileset43Tilemap, "data/tilemaps/43-blue-rooms.bin", 0E04h


; Tileset 54 - Main Deck Restricted Lab Glass Tubes
.org TilesetEntry + (TilesetEntry_Size * 54h) + TilesetEntry_RlebgGfxPointer
    tilesetgfx @Tileset54RlebgGfx, "data/tilesets/tileset-54.gfx", 0A5Bh

.org TilesetEntry + (TilesetEntry_Size * 54h) + TilesetEntry_TilemapPointer
    tilemap @Tileset54Tilemap, "data/tilemaps/54-restricted-lab-glass-tubes.bin", 0904h


; Tileset 58 - Sector 1 Tourian Area
.org TilesetEntry + (TilesetEntry_Size * 58h) + TilesetEntry_RlebgGfxPointer
    tilesetgfx @Tileset58RlebgGfx, "data/tilesets/tileset-58.gfx", 109Fh

.org TilesetEntry + (TilesetEntry_Size * 58h) + TilesetEntry_TilemapPointer
    tilemap @Tileset58Tilemap, "data/tilemaps/58-tourian.bin", 0E00h
