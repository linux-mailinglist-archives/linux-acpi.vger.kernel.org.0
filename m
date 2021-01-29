Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241CF308E0B
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 21:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhA2UE7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jan 2021 15:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhA2UEU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jan 2021 15:04:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF4C061573
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jan 2021 12:03:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j18so7727309wmi.3
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jan 2021 12:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hug8S9/u6gukwSGFne0RtOBB1RjPUWO6spzpB//NDIE=;
        b=RcgGsEXPjG9NDhY/kb8KhPG2GwXxddsWdrfNG3GK0NYyNxX1sYKwkigcbscamZJPXv
         h1ZoRh6MkC50apjO/ivUgtgxr6v41vKr3Saiefm9V3D/7JR+VjuoP22z4x9mAWLFjogx
         0QWjOp/D/9aEoReb97nZAcb1suUEvw52Y6ul+1NcErvaieDQCaja57C2WOJQSx52/tva
         QHnVZpViHNZ2f+5hUvesjJYpzqxkaDt0Ck4CzlORvMDvD4Emp/PZ3I5sZ1oZ+KRFvE+q
         kcjYoCpTVSNADBGVanigV7vnSYAojWXAhn4+ekdE230w+hGAddBNsFPI5DUtgKhFdEvM
         1Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hug8S9/u6gukwSGFne0RtOBB1RjPUWO6spzpB//NDIE=;
        b=jL0shG6n5oXAfQzHS+qVuCdD5HDnO6/U2vEZt9890/YJD8/3bTti2wxCwzbSCuTSqk
         dJmDLAlsNTmpXnxeCX5+ItG8U0nV/m+tcUo+/jVsKSkgAl5p5P9WIUiJR+UH3RuX47f3
         mk6AumeacHnbofDnxW5V61C5QDzgaFBb3aAZCNScwVxqaUKdhqSUVtiGIHIDOyY6zMeF
         w2ZCyf09Y7x2Dh2u2AjhYIbRVh3aFRumuplkKUJrJbkuAbOmL6wNN0PrKA/+EzFTJ4bP
         StWv1lz3zoePwxIgZGzt8HAd+vfZPadscrDAtRn7GcoIaN9zvLSRL8pmgZL/gNaEHLtN
         X/Jg==
X-Gm-Message-State: AOAM530Wxku4LGcektyOWtRHRvaiEJbYEKKxuc/Pmr2rWE6qvJFvOqYB
        +WERm9ut7Xd5euaWidAPKQCc40TSjRtSwX40mqI=
X-Google-Smtp-Source: ABdhPJzDwiUvbv5M+7BBhbm5J46MDckUR1Hu1LekLVacxnKwDlJ7m7Wv1XHttYBc1mE+ohvxHZuImIcqqG0EVFvFngE=
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr5282916wme.76.1611950616549;
 Fri, 29 Jan 2021 12:03:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com> <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
 <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
 <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com> <CA+GA0_vKyJZSQZ9bA6_BSDeGfRZ_nz86gj2aVHaOoy1h57CMzA@mail.gmail.com>
In-Reply-To: <CA+GA0_vKyJZSQZ9bA6_BSDeGfRZ_nz86gj2aVHaOoy1h57CMzA@mail.gmail.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Fri, 29 Jan 2021 21:03:18 +0100
Message-ID: <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux 5.10
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pt., 29 sty 2021 o 19:59 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> nap=
isa=C5=82(a):
>
> czw., 28 sty 2021 o 15:32 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> =
napisa=C5=82(a):
> >
> > czw., 28 sty 2021 o 13:39 Rafael J. Wysocki <rafael@kernel.org> napisa=
=C5=82(a):
> > > The only explanation for that I can think about (and which does not
> > > involve supernatural intervention so to speak) is a stack corruption
> > > occurring between these two calls in sdw_intel_acpi_cb().  IOW,
> > > something scribbles on the handle in the meantime, but ATM I have no
> > > idea what that can be.
> >
> > I tried KASAN but it didn't find anything and kernel actually booted
> > successfully.
>
> I investigated this and it looks like a compiler bug (or something nastie=
r),
> but I can't find where exactly registers get corrupted because if I add p=
rintks
> the corruption seems on the printk side, but if I don't add them it seems
> the value gets corrupted earlier.
(...)
> I'm using gcc 10.2.1 from Debian testing.

Someone on IRC, after hearing only that "gcc miscompiles the kernel",
suggested disabling CONFIG_STACKPROTECTOR_STRONG.
It helped indeed and it matches my observations, so it's quite likely it
is the culprit.

What do we do now?

Marcin
