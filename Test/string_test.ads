-------------------------------------------------------------------------------
--
--  Copyright (C) 2013, 2014 Stephen Leake.  All Rights Reserved.
--  Copyright (C) 2000 Ted Dennison
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

with Ada.Text_IO;

with OpenToken.Recognizer.Character_Set;
with OpenToken.Recognizer.End_Of_File;
with OpenToken.Recognizer.Keyword;
with OpenToken.Recognizer.String;

with OpenToken.Token.Enumerated;
with OpenToken.Token.Enumerated.Analyzer;

-----------------------------------------------------------------------------
--  This package provides the library-level declarations for running
--  the string test driver.
-----------------------------------------------------------------------------
package String_Test is


   --  Global text file for reading parse data
   File : Ada.Text_IO.File_Type;

   File_Name : constant String := "String_Test.txt";

   type Example_Token_ID is (Whitespace, If_ID, String_ID, EOF);

   Token_Image_Width : Integer := Example_Token_ID'Width;
   package Master_Example_Token is new OpenToken.Token.Enumerated
     (Example_Token_ID, If_ID, EOF, Example_Token_ID'Image);
   package Tokenizer is new Master_Example_Token.Analyzer;

   Ada_Syntax : constant Tokenizer.Syntax :=
     (If_ID      => Tokenizer.Get (OpenToken.Recognizer.Keyword.Get ("if")),
      String_ID  => Tokenizer.Get (OpenToken.Recognizer.String.Get),
      Whitespace => Tokenizer.Get (OpenToken.Recognizer.Character_Set.Get
                                     (OpenToken.Recognizer.Character_Set.Standard_Whitespace)),
      EOF        => Tokenizer.Get (OpenToken.Recognizer.End_Of_File.Get)
     );

   C_Syntax : constant Tokenizer.Syntax :=
     (If_ID      => Tokenizer.Get (OpenToken.Recognizer.Keyword.Get ("if")),
      String_ID  => Tokenizer.Get (OpenToken.Recognizer.String.Get (Escapeable => True)),
      Whitespace => Tokenizer.Get (OpenToken.Recognizer.Character_Set.Get
                                     (OpenToken.Recognizer.Character_Set.Standard_Whitespace)),
      EOF        => Tokenizer.Get (OpenToken.Recognizer.End_Of_File.Get)
     );

   Analyzer : Tokenizer.Handle := Tokenizer.Initialize (Ada_Syntax);


end String_Test;
