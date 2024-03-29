-------------------------------------------------------------------------------
--
-- Copyright (C) 2009, 2014 Stephe Leake
-- Copyright (C) 2000 Ted Dennison
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

-------------------------------------------------------------------------------
--  Test driver for the token list handling code.
-------------------------------------------------------------------------------

with Ada.Command_Line;
with Ada.Exceptions;
with Ada.Text_IO;
with OpenToken.Text_Feeder.String;
with OpenToken.Token.List;
procedure Token_List_Test.Run is
begin

   ----------------------------------------------------------------------------
   --  Test Case 1
   --
   --  Inputs           : A valid list of tokens.
   --
   --  Expected Results : A Token.LIst
   --  Purpose          : Verify that a valid list of tokens is properly parsed.
   Test_Case_1 :
   declare

      Parse_String : constant String := "5, 3, 1000, 78";

      Analyzer : constant Tokenizer.Handle := Tokenizer.Initialize (Syntax, String_Feeder'Access);

      List : aliased OpenToken.Token.List.Class :=
        OpenToken.Token.List.Get
        (Element   => Syntax (Int).Token_Handle,
         Separator => Syntax (Comma).Token_Handle);
   begin

      Ada.Text_IO.Put ("Testing parsing of valid token list...");
      Ada.Text_IO.Flush;

      --  Put the parse string into the analyzer's text feeder.
      OpenToken.Text_Feeder.String.Set
        (Feeder => String_Feeder,
         Value  => Parse_String);

      --  Load up the first token
      Analyzer.Find_Next;

      --  Perform the parse
      OpenToken.Token.List.Parse (List'Access, Analyzer);

      if Analyzer.ID = EOF then
         Ada.Text_IO.Put_Line ("passed");
      else
         Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
         Ada.Text_IO.Put_Line ("failed.");
         Ada.Text_IO.Put_Line
           ("There was an unexpected " &
              Token_IDs'Image (Analyzer.ID) &
              " left on the input stream.");
      end if;

   exception
   when Error : others =>
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      Ada.Text_IO.Put_Line ("failed due to parse exception:");
      Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Information (Error));
   end Test_Case_1;

   ----------------------------------------------------------------------------
   --  Test Case 2
   --
   --  Inputs           : A couple of integer tokens.
   --
   --  Expected Results : A Token.List
   --  Purpose          : Verify that a single token is properly parsed as a
   --                     token list.
   Test_Case_2 : declare

      Parse_String : constant String := "5 1000";

      Analyzer : constant Tokenizer.Handle := Tokenizer.Initialize (Syntax, String_Feeder'Access);

      List : aliased OpenToken.Token.List.Class :=
        OpenToken.Token.List.Get
        (Element   => Syntax (Int).Token_Handle,
         Separator => Syntax (Comma).Token_Handle);

   begin

      Ada.Text_IO.Put ("Testing parsing of single-token token list...");
      Ada.Text_IO.Flush;

      --  Put the parse string into the analyzer's text feeder.
      OpenToken.Text_Feeder.String.Set
        (Feeder => String_Feeder,
         Value  => Parse_String);

      --  Load up the first token
      Analyzer.Find_Next;

      --  Parse 2 token lists (one for each integer).
      OpenToken.Token.List.Parse (List'Access, Analyzer);

      OpenToken.Token.List.Parse (List'Access, Analyzer);

      if Analyzer.ID = EOF then
         Ada.Text_IO.Put_Line ("passed");
      else
         Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
         Ada.Text_IO.Put_Line ("failed.");
         Ada.Text_IO.Put_Line
           ("There was an unexpected " &
              Token_IDs'Image (Analyzer.ID) &
              " left on the input stream.");
      end if;

   exception
   when Error : others =>
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      Ada.Text_IO.Put_Line ("failed due to parse exception:");
      Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Information (Error));
   end Test_Case_2;

   ----------------------------------------------------------------------------
   --  Test Case 3
   --
   --  Inputs           : An invalid token list that ends with a comma.
   --
   --  Expected Results : A parse exception.
   --  Purpose          : Verify that an invalid token list is correctly
   --                     diagnosed.
   --
   Test_Case_3 : declare

      Parse_String : constant String := "5,1000, ";

      Analyzer : constant Tokenizer.Handle := Tokenizer.Initialize (Syntax, String_Feeder'Access);

      List : aliased OpenToken.Token.List.Class :=
        OpenToken.Token.List.Get
        (Element   => Syntax (Int).Token_Handle,
         Separator => Syntax (Comma).Token_Handle);

   begin

      Ada.Text_IO.Put ("Testing parsing of invalid token list...");
      Ada.Text_IO.Flush;

      --  Put the parse string into the analyzer's text feeder.
      OpenToken.Text_Feeder.String.Set
        (Feeder => String_Feeder,
         Value  => Parse_String);

      --  Load up the first token
      Analyzer.Find_Next;

      --  Parse 2 token lists (one for each integer).
      OpenToken.Token.List.Parse (List'Access, Analyzer);

      Ada.Text_IO.Put_Line ("failed.");
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);

   exception
   when OpenToken.Parse_Error =>
      Ada.Text_IO.Put_Line ("passed.");

   when Error : others =>
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      Ada.Text_IO.Put_Line ("failed due to parse exception:");
      Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Information (Error));
   end Test_Case_3;
end Token_List_Test.Run;
