Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B552F80A1
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 17:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbhAOQXi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 11:23:38 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:34080 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbhAOQXi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jan 2021 11:23:38 -0500
Received: by mail-oi1-f172.google.com with SMTP id s75so10099444oih.1
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jan 2021 08:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZF3vo+hq1sJHXYDjszIie3UKnzyWE+Wqtfr8a1MrbA=;
        b=NTnQ0YXP26pVUUpOP14k6277Ym2VFrd3daQEIrdgK4iudAapgyXzJV9l+yJVc05O8B
         c4zZGN28E+JuPytEfujPFGYrlVMaJ+J6wuaFvT1z3ea23W6MmK6d6gdmkvpuPpWuk1eC
         gmKzce9L0v2lqGBdHmdGrrW9Labb2ZaoVQnSb0FuD/zbIccBPKEAMCru0gj8V3nYIjDd
         AznonHMQOlTYtd3kaQKe7xV/hFhhGwjsP0juNSbgD4Wu6NAZnhdZtZ0k9rdjOCj815PI
         0Xh8uFD/FVHGugOyxYipMS/8tkXiXPkQfIefcXaUm8a0i3HvVVT0iEbEhtoKusc7QDAR
         zKkA==
X-Gm-Message-State: AOAM530b0ezRNbV8vVsY87Y9hv3JEoDsb5G6rfaohxyvuGfJQO/IBley
        mf2REp9n03uGyx7nigEdnP/GoFSg+DdQsCuJi2M=
X-Google-Smtp-Source: ABdhPJxcg/GCA54IsaTR+7HMdHI4TUZUl87B9K0l74fnO9Ho8mfJFLOEYAbp0vOeXhVKAeq//CbPwi5P0cdXUC52HUk=
X-Received: by 2002:aca:4892:: with SMTP id v140mr6209961oia.71.1610727777191;
 Fri, 15 Jan 2021 08:22:57 -0800 (PST)
MIME-Version: 1.0
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <CAJZ5v0i63MsXX18rat7XfxUHBsc_OKD1nZvdv07WytgNP7+mtQ@mail.gmail.com>
 <c27b98bf-c829-e128-cb74-149b14028a22@linux.intel.com> <10742637.M1KgVVZ4YP@kreacher>
 <8ca863bc-f312-8757-5f03-5364a691a860@linux.intel.com> <ee83595b-9e87-aab9-de81-ecb3d691258f@redhat.com>
In-Reply-To: <ee83595b-9e87-aab9-de81-ecb3d691258f@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jan 2021 17:22:45 +0100
Message-ID: <CAJZ5v0j87iF7S2-H+5D3A9HbRBA=W03r_9GPgwWLtH6nLwwZfw@mail.gmail.com>
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 15, 2021 at 5:05 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/15/21 4:38 PM, Pierre-Louis Bossart wrote:
> >
> >> This means that skipping the enumeration of a certain device alone is
> >> problematic which is a surprise of sorts.
> >>
> >> Let's see what device that may be.
> >>
> >> Because the machine booted with the debug patch from Hans, it should also boot
> >> with the one below, so please do that and send the output of
> >>
> >> $ dmesg | grep Dependencies
> >
> > Yep, boot success with that patch :-)
> >
> > root@plb-Zotac:~# dmesg | grep Dependencies
> > [    0.426722] ACPI: \_SB_.PCI0.SDHB: Dependencies found
> > [    0.427927] ACPI: \_SB_.PCI0.SDHB.BRCM: Dependencies found
> > [    0.431863] ACPI: \_SB_.PCI0.SDHC: Dependencies found
> > [    0.433128] ACPI: \_SB_.PCI0.SHC1: Dependencies found
> > [    0.466328] ACPI: \_SB_.PCI0.I2C1.BATC: Dependencies found
> > [    0.478490] ACPI: \_SB_.PCI0.I2C3.TIDR: Dependencies found
> > [    0.479851] ACPI: \_SB_.PCI0.I2C3.ABAT: Dependencies found
> > [    0.480756] ACPI: \_SB_.PCI0.I2C4: Dependencies found
> > [    0.482605] ACPI: \_SB_.PCI0.I2C4.CA10: Dependencies found
> > [    0.484464] ACPI: \_SB_.PCI0.I2C4.CAM9: Dependencies found
> > [    0.485769] ACPI: \_SB_.PCI0.I2C4.CAM3: Dependencies found
> > [    0.487187] ACPI: \_SB_.PCI0.I2C4.CAM4: Dependencies found
> > [    0.490563] ACPI: \_SB_.PCI0.I2C6.TCS0: Dependencies found
> > [    0.492673] ACPI: \_SB_.PCI0.I2C6.SYN1: Dependencies found
> > [    0.494923] ACPI: \_SB_.PCI0.I2C7.PMI1: Dependencies found
> > [    0.496528] ACPI: \_SB_.PCI0.I2C7.PMI2: Dependencies found
> > [    0.498111] ACPI: \_SB_.PCI0.I2C7.PMI5: Dependencies found
> > [    0.499909] ACPI: \_SB_.PCI0.I2C7.PMIF: Dependencies found
> > [    0.500891] ACPI: \_SB_.PCI0.I2C7.PMIC: Dependencies found
> > [    0.502822] ACPI: \_SB_.PCI0.I2C7.BMDR: Dependencies found
> > [    0.504333] ACPI: \_SB_.PCI0.I2C7.WIDR: Dependencies found
> > [    0.505689] ACPI: \_SB_.PCI0.I2C7.BATC: Dependencies found
> > [    0.509734] ACPI: \_SB_.PCI0.AMCR: Dependencies found
> > [    0.510715] ACPI: \_SB_.PCI0.TIMC: Dependencies found
> > [    0.516336] ACPI: \_SB_.PCI0.BRCM: Dependencies found
>
> Ah, that is enlightening, that is not supposed to happen, that device
> has both an _ADR and an _HID method which is not allowed according
> to the spec.
>
> Can you try a clean 5.11 kernel (so none of the previous
> debug patches) with the following change added:
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1f27f74cc83c..93954ac3bfcc 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1854,7 +1854,8 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
>          * 2. ACPI nodes describing USB ports.
>          * Still, checking for _HID catches more then just these cases ...
>          */
> -       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
> +       if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID") ||
> +           acpi_has_method(handle, "_ADR"))
>                 return 0;
>
>         status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
>
>
> > [    0.517490] ACPI: \_SB_.PCI0.LNPW: Dependencies found
>
> And idem. for this one.
>
> That might very well fix this.

It might.

That said, there are "interesting" dependencies in those ACPI tables
(like on the PMIC which is deferred, because it depends on I2C7 and
GP01 and even some power resources depend on it).
