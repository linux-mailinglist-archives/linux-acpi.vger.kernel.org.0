Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FCD1C77B8
	for <lists+linux-acpi@lfdr.de>; Wed,  6 May 2020 19:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgEFRV4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 May 2020 13:21:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:34355 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgEFRV4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 May 2020 13:21:56 -0400
IronPort-SDR: zLfp0CrEugNCL+MPTy2DJkdPesr/n8Nv4lsEz4xlpuonNnmPeClkKbkgtt8trmBiZdQ3SGBz6G
 WK7yz2zZQK4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 10:21:54 -0700
IronPort-SDR: 3rCiY0xA733YJl+fxDqC7Xrl04xKf8MfWJII+B25MyAGiPTSl1AXl8BgJSiTD2nW86QKlSt7CO
 m8it1bUhyc8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="461510228"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.151.242]) ([10.249.151.242])
  by fmsmga005.fm.intel.com with ESMTP; 06 May 2020 10:21:51 -0700
Subject: Re: 5.6 regression caused by "ACPICA: Dispatcher: always generate
 buffer objects for ASL create_field() operator"
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        Mattia Dongili <malattia@linux.it>,
        William Bader <williambader@hotmail.com>,
        Dominik Mierzejewski <dominik@greysector.net>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <49f20a91-9362-6249-d413-1461258d56a9@redhat.com>
 <11795a75-70de-5fcc-878f-14a0381947ea@gmail.com>
 <BYAPR11MB3096868FE8523B2F94A50F9DF0A70@BYAPR11MB3096.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <7fb8757c-41e7-3be0-5552-80696559bdfe@intel.com>
Date:   Wed, 6 May 2020 19:21:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3096868FE8523B2F94A50F9DF0A70@BYAPR11MB3096.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/6/2020 12:11 AM, Kaneda, Erik wrote:
>
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org <linux-acpi-
>> owner@vger.kernel.org> On Behalf Of Maximilian Luz
>> Sent: Tuesday, May 5, 2020 6:50 AM
>> To: Hans de Goede <hdegoede@redhat.com>; Wysocki, Rafael J
>> <rafael.j.wysocki@intel.com>; Moore, Robert <robert.moore@intel.com>;
>> Kaneda, Erik <erik.kaneda@intel.com>; Mattia Dongili <malattia@linux.it>;
>> William Bader <williambader@hotmail.com>; Dominik Mierzejewski
>> <dominik@greysector.net>
>> Cc: linux-acpi <linux-acpi@vger.kernel.org>; Darren Hart
>> <dvhart@infradead.org>; Andy Shevchenko <andy@infradead.org>;
>> platform-driver-x86@vger.kernel.org
>> Subject: Re: 5.6 regression caused by "ACPICA: Dispatcher: always generate
>> buffer objects for ASL create_field() operator"
>>
>> On 5/5/20 2:55 PM, Hans de Goede wrote:
>>> Hi All,
>>>
>>> Commit 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
>>> objects for ASL create_field() operator") has dropped the automatic
>>> conversion of small buffers into integers.
>>>
>>> But some drivers relied on this automatic conversion, these drivers
>>> have checks like this:
>>>
>>>           if (object->type != ACPI_TYPE_INTEGER) {
>>>                   pr_warn("Invalid acpi_object: expected 0x%x got 0x%x\n",
>>>                                   ACPI_TYPE_INTEGER, object->type);
>>>                   kfree(object);
>>>                   return -EINVAL;
>>>           }
>>>
>>> This specific bit comes from the sony-laptop (platform/x86) code, the
>>> ACPICA change has broken this code, causing systems using this driver
>>> to hang on resume from suspend.
>>>
>>> We have multiple bug-reports open for this already:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=207491
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1829096
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1830150
>>>
>>> Mattia Dongili, the sony-laptop driver has already submitted a fix for
>>> this upstream, adjusting the sony-laptop driver to deal with the
>>> returned object type now being a BUFFER.
>>>
>>> The goal of this email is to:
>>>
>>> 1. Make everyone involved aware of this breakage as we may see similar
>>> breakage elsewhere.
>>>
>>> 2. Discuss if we should maybe revert the ACPICA change.
>>>
>>> If you are reading this then 1. has been accomplished :)
>>>
>>> Which leaves us with 2. I'm tending towards keeping the change, since
>>> it seems the right thing to do and dealing with the fallout. But since
>>> there is fallout we should also at least consider reverting the ACPICA
>>> change.
>>>
>>> So ACPI maintainers what is you take on this ?
> What a mess. Several thoughts...
>
> I think we should keep the internal AML interpreter behavior as is because it solves a problem.

I also would prefer to deal with the fallout rather than to revert the fix.

I think that the potential damage is limited and the affected driver 
code should be fixed anyway which may not happen if the change in 
question is reverted.


> The ACPI spec says that buffers that are small enough to fit inside of integers should be treated as
> integers. However, we found that this is not the case for CreateField operators. The internal
> representation of this needs to be a buffer to match MS AML interpreter.
>
> SNC is not a pre-defined method so we actually don't know what the return type is supposed
> to be. At some point during the development of this driver, it's likely that someone made an observation
> about what "SNC" returned at some point in time and continued to assume that it will use the same
> type.
>
> For methods that are not a part of the ACPI specification, buffers less than or equal to 8 bytes and
> integers could be used interchangeably. I don't see a reason why the data inside the buffer should be
> invalid.
>
> Erik
>>> Regards,
>>>
>>> Hans
>> Hi,
>>
>> I'd like to advise against reverting the commit. Quite honestly, I don't think
>> reverting the commit is a good idea. This will break things for devices that
>> assume Microsoft-like AML interpreter behavior _inside_ the DSDT. Such as
>> the MS Surface devices for example, which, as stated in the commit message,
>> depend on the type being Buffer via a check on ObjectType(...). There is no
>> fix for those devices other than a) accepting MS behavior in ACPICA, b)
>> introducing a quirk in ACPICA which switches between behaviors on a device
>> basis, or c) patching the DSDT of those devices specifically for Linux.
>>
>> I'd also argue that since this is MS behavior, this is the behavior that almost all
>> consumer electronics devices with ACPI will expect. Case in point, the DSDT
>> of one of the affected Sony laptops, which contains the following code:
>>
>>           CreateField (SNBF, Zero, 0x20, SNBD)
>>           CreateWordField (SNBF, 0x02, CPW0)
>>           CreateWordField (SNBF, 0x04, CPW1)
>>           CreateWordField (SNBF, Zero, RCW0)
>>           CreateWordField (SNBF, 0x02, RCW1)
>>
>> They explicitly create a Buffer field of 32 bits via CreateField and not a 32 bit
>> Integer field via CreateDWordField. I'd argue that if they wanted this field to
>> be an Integer, CreateDWordField would be the straight-forward approach.
>>
>> Unfortunately, I also don't see a way to identify all affected calls to ACPI
>> functions automatically or easily, as this requires to look at the DSDTs and the
>> code behind those calls. If you have DSDTs, here's a way to identify if that
>> particular DSDT/driver combo is affected:
>>
>> If a call to an ACPI function expects an Integer and the ACPI function returns
>> a field created with CreateField(...) and the field is smaller than 64 bits (on
>> 64bit machines), then this call is affected.
>>
>> The only semi-reasonable way, as far as I can see, to identify this on a broad
>> scale is to get this information out to the respective maintainers of drivers
>> with apci_evaluate_{integer,object,dsm,..?} calls and ask them to check
>> those calls against DSDTs. Also maybe help them by introducing a function
>> which does Buffer-to-Integer conversion.
>>
>> Regards,
>> Maximilian
>>

