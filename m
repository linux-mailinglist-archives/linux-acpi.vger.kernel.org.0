Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97DB3B191E
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2019 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfIMHoE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Sep 2019 03:44:04 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:58042 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfIMHoE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Sep 2019 03:44:04 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 1F5CF46A74; Fri, 13 Sep 2019 09:44:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 1BA5446776;
        Fri, 13 Sep 2019 09:44:02 +0200 (CEST)
Date:   Fri, 13 Sep 2019 09:44:02 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     "Moore, Robert" <robert.moore@intel.com>
cc:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ferry Toth <ftoth@telfort.nl>,
        nikolaus.voss@loewensteinmedical.de
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1909130911180.20316@fox.voss.local>
References: <20190906174605.GY2680@smile.fi.intel.com> <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de> <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Bob,

On Thu, 12 Sep 2019, Moore, Robert wrote:
> The ability to unload an ACPI table (especially AML tables such as 
> SSDTs) is in the process of being deprecated in ACPICA -- since it is 
> also deprecated in the current ACPI specification. This is being done 
> because of the difficulty of deleting the namespace entries for the 
> table.  FYI, Windows does not properly support this function either.

ok, I see it can be a problem to unload an AML table with all it's 
consequences e.g. with respect to driver unregistering in setups with 
complex dependencies. It will only work properly under certain conditions 
- nevertheless acpi_tb_unload_table() is still exported in ACPICA and we 
should get this working as it worked before.

The API change I request is not directly related to table unloading, it's 
just that the index of the loaded table is returned for future reference:

[...]

>> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index 3845c8fcc94e5..c90bbdc4146a6 100644
>> --- a/include/acpi/acpixf.h
>> +++ b/include/acpi/acpixf.h
>> @@ -452,7 +452,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>> 					       u8 physical))
>>
>> ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>> -			    acpi_load_table(struct acpi_table_header *table))
>> +			    acpi_load_table(struct acpi_table_header *table,
>> +					    u32 *table_idx))
>>
>> ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>> 			    acpi_unload_parent_table(acpi_handle object))
>> --
>> 2.17.1
>>

This allows for a simple fix of the regression and doesn't imply future 
support for table unloading. Would this be acceptable?

Niko
