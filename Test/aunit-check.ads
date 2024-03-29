--  Abstract :
--
--  Generic Check routines for AUnit
--
--  Copyright (C) 2009, 2010, 2013, 2014 Stephen Leake.  All Rights Reserved.
--
--  This library is free software; you can redistribute it and/or
--  modify it under terms of the GNU General Public License as
--  published by the Free Software Foundation; either version 3, or (at
--  your option) any later version. This library is distributed in the
--  hope that it will be useful, but WITHOUT ANY WARRANTY; without even
--  the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
--  PURPOSE. See the GNU General Public License for more details. You
--  should have received a copy of the GNU General Public License
--  distributed with this program; see file COPYING. If not, write to
--  the Free Software Foundation, 59 Temple Place - Suite 330, Boston,
--  MA 02111-1307, USA.
--
--  As a special exception, if other files instantiate generics from
--  this unit, or you link this unit with other files to produce an
--  executable, this  unit  does not  by itself cause  the resulting
--  executable to be covered by the GNU General Public License. This
--  exception does not however invalidate any other reasons why the
--  executable file  might be covered by the  GNU Public License.

pragma License (Modified_GPL);

with Ada.Tags;
with Ada.Text_IO;
package AUnit.Check is

   generic
      type Item_Type is (<>);
   procedure Gen_Check_Discrete
     (Label    : in String;
      Computed : in Item_Type;
      Expected : in Item_Type);

   generic
      type Item_Type;
      type Item_Access_Type is access Item_Type;
   procedure Gen_Check_Access
     (Label    : in String;
      Computed : in Item_Access_Type;
      Expected : in Item_Access_Type);

   procedure Check
     (Label    : in String;
      Computed : in Boolean;
      Expected : in Boolean);

   procedure Check
     (Label    : in String;
      Computed : in String;
      Expected : in String);

   procedure Check
     (Label    : in String;
      Computed : in Integer;
      Expected : in Integer);

   procedure Check
     (Label    : in String;
      Computed : in Ada.Tags.Tag;
      Expected : in Ada.Tags.Tag);

   type Line_Number_Array_Type is array (Positive range <>) of Ada.Text_IO.Count;

   procedure Check_Files
     (Label         : in String;
      Computed_Name : in String;
      Expected_Name : in String;
      Skip          : in Line_Number_Array_Type := (1 .. 0 => 1));
   --  Compare files named Computed_Name and Expected_Name
   --
   --  Skip lines in Skip; this allows for lines with time stamps that
   --  are not repeatable.

end AUnit.Check;
