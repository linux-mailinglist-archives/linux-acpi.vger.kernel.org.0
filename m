Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D31339E75B
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFGTUw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 15:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231465AbhFGTUw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 15:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623093540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jeXXdLZfxBmcspDEtdU9VRwCLq0REvvI5zeo9PjVPI=;
        b=MX7wPPw+vo8LuvXqQr7fG0TZaKA+mzmi3WhoOEAdO5g3S0TbvhfQM1as8wP52lFgKtuQtx
        6kZUuuHw0InWHx1cn4H8ObgMHWR92sEgopsBg63Lu4kyW+kUgywZYo1QlO9Gl/zsKxgf6o
        riUJ+oKYbN9rZJ6Cwlgaw0wlgrChNyM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-M1IfGE-wPKmrcjZkM96-Cg-1; Mon, 07 Jun 2021 15:18:59 -0400
X-MC-Unique: M1IfGE-wPKmrcjZkM96-Cg-1
Received: by mail-ed1-f69.google.com with SMTP id u21-20020aa7d5550000b02903937d876df1so3014037edr.20
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 12:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+jeXXdLZfxBmcspDEtdU9VRwCLq0REvvI5zeo9PjVPI=;
        b=rHCpMGkLblRBDr8FocXXy3krXfhPXC6uveKjl5H3voUpFl7FqBagJHrDPS0qER3wom
         eurv1g7kBHnQPiugX8TahZK/ifNoVEdZeaNFZmqIEwgMO5JLTQgNBsFoq/xhgBw8ESoL
         Ji05gNgSFvJjPCQRC0F4gVO4Nox1nASectrNgj7u3PDwOKsJSZn/xlbrwABsRqgzPrnM
         1+SfCQhpTz3CIgHN5zZa7D/uY5REo7IgRm1di2otBA1oyBHV/WSV8b86IdY7kvetoXPr
         z1+XPC+By6m3rH1fpTRfoKLz0yTuijqoLxg0igrN5pfqnkSc3DMoJViYNrZdUCrz6Uh8
         Gnww==
X-Gm-Message-State: AOAM533WKqcIOjESIgDNYhzDUgyH9TYvR69kWF1VS4XVXCQYsMylQ19z
        s+OEf/HK4tJUfTVHjILFJ1uOKRsA9K6vY1v+AzR358ph0L4jqEqrOU8JdpDi8HTUKq5/bWgfLv9
        +elM/ccAv36GOzsRReLEOCddK2YdmXQlCp/5FpFNF9hYSY74iLb3zADOTG0OZ68tEMkqJ1qIVbQ
        ==
X-Received: by 2002:a17:906:365a:: with SMTP id r26mr19564417ejb.340.1623093537962;
        Mon, 07 Jun 2021 12:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPw6b92ShiawifsL+lLEavzzPSrxpXvgaiRL0kldVZMvXs+lcWdv86jqh20Mr9a8wMNa/qzw==
X-Received: by 2002:a17:906:365a:: with SMTP id r26mr19564390ejb.340.1623093537655;
        Mon, 07 Jun 2021 12:18:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y10sm1816432edc.66.2021.06.07.12.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 12:18:57 -0700 (PDT)
Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@outlook.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
 <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com>
 <a3c05e2f-af1c-ef19-4c9a-6b5b82d2da6d@redhat.com>
 <CAJZ5v0hYnEes7SDqwSqTGKQf4Qebr=gmj_qSQOPWKQzPdpAwrw@mail.gmail.com>
 <FR1PR80MB5051E91269FD36681BB357A7E1389@FR1PR80MB5051.lamprd80.prod.outlook.com>
 <YL5EjVDYLPhRKMIA@lahna.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <209a230c-a7a6-7a8e-0515-97fb534d7401@redhat.com>
Date:   Mon, 7 Jun 2021 21:18:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YL5EjVDYLPhRKMIA@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/7/21 6:08 PM, Mika Westerberg wrote:
> Hi,
> 
> Tried now on ADL-P and TGL systems and the _OSC still works properly.
> 
> Thanks Hans for fixing!
> 
> Feel free to add my Tested-by.

Thank you for testing, unfortunately so far from the comments here:

https://bugzilla.kernel.org/show_bug.cgi?id=213023

it seems that my patch does not help resolve the issues caused
by commit 719e1f561afb ("ACPI: Execute platform _OSC also with query
bit clear"), where as reverting that commit does resolve them :|

Does anyone have any other ideas how to fix this ?

Regards,

Hans





> 
> On Mon, Jun 07, 2021 at 01:01:59PM +0000, Mario Limonciello wrote:
>>    Mika,
>>
>>    Can you have a try and make sure this modification still works properly
>>    on the series in the hardware we originally did it for?
>>      __________________________________________________________________
>>
>>    From: Rafael J. Wysocki <rafael@kernel.org>
>>    Sent: Monday, June 7, 2021 6:13:21 AM
>>    To: Hans de Goede <hdegoede@redhat.com>
>>    Cc: Rafael J . Wysocki <rjw@rjwysocki.net>; Mario Limonciello
>>    <mario.limonciello@outlook.com>; linux-acpi
>>    <linux-acpi@vger.kernel.org>
>>    Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
>>
>>    On Mon, Jun 7, 2021 at 12:05 PM Hans de Goede <hdegoede@redhat.com>
>>    wrote:
>>    >
>>    > HI,
>>    >
>>    > On 6/7/21 11:43 AM, Hans de Goede wrote:
>>    > > Hi,
>>    > >
>>    > > On 6/3/21 7:26 PM, Hans de Goede wrote:
>>    > >> Hi Rafael,
>>    > >>
>>    > >> I've been helping some users with trying to get to the bottom of
>>    some
>>    > >> new ACPI errors with kernel 5.12, see:
>>    > >>
>>    > >> [1]https://bugzilla.kernel.org/show_bug.cgi?id=213023
>>    > >>
>>    > >> After looking at dmesg output; and after editing the dmesg output
>>    > >> a bit so that I could do diff -u on it, the following stands out:
>>    > >>
>>    > >> --- dmesg_5.10.38-1-lts      2021-06-03 16:29:41.372922210 +0200
>>    > >> +++ dmesg_linux-5.12.5-arch1-1       2021-06-03 16:30:01.013031634
>>    +0200
>>    > >> @@ -92,7 +92,7 @@
>>    > >>  ACPI: IRQ9 used by override.
>>    > >>  Using ACPI (MADT) for SMP configuration information
>>    > >>  ACPI: HPET id: 0x8086a201 base: 0xfed00000
>>    > >> -ACPI: Core revision 20200925
>>    > >> +ACPI: Core revision 20210105
>>    > >>  PM: Registering ACPI NVS region [mem 0x7156c000-0x7156cfff] (4096
>>    bytes)
>>    > >>  PM: Registering ACPI NVS region [mem 0x8a88f000-0x8af7efff]
>>    (7274496 bytes)
>>    > >>  ACPI FADT declares the system doesn't support PCIe ASPM, so
>>    disable it
>>    > >> @@ -113,10 +113,6 @@
>>    > >>  ACPI: Dynamic OEM Table Load:
>>    > >>  ACPI: SSDT 0xFFFF... 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL
>>    20160527)
>>    > >>  ACPI: Dynamic OEM Table Load:
>>    > >> -ACPI: SSDT 0xFFFF... 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL
>>    20160527)
>>    > >> -ACPI: Dynamic OEM Table Load:
>>    > >> -ACPI: SSDT 0xFFFF... 000628 (v02 PmRef  HwpLvt   00003000 INTL
>>    20160527)
>>    > >> -ACPI: Dynamic OEM Table Load:
>>    > >>  ACPI: SSDT 0xFFFF... 000D14 (v02 PmRef  ApIst    00003000 INTL
>>    20160527)
>>    > >>  ACPI: Dynamic OEM Table Load:
>>    > >>  ACPI: SSDT 0xFFFF... 000317 (v02 PmRef  ApHwp    00003000 INTL
>>    20160527)
>>    > >>
>>    > >> Note how for some reason the kernel is no longer loading the
>>    Cpu0Hwp and
>>    > >> HwpLvt SSDT-s ?
>>    > >>
>>    > >> Do you have any ideas what might be causing this ?
>>    > >
>>    > > Good news, a very similar bug is being tracked here:
>>    > >
>>    > > [2]https://bugzilla.redhat.com/show_bug.cgi?id=1963717
>>    > >
>>    > > And one of the reporters there has done a git bisect and has found
>>    the commit which is causing the problem for them:
>>    > >
>>    > > """
>>    > > git-bisect points to 719e1f561afbe020ed175825a9bd25ed62ed1697 :
>>    > > "ACPI: Execute platform _OSC also with query bit clear".
>>    > >
>>    > > Tested 5.12.9 kernel with the commit reverted, and confirmed that
>>    the error
>>    > > messages are gone. (I had to revert
>>    > > 5a6a2c0f0f43676df27632d657a3f18b151a7ef8 for dependency too.)
>>    > >
>>    > > It also brings back the /sys/devices/system/cpu/cpu0/acpi_cppc
>>    which is absent
>>    > > in the stable 5.12.x
>>    > >
>>    > > Hope this helps
>>    > > """
>>    >
>>    > I've taken a quick look at commit 719e1f561afb ("ACPI: Execute
>>    platform _OSC also with query bit clear") and I think I may have found
>>    the problem.
>>    >
>>    > I've attached a patch which I think may fix this (and I've asked the
>>    reporters of the bugs to test this).
>>    Thank you, the patch looks reasonable to me.
>>    It looks like commit 719e1f561afb went a bit too far.
>>
>> References
>>
>>    1. https://bugzilla.kernel.org/show_bug.cgi?id=213023
>>    2. https://bugzilla.redhat.com/show_bug.cgi?id=1963717
> 

