Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460AE2F803C
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 17:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAOQGw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 11:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbhAOQGw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 11:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610726725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7uIhIR/lep2T6upN/4ujTYmAYf6Du344gG+7lPMB9p4=;
        b=HV4ldlpoSD9awjGop/3dho1N3YrbTxWqQUNrf/T9UNCHT7Sw0LJ75ikkNnqlGLDbDchMwq
        mRPBRT+Sr7aJZss7VqEcO8zERya4M50l1qJdhOlOGIT9UpO0FNHT9vePVA0gyHNj1U5Onb
        WF1KwmwUAq1nqXQKZWXiREwZMpS2Prk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-N5qBcGgOOiOBfE84tUd2GA-1; Fri, 15 Jan 2021 11:05:23 -0500
X-MC-Unique: N5qBcGgOOiOBfE84tUd2GA-1
Received: by mail-ej1-f70.google.com with SMTP id le12so656066ejb.13
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jan 2021 08:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7uIhIR/lep2T6upN/4ujTYmAYf6Du344gG+7lPMB9p4=;
        b=cSP9zphE6Py6kSIOwV/+bFLzTWclsdII9imDX2/1ZCBsFtXdNwPsRXjqYdGHX5lHSr
         YOKRVJYKAuwrAm4SI9v4GcAn5Iq5fxzeBGBb0YkygP8yK3Prvm/DhsIzKrFlPT7rG/6M
         HZeCmaZeHIVd0koOItvfkyQEImtc/7/OTOqnkL6fM6Q+2pT7whwJMKPAjYASFaR/F0Vu
         AXl1ZJLT6Lhk0Enr+7kJ48g30CtYw6I0Nf6Z2Fm1VqBg+1b0KWijgeRvAXj0TopIrOlY
         0/loAcMIvUd9+AVM83mlt+yzQNqzHlqkYt9QvWhbBh9+fuAypNZICgkAThXJlstYMED/
         ttVw==
X-Gm-Message-State: AOAM531fmbmb1s2whHDHalssHjqEIySp9WDPsxjTZeaJSvHqPTU2C3VZ
        lMeWjAvds26ZAFyCQ+5yzgtVyDfYMrj7aXlKiBqhBO2h4WVWm43FzDcJzSCKEs2lJLdBPAOUQ4E
        rjwhpnsHA+qI7aR6YCehMzQ==
X-Received: by 2002:a17:906:65a:: with SMTP id t26mr9081125ejb.394.1610726722103;
        Fri, 15 Jan 2021 08:05:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBgaxc5OjUw+FkxMjwo0f8xKOm1oNB8Iuo4NSK2TAXLayE1jV5MFjWm8QBVo5ovWgtLa+MiA==
X-Received: by 2002:a17:906:65a:: with SMTP id t26mr9081109ejb.394.1610726721875;
        Fri, 15 Jan 2021 08:05:21 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id p16sm4163559edw.44.2021.01.15.08.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 08:05:21 -0800 (PST)
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <CAJZ5v0i63MsXX18rat7XfxUHBsc_OKD1nZvdv07WytgNP7+mtQ@mail.gmail.com>
 <c27b98bf-c829-e128-cb74-149b14028a22@linux.intel.com>
 <10742637.M1KgVVZ4YP@kreacher>
 <8ca863bc-f312-8757-5f03-5364a691a860@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ee83595b-9e87-aab9-de81-ecb3d691258f@redhat.com>
Date:   Fri, 15 Jan 2021 17:05:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8ca863bc-f312-8757-5f03-5364a691a860@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/15/21 4:38 PM, Pierre-Louis Bossart wrote:
> 
>> This means that skipping the enumeration of a certain device alone is
>> problematic which is a surprise of sorts.
>>
>> Let's see what device that may be.
>>
>> Because the machine booted with the debug patch from Hans, it should also boot
>> with the one below, so please do that and send the output of
>>
>> $ dmesg | grep Dependencies
> 
> Yep, boot success with that patch :-)
> 
> root@plb-Zotac:~# dmesg | grep Dependencies
> [    0.426722] ACPI: \_SB_.PCI0.SDHB: Dependencies found
> [    0.427927] ACPI: \_SB_.PCI0.SDHB.BRCM: Dependencies found
> [    0.431863] ACPI: \_SB_.PCI0.SDHC: Dependencies found
> [    0.433128] ACPI: \_SB_.PCI0.SHC1: Dependencies found
> [    0.466328] ACPI: \_SB_.PCI0.I2C1.BATC: Dependencies found
> [    0.478490] ACPI: \_SB_.PCI0.I2C3.TIDR: Dependencies found
> [    0.479851] ACPI: \_SB_.PCI0.I2C3.ABAT: Dependencies found
> [    0.480756] ACPI: \_SB_.PCI0.I2C4: Dependencies found
> [    0.482605] ACPI: \_SB_.PCI0.I2C4.CA10: Dependencies found
> [    0.484464] ACPI: \_SB_.PCI0.I2C4.CAM9: Dependencies found
> [    0.485769] ACPI: \_SB_.PCI0.I2C4.CAM3: Dependencies found
> [    0.487187] ACPI: \_SB_.PCI0.I2C4.CAM4: Dependencies found
> [    0.490563] ACPI: \_SB_.PCI0.I2C6.TCS0: Dependencies found
> [    0.492673] ACPI: \_SB_.PCI0.I2C6.SYN1: Dependencies found
> [    0.494923] ACPI: \_SB_.PCI0.I2C7.PMI1: Dependencies found
> [    0.496528] ACPI: \_SB_.PCI0.I2C7.PMI2: Dependencies found
> [    0.498111] ACPI: \_SB_.PCI0.I2C7.PMI5: Dependencies found
> [    0.499909] ACPI: \_SB_.PCI0.I2C7.PMIF: Dependencies found
> [    0.500891] ACPI: \_SB_.PCI0.I2C7.PMIC: Dependencies found
> [    0.502822] ACPI: \_SB_.PCI0.I2C7.BMDR: Dependencies found
> [    0.504333] ACPI: \_SB_.PCI0.I2C7.WIDR: Dependencies found
> [    0.505689] ACPI: \_SB_.PCI0.I2C7.BATC: Dependencies found
> [    0.509734] ACPI: \_SB_.PCI0.AMCR: Dependencies found
> [    0.510715] ACPI: \_SB_.PCI0.TIMC: Dependencies found
> [    0.516336] ACPI: \_SB_.PCI0.BRCM: Dependencies found

Ah, that is enlightening, that is not supposed to happen, that device
has both an _ADR and an _HID method which is not allowed according
to the spec.

Can you try a clean 5.11 kernel (so none of the previous
debug patches) with the following change added:

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1f27f74cc83c..93954ac3bfcc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1854,7 +1854,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 	 * 2. ACPI nodes describing USB ports.
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
-	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
+	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID") ||
+	    acpi_has_method(handle, "_ADR"))
 		return 0;
 
 	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);


> [    0.517490] ACPI: \_SB_.PCI0.LNPW: Dependencies found

And idem. for this one.

That might very well fix this.

Regards,

Hans





> [    0.531940] ACPI: \_SB_.WLCH: Dependencies found
> [    0.532866] ACPI: \_SB_.WCH2: Dependencies found
> [    0.533927] ACPI: \_SB_.FLDM: Dependencies found
> [    0.541033] ACPI: \_SB_.BTNS: Dependencies found
> [    0.543079] ACPI: \_SB_.TBAD: Dependencies found
> [    0.549169] ACPI: \_SB_.UBTC: Dependencies found
> 
> I can run more tests as needed.
> 
>> ---
>>   drivers/acpi/scan.c |    9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/scan.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/scan.c
>> +++ linux-pm/drivers/acpi/scan.c
>> @@ -1950,10 +1950,8 @@ static acpi_status acpi_bus_check_add(ac
>>       if (type == ACPI_BUS_TYPE_DEVICE && check_dep) {
>>           u32 count = acpi_scan_check_dep(handle);
>>           /* Bail out if the number of recorded dependencies is not 0. */
>> -        if (count > 0) {
>> -            acpi_bus_scan_second_pass = true;
>> -            return AE_CTRL_DEPTH;
>> -        }
>> +        if (count > 0)
>> +            acpi_handle_info(handle, "Dependencies found\n");
>>       }
>>         acpi_add_single_object(&device, handle, type, sta);
>> @@ -1961,8 +1959,7 @@ static acpi_status acpi_bus_check_add(ac
>>           return AE_CTRL_DEPTH;
>>         acpi_scan_init_hotplug(device);
>> -    if (!check_dep)
>> -        acpi_scan_dep_init(device);
>> +    acpi_scan_dep_init(device);
>>     out:
>>       if (!*adev_p)
>>
>>
>>
> 

