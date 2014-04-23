package com.google.zxing.client.result
{
/*
 * Copyright 2007 ZXing authors
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
import com.google.zxing.Result;
import com.google.zxing.common.flexdatatypes.HashTable;

/**
 * Represents a result that encodes an e-mail address, either as a plain address
 * like "joe(at)example.org" or a mailto: URL like "mailto:joe(at)example.org".
 *
 * @author Sean Owen
 */
public final class EmailAddressResultParser extends ResultParser {

  public static function  parse(result:Result):EmailAddressParsedResult {
    var rawText:String  = result.getText();
    if (rawText == null) {
      return null;
    }
    var emailAddress:String;
    if ((rawText.substr(0,7) == "mailto:") || (rawText.substr(0,7) == "MAILTO:")) {
      // If it starts with mailto:, assume it is definitely trying to be an email address
      emailAddress = rawText.substring(7);
      var queryStart:int = emailAddress.indexOf('?');
      if (queryStart >= 0) {
        emailAddress = emailAddress.substring(0, queryStart);
      }
      var nameValues:HashTable = parseNameValuePairs(rawText);
      var subject:String = null;
      var body:String = null;
      if (nameValues != null) {
        if (emailAddress.length == 0) {
          emailAddress = String( nameValues._get("to"));
        }
        subject = String(nameValues._get("subject"));
        body = String(nameValues._get("body"));
      }
      return new EmailAddressParsedResult(emailAddress, subject, body, rawText);
    } else {
      if (!EmailDoCoMoResultParser.isBasicallyValidEmailAddress(rawText)) {
        return null;
      }
      emailAddress = rawText;
      return new EmailAddressParsedResult(emailAddress, null, null, "mailto:" + emailAddress);
    }
  }

}}