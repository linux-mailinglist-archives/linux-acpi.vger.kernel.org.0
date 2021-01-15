Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB26B2F810E
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 17:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbhAOQnr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 11:43:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:25710 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbhAOQnr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 11:43:47 -0500
IronPort-SDR: E5g0fkpqvwJ/+6ehG7WU0okm/+EdzGqbL1RGGqp9e9ZXY1iGzs7U/ZYFuvyYdDsbveKXrF1o1L
 N0xm07SCBXvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166242945"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="166242945"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 08:42:00 -0800
IronPort-SDR: zrJqSqxAYzqvQCABeShysI4jePQp9mqfbjCDQn5YGrx2qPH1l+9Ebdf61v5FbOKrnVr3Zk1gWd
 AqLZm1QmYgsA==
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="364630530"
Received: from kshimanx-mobl.amr.corp.intel.com (HELO [10.212.104.192]) ([10.212.104.192])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 08:41:59 -0800
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <CAJZ5v0i63MsXX18rat7XfxUHBsc_OKD1nZvdv07WytgNP7+mtQ@mail.gmail.com>
 <c27b98bf-c829-e128-cb74-149b14028a22@linux.intel.com>
 <10742637.M1KgVVZ4YP@kreacher>
 <8ca863bc-f312-8757-5f03-5364a691a860@linux.intel.com>
 <ee83595b-9e87-aab9-de81-ecb3d691258f@redhat.com>
 <CAJZ5v0j87iF7S2-H+5D3A9HbRBA=W03r_9GPgwWLtH6nLwwZfw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8b316bf8-6a5c-c6d4-c0db-304ec529c805@linux.intel.com>
Date:   Fri, 15 Jan 2021 10:41:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j87iF7S2-H+5D3A9HbRBA=W03r_9GPgwWLtH6nLwwZfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


>>> [    0.516336] ACPI: \_SB_.PCI0.BRCM: Dependencies found
>>
>> Ah, that is enlightening, that is not supposed to happen, that device
>> has both an _ADR and an _HID method which is not allowed according
>> to the spec.

it's not an uncommon issue for audio codecs, here's three examples:

             Device (RTK1)
             {
                 Name (_ADR, Zero)  // _ADR: Address
                 Name (_HID, "10EC5670")  // _HID: Hardware ID
                 Name (_CID, "10EC5670")  // _CID: Compatible ID
                 Name (_DDN, "ALC5642")  // _DDN: DOS Device Name

         Device (MAXM)
         {
             Name (_ADR, Zero)  // _ADR: Address
             Name (_HID, "193C9890")  // _HID: Hardware ID
             Name (_CID, "193C9890")  // _CID: Compatible ID
             Name (_DDN, "Maxim 98090 Codec  ")  // _DDN: DOS Device Name

         Device (TISW)
         {
             Name (_ADR, Zero)  // _ADR: Address
             Name (_HID, "104C227E")  // _HID: Hardware ID
             Name (_CID, "104C227E")  // _CID: Compatible ID

It's been that way for years...

>> Can you try a clean 5.11 kernel (so none of the previous
>> debug patches) with the following change added:
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 1f27f74cc83c..93954ac3bfcc 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1854,7 +1854,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
>>           * 2. ACPI nodes describing USB ports.
>>           * Still, checking for _HID catches more then just these cases ...
>>           */
>> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
>> +       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID") ||
>> +           acpi_has_method(handle, "_ADR"))
>>                  return 0;
>>
>>          status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
>>
>>
>>> [    0.517490] ACPI: \_SB_.PCI0.LNPW: Dependencies found
>>
>> And idem. for this one.
>>
>> That might very well fix this.

Nope, no luck with this patch. boot still stuck.

> It might.
> 
> That said, there are "interesting" dependencies in those ACPI tables
> (like on the PMIC which is deferred, because it depends on I2C7 and
> GP01 and even some power resources depend on it).
> 
