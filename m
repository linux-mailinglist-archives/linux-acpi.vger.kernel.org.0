Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08783BF97C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2019 20:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfIZSof (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Sep 2019 14:44:35 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:33348 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbfIZSof (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Sep 2019 14:44:35 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 979AE4D586; Thu, 26 Sep 2019 20:44:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 95F9D4D574;
        Thu, 26 Sep 2019 20:44:33 +0200 (CEST)
Date:   Thu, 26 Sep 2019 20:44:33 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
cc:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Moore, Robert" <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C6481F2@ORSMSX122.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1909262043380.13592@fox.voss.local>
References: <20190906174605.GY2680@smile.fi.intel.com> <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de> <CF6A88132359CE47947DB4C6E1709ED53C6481B1@ORSMSX122.amr.corp.intel.com> <20190926163528.GH32742@smile.fi.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C6481F2@ORSMSX122.amr.corp.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 26 Sep 2019, Schmauss, Erik wrote:
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org>
>> On Behalf Of Shevchenko, Andriy
>> Sent: Thursday, September 26, 2019 9:35 AM
>> To: Schmauss, Erik <erik.schmauss@intel.com>
>> Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>; Rafael J. Wysocki
>> <rjw@rjwysocki.net>; Moore, Robert <robert.moore@intel.com>; Len Brown
>> <lenb@kernel.org>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel
>> Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; linux-
>> acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org;
>> nv@vosn.de
>> Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
>>
>> On Thu, Sep 26, 2019 at 07:09:05PM +0300, Schmauss, Erik wrote:
>>>> -----Original Message-----
>>>> From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>>>> Sent: Thursday, September 12, 2019 1:08 AM
>>>> To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik
>>>> <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
>>>> Moore, Robert <robert.moore@intel.com>
>>>> Cc: Len Brown <lenb@kernel.org>; Jacek Anaszewski
>>>> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan
>>>> Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org;
>>>> devel@acpica.org; linux- kernel@vger.kernel.org; nv@vosn.de;
>>>> Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>>>> Subject: [PATCH] ACPICA: make acpi_load_table() return table index
>>>>
>>> Hi Nikolaus,
>>>
>>>> For unloading an ACPI table, it is necessary to provide the index of the table.
>>>> The method intended for dynamically loading or hotplug addition of
>>>> tables, acpi_load_table(), should provide this information via an
>>>> optional pointer to the loaded table index.
>>>
>>> We'll take this patch for ACPICA upstream
>>
>> Erik,
>>
> Hi Andy,
>
>> how about to have also counterpart to acpi_load_table() which will do what it's
>> done now in acpi_configfs.c via acpi_tb_*() API?
>
> I should have given more details. We decided to add this extra parameter 
> in AcpiLoadTable and we're going to create an AcpiUnloadTable function 
> that will take table index to unload the table (basically the 
> acpi_tb_unload..). Once we do this, you can use table indices with 
> AcpiUnloadTable and AcpiLoadTable.

that's even better news.

Rafael, shall I prepare anything?

Niko

>
> Erik
>>
>> Because it's kinda strange to call acpi_load_table*() and acpi_tb_*() in the
>> same module.
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>

-- 
Nikolaus Voss - Aastwiete 4 - 22880 Wedel

