Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D912F8D16
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jan 2021 12:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbhAPLU1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Jan 2021 06:20:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbhAPLU0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Jan 2021 06:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610795939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0xd3neYsKxFkMz6qNzca4ekqL6GXvzPSRHG9+NyPlE=;
        b=DWbojVK4ksvT49m/UGcN+tWG2Tr1SjA6zQy9x2vQvjK52M6jY8C/irFPThk+PoOhBHrG9o
        I+ih0iw6pl2g5vh5U+2PYPkyeLptdh/TRvZqUrR1WiNh3/U+k2lPctm9tjQDnRmGMDEHws
        gBeuBf6MhK3I4ZsaCleH5zUGT4iTOns=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-YjNLmW1XMMC3OGkVkTom3g-1; Sat, 16 Jan 2021 06:18:57 -0500
X-MC-Unique: YjNLmW1XMMC3OGkVkTom3g-1
Received: by mail-ed1-f71.google.com with SMTP id dc6so5210475edb.14
        for <linux-acpi@vger.kernel.org>; Sat, 16 Jan 2021 03:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H0xd3neYsKxFkMz6qNzca4ekqL6GXvzPSRHG9+NyPlE=;
        b=BGFJJg8cfwSl2eQlJMk+U6CnFuc79nHtQRyPYv5JmPb1aDJtB3XQg4q83ETkS7H8jY
         0TDUk890UQj7lCqqdw9cQhSu4byN7IsDdInRXxHs9VCvIzyXSe3VghkbrWdlBIARROSO
         wJMUtaVqa3JIbqCHh5AYR5nqPjzegUGeyo/Kkqrs7/MCKsoLIzZY02SD7ORdNy75OxaO
         EraLAVoCYISyFP2eKrzq663d7NQXU2J/e7OIpLLzHsNCQgErG4vSrnj/RFATvSEUzXNO
         YS5t9U/e6n7MKMo9eLihzYeButrCwRIPn8vbMCvcsS/TkY7U8TWHB6mnbDK2o+6Wjs8I
         4fhw==
X-Gm-Message-State: AOAM5308ZDexGRe2QuZHSp3lx1Ij9V15Kav646bm537H1QsBT2KVUusz
        wCNnHAST2cYqI94TO8FTyd8abP/bu8WXWVqRHaS2rufyMau/SZnZ9nNJvXW/4NZGWdjWaUHu172
        d7ZClyonTPaEkSt/b/w91Zw==
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr12838323ejp.458.1610795936004;
        Sat, 16 Jan 2021 03:18:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8KFVpq0zhujtHQPCQfpGhoy1SmV+f7gNmi2lwpQYU4iEF+bKZcb8+LCbXYQY0vCTkYC7gMA==
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr12838314ejp.458.1610795935830;
        Sat, 16 Jan 2021 03:18:55 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id n2sm6239855ejj.24.2021.01.16.03.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 03:18:55 -0800 (PST)
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <CAJZ5v0j87iF7S2-H+5D3A9HbRBA=W03r_9GPgwWLtH6nLwwZfw@mail.gmail.com>
 <8b316bf8-6a5c-c6d4-c0db-304ec529c805@linux.intel.com>
 <2803525.PQFCXvBIof@kreacher>
 <a16da87e-903f-d230-c271-b35d6c4ba9da@redhat.com>
 <56b732f4-9a24-688e-7cc7-6c2522d173c9@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a2ab4970-99ea-13c5-c02e-4e04030e1feb@redhat.com>
Date:   Sat, 16 Jan 2021 12:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <56b732f4-9a24-688e-7cc7-6c2522d173c9@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/15/21 11:43 PM, Pierre-Louis Bossart wrote:
>>> OK, thanks!
>>>
>>> Now, there is a theory to test and some more debug work to do.
>>>
>>> First, the kernel should not crash outright if some ACPI device objects are
>>> missing which evidently happens here.  There may be some problems resulting
>>> from that, but the crash indicates a code bug in the kernel.
>>>
>>> Apparently, something expects the device objects to be there so badly, that it
>>> crashes right away when they aren't there.  One of the issues that may cause
>>> that to happen are mistakes around the acpi_bus_get_device() usage and I found
>>> two of them, so below is a patch to test.
>>>
>>> Please apply to plain 5.11-rc3 (or -rc4 when it is out) and see if that makes
>>> any difference.
>>>
>>> ---
>>>  drivers/acpi/scan.c         |    3 +--
>>>  drivers/usb/core/usb-acpi.c |    3 +--
>>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>>
>>> Index: linux-pm/drivers/acpi/scan.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/scan.c
>>> +++ linux-pm/drivers/acpi/scan.c
>>> @@ -2120,8 +2120,7 @@ void acpi_walk_dep_device_list(acpi_hand
>>>  	mutex_lock(&acpi_dep_list_lock);
>>>  	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
>>>  		if (dep->supplier == handle) {
>>> -			acpi_bus_get_device(dep->consumer, &adev);
>>> -			if (!adev)
>>> +			if (acpi_bus_get_device(dep->consumer, &adev))
>>>  				continue;
>>>  
>>>  			adev->dep_unmet--;
>>> Index: linux-pm/drivers/usb/core/usb-acpi.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/usb/core/usb-acpi.c
>>> +++ linux-pm/drivers/usb/core/usb-acpi.c
>>> @@ -163,10 +163,9 @@ usb_acpi_get_companion_for_port(struct u
>>>  	} else {
>>>  		parent_handle = usb_get_hub_port_acpi_handle(udev->parent,
>>>  							     udev->portnum);
>>> -		if (!parent_handle)
>>> +		if (!parent_handle || acpi_bus_get_device(parent_handle, &adev))
>>>  			return NULL;
>>>  
>>> -		acpi_bus_get_device(parent_handle, &adev);
>>>  		port1 = port_dev->portnum;
>>>  	}
>>>  
>> I can confirm that these changes fix the intermittent boot issue I had with
>> 5.11-rc3 on the Minix Neo z83-4. It is getting a bit late here, so I will
>> test my second (also intermittent) reproducer tomorrow.
> 
> Success on my side as well. I can boot and here is the updated list of dependencies (shorter than for the last test)

It is shorter because of this part of the debugging patch which Rafael send:

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1854,7 +1854,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 	 * 2. ACPI nodes describing USB ports.
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
-	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
+	if (!acpi_has_method(handle, "_DEP") || acpi_has_method(handle, "_ADR")
+	    || !acpi_has_method(handle, "_HID"))
 		return 0;
 
 	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);


So that is expected.

> I attached the diff I tested to make sure I didn't miss anything.

Erm, it looks like you also applied the debug patch from Rafael's last email, that
was only intended to be applied in case things still did not work I believe.

This bit from the debug-patch:

@@ -1937,10 +1938,8 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 	if (type == ACPI_BUS_TYPE_DEVICE && check_dep) {
 		u32 count = acpi_scan_check_dep(handle);
 		/* Bail out if the number of recorded dependencies is not 0. */
-		if (count > 0) {
-			acpi_bus_scan_second_pass = true;
-			return AE_CTRL_DEPTH;
-		}
+		if (count > 0)
+			acpi_handle_info(handle, "Dependencies found\n");
 	}
 
 	acpi_add_single_object(&device, handle, type, sta);

Will cause all devices to be added during the first scan pass, like my
initial hack/test patch. Can you drop the debug patch and test with just the 2
changes from Rafael's previous mail please ?

Regards,

Hans




> 
> Thanks
> 
> -Pierre
> 
> 

