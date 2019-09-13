Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8BB21CE
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2019 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfIMOUa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 13 Sep 2019 10:20:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:44618 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfIMOU3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Sep 2019 10:20:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 07:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,501,1559545200"; 
   d="scan'208";a="185111065"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2019 07:20:22 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Sep 2019 07:20:22 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.57]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.217]) with mapi id 14.03.0439.000;
 Fri, 13 Sep 2019 07:20:22 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Nikolaus Voss <nv@vosn.de>
CC:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "Pavel Machek" <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ferry Toth <ftoth@telfort.nl>,
        "nikolaus.voss@loewensteinmedical.de" 
        <nikolaus.voss@loewensteinmedical.de>
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Topic: [PATCH] ACPICA: make acpi_load_table() return table index
Thread-Index: AQHVaUE6M44QnoJV0UqVXW85SrAmnKcoFnTQgAGaZwD///c2gA==
Date:   Fri, 13 Sep 2019 14:20:21 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B967ADF6@ORSMSX110.amr.corp.intel.com>
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909130911180.20316@fox.voss.local>
In-Reply-To: <alpine.DEB.2.20.1909130911180.20316@fox.voss.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWVkNGQxYWEtM2M4NC00MTUzLWIwMDYtMzBjYzUxNWY4ZTA3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieHFETnZUbHBtcml3MkEzS1lRaXBLSVVZdktQaHUrQkp0MnZWNFwvU1pMV1ErSUdwZ29cL1wvMjJcL3JHZDV2aVM2dmMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



-----Original Message-----
From: Nikolaus Voss [mailto:nv@vosn.de] 
Sent: Friday, September 13, 2019 12:44 AM
To: Moore, Robert <robert.moore@intel.com>
Cc: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; Ferry Toth <ftoth@telfort.nl>; nikolaus.voss@loewensteinmedical.de
Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index

Bob,

On Thu, 12 Sep 2019, Moore, Robert wrote:
> The ability to unload an ACPI table (especially AML tables such as
> SSDTs) is in the process of being deprecated in ACPICA -- since it is 
> also deprecated in the current ACPI specification. This is being done 
> because of the difficulty of deleting the namespace entries for the 
> table.  FYI, Windows does not properly support this function either.

ok, I see it can be a problem to unload an AML table with all it's consequences e.g. with respect to driver unregistering in setups with complex dependencies. It will only work properly under certain conditions
- nevertheless acpi_tb_unload_table() is still exported in ACPICA and we should get this working as it worked before.

AcpiTbUnloadTable is not exported, it is an internal interface only -- as recognized by the "AcpiTb". I'm not sure that I want to change the interface to AcpiLoadTable just for something that is being deprecated. Already, we throw an ACPI_EXCEPTION if the Unload operator is encountered in the AML byte stream. The same thing with AcpiUnloadParentTable - it is being deprecated.


    ACPI_EXCEPTION ((AE_INFO, AE_NOT_IMPLEMENTED,
        "AML Unload operator is not supported"));


The API change I request is not directly related to table unloading, it's just that the index of the loaded table is returned for future reference:

[...]

>> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index 
>> 3845c8fcc94e5..c90bbdc4146a6 100644
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

This allows for a simple fix of the regression and doesn't imply future support for table unloading. Would this be acceptable?

Niko
