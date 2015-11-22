module Paths_e2e_parser (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/davy/Dev/e2e-parser/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/bin"
libdir     = "/home/davy/Dev/e2e-parser/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/lib/x86_64-linux-ghc-7.10.2/e2e-parser-0.1.0.0-F6zQXIDO95l0UXgEEdIFTI"
datadir    = "/home/davy/Dev/e2e-parser/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/share/x86_64-linux-ghc-7.10.2/e2e-parser-0.1.0.0"
libexecdir = "/home/davy/Dev/e2e-parser/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/libexec"
sysconfdir = "/home/davy/Dev/e2e-parser/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "e2e_parser_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "e2e_parser_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "e2e_parser_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "e2e_parser_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "e2e_parser_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
