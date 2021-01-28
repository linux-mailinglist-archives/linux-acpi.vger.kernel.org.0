Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3E630772D
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jan 2021 14:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA1Ncy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 28 Jan 2021 08:32:54 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:36509 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhA1Ncv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2021 08:32:51 -0500
Received: by mail-oo1-f48.google.com with SMTP id j8so1419471oon.3
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jan 2021 05:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ZIAeZuY05Uv3CfEX1Xk8kyFfIF3atTVLycALxe7y1s=;
        b=ClcavAICmKeKZ8psYBpdItxAhGrhDnt1AHvP7qmCyKNM/XnarMYH4+L5X7Jq5PVXDo
         ZbyDHANM2vkYk6gROzgCMVoH9F141K8VGPifERHG1djPd4aPzUmF/SLVxARlDCZlRqUx
         H3ORpxFstbduO2VZ9Dse+pJbaJVpCUNJ36EDvKxJ4NOtsIFgvXOeIPr//Q7gwZg8EiQH
         VoWy9dau4Pvv5lrrvZ0+2PkzC5tcUTiy049UBnlgjs1oV9M6AYhoBBUZ20M7X4F6M6MD
         bBZ/NtTKklq98rYI7IbGoH+bQYqBHEC0iDIp9dnKXF735caWEIHyioFiPMwqR2XoxMIN
         tV4w==
X-Gm-Message-State: AOAM531E8ejlo8ebakWJ3WdiZdys5UJlQM5SSuzDIRx9p+fU4MkfympW
        EX+O0t4CVwCIn1vYaa9o9I0NmTGId8xzXtZxgTw=
X-Google-Smtp-Source: ABdhPJyJ32mz1m4SbKIpE/9O/ggIXFjXPm/fgsr5hXMXRwvgMkxs2cbA5CIfK6hklkDLQrFTG2gRz0P+ObYqLqxgkl0=
X-Received: by 2002:a4a:bf14:: with SMTP id r20mr11363028oop.2.1611840730383;
 Thu, 28 Jan 2021 05:32:10 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com> <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <709fa03c-43b7-45e4-3ddc-aae0d8f4ced4@linux.intel.com> <CA+GA0_sXVNHr1048otvwGwORt17ET0EbvTq-kGMOQoh1YOWYRw@mail.gmail.com>
In-Reply-To: <CA+GA0_sXVNHr1048otvwGwORt17ET0EbvTq-kGMOQoh1YOWYRw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Jan 2021 14:31:59 +0100
Message-ID: <CAJZ5v0gRjO-0Kt8BHXwv2EbBuJhxcx=afQWpKkiUJBdVc8=dEg@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux 5.10
To:     =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 28, 2021 at 2:25 PM Marcin Ślusarz <marcin.slusarz@gmail.com> wrote:
>
> śr., 27 sty 2021 o 23:02 Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> napisał(a):
> > On 1/27/21 1:18 PM, Marcin Ślusarz wrote:
> > > śr., 27 sty 2021 o 18:28 Pierre-Louis Bossart
> > > <pierre-louis.bossart@linux.intel.com> napisał(a):
> > >>> Weird, I can't reproduce this problem with my self-compiled kernel :/
> > >>> I don't even see soundwire modules loaded in. Manually loading them of course
> > >>> doesn't do much.
> > >>>
> > >>> Previously I could boot into the "faulty" kernel by using "recovery mode", but
> > >>> I can't do that anymore - it crashes too.
> > >>>
> > >>> Maybe there's some kind of race and this bug depends on some specific
> > >>> ordering of events?
> > >>
> > >> missing Kconfig?
> > >> You need CONFIG_SOUNDWIRE and CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE
> > >> selected to enter this sdw_intel_acpi_scan() routine.
> > >
> > > It was a PEBKAC, but a slightly different one. I won't bore you with
> > > (embarrassing) details ;).
> > >
> > > I reproduced the problem, tested both your and Rafael's patches
> > > and the kernel still crashes, with the same stack trace.
> > > (Yes, I'm sure I booted the right kernel :)
> > >
> > > Why "recovery mode" stopped working (or worked previously) is still a mystery.
> > >
> >
> > Thanks Marcin for the information. If you have a consistent failure
> > that's better to some extent.
> >
> > Maybe a bit of explanation of what this routine tries to do:
> > when SoundWire is enabled in a system, we need to have the following
> > pattern in the DSDT:
> >
> >      Scope (_SB.PCI0)
> >      {
> >          Device (HDAS)
> >          {
> >              Name (_ADR, 0x001F0003)  // _ADR: Address
> >          }
> >
> >
> >          Scope (HDAS)
> >          {
> >              Device (SNDW)
> >              {
> >                  Name (_ADR, 0x40000000)  // _ADR: Address
> >
> > The only thing the code does is to walk through the children and check
> > if the valid _ADR 0x40000000 is found.
> >
> > You don't have SoundWire in your device so there should not be any
> > children found. I don't see anything in the DSDT that looks like
> > _SB.PCI0.HDAS.<something>, so in theory we should not even enter the
> > callback.
> >
> > The error happens in acpi_bus_get_device(), after we read the adr but
> > before we check it, so wondering if we shouldn't revert the checks. Can
> > you try the diff below? I am not sure why there is a crash and we should
> > root-cause this issue, just trying to triangulate what is happening.
> >
> > diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> > index cabdadb09a1b..6bc87a682fb3 100644
> > --- a/drivers/soundwire/intel_init.c
> > +++ b/drivers/soundwire/intel_init.c
> > @@ -369,13 +369,6 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle
> > handle, u32 level,
> >          if (ACPI_FAILURE(status))
> >                  return AE_OK; /* keep going */
> >
> > -       if (acpi_bus_get_device(handle, &adev)) {
> > -               pr_err("%s: Couldn't find ACPI handle\n", __func__);
> > -               return AE_NOT_FOUND;
> > -       }
> > -
> > -       info->handle = handle;
> > -
> >          /*
> >           * On some Intel platforms, multiple children of the HDAS
> >           * device can be found, but only one of them is the SoundWire
> > @@ -386,6 +379,13 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle
> > handle, u32 level,
> >          if (FIELD_GET(GENMASK(31, 28), adr) != SDW_LINK_TYPE)
> >                  return AE_OK; /* keep going */
> >
> > +       if (acpi_bus_get_device(handle, &adev)) {
> > +               pr_err("%s: Couldn't find ACPI handle\n", __func__);
> > +               return AE_NOT_FOUND;
> > +       }
> > +
> > +       info->handle = handle;
> > +
> >          /* device found, stop namespace walk */
> >          return AE_CTRL_TERMINATE;
> >   }
>
> still the same crash

The modification doesn't fundamentally change the conditions, but
since the flow gets to the acpi_bus_get_device() evaluation, adr
appears to make sense (which is kind of strange, because it shouldn't
in the "no SoundWire" case).
