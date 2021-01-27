Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3831E3063F3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 20:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhA0TT5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 14:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhA0TTy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 14:19:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5C7C06174A
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 11:19:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c128so2643167wme.2
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2021 11:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WmTmSJyvMNMEsxUfXorZvamTtfHyuaHjFj26Pjyvxgg=;
        b=B7uVylQ4lWkmgSEe8GWJf1WCvdQR/UkeEDDPlC+SkfwO9jgFMoHL9DQ1Q4MvMkpBlV
         qdNXepVzwR1lj8z9hIAWbQdWYXDELgnVAvpvciskVcarC9cWy4W5Pii+eYZBBtRnWhox
         Vvc8T9Yf5br5KXAgnDTiu7xr4Qm1BIKjHyLtvS3hePk8RLMZem3ohq4U8oRce3XGIIkQ
         6a7y/kdk1YzLh/fe58BMrm9EuFOoXUR6UG45FqICGgfJqPL5mbwtRXPAAPnWPoCSnI7n
         FAbvsq4XdnxPCy8doFkQEXsdYPdX+RvEenPc/swndBYjiHLMLYlyA5OPPSrrgn2Dw1tK
         5p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WmTmSJyvMNMEsxUfXorZvamTtfHyuaHjFj26Pjyvxgg=;
        b=f+/XDWkN6tZdhPmqsb1NeXmRqua3heMZSsupT6W2Bn9sy5A68v6EdBFCqfmymPrie2
         Tt+AmDOguGrmzoAvL/YkcWe/4WFo0pxrCwt3DpQLhmUIaSKCCM86ssZGOCzMogsZK30k
         4YxSMMqy9Q21nnBWewOqOHKM0GuOWohr5Uc9jZiWQK/la0K/+9jdSJTLt+A6/KNCLioR
         bWQzFHIfu8WUaq9hJiDvQZ7oAYuPfzQbjMC9DLF1suUF8aF1bkA/foEh/0SUNEXz79Eq
         hPpjbDHd4mShJP9eZpWV0WYybMkSkaxzy35e3DPGW9d5OPshAnYm8JKIsjfhuE+3EoAs
         gOrw==
X-Gm-Message-State: AOAM531VelNqcXsamA5mND47DrXfxGMXogrnSAdsT0pNSG+U6jG/CXax
        TOwz9So/qgGPVOptkro42Qk1JJ23IUi451/AFbM=
X-Google-Smtp-Source: ABdhPJwjVss4T/I/Wvjp4U+yLwODJcxV8/S0Q16ivTYKxPBelNOC8XdFXHFlIPDJtsRRyLJG/KAN8Tp6hizIIr+sLI8=
X-Received: by 2002:a1c:2905:: with SMTP id p5mr5413653wmp.156.1611775152973;
 Wed, 27 Jan 2021 11:19:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com> <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com>
In-Reply-To: <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Wed, 27 Jan 2021 20:18:58 +0100
Message-ID: <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
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

=C5=9Br., 27 sty 2021 o 18:28 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):
> > Weird, I can't reproduce this problem with my self-compiled kernel :/
> > I don't even see soundwire modules loaded in. Manually loading them of =
course
> > doesn't do much.
> >
> > Previously I could boot into the "faulty" kernel by using "recovery mod=
e", but
> > I can't do that anymore - it crashes too.
> >
> > Maybe there's some kind of race and this bug depends on some specific
> > ordering of events?
>
> missing Kconfig?
> You need CONFIG_SOUNDWIRE and CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE
> selected to enter this sdw_intel_acpi_scan() routine.

It was a PEBKAC, but a slightly different one. I won't bore you with
(embarrassing) details ;).

I reproduced the problem, tested both your and Rafael's patches
and the kernel still crashes, with the same stack trace.
(Yes, I'm sure I booted the right kernel :)

Why "recovery mode" stopped working (or worked previously) is still a myste=
ry.
