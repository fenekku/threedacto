## SOIL (Simple OpenGL Image Library) Nimrod wrapper

when defined(Linux):
  const LibName = "libSOIL.so.1"


const
  ## The format of images that may be loaded (force_channels).
  ## SOIL_LOAD_AUTO leaves the image in whatever format it was found.
  ## SOIL_LOAD_L forces the image to load as Luminous (greyscale)
  ## SOIL_LOAD_LA forces the image to load as Luminous with Alpha
  ## SOIL_LOAD_RGB forces the image to load as Red Green Blue
  ## SOIL_LOAD_RGBA forces the image to load as Red Green Blue Alpha
  SOIL_LOAD_AUTO* = 0
  SOIL_LOAD_L*    = 1
  SOIL_LOAD_LA*   = 2
  SOIL_LOAD_RGB*  = 3
  SOIL_LOAD_RGBA* = 4

  # Passed in as reuse_texture_ID, will cause SOIL to
  # register a new texture ID using glGenTextures().
  # If the value passed into reuse_texture_ID > 0 then
  # SOIL will just re-use that texture ID (great for
  # reloading image assets in-game!)
  SOIL_CREATE_NEW_ID* = 0

  # flags you can pass into SOIL_load_OGL_texture()
  # and SOIL_create_OGL_texture().
  # (note that if SOIL_FLAG_DDS_LOAD_DIRECT is used
  # the rest of the flags with the exception of
  # SOIL_FLAG_TEXTURE_REPEATS will be ignored while
  # loading already-compressed DDS files.)

  # SOIL_FLAG_POWER_OF_TWO: force the image to be POT
  # SOIL_FLAG_MIPMAPS: generate mipmaps for the texture
  # SOIL_FLAG_TEXTURE_REPEATS: otherwise will clamp
  # SOIL_FLAG_MULTIPLY_ALPHA: for using (GL_ONE,GL_ONE_MINUS_SRC_ALPHA) blending
  # SOIL_FLAG_INVERT_Y: flip the image vertically
  # SOIL_FLAG_COMPRESS_TO_DXT: if the card can display them, will convert RGB to DXT1, RGBA to DXT5
  # SOIL_FLAG_DDS_LOAD_DIRECT: will load DDS files directly without _ANY_ additional processing
  # SOIL_FLAG_NTSC_SAFE_RGB: clamps RGB components to the range [16,235]
  # SOIL_FLAG_CoCg_Y: Google YCoCg; RGB=>CoYCg, RGBA=>CoCgAY
  # SOIL_FLAG_TEXTURE_RECTANGE: uses ARB_texture_rectangle ; pixel indexed & no repeat or MIPmaps or cubemaps
  SOIL_FLAG_POWER_OF_TWO* = 1
  SOIL_FLAG_MIPMAPS* = 2
  SOIL_FLAG_TEXTURE_REPEATS* = 4
  SOIL_FLAG_MULTIPLY_ALPHA* = 8
  SOIL_FLAG_INVERT_Y* = 16
  SOIL_FLAG_COMPRESS_TO_DXT* = 32
  SOIL_FLAG_DDS_LOAD_DIRECT* = 64
  SOIL_FLAG_NTSC_SAFE_RGB* = 128
  SOIL_FLAG_CoCg_Y* = 256
  SOIL_FLAG_TEXTURE_RECTANGLE* = 512

{.push callconv: cdecl, discardable.}

# Loads an image from disk into an OpenGL texture.
# \param filename the name of the file to upload as a texture
# \param force_channels 0-image format, 1-luminous, 2-luminous/alpha, 3-RGB, 4-RGBA
# \param reuse_texture_ID 0-generate a new texture ID, otherwise reuse the texture ID (overwriting the old texture)
# \param flags can be any of SOIL_FLAG_POWER_OF_TWO | SOIL_FLAG_MIPMAPS | SOIL_FLAG_TEXTURE_REPEATS | SOIL_FLAG_MULTIPLY_ALPHA | SOIL_FLAG_INVERT_Y | SOIL_FLAG_COMPRESS_TO_DXT | SOIL_FLAG_DDS_LOAD_DIRECT
# \return 0-failed, otherwise returns the OpenGL texture handle
proc SOIL_load_OGL_texture*( filename : cstring,
                            force_channels : int,
                            reuse_texture_ID : uint,
                            flags : uint): uint32 {.importc: "SOIL_load_OGL_texture", dynlib: LibName.}

# This function resturns a pointer to a string describing the last thing
# that happened inside SOIL.  It can be used to determine why an image
# failed to load.
proc SOIL_last_result*(): cstring {.importc: "SOIL_last_result", dynlib: LibName.}

## Loads an image from disk into an array of unsigned chars.
## Note that *channels return the original channel count of the
## image.  If force_channels was other than SOIL_LOAD_AUTO,
## the resulting image has force_channels, but *channels may be
## different (if the original image had a different channel
## count).
## \return 0 if failed, otherwise returns 1
proc SOIL_load_image*(filename : string, width : ptr cint, height : ptr cint,
                     channels : ptr cint, force_channels : int): pointer {.
  importc: "SOIL_load_image", dynlib: LibName.}

{.pop.}
