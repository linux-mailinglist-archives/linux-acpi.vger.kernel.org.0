Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A5BB0E2
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Sep 2019 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406399AbfIWJFP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Sep 2019 05:05:15 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:38796 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbfIWJFO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Sep 2019 05:05:14 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 365F44D574; Mon, 23 Sep 2019 11:05:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 326184D564;
        Mon, 23 Sep 2019 11:05:10 +0200 (CEST)
Date:   Mon, 23 Sep 2019 11:05:10 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     "Moore, Robert" <robert.moore@intel.com>
cc:     Ferry Toth <fntoth@gmail.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9686438@ORSMSX110.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1909231100190.16390@fox.voss.local>
References: <20190906174605.GY2680@smile.fi.intel.com> <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de> <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com> <alpine.DEB.2.20.1909130911180.20316@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B967ADF6@ORSMSX110.amr.corp.intel.com> <20190913151228.GT2680@smile.fi.intel.com> <7625fe37-1710-056d-fb9e-39c33fd962a1@gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E3B967AEC9@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909161134070.2910@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B968327D@ORSMSX110.amr.corp.intel.com> <alpine.DEB.2.20.1909181624550.3925@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B9686438@ORSMSX110.amr.corp.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 19 Sep 2019, Moore, Robert wrote:
>
>
> -----Original Message-----
> From: Nikolaus Voss [mailto:nv@vosn.de]
> Sent: Wednesday, September 18, 2019 7:32 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Ferry Toth <fntoth@gmail.com>; Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; Jan Kiszka <jan.kiszka@siemens.com>
> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
>
> On Wed, 18 Sep 2019, Moore, Robert wrote:
>>
>>
>> -----Original Message-----
>> From: Nikolaus Voss [mailto:nv@vosn.de]
>> Sent: Monday, September 16, 2019 2:47 AM
>> To: Moore, Robert <robert.moore@intel.com>
>> Cc: Ferry Toth <fntoth@gmail.com>; Shevchenko, Andriy
>> <andriy.shevchenko@intel.com>; Schmauss, Erik
>> <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len
>> Brown <lenb@kernel.org>; Jacek Anaszewski
>> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
>> <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org;
>> linux-kernel@vger.kernel.org; Jan Kiszka <jan.kiszka@siemens.com>
>> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
>>
>> On Fri, 13 Sep 2019, Moore, Robert wrote:
>>>
>>>
>>> -----Original Message-----
>>> From: Ferry Toth [mailto:fntoth@gmail.com]
>>> Sent: Friday, September 13, 2019 9:48 AM
>>> To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Moore, Robert
>>> <robert.moore@intel.com>
>>> Cc: Nikolaus Voss <nv@vosn.de>; Schmauss, Erik
>>> <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len
>>> Brown <lenb@kernel.org>; Jacek Anaszewski
>>> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
>>> <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org;
>>> linux-kernel@vger.kernel.org; nikolaus.voss@loewensteinmedical.de;
>>> Jan Kiszka <jan.kiszka@siemens.com>
>>> Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table
>>> index
>>>
>>> Hello all,
>>>
>>> Sorry to have sent our message with cancelled e-mail address. I have correct this now.
>>>
>>> Op 13-09-19 om 17:12 schreef Shevchenko, Andriy:
>>>> On Fri, Sep 13, 2019 at 05:20:21PM +0300, Moore, Robert wrote:
>>>>> -----Original Message-----
>>>>> From: Nikolaus Voss [mailto:nv@vosn.de]
>>>>> Sent: Friday, September 13, 2019 12:44 AM
>>>>> To: Moore, Robert <robert.moore@intel.com>
>>>>> Cc: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss,
>>>>> Erik <erik.schmauss@intel.com>; Rafael J. Wysocki
>>>>> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Jacek Anaszewski
>>>>> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan
>>>>> Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org;
>>>>> devel@acpica.org; linux-kernel@vger.kernel.org; Ferry Toth
>>>>> <ftoth@telfort.nl>; nikolaus.voss@loewensteinmedical.de
>>>>> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table
>>>>> index
>>>>>
>>>>> Bob,
>>>>>
>>>>> On Thu, 12 Sep 2019, Moore, Robert wrote:
>>>>>> The ability to unload an ACPI table (especially AML tables such as
>>>>>> SSDTs) is in the process of being deprecated in ACPICA -- since it
>>>>>> is also deprecated in the current ACPI specification. This is
>>>>>> being done because of the difficulty of deleting the namespace
>>>>>> entries for the table.  FYI, Windows does not properly support this function either.
>>>>>
>>>>> ok, I see it can be a problem to unload an AML table with all it's
>>>>> consequences e.g. with respect to driver unregistering in setups
>>>>> with complex dependencies. It will only work properly under certain
>>>>> conditions
>>>>> - nevertheless acpi_tb_unload_table() is still exported in ACPICA and we should get this working as it worked before.
>>>>>
>>>>> AcpiTbUnloadTable is not exported, it is an internal interface only
>>>>> -- as recognized by the "AcpiTb".
>>>>
>>>> In Linux it became a part of ABI when the
>>>>
>>>> commit 772bf1e2878ecfca0d1f332071c83e021dd9cf01
>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Date:   Fri Jun 9 20:36:31 2017 +0200
>>>>
>>>>      ACPI: configfs: Unload SSDT on configfs entry removal
>>>>
>>>> appeared in the kernel.
>>>
>>> And the commit message explains quite well why it is an important feature:
>>>
>>> "This allows to change SSDTs without rebooting the system.
>>> It also allows to destroy devices again that a dynamically loaded SSDT created.
>>>
>>> The biggest problem AFAIK is that under linux, many drivers cannot be unloaded. Also, there are many race conditions as the namespace entries "owned" by an SSDT being unloaded are deleted (out from underneath a driver).
>>>
>>> This is widely similar to the DT overlay behavior."
>>>
>>>>> I'm not sure that I want to change the interface to AcpiLoadTable
>>>>> just for something that is being deprecated. Already, we throw an
>>>>> ACPI_EXCEPTION if the Unload operator is encountered in the AML
>>>>> byte stream. The same thing with AcpiUnloadParentTable - it is being deprecated.
>>>>>
>>>>>      ACPI_EXCEPTION ((AE_INFO, AE_NOT_IMPLEMENTED,
>>>>>          "AML Unload operator is not supported"));
>>
>> Bob, what is your suggestion to fix the regression then?
>>
>> We could revert acpi_configfs.c to use
>> acpi_tb_install_and_load_table() instead of acpi_load_table(), leaving
>> loaded APCI objects uninitalized, but at least, unloading will work again.
>>
>> I guess my next question is: why do you want to unload a table in the
>> first place?
>
> Because it worked before and there are people who rely on it. If it's 
> deprecated there should be a user notification and a reasonable 
> end-of-life timeline to give these users a chance to develop an 
> alternative solution.
>
> So, I still don't understand why this no longer works. We did not make 
> any purposeful changes in this area - AFAIK. Bob

It's because the acpi_configfs driver formerly used 
acpi_tb_install_and_load_table() which returns the table index, but 
doesn't resolve the references. It now uses acpi_load_table() which 
resolves the references, but doesn't return the table index, so unloading 
doesn't work any more.

>
> Niko
>
>>
>>
>> Do we have any other options?
>>
>> Niko
>>
>
