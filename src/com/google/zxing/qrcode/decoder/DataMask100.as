/*
 * Copyright 2013 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.zxing.qrcode.decoder
{
		import com.google.zxing.qrcode.decoder.DataMaskBase;

  /**
   * 100: mask bits for which (x/2 + y/3) mod 2 == 0
   */
  public class DataMask100 extends DataMaskBase {

    public override function isMasked(i:int, j:int):Boolean {
      return (((i >>> 1) + (int(j /3))) & 0x01) == 0;
    }
  }


    
}