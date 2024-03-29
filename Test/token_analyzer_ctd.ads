-------------------------------------------------------------------------------
--
--  Copyright (C) 2013, 2014 Stephen Leake.  All Rights Reserved.
--  Copyright (C) 2013 Ted Dennison
--
-- This file is part of the OpenToken package.
--
-- The OpenToken package is free software; you can redistribute it and/or
-- modify it under the terms of the  GNU General Public License as published
-- by the Free Software Foundation; either version 3, or (at your option)
-- any later version. The OpenToken package is distributed in the hope that
-- it will be useful, but WITHOUT ANY WARRANTY; without even the implied
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for  more details.  You should have received
-- a copy of the GNU General Public License  distributed with the OpenToken
-- package;  see file GPL.txt.  If not, write to  the Free Software Foundation,
-- 59 Temple Place - Suite 330,  Boston, MA 02111-1307, USA.
--
--  As a special exception, if other files instantiate generics from
--  this unit, or you link this unit with other files to produce an
--  executable, this unit does not by itself cause the resulting
--  executable to be covered by the GNU General Public License. This
--  exception does not however invalidate any other reasons why the
--  executable file might be covered by the GNU Public License.
--
-------------------------------------------------------------------------------

with OpenToken.Token.Enumerated;
with OpenToken.Token.Enumerated.Analyzer;
with OpenToken.Recognizer.Keyword;
with OpenToken.Recognizer.Nothing;

-----------------------------------------------------------------------------
--  Library-level declarations for test driver for the token
--  anlayzer's default token functionality
-----------------------------------------------------------------------------
package Token_Analyzer_CTD is

   type Token_IDs is (Normal, Default);

   package Master_Token is new OpenToken.Token.Enumerated
     (Token_IDs, Token_IDs'First, Token_IDs'Last, Token_IDs'Image);
   package Tokenizer is new Master_Token.Analyzer;

   Normal_Text : constant String := "Normal";

   Syntax : Tokenizer.Syntax :=
     (Normal  => Tokenizer.Get (OpenToken.Recognizer.Keyword.Get (Normal_Text)),
      Default => Tokenizer.Get (OpenToken.Recognizer.Nothing.Get)
     );

   Analyzer : Tokenizer.Handle := Tokenizer.Initialize
     (Language_Syntax => Syntax,
      Default         => Default);

end Token_Analyzer_CTD;
