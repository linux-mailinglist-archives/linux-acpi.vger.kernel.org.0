Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A25B247B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2019 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfIMREi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Sep 2019 13:04:38 -0400
Received: from mailfilter04-out31.webhostingserver.nl ([141.138.168.145]:65343
        "EHLO mailfilter04-out31.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730967AbfIMREi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Sep 2019 13:04:38 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 13:04:37 EDT
X-Halon-ID: 310a252d-d646-11e9-b6df-001a4a4cb95f
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter04.webhostingserver.nl (Halon) with ESMTPSA
        id 310a252d-d646-11e9-b6df-001a4a4cb95f;
        Fri, 13 Sep 2019 16:47:37 +0000 (UTC)
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=[10.8.0.6])
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.2)
        (envelope-from <fntoth@gmail.com>)
        id 1i8okI-00ERzi-8M; Fri, 13 Sep 2019 18:48:30 +0200
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>
Cc:     Nikolaus Voss <nv@vosn.de>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nikolaus.voss@loewensteinmedical.de" 
        <nikolaus.voss@loewensteinmedical.de>,
        Jan Kiszka <jan.kiszka@siemens.com>
Newsgroups: gmane.linux.kernel,gmane.linux.acpi.devel
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909130911180.20316@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B967ADF6@ORSMSX110.amr.corp.intel.com>
 <20190913151228.GT2680@smile.fi.intel.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <7625fe37-1710-056d-fb9e-39c33fd962a1@gmail.com>
Date:   Fri, 13 Sep 2019 18:48:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913151228.GT2680@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all,

Sorry to have sent our message with cancelled e-mail address. I have 
correct this now.

Op 13-09-19 om 17:12 schreef Shevchenko, Andriy:
> On Fri, Sep 13, 2019 at 05:20:21PM +0300, Moore, Robert wrote:
>> -----Original Message-----
>> From: Nikolaus Voss [mailto:nv@vosn.de]
>> Sent: Friday, September 13, 2019 12:44 AM
>> To: Moore, Robert <robert.moore@intel.com>
>> Cc: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; Ferry Toth <ftoth@telfort.nl>; nikolaus.voss@loewensteinmedical.de
>> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
>>
>> Bob,
>>
>> On Thu, 12 Sep 2019, Moore, Robert wrote:
>>> The ability to unload an ACPI table (especially AML tables such as
>>> SSDTs) is in the process of being deprecated in ACPICA -- since it is
>>> also deprecated in the current ACPI specification. This is being done
>>> because of the difficulty of deleting the namespace entries for the
>>> table.  FYI, Windows does not properly support this function either.
>>
>> ok, I see it can be a problem to unload an AML table with all it's consequences e.g. with respect to driver unregistering in setups with complex dependencies. It will only work properly under certain conditions
>> - nevertheless acpi_tb_unload_table() is still exported in ACPICA and we should get this working as it worked before.
>>
>> AcpiTbUnloadTable is not exported, it is an internal interface only -- as
>> recognized by the "AcpiTb".
> 
> In Linux it became a part of ABI when the
> 
> commit 772bf1e2878ecfca0d1f332071c83e021dd9cf01
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Fri Jun 9 20:36:31 2017 +0200
> 
>      ACPI: configfs: Unload SSDT on configfs entry removal
> 
> appeared in the kernel.

And the commit message explains quite well why it is an important feature:

"This allows to change SSDTs without rebooting the system.
It also allows to destroy devices again that a dynamically loaded SSDT
created.

This is widely similar to the DT overlay behavior."

>> I'm not sure that I want to change the interface
>> to AcpiLoadTable just for something that is being deprecated. Already, we
>> throw an ACPI_EXCEPTION if the Unload operator is encountered in the AML byte
>> stream. The same thing with AcpiUnloadParentTable - it is being deprecated.
>>
>>      ACPI_EXCEPTION ((AE_INFO, AE_NOT_IMPLEMENTED,
>>          "AML Unload operator is not supported"));
> 

