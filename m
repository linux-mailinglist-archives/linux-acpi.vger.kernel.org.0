Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10859306122
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 17:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhA0Qi0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 11:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbhA0QhZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 11:37:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5C8C06174A
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 08:36:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q7so2549708wre.13
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VaXvFofDQBL43I0u6dtbr2m8OtQ1+s1/YV8MzWBJU3Y=;
        b=EWz0LkYBq5Nywb4xl/My35Fixpsum7hCQKUhKJxBgW02Si/UzjX4UHtG5Aqmn/WvUP
         JYJVpIWtO7g3e82G3hKzowHgfNCUeW5EirVQR9ppnwxjolQuhRC3ACc8ZxeaZOktD2aq
         qaWmavxvynzJTodXRtVNOp+xiQimRXk2uVsIUEvsqi/J4BoLkHdv6LYuMmV6NFmZfqhj
         GjRw+z6C/On2/cUL76j5MpbrP4lbZK09jXsn+Rpw2ouoN6Vu9TF21hhVvbqzugA5F2oh
         5W00CTOdFlTxV0/11pjk6lk3IV+VchqSAPwE5dJ1hbeWEhYT9LsJiNfr9ZFQBvXySe13
         ZWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VaXvFofDQBL43I0u6dtbr2m8OtQ1+s1/YV8MzWBJU3Y=;
        b=uhZKgKZR9uQTrAH7/pkZYdfWkyDz1uwr/0ED2b/od6RPuO4Tzz31bWjQFBUz+FgXgo
         NLXco62E1AE5iWfjAmSizNKZ47PuFEEk3c6fY6U1b2lAoIQ7ICd4q1MMaW93fB7pO/Im
         2BFgu8mQz+L4kOE2bgdcRSxn1iYfQhnYhNPF6ZnFT8Uhg50Xf9xYVyycUftGMeVXjRww
         SdoT1XdpdCw4bftGLPXlBoYHi5WBj4gXBd65sFTYCwHn9EjrQT0IN2a2APpCei7oDYVC
         pkISlDl7VEobbl6cy/81TJVH+MBtIahox6l4Gt9/Zra+L0CYMC52ggQ31GWWFCHA27et
         23Qw==
X-Gm-Message-State: AOAM530MpaVb0kdGVy7xaAzRWScEgKzINgBf2s5X9SEALURYdSZOHGBL
        62VEJY1iKqPKDg48hoN3dKJYC6+W9We34sAnj2pA7L6d
X-Google-Smtp-Source: ABdhPJy1eeybekzidx0QliVZxuDpU6HjIbJ3kRak7obqIc44Oxlvar4O/7qcIT3/NHPLNpX9dTi9BKLD2NbTPDmJxuo=
X-Received: by 2002:a5d:5611:: with SMTP id l17mr12361882wrv.2.1611765404004;
 Wed, 27 Jan 2021 08:36:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
In-Reply-To: <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Wed, 27 Jan 2021 17:36:29 +0100
Message-ID: <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux 5.10
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
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

czw., 21 sty 2021 o 18:47 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> na=
pisa=C5=82(a):
>
> =C5=9Br., 20 sty 2021 o 23:28 Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
> > >> Linux 5.10 fails to boot on my IceLake laptop, where 5.9 worked fine=
.
> > >> I'm not sure whether it's a bug in ACPI or Soundwire subsystem, so I=
'm
> > >> sending this to both
> > >> lists. The W taint flag is because of an unrelated nouveau failure (=
It
> > >> was busted on 5.9, and is
> > >> still on 5.10). Full kernel log down below.
> > >> It's from a distro kernel, but I can build my own kernel with patche=
s if needed.
> > >
> > > Please try to add a check for handle against NULL to
> > > snd_intel_dsp_check_soundwire() after
> > >
> > > handle =3D ACPI_HANDLE(&pci->dev);
> > >
> > > and see if this makes any difference.
> > >
> > > This should check handle against NULL anyway, even if it didn't crash=
 later on.
>
> I'll do that later.

Weird, I can't reproduce this problem with my self-compiled kernel :/
I don't even see soundwire modules loaded in. Manually loading them of cour=
se
doesn't do much.

Previously I could boot into the "faulty" kernel by using "recovery mode", =
but
I can't do that anymore - it crashes too.

Maybe there's some kind of race and this bug depends on some specific
ordering of events?

>
> >
> > Is there a way you can share the DSDT?
>
> I uploaded it here: https://people.freedesktop.org/~mslusarz/tmp/dsdt.dat
>
> >
> > The only thing we do in that sdw_intel_acpi_scan() function is check fo=
r
> > an _ADR and read two _DSD properties. I think it's been 2 years since w=
e
> > wrote it and never had an issue, never say never I guess...
> >
> > If you want to bypass this problem for the time being, you can add a
> > kernel option in /etc/modprobe.d/alsa-base.conf
> >
> > options snd-intel-dspcfg dsp_driver=3D1
> >
> > that will force the use of the HDaudio legacy driver and bypass the
> > driver autodetection.

Yeah, this also works.
