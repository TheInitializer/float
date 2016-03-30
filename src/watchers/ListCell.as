/*
 * Scratch Project Editor and Player
 * Copyright (C) 2014 Massachusetts Institute of Technology
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

package watchers {
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import uiwidgets.ResizeableFrame;

public class ListCell extends Sprite {

	private const format:TextFormat = new TextFormat(CSS.font, 11, 0xFFFFFF, true);

	public var tf:TextField;
	private var frame:ResizeableFrame;

	public function ListCell(s:String, width:int, whenChanged:Function, nextCell:Function) {
		frame = new ResizeableFrame(0xFFFFFF, Specs.listColor, 6, true);
		addChild(frame);
		addTextField(whenChanged, nextCell);
		tf.text = s;
		setWidth(width);
	}

	public function setText(s:String, w:int = 0):void {
		// Set the text and, optionally, the width.
		tf.text = s;
		setWidth((w > 0) ? w : frame.w);
	}

	public function setEditable(isEditable:Boolean):void {
		tf.type = isEditable ? 'input' : 'dynamic';
	}

	public function setWidth(w:int):void {
		tf.width = Math.max(w, 15); // forces line wrapping, possibly changing tf.height
		var frameH:int = Math.max(tf.textHeight + 7, 20);
		frame.setWidthHeight(tf.width, frameH);
	}

	private function addTextField(whenChanged:Function, nextCell:Function):void {
		tf = new TextField();
		tf.type = 'input';
		tf.wordWrap = true;
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.defaultTextFormat = format;
		tf.x = 3;
		tf.y = 1;
		tf.addEventListener(Event.CHANGE, whenChanged);
		tf.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, nextCell);
		addChild(tf);
	}

	public function select():void {
		stage.focus = tf;
		tf.setSelection(0, tf.getLineLength(0));
	}

}}
