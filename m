Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2222F307705
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jan 2021 14:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhA1N02 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jan 2021 08:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhA1N0R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2021 08:26:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73A4C061573
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jan 2021 05:25:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z6so5338982wrq.10
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jan 2021 05:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5CJz8xLHc13QcIlEYKKlUT9R0qkQPk9oXqmcrIZ27QY=;
        b=hhFyNkNdt9g+ql1bsZG7vbhI10kPhDWRIYKPVMSW21jvFL7L5m6h7bD5hVgLHkXc57
         ASQb7KYAFtnHQMXZRoJMzbe1QU3YV9IklzuKF3Ty9p4pRHE8H26c4pl5l7OmnAcTQfLu
         0oQcCcVcS9sqq2c57HEEdQVG0MH7SoVGPcystgzxaY4pRBnZbVxHjHice93a1stnP2I9
         oT/texPqcMEYNXT5Vh7b5WF+2i2Vl3o37Vu9hcL6oTjFmiksDxbe6hjQXMSkgmc2//N6
         +LuyeiT41I9ZJaKt0nNpGmAd6NuM/q0dVLxH8NGLBmmWFq0L9EVM8kqsD/lmZUkSc8Zq
         oHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5CJz8xLHc13QcIlEYKKlUT9R0qkQPk9oXqmcrIZ27QY=;
        b=RXtZRf9H2KB7xmhM2T4+GgZJoXMBG+XTJTk+7/8o/w1hnVx1U5x3Exp1w9Nix/r2+Q
         f0UzaFIIwHWtsDyBWcy4EMXl59jKzNGZeTGD1TJN5AVpfQleGkTlOvXKMntDf+9V8uDo
         bP1rHE9JRj+NKJPckAlBai7uZhpD+JPB81S566oUMxMLfuBBX3hWwyEbnWdGEfOWVtpu
         RO/6Gbv/DC5Z9gBMxRsi0rCdQ8kmtYswjcIbx7X007MTdlUZY+FE3UOc2ZD/2K7fZ/tD
         rPgSH6z7dDUI5VA1Es3KA253PhcicT3rrxPM57Ocz5+WgKWzs71s15ZXz2W3XgNutjUF
         Z7KQ==
X-Gm-Message-State: AOAM530RsAIP4NXKnHvw7O9o7BkLi6Dkn3oQRtnbkrYF+YZjU/jZPFgZ
        /HbIb+i5gjthc6FRy+5zvw4uMzCp3t9rMI+XHJ9Irk/L1lc=
X-Google-Smtp-Source: ABdhPJwMQ9ruALH/Jb2jaRHJomVbcEBfRHKcvurxJRTBp/GAU9u3ZPLUFTVMgcarXl5ntS4iyKMiXpxmnqnazgKLVJ4=
X-Received: by 2002:a5d:4046:: with SMTP id w6mr15792973wrp.369.1611840335384;
 Thu, 28 Jan 2021 05:25:35 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com> <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <709fa03c-43b7-45e4-3ddc-aae0d8f4ced4@linux.intel.com>
In-Reply-To: <709fa03c-43b7-45e4-3ddc-aae0d8f4ced4@linux.intel.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Thu, 28 Jan 2021 14:25:19 +0100
Message-ID: <CA+GA0_sXVNHr1048otvwGwORt17ET0EbvTq-kGMOQoh1YOWYRw@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux 5.10
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

=C5=9Br., 27 sty 2021 o 23:02 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
> On 1/27/21 1:18 PM, Marcin =C5=9Alusarz wrote:
> > =C5=9Br., 27 sty 2021 o 18:28 Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
> >>> Weird, I can't reproduce this problem with my self-compiled kernel :/
> >>> I don't even see soundwire modules loaded in. Manually loading them o=
f course
> >>> doesn't do much.
> >>>
> >>> Previously I could boot into the "faulty" kernel by using "recovery m=
ode", but
> >>> I can't do that anymore - it crashes too.
> >>>
> >>> Maybe there's some kind of race and this bug depends on some specific
> >>> ordering of events?
> >>
> >> missing Kconfig?
> >> You need CONFIG_SOUNDWIRE and CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE
> >> selected to enter this sdw_intel_acpi_scan() routine.
> >
> > It was a PEBKAC, but a slightly different one. I won't bore you with
> > (embarrassing) details ;).
> >
> > I reproduced the problem, tested both your and Rafael's patches
> > and the kernel still crashes, with the same stack trace.
> > (Yes, I'm sure I booted the right kernel :)
> >
> > Why "recovery mode" stopped working (or worked previously) is still a m=
ystery.
> >
>
> Thanks Marcin for the information. If you have a consistent failure
> that's better to some extent.
>
> Maybe a bit of explanation of what this routine tries to do:
> when SoundWire is enabled in a system, we need to have the following
> pattern in the DSDT:
>
>      Scope (_SB.PCI0)
>      {
>          Device (HDAS)
>          {
>              Name (_ADR, 0x001F0003)  // _ADR: Address
>          }
>
>
>          Scope (HDAS)
>          {
>              Device (SNDW)
>              {
>                  Name (_ADR, 0x40000000)  // _ADR: Address
>
> The only thing the code does is to walk through the children and check
> if the valid _ADR 0x40000000 is found.
>
> You don't have SoundWire in your device so there should not be any
> children found. I don't see anything in the DSDT that looks like
> _SB.PCI0.HDAS.<something>, so in theory we should not even enter the
> callback.
>
> The error happens in acpi_bus_get_device(), after we read the adr but
> before we check it, so wondering if we shouldn't revert the checks. Can
> you try the diff below? I am not sure why there is a crash and we should
> root-cause this issue, just trying to triangulate what is happening.
>
> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_ini=
t.c
> index cabdadb09a1b..6bc87a682fb3 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -369,13 +369,6 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle
> handle, u32 level,
>          if (ACPI_FAILURE(status))
>                  return AE_OK; /* keep going */
>
> -       if (acpi_bus_get_device(handle, &adev)) {
> -               pr_err("%s: Couldn't find ACPI handle\n", __func__);
> -               return AE_NOT_FOUND;
> -       }
> -
> -       info->handle =3D handle;
> -
>          /*
>           * On some Intel platforms, multiple children of the HDAS
>           * device can be found, but only one of them is the SoundWire
> @@ -386,6 +379,13 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle
> handle, u32 level,
>          if (FIELD_GET(GENMASK(31, 28), adr) !=3D SDW_LINK_TYPE)
>                  return AE_OK; /* keep going */
>
> +       if (acpi_bus_get_device(handle, &adev)) {
> +               pr_err("%s: Couldn't find ACPI handle\n", __func__);
> +               return AE_NOT_FOUND;
> +       }
> +
> +       info->handle =3D handle;
> +
>          /* device found, stop namespace walk */
>          return AE_CTRL_TERMINATE;
>   }

still the same crash
