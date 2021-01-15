Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E872F86F0
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 21:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbhAOUtu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 15:49:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727204AbhAOUtt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 15:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610743701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h78aLzK7T/4YSRsc/LXk3VPIoZf9w7bE89xtwfEbOho=;
        b=RrbfyXae6Qx7EwIXEhmV0l0GRZTVy6F5WVTewDHnQq1ay6RmZYutZCRZGrIcx9J91fvshO
        ssLnWNlDYkWDur9wT+PJS01s2rvOv/qvUR61RRxO1cW5fluu6pDSJkNleO5cvH2OOnRq+D
        CB04pnF8FYWqk4UTIclfMA+1n1vlwSo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-5dQCW2yQPHKMorbJYaQL1g-1; Fri, 15 Jan 2021 15:48:18 -0500
X-MC-Unique: 5dQCW2yQPHKMorbJYaQL1g-1
Received: by mail-ej1-f71.google.com with SMTP id rl8so3792454ejb.8
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jan 2021 12:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h78aLzK7T/4YSRsc/LXk3VPIoZf9w7bE89xtwfEbOho=;
        b=co4HA9FTSyXchhylMvxbfSovOjjs4mOmnK0kPKqgUqleMteefcVXmA9kUvv3xg336M
         +bkhAFRgwZ6EneAeoXgr4JimjvPQJAyhzOAlRS5O+XJWTl1y3g6yj34xdT5n7Y+SWc7y
         OecyZ3C0HzEaEjrKL/toHzrUI8UieAGZVZlhwXI0PVT35h+22F/75Q6lfgDd+Tc4ZUXT
         SvR/3qN8SWCRg27oJqVJW2iFwsbDPPCY95Xsv4IDTBT/BNMuI9A3+EiLvBWRhz2UX2Pt
         3D6yCG9T4Yj7TT55js/3L4ihzsdvmk9AOzyBwOCh0MYIgqwvTvVBerXThHQvpivp6QcS
         MZsw==
X-Gm-Message-State: AOAM531eu2Q1POo7WPw6MLodToPwcIMyxTz7oL96nq5xoxQVeqJ/0Iq9
        1YDfvsocMcPRdN7u9X2nNfSB++npO92nXrn7U1Leb9pL2cxBvnsR5UBV985dhs4bfM8JHLOuAYx
        m7Y8dZGvuGN/fcogHX0D4HA==
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr11244951edt.213.1610743697420;
        Fri, 15 Jan 2021 12:48:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaXYZ1YGuh5o3JDo+/fDNFozr2VhdGoydQdAWWDyuipJZcmd8TpNMLm88un1wyMNY1LQUVLA==
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr11244933edt.213.1610743697164;
        Fri, 15 Jan 2021 12:48:17 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id cb14sm4475436ejb.105.2021.01.15.12.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 12:48:16 -0800 (PST)
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ee1c264e-b4bc-9657-1f45-288f9f4c1ef3@redhat.com>
Date:   Fri, 15 Jan 2021 21:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2803525.PQFCXvBIof@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/15/21 8:01 PM, Rafael J. Wysocki wrote:
> On Friday, January 15, 2021 5:41:57 PM CET Pierre-Louis Bossart wrote:
>>
>>>>> [    0.516336] ACPI: \_SB_.PCI0.BRCM: Dependencies found
>>>>
>>>> Ah, that is enlightening, that is not supposed to happen, that device
>>>> has both an _ADR and an _HID method which is not allowed according
>>>> to the spec.
>>
>> it's not an uncommon issue for audio codecs, here's three examples:
>>
>>              Device (RTK1)
>>              {
>>                  Name (_ADR, Zero)  // _ADR: Address
>>                  Name (_HID, "10EC5670")  // _HID: Hardware ID
>>                  Name (_CID, "10EC5670")  // _CID: Compatible ID
>>                  Name (_DDN, "ALC5642")  // _DDN: DOS Device Name
>>
>>          Device (MAXM)
>>          {
>>              Name (_ADR, Zero)  // _ADR: Address
>>              Name (_HID, "193C9890")  // _HID: Hardware ID
>>              Name (_CID, "193C9890")  // _CID: Compatible ID
>>              Name (_DDN, "Maxim 98090 Codec  ")  // _DDN: DOS Device Name
>>
>>          Device (TISW)
>>          {
>>              Name (_ADR, Zero)  // _ADR: Address
>>              Name (_HID, "104C227E")  // _HID: Hardware ID
>>              Name (_CID, "104C227E")  // _CID: Compatible ID
>>
>> It's been that way for years...
>>
>>>> Can you try a clean 5.11 kernel (so none of the previous
>>>> debug patches) with the following change added:
>>>>
>>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>>> index 1f27f74cc83c..93954ac3bfcc 100644
>>>> --- a/drivers/acpi/scan.c
>>>> +++ b/drivers/acpi/scan.c
>>>> @@ -1854,7 +1854,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
>>>>           * 2. ACPI nodes describing USB ports.
>>>>           * Still, checking for _HID catches more then just these cases ...
>>>>           */
>>>> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
>>>> +       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID") ||
>>>> +           acpi_has_method(handle, "_ADR"))
>>>>                  return 0;
>>>>
>>>>          status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
>>>>
>>>>
>>>>> [    0.517490] ACPI: \_SB_.PCI0.LNPW: Dependencies found
>>>>
>>>> And idem. for this one.
>>>>
>>>> That might very well fix this.
>>
>> Nope, no luck with this patch. boot still stuck.
> 
> OK, thanks!
> 
> Now, there is a theory to test and some more debug work to do.
> 
> First, the kernel should not crash outright if some ACPI device objects are
> missing which evidently happens here.  There may be some problems resulting
> from that, but the crash indicates a code bug in the kernel.
> 
> Apparently, something expects the device objects to be there so badly, that it
> crashes right away when they aren't there.  One of the issues that may cause
> that to happen are mistakes around the acpi_bus_get_device() usage and I found
> two of them, so below is a patch to test.
> 
> Please apply to plain 5.11-rc3 (or -rc4 when it is out) and see if that makes
> any difference.
> 
> ---
>  drivers/acpi/scan.c         |    3 +--
>  drivers/usb/core/usb-acpi.c |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2120,8 +2120,7 @@ void acpi_walk_dep_device_list(acpi_hand
>  	mutex_lock(&acpi_dep_list_lock);
>  	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
>  		if (dep->supplier == handle) {
> -			acpi_bus_get_device(dep->consumer, &adev);
> -			if (!adev)
> +			if (acpi_bus_get_device(dep->consumer, &adev))
>  				continue;
>  
>  			adev->dep_unmet--;

Oh, OOOhh, good catch I've been staring at these exact lines multiple times,
my "spidey sense" telling me that the problem was likely something like this:

1. The addition of the acpi_device gets deferred because of the _DEP
list, this means that there are now entries for it on the acpi_dep_list

2. Later during the first pass, or before the handle is checked again
during the second pass, acpi_walk_dep_device_list() gets called because
the _DEP is now resolved.

3. My theory was this would lead to doing driver attach twice or some
such, but that is not possible...

But instead we are following a pointer which points to whatever the memory
used by the:

        struct acpi_device *adev;

local variable on the stack points to; and it seems, at least with
my compiler / kernel .config that the stack layout is such that the
stack memory does contain a valid pointer (from some previous functions
stack frame) and then whatever that points to gets used as an acpi_device
and likely gets mangled a bit. Which explains the memory-corruption like
behavior which I've been seeing.

Specifically I think that this happening when the MMC controller
addition gets deferred to the second step:

[    0.426722] ACPI: \_SB_.PCI0.SDHB: Dependencies found
[    0.427927] ACPI: \_SB_.PCI0.SDHB.BRCM: Dependencies found
[    0.431863] ACPI: \_SB_.PCI0.SDHC: Dependencies found
[    0.433128] ACPI: \_SB_.PCI0.SHC1: Dependencies found


I'll verify that this fixes both my reproducers (5.10 + backport on one device,
5.11-rc3 on another dev) by seeing if I can now boot 10 times in a row
successfully. But I'm pretty hopeful that this will fix them.

I'm also hopeful that this will fix Pierre-Louis' case too.


> Index: linux-pm/drivers/usb/core/usb-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/usb/core/usb-acpi.c
> +++ linux-pm/drivers/usb/core/usb-acpi.c
> @@ -163,10 +163,9 @@ usb_acpi_get_companion_for_port(struct u
>  	} else {
>  		parent_handle = usb_get_hub_port_acpi_handle(udev->parent,
>  							     udev->portnum);
> -		if (!parent_handle)
> +		if (!parent_handle || acpi_bus_get_device(parent_handle, &adev))
>  			return NULL;
>  
> -		acpi_bus_get_device(parent_handle, &adev);
>  		port1 = port_dev->portnum;
>  	}
>  

I'm pretty sure that we are not actually hitting this one, but we should
definitely still fix it.

Regards,

Hans

