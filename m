Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE9107C07
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Nov 2019 01:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKWAdd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 19:33:33 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36142 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWAdd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2019 19:33:33 -0500
Received: by mail-wm1-f42.google.com with SMTP id n188so7701037wme.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2019 16:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SeCyk7HOYdzMfs1B1VQmyIAPtP/kuuTVCL8fwRoPdOU=;
        b=e61U2rL2yIrpRc6bNbrXMY3LKFdrM2zC+aWDlPiekfK5jonaSDxDJOK654knJKpcVb
         hOdIQ6FUydYUHxS/OsNk0ZJjiRkG4YZmrNFamh9pJJKLJDTK/hbMC+kpTDpDR/4xKdBi
         AB/Oh72OV6aqekfdy6Dfdbb0aOHCUGS+53egI9prMxIjXO4QxrQa1EvdgJDr9LyBKxWF
         A7burM/vB4EFPFot0AE00X3swRat+X1vQwmORIy+sjlxBkO+XbQElkvRZkFrrdaiwFIt
         xiuqA5o7uMRt9ew3NibsgFCuzPQ6X3sLnkVgT7HcKUMQae0fqicBIkWYrIXNTiyOGn0l
         syyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SeCyk7HOYdzMfs1B1VQmyIAPtP/kuuTVCL8fwRoPdOU=;
        b=TV8EVVJ9Tpj8rPRWCFXRlj3Wg85F/KyAnf+nXLSQofIpDYQHRjmaBAr3pbzDJiBQ36
         qGTGrHQI0gkACMHmzLcmRCArIYMn9uchnxia+Hd8dzilIEIuh++LxeLjCS7hXNWuriou
         UunTkQA71Hfjv/qsfL9BbYyAhcuaqR8lu//jXTxFxlPj+vDR84b7CSwcMiBzShob+L7n
         BwGIw4FZlBECGp37xyST/oLsifrsK4Q8hgi2yTYJqW1KPxE6CqvJFL6Bx3rGvQIZ3tay
         6YFV8Ch6Rddu+Bhr0NEGVqrUboJKYL6TWssYJQ6pLPROrT6TWkWcfz/68mYYPW7zw4QK
         uXog==
X-Gm-Message-State: APjAAAUWr3rl95hAuT/AQ+WsyFwRUyJ+MGrl0e5lDXZD4BAijLAt23pX
        M9PfRtLV6JD9gddlx1kk4Dkm2z3l
X-Google-Smtp-Source: APXvYqyu0OD73qaQw7FDmCn02T8h58W0p/gdGE9wxy0G1sWWGvZGDSjc2VOSIUPCBp0Rqos1SDbjhQ==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr19595145wmi.64.1574469210383;
        Fri, 22 Nov 2019 16:33:30 -0800 (PST)
Received: from [192.168.2.202] (pD9E5A9AC.dip0.t-ipconnect.de. [217.229.169.172])
        by smtp.gmail.com with ESMTPSA id z11sm3143wrg.0.2019.11.22.16.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 16:33:29 -0800 (PST)
Subject: Re: PROBLEM: Calling ObjectType on buffer field reports type integer
To:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C592D47@ORSMSX122.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C59405C@ORSMSX122.amr.corp.intel.com>
 <fe4bcc1c-5c15-caa6-ce01-a5df962ff008@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5942CA@ORSMSX122.amr.corp.intel.com>
 <51e156ec-c2ed-84be-13c0-99a213e1d4b7@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C595C50@ORSMSX122.amr.corp.intel.com>
 <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
 <c6511010-f160-a2ee-1b89-46df051a85e4@gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B196C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A77@ORSMSX110.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C68481C@ORSMSX122.amr.corp.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <20f023a8-67f2-71dd-266d-700012c05b39@gmail.com>
Date:   Sat, 23 Nov 2019 01:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C68481C@ORSMSX122.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 11/23/19 12:29 AM, Schmauss, Erik wrote:
> Bob and I started debugging this and we found the issue:
> 
> Let's say that we have this code:
> 
> Name (BUF1, Buffer (0x10) {})
> Method (M001)
> {
>      CreateField (BUF1, 1, 72, FLD0)
>      local0 = FLD0 // BUG: store operator (aka =)  converts FLD0 into an integer
>      return (ObjectType (local0)) // Integer is returned
> }
> 
> Although FLD0's value is small enough to fit in an integer, the bit length of FLD0 exceeds 64 bits so local0 should actually be a Buffer type.
> 
> This is likely an issue in the implicit object conversion rules implemented in the store operator. I'll take a look at this next week or the week after...

This looks like a separate problem to me. On the SB2 there is this piece
of code, simplified:

     Name(RQBF, Buffer (0xFF) {})
     CreateByteField (RQBF, 0x03, ALEN)

     // ...
     // GenericSerialBus/AttribRawProcessBytes access to fill RQBF
     // ...

     If (/* success and everything is valid */)
     {
         Local3 = (ALEN * 0x08)
         CreateField (RQBF, 0x20, Local3, ARB)
         Local4 = ARB /* \_SB_._SAN.RQSX.ARB_ */
     }
     Else
     {
         Local4 = 0x01   // or some other error code as integer
     }

     // ...
     // some more stuff
     // ...

     If ((ObjectType (Local4) == One /* Integer */))
     {
         // notify that an error has occurred
     }
     Else
     {
         // success and actually use data from Local4
     }

The code in question basically unpacks a payload from some other
management stuff sent over the OperationRegion.

Here, ALEN is the length of a dynamically sized payload in bytes, which
is obtained from the data returned by the OperationRegion access. This
can for example be 4, making the field length 32 bit. So this is not an
issue of the field length being larger than intmax bits, it actually is
sometimes only 32 bits, or 8 bits, depending on the response of the
driver connected to the OperationRegion. Also the DSDT depends on that,
see the example below.

Just to reiterate, the code works fine for payloads with ALEN > 8 (so
more than 8 bytes), but fails for anything less.

Also note that this is not something that can be fixed by just telling
the GenericSerialBus/OperationRegion driver to just return 9 bytes
instead: There are length-checks on Local4 further down the line to
validate it actually contains what was requested.

An example of how this piece of code is actually used, if that helps
(again simplified):

     Method (RQST, 1)
     {
         // pretty much the code above
         Return (Local4)     // either payload or integer error code
     }

     Scope (_SB.BAT1)
     {
         Method (_STA, 0)
         {
             Local0 = RQST(0x01)     // request battery status

             If ((ObjectType (Local0) == 0x03))      // is buffer type
             {
                 If ((SizeOf (Local0) == 0x04))      // has length 4
                 {
                     CreateDWordField (Local0, 0, BAST)
                     Return (BAST)
                 }
             }

             Return (0x00)           // return default value
         }
     }


Regards,
Maximilian
