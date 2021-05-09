Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D112377795
	for <lists+linux-acpi@lfdr.de>; Sun,  9 May 2021 18:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhEIQaL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 9 May 2021 12:30:11 -0400
Received: from gusto.metanet.ch ([80.74.154.155]:37211 "EHLO gusto.metanet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhEIQaK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 9 May 2021 12:30:10 -0400
Received: from [IPv6:2001:1715:9d9d:aa90:f994:fe8f:7236:9006] (localhost [127.0.0.1]) by gusto.metanet.ch (Postfix) with ESMTPSA id 930794F00FF8;
        Sun,  9 May 2021 18:29:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fabwu.ch; s=default;
        t=1620577745; bh=9rOWSK4pqfbFXroXK6Sw2Jy5GPRcCkJx2iD7Kint+aA=;
        h=Subject:To:From;
        b=r4jApK5WE6x5CaXgrYXgRPS81qgvHlwClnOgxsCtOh86akq2oUxLWiBjPj8WWo+NT
         H/bupTDfqEZzFz4h0aUTCgC4VCk0bKYvAiwAtidPdNG0cCBad09QTPxiKvSes1UzIi
         C73/sXP7WlTToj+X186xDn0IgYLeoMhljENnQ6xk=
Authentication-Results: gusto.metanet.ch;
        spf=pass (sender IP is 2001:1715:9d9d:aa90:f994:fe8f:7236:9006) smtp.mailfrom=me@fabwu.ch smtp.helo=[IPv6:2001:1715:9d9d:aa90:f994:fe8f:7236:9006]
Received-SPF: pass (gusto.metanet.ch: connection is authenticated)
Subject: Re: [PATCH v3 1/2] ACPI: Add _PLD panel positions
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20210413063435.18111-1-me@fabwu.ch>
 <20210414083022.25453-1-me@fabwu.ch> <20210414083022.25453-2-me@fabwu.ch>
 <CAJZ5v0ich7DA47ybP552MJJg6-TkShnJyGcrz0PpWYETHHREHQ@mail.gmail.com>
From:   =?UTF-8?Q?Fabian_W=c3=bcthrich?= <me@fabwu.ch>
Message-ID: <9cd3609d-238c-afb1-5976-8fb5577c8a3d@fabwu.ch>
Date:   Sun, 9 May 2021 18:29:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ich7DA47ybP552MJJg6-TkShnJyGcrz0PpWYETHHREHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Erik,

Do I need to add anything to this patch or is it fine like that?

Thanks,
Fabian

On 14.04.21 15:50, Rafael J. Wysocki wrote:
> On Wed, Apr 14, 2021 at 10:30 AM Fabian Wüthrich <me@fabwu.ch> wrote:
>>
>> The ACPI specification v6.3 defines the panel positions in chapter 6.1.8
>> "_PLD (Physical Location of Device)"
>>
>> Signed-off-by: Fabian Wüthrich <me@fabwu.ch>
>> Reviewed-by: Daniel Scally <djrscally@gmail.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> This is ACPICA material.
> 
> Erik, can you pick up this one, please?
> 
>> ---
>>  include/acpi/acbuffer.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
>> index 18197c16149f..d42e82a82852 100644
>> --- a/include/acpi/acbuffer.h
>> +++ b/include/acpi/acbuffer.h
>> @@ -207,4 +207,13 @@ struct acpi_pld_info {
>>  #define ACPI_PLD_GET_HORIZ_OFFSET(dword)        ACPI_GET_BITS (dword, 16, ACPI_16BIT_MASK)
>>  #define ACPI_PLD_SET_HORIZ_OFFSET(dword,value)  ACPI_SET_BITS (dword, 16, ACPI_16BIT_MASK, value)      /* Offset 128+16=144, Len 16 */
>>
>> +/* Panel position defined in _PLD section of ACPI Specification 6.3 */
>> +#define ACPI_PLD_PANEL_TOP                     0
>> +#define ACPI_PLD_PANEL_BOTTOM                  1
>> +#define ACPI_PLD_PANEL_LEFT                    2
>> +#define ACPI_PLD_PANEL_RIGHT                   3
>> +#define ACPI_PLD_PANEL_FRONT                   4
>> +#define ACPI_PLD_PANEL_BACK                    5
>> +#define ACPI_PLD_PANEL_UNKNOWN                 6
>> +
>>  #endif                         /* ACBUFFER_H */
>> --
>> 2.31.1
>>
