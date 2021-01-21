Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A472FF25E
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 18:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbhAURsg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 12:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389229AbhAURs2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 12:48:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4EDC0613ED
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 09:47:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so2598492wrx.4
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 09:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j96Ln7ZT4wvRWc5O/15NLrOnQPo7WJgQFYyt38K2H2U=;
        b=YZPWDlNJiVde0uSZg0Ea6OMOi8zIH3rq5ghid4RrVCt8WU2nLqZnS2NknZ6iPF52Bw
         hQLh+7kxhIaYRIilZ2DVREqsg4Zxx9/KwzO5U/SYes/kKdIZdHhx4xuGA4vGqWzT/TDz
         +MMhTtlj3AKNuPI8jNBXXtaPKlV8tNhZ/JMu5rapSN+uG7mLCCse1BUeLvVAVepgDGt/
         U4qKyM3Tega1Nb4SDzCswHbxZxWfGcHt3wOg/IXTl+W5kRqdrLeknobNFk2xueZiWMYa
         FjX734Ude125jIA0ATTFT6rUvkkMD8mYlpTz+B0X4/T+GWq5flRo0sM8uPUFAwTJRZMk
         Cb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j96Ln7ZT4wvRWc5O/15NLrOnQPo7WJgQFYyt38K2H2U=;
        b=UjSFZoS/UlhlupjuFB/RW5Mp9dWuBMkculxU3c2T0XcN0FpmZhRGxUv6io1gvRM0q8
         lqEj7vXs2XE883O041Wzg8Xt6xvPJSKXTCEyckWYekfGoo4MKaq6BrH5QS90abseT+po
         smMpt8QqOJYp+cLzwQ3ryE3+UfjGW8719hAH3hKm4UsesqwOs80sSaNDW3WBVtiTWvTB
         6sgw/2Ik4JnxToBrRiobYLDhDEthtrDB7UBCrxL/gNjLS44QvglUkmmYvhvWLRz5dTYE
         IzQ0RRKFIy5SQ1AY8UJfj713NQUDn2PKBR/cLwLYHr9mFKBU82g+CyZdSlnP4pgxB4bD
         Wlzw==
X-Gm-Message-State: AOAM532W3tXlNIZGcHNXse/Yu+5p5m7hHm7EMXTaRIl7Y4/MplQVQjZ6
        ZpK00FqW0sEXP+m08NSU2W1fOMcO17g+1PhF80M=
X-Google-Smtp-Source: ABdhPJwDQ6YlIILLhhEEoueRGp1tt+aH9BWGM2mi38mPJ5EJ8cIvyDtU84gSIjUw7023Vj9C/nnT4tBDIhcgRKNtAu0=
X-Received: by 2002:adf:fa92:: with SMTP id h18mr615603wrr.142.1611251261301;
 Thu, 21 Jan 2021 09:47:41 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com> <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
In-Reply-To: <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Thu, 21 Jan 2021 18:47:29 +0100
Message-ID: <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
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

=C5=9Br., 20 sty 2021 o 23:28 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
> >> Linux 5.10 fails to boot on my IceLake laptop, where 5.9 worked fine.
> >> I'm not sure whether it's a bug in ACPI or Soundwire subsystem, so I'm
> >> sending this to both
> >> lists. The W taint flag is because of an unrelated nouveau failure (It
> >> was busted on 5.9, and is
> >> still on 5.10). Full kernel log down below.
> >> It's from a distro kernel, but I can build my own kernel with patches =
if needed.
> >
> > Please try to add a check for handle against NULL to
> > snd_intel_dsp_check_soundwire() after
> >
> > handle =3D ACPI_HANDLE(&pci->dev);
> >
> > and see if this makes any difference.
> >
> > This should check handle against NULL anyway, even if it didn't crash l=
ater on.

I'll do that later.

>
> Is there a way you can share the DSDT?

I uploaded it here: https://people.freedesktop.org/~mslusarz/tmp/dsdt.dat

>
> The only thing we do in that sdw_intel_acpi_scan() function is check for
> an _ADR and read two _DSD properties. I think it's been 2 years since we
> wrote it and never had an issue, never say never I guess...
>
> If you want to bypass this problem for the time being, you can add a
> kernel option in /etc/modprobe.d/alsa-base.conf
>
> options snd-intel-dspcfg dsp_driver=3D1
>
> that will force the use of the HDaudio legacy driver and bypass the
> driver autodetection.

Thanks.
