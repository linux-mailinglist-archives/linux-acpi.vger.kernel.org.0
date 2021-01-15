Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9BA2F880A
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 23:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbhAOV66 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 16:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbhAOV65 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 16:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610747850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jY+U5v6/6kVmmsRdUZSZGfpfyPH/xyMsKCvEUpN/LO4=;
        b=FG6/HJqK6jgH/nrpf78sUN+ai0GX04V8CMo5YlyBqzFj7wj1YC5/3E9j5cPHAPaC1hzaov
        Qo1yYDLA3+05MipCXnVXLZmEc2b94tEPp6lEMrBqI7EfWkZJJz3ZtHXeFvmemFFGPzbSP2
        koVUWD4XTGaTH2iyMsDWuty845vSITg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-LG56V4SROpy9m0lbUQFXTg-1; Fri, 15 Jan 2021 16:57:28 -0500
X-MC-Unique: LG56V4SROpy9m0lbUQFXTg-1
Received: by mail-ej1-f70.google.com with SMTP id le12so1017530ejb.13
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jan 2021 13:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jY+U5v6/6kVmmsRdUZSZGfpfyPH/xyMsKCvEUpN/LO4=;
        b=rE4wNdpAheo+7mqh+k5LPsmjiSrWp5ejVKpoqXvjnXLYff0RCbndUo/WZfwewIRcdS
         /Ru2lPQk/NXYrNdK0XD3t0SbuXmh5zN2CkKGuo3yy+jXKX2zlD9WXxeCfHsHe0h+xdRf
         Yr0xTfswlZuN8vvothKZ/cr2g8p2S1uzUgxNPJLUEnTBYye7pxCfZPmj9PT8HtEkH2Df
         tiOK1XhY0ekyJIXSovBAc1yBMmr09iEdS4mum1PIm3oNLDBT9vgvjNZfhxkBDBI0ujGr
         46yIkHggCV6e1kpKoEQtrpqUyUEfLXMIGEY/f+bKLUITJhPoLKjBaJivaB8G82en+ztR
         6A5g==
X-Gm-Message-State: AOAM532zqEIWARtl2MHQcEUtQWiNivVo+6Mgf+jEcsSA4wW1geUUPEoJ
        ThYlNK6LCi95X9/5Aa7kRH3LI4L6NHiS0AilGSmBcID7ZQvh6E8VGgQ3EKEO8PvgI4tPhHLoRrr
        RZpoSiltOf6OmYksrd2Kpkg==
X-Received: by 2002:a17:906:edc8:: with SMTP id sb8mr10376898ejb.247.1610747847713;
        Fri, 15 Jan 2021 13:57:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRrIMhOT+NMY0wvZmfo//VjzwYaE1r8AOrwPah/qKatS1qkE01rEFGj/YZW6JpziwKRwwgoQ==
X-Received: by 2002:a17:906:edc8:: with SMTP id sb8mr10376887ejb.247.1610747847489;
        Fri, 15 Jan 2021 13:57:27 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id j18sm4358066ejv.18.2021.01.15.13.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 13:57:26 -0800 (PST)
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
Message-ID: <a16da87e-903f-d230-c271-b35d6c4ba9da@redhat.com>
Date:   Fri, 15 Jan 2021 22:57:26 +0100
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

I can confirm that these changes fix the intermittent boot issue I had with
5.11-rc3 on the Minix Neo z83-4. It is getting a bit late here, so I will
test my second (also intermittent) reproducer tomorrow.

Regards,

Hans


