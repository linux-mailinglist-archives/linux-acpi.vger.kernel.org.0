Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1432F8D4D
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jan 2021 13:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbhAPM15 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Jan 2021 07:27:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbhAPM15 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Jan 2021 07:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610799989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duWRece1HKc2ztuSf6Lle5PTVhNxw3bqYgIytTm4DGE=;
        b=AhyQaXQJxV2aF6Pp7FlJ3uSEcRRXiBtwsg8f0Qdk2oT0oMya2W/8NwqFZ6HiM6nZ/1mIT2
        oeortC2xLaW02XbnOSO15fO81VJWzeDEDSoKxgbzoI+GIFJS7BcHWqDMNTE7Ih7FltrrwI
        RK7hQk2dl0OL8YFfwdEwVgbJUc+eUqg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-akww1ASaMF6oDwNkkh1TtA-1; Sat, 16 Jan 2021 07:26:26 -0500
X-MC-Unique: akww1ASaMF6oDwNkkh1TtA-1
Received: by mail-ed1-f71.google.com with SMTP id x13so5303140edi.7
        for <linux-acpi@vger.kernel.org>; Sat, 16 Jan 2021 04:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=duWRece1HKc2ztuSf6Lle5PTVhNxw3bqYgIytTm4DGE=;
        b=IlqU341eMRvqagDZHz4oKfMKB40fGtgTkAzg9hukruhq6/6RdUWOzWy89iOJt5HAUh
         B30GmR87ciOwUjjPg2msAKeMILC9KNOp6r7qruycREhE7kbFHUp6zYijiTD7KBRdozwW
         ze8QMJgHttWGt6N70kxhisPhb/7xuKod8TGdGp0reCvqaX5plSLP856UtpGcoLvcbHe2
         HV76oeaG23EnT+BK27X4/APoFZqGI+glvHn91ZyJkIYoJqdbIHzZoSveXnUO4ezLK7TL
         Lazv6HbOER+cV4ZSwWoF0mp4gkzgkBA2ZaOiztM8sfSwqJ+iU8fLRNYz+2rpvjwttbvU
         qBEQ==
X-Gm-Message-State: AOAM533pWwvn5TSL9AlvYoJamMzh+b0dtrlDTwe6F5FpMM7O6L1ksNxe
        70PJN/oUlbaiulTmc181n/trPIhSEf/HDL5yJD14uymqC5M3+Bo5Eh5k3PEliX11kqNtgFa2rUF
        zXZ+rABpo779iQ7Bkcrdqzg==
X-Received: by 2002:a05:6402:3c3:: with SMTP id t3mr13375034edw.86.1610799985052;
        Sat, 16 Jan 2021 04:26:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylIh4wJ9DrVboQj0cwxh1nANOfGPnNaQnKsdMrK0OWpyu7J7wk2KPBClXiot0KriSP506Ehg==
X-Received: by 2002:a05:6402:3c3:: with SMTP id t3mr13375024edw.86.1610799984788;
        Sat, 16 Jan 2021 04:26:24 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id gb14sm6125504ejc.61.2021.01.16.04.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 04:26:23 -0800 (PST)
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <CAJZ5v0j87iF7S2-H+5D3A9HbRBA=W03r_9GPgwWLtH6nLwwZfw@mail.gmail.com>
 <8b316bf8-6a5c-c6d4-c0db-304ec529c805@linux.intel.com>
 <2803525.PQFCXvBIof@kreacher>
 <a16da87e-903f-d230-c271-b35d6c4ba9da@redhat.com>
Message-ID: <98e6ed8e-884e-adb4-a146-a66daefa94a7@redhat.com>
Date:   Sat, 16 Jan 2021 13:26:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a16da87e-903f-d230-c271-b35d6c4ba9da@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/15/21 10:57 PM, Hans de Goede wrote:
> Hi,
> 
> On 1/15/21 8:01 PM, Rafael J. Wysocki wrote:
>> On Friday, January 15, 2021 5:41:57 PM CET Pierre-Louis Bossart wrote:
>>>
>>>>>> [    0.516336] ACPI: \_SB_.PCI0.BRCM: Dependencies found
>>>>>
>>>>> Ah, that is enlightening, that is not supposed to happen, that device
>>>>> has both an _ADR and an _HID method which is not allowed according
>>>>> to the spec.
>>>
>>> it's not an uncommon issue for audio codecs, here's three examples:
>>>
>>>              Device (RTK1)
>>>              {
>>>                  Name (_ADR, Zero)  // _ADR: Address
>>>                  Name (_HID, "10EC5670")  // _HID: Hardware ID
>>>                  Name (_CID, "10EC5670")  // _CID: Compatible ID
>>>                  Name (_DDN, "ALC5642")  // _DDN: DOS Device Name
>>>
>>>          Device (MAXM)
>>>          {
>>>              Name (_ADR, Zero)  // _ADR: Address
>>>              Name (_HID, "193C9890")  // _HID: Hardware ID
>>>              Name (_CID, "193C9890")  // _CID: Compatible ID
>>>              Name (_DDN, "Maxim 98090 Codec  ")  // _DDN: DOS Device Name
>>>
>>>          Device (TISW)
>>>          {
>>>              Name (_ADR, Zero)  // _ADR: Address
>>>              Name (_HID, "104C227E")  // _HID: Hardware ID
>>>              Name (_CID, "104C227E")  // _CID: Compatible ID
>>>
>>> It's been that way for years...
>>>
>>>>> Can you try a clean 5.11 kernel (so none of the previous
>>>>> debug patches) with the following change added:
>>>>>
>>>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>>>> index 1f27f74cc83c..93954ac3bfcc 100644
>>>>> --- a/drivers/acpi/scan.c
>>>>> +++ b/drivers/acpi/scan.c
>>>>> @@ -1854,7 +1854,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
>>>>>           * 2. ACPI nodes describing USB ports.
>>>>>           * Still, checking for _HID catches more then just these cases ...
>>>>>           */
>>>>> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
>>>>> +       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID") ||
>>>>> +           acpi_has_method(handle, "_ADR"))
>>>>>                  return 0;
>>>>>
>>>>>          status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
>>>>>
>>>>>
>>>>>> [    0.517490] ACPI: \_SB_.PCI0.LNPW: Dependencies found
>>>>>
>>>>> And idem. for this one.
>>>>>
>>>>> That might very well fix this.
>>>
>>> Nope, no luck with this patch. boot still stuck.
>>
>> OK, thanks!
>>
>> Now, there is a theory to test and some more debug work to do.
>>
>> First, the kernel should not crash outright if some ACPI device objects are
>> missing which evidently happens here.  There may be some problems resulting
>> from that, but the crash indicates a code bug in the kernel.
>>
>> Apparently, something expects the device objects to be there so badly, that it
>> crashes right away when they aren't there.  One of the issues that may cause
>> that to happen are mistakes around the acpi_bus_get_device() usage and I found
>> two of them, so below is a patch to test.
>>
>> Please apply to plain 5.11-rc3 (or -rc4 when it is out) and see if that makes
>> any difference.
>>
>> ---
>>  drivers/acpi/scan.c         |    3 +--
>>  drivers/usb/core/usb-acpi.c |    3 +--
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/scan.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/scan.c
>> +++ linux-pm/drivers/acpi/scan.c
>> @@ -2120,8 +2120,7 @@ void acpi_walk_dep_device_list(acpi_hand
>>  	mutex_lock(&acpi_dep_list_lock);
>>  	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
>>  		if (dep->supplier == handle) {
>> -			acpi_bus_get_device(dep->consumer, &adev);
>> -			if (!adev)
>> +			if (acpi_bus_get_device(dep->consumer, &adev))
>>  				continue;
>>  
>>  			adev->dep_unmet--;
>> Index: linux-pm/drivers/usb/core/usb-acpi.c
>> ===================================================================
>> --- linux-pm.orig/drivers/usb/core/usb-acpi.c
>> +++ linux-pm/drivers/usb/core/usb-acpi.c
>> @@ -163,10 +163,9 @@ usb_acpi_get_companion_for_port(struct u
>>  	} else {
>>  		parent_handle = usb_get_hub_port_acpi_handle(udev->parent,
>>  							     udev->portnum);
>> -		if (!parent_handle)
>> +		if (!parent_handle || acpi_bus_get_device(parent_handle, &adev))
>>  			return NULL;
>>  
>> -		acpi_bus_get_device(parent_handle, &adev);
>>  		port1 = port_dev->portnum;
>>  	}
>>  
> 
> I can confirm that these changes fix the intermittent boot issue I had with
> 5.11-rc3 on the Minix Neo z83-4. It is getting a bit late here, so I will
> test my second (also intermittent) reproducer tomorrow.

Good news, I can confirm that these 2 changes fix this on my other reproducer too.

FYI: My other reporducer was 5.10.2 with the ACPI scan changes backported for testing
on a Lenovo Yoga Tablet 2 1051L.

Regards,

Hans

