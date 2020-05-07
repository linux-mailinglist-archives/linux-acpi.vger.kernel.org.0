Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8AC1C8820
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEGLZv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 07:25:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725903AbgEGLZs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 May 2020 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588850745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okJLc56HxgwRQ3pAUVl+d+At6cmSRE2fHfdVLfqeU9E=;
        b=MjMZ+p0S8dPw5ntZrZgV5n5Z0DfFwxmNEP4n4b7ktpnumulFBis0EAe93HEvWE2QFH/keo
        mgCsQjn9vI2QQIMLYS6L9oBCxt3fwdPL12p7vlBqrLI1DjQerC+HXBGX65lsqDEtna8NlN
        ZsNDHxVygtUWfSRwsZgWRjFHLD1kJ+E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-jFPA_0YoM823OxGa-0ZRrQ-1; Thu, 07 May 2020 07:25:41 -0400
X-MC-Unique: jFPA_0YoM823OxGa-0ZRrQ-1
Received: by mail-wm1-f71.google.com with SMTP id h22so3193906wml.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2020 04:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=okJLc56HxgwRQ3pAUVl+d+At6cmSRE2fHfdVLfqeU9E=;
        b=pezkFjzDgV6VZPVsZvjUL6gbIzvMry3wTgU03M6+UaFsyI2VpTSZHgTYN0CafoJtpZ
         GYK55PWQ0Hntoxc2xeni4UPqzCjVgWdT/jcT/JuN6YhARSowsqm0abqHc9v+lB1IYS+y
         H2vu2pUgeQnkBRWumk9g2Czr4OJAslRkVbFcbIH2hv1NjYEVDc16ShEK2JUWqpixaVIY
         B6MFO3MaOm8hGog8MzAyq0B0WnsRfFH/jxsDcaP6vWBesx+QmNeiXOyOl/9xX7ObyoCH
         4wEo23qV9Yk2GHwh+6mrA8L6RgljoUKVPctUBH0FSxPpLGLH/rnJQoZS9kdBeu5KyB5N
         dR2w==
X-Gm-Message-State: AGi0PuYU0iWZcAXRyz2D0nFu6WfNpCKrZseDwNCm/p/w6AqF99ltWDz2
        QDX+nAHxh2WWIOtDPAhM96fPu4jhkVA6LlZ/CV/0IP9wlJ/y+GFu8Z0kSQBCPzH8a1oyaXnoPOw
        g3f/2Gf8FE/hOJucelfe0jA==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr15287562wrl.308.1588850740413;
        Thu, 07 May 2020 04:25:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNANnxsVsnNOEDgu94fgMKk/XWfA1Fdjv1VV703EFoHeL4+phgQNEomnmqNuXDRae/SyMmxA==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr15287547wrl.308.1588850740181;
        Thu, 07 May 2020 04:25:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id n9sm7412749wrv.43.2020.05.07.04.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 04:25:39 -0700 (PDT)
Subject: Re: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
 switch on "Detachable" and "Portable" chassis-types
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200502182951.114231-1-hdegoede@redhat.com>
 <20200502182951.114231-5-hdegoede@redhat.com>
 <7c3e5f844a224ff780cd8e3b3f5f7641@AUSX13MPC101.AMER.DELL.COM>
 <13a8ec94-1eae-4d95-7238-85c612ebc896@redhat.com>
 <afe7c366c97f4ab18d5a98a9695ceff6@AUSX13MPC101.AMER.DELL.COM>
 <CAHp75VcNJFfgshhL_pYsHodF1pMNySw08Z_4jr-vVkE-Xpj_ng@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ca5e5db1-eac5-358b-7d85-95d62e87b6f0@redhat.com>
Date:   Thu, 7 May 2020 13:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcNJFfgshhL_pYsHodF1pMNySw08Z_4jr-vVkE-Xpj_ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/5/20 4:27 PM, Andy Shevchenko wrote:
> On Tue, May 5, 2020 at 5:22 PM <Mario.Limonciello@dell.com> wrote:
>>
>>> -----Original Message-----
>>> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
>>> owner@vger.kernel.org> On Behalf Of Hans de Goede
>>> Sent: Tuesday, May 5, 2020 4:06 AM
>>> To: Limonciello, Mario; dvhart@infradead.org; andy@infradead.org
>>> Cc: linux-acpi@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
>>> kernel@vger.kernel.org
>>> Subject: Re: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
>>> switch on "Detachable" and "Portable" chassis-types
>>>
>>>
>>> [EXTERNAL EMAIL]
>>>
>>> Hi,
>>>
>>> On 5/4/20 5:37 PM, Mario.Limonciello@dell.com wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>>> Sent: Saturday, May 2, 2020 1:30 PM
>>>>> To: Darren Hart; Andy Shevchenko; Limonciello, Mario
>>>>> Cc: Hans de Goede; linux-acpi@vger.kernel.org; platform-driver-
>>>>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>>>>> Subject: [PATCH 4/5] platform/x86: intel-vbtn: Also handle tablet-mode
>>> switch
>>>>> on "Detachable" and "Portable" chassis-types
>>>>>
>>>>>
>>>>> [EXTERNAL EMAIL]
>>>>>
>>>>> Commit de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
>>>>> switch on 2-in-1's") added a DMI chassis-type check to avoid accidentally
>>>>> reporting SW_TABLET_MODE = 1 to userspace on laptops.
>>>>>
>>>>> Some devices with a detachable keyboard and using the intel-vbnt (INT33D6)
>>>>> interface to report if they are in tablet mode (keyboard detached) or not,
>>>>> report 32 / "Detachable" as chassis-type, e.g. the HP Pavilion X2 series.
>>>>>
>>>>> Other devices with a detachable keyboard and using the intel-vbnt (INT33D6)
>>>>> interface to report SW_TABLET_MODE, report 8 / "Portable" as chassis-type.
>>>>> The Dell Venue 11 Pro 7130 is an example of this.
>>>>>
>>>>> Extend the DMI chassis-type check to also accept Portables and Detachables
>>>>> so that the intel-vbtn driver will report SW_TABLET_MODE on these devices.
>>>>>
>>>>> Note the chassis-type check was originally added to avoid a false-positive
>>>>> tablet-mode report on the Dell XPS 9360 laptop. To the best of my knowledge
>>>>> that laptop is using a chassis-type of 9 / "Laptop", so after this commit
>>>>> we still ignore the tablet-switch for that chassis-type.
>>>>
>>>> Yes that's correct.
>>>>
>>>>>
>>>>> Fixes: de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
>>>>> switch on 2-in-1's")
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>> Looking at the Microsoft Windows documentation for tablet-mode reporting:
>>>>> https://docs.microsoft.com/en-us/windows-hardware/drivers/gpiobtn/button-
>>>>> implementation
>>>>>
>>>>> Then the presence of a tablet-mode switch is indicated by the presence
>>>>> of a PNP0C60 compatible ACPI devices. There are 2 ways in which this device
>>>>> can report the tablet-mode. 1. Directly providing a GpioInt resource inside
>>>>> the PNP0C60 device, 2. Through injecting events from a Windows driver.
>>>>>
>>>>> It seems that the intel-vbtn / the INT33D6 ACPI device is the ACPI side
>>>>> of Intel's generic solution for the case where the tablet-mode comes from
>>>>> the embedded-controller and needs to be "injected".
>>>>>
>>>>> This all suggests that it might be better to replace the chassis-type
>>>>> check with a acpi_dev_present("PNP0C60", NULL, -1) check.
>>>>>
>>>>> Mario, can you provide an acpidump and alsa-info.sh output for the
>>>>> Dell XPS 9360, so that I can check if that might help with the issue
>>>>> there, and thus is a potential candidate to replace the chassis-type
>>>>> check?
>>>>
>>>> Unfortunately with WFH right now, I don't have access to a XPS 9630 to
>>>> double check the patch series.
>>>>
>>>> However I do agree this should be a good approach.
>>>
>>> Ok, so lets stick with the chassis-type check (as amended by this patch)
>>> for now then. Then once you are able to go to your office again, we
>>> can examine the acpi_dev_present("PNP0C60", NULL, -1) alternative.
>>
>> I know XPS 13's are pretty popular, perhaps someone on the mailing list who has
>> one can share ACPI dump in the interim.
> 
> https://github.com/intel/dptfxtract/issues/13

Good one.

So this has:

         Device (CIND)
         {
             Name (_HID, "INT33D3" /* Intel GPIO Buttons */)  // _HID: Hardware I
             Name (_CID, "PNP0C60" /* Display Sensor Device */)  // _CID: Compati
             Method (_STA, 0, Serialized)  // _STA: Status
             {
                 If ((OSYS >= 0x07DC))
                 {
                     Return (0x0F)
                 }

                 Return (Zero)
             }
         }

And OSYS >= 0x07DC checks for "Windows 2012" which Linux does advertise,
so despite not having a tablet-mode(switch) the XPS 9360 still has a
PNP0C60 ACPI device and will report 0xf (present) as status for it,
so a acpi_dev_present("PNP0C60", NULL, -1) check will succeed on it.

Conclusion: such a check is not a valid alternative for checking DMI
chassis-types (and from that pov this series thus is ready for merging).

Regards,

Hans

