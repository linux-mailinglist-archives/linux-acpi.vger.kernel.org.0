Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8785F30F372
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 13:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhBDMuE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 07:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhBDMuD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 07:50:03 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCBC061573
        for <linux-acpi@vger.kernel.org>; Thu,  4 Feb 2021 04:49:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id w4so3000787wmi.4
        for <linux-acpi@vger.kernel.org>; Thu, 04 Feb 2021 04:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fEUlv+xghuMoX85SLZ/8Eet91YOqowydbDYODhOPyBg=;
        b=leiudJNw729oJ/3GOpEWm5v8k2wpSvhpcQuu1RZopYgJh/IULWpJQ9qKFx7gVlBSHx
         W9tn5uNRm5AxIW98Usq4UGFPGeefKL8OXVA0toqK5JL5gBA1/XH1mRZ8e44H1e2bmu2U
         BIfcjZaolr2kqFkN0wHGoz+d+4qncSpr2syGcGDGLUeGMXF1CPpoCxbC5KTVyOZBp1Ub
         8CdePw1fMP7eSajdwQ7558rXi2R8jEfMCp+ITyg0TKbqXX7VgGQrq/JzhhhIJ0k84fAc
         WBHXMKL94wrZWeZa0GMGkeiVkynb3pLC/6axKXu0Z8ZiwwleZLBRtl2TExHLURBFDEg+
         M4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fEUlv+xghuMoX85SLZ/8Eet91YOqowydbDYODhOPyBg=;
        b=lV1O/Nbuaq76AMME7tOsR5DeaF+ngh6EQCoVCL6k5Nr/zszUPMDAs8/9FLJxF2wVoo
         b51Y+uSbrJv8IHU3IUXq+h6z42hehOuFb2rzDPpOs852uwhqxbQzOUWvyHANrqClhFfy
         CHfPadE03uGg7A1Y4yvZvDZoXChTE3lDbHoHrLtCpOMZ8eNO7UixidIr6tVquKNt/Zdw
         joOCAQDwsOw+kzFl74nSaVTkDkK/SgNMMGSPGNI3OhoNfL2dAIakkexBdll7tAGLYCwL
         oaiwY9z72LQEmG7SjzkMLAXaLUG7Srd1MZTgd5VwC2Mab+9AWYTEqcBRUQakqgi3W8q9
         qsAQ==
X-Gm-Message-State: AOAM53269GXOAbgZuLApCYS8acpOthKMIjR+ZXG8aFoW9Wi88RG93Abh
        oerejRkEOnII88HY/5rj4M1HNw3GlTSGWn2TKV8=
X-Google-Smtp-Source: ABdhPJxyVqmUGkpHtUNgbE1wuFIvJVT/WDButLa0nCuI2mCCu1otJP+HKlXCVTIBWc0HS7CtcmuaZ9gxWcaYLHXS5iM=
X-Received: by 2002:a05:600c:35ce:: with SMTP id r14mr7434530wmq.136.1612442961064;
 Thu, 04 Feb 2021 04:49:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com> <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
 <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
 <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com>
 <CA+GA0_vKyJZSQZ9bA6_BSDeGfRZ_nz86gj2aVHaOoy1h57CMzA@mail.gmail.com>
 <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com>
 <CAJZ5v0hqHihRdad16Djo+R1ezjFHt2YffgDg59TYYKJSSjmA4Q@mail.gmail.com>
 <CA+GA0_s7atD4O_DP0NXwVUVvdia2NWwSEfW2Mcw-UoJ9effPvg@mail.gmail.com> <CA+GA0_sZQXACjuzYYvrJq-vF-mmjaq82SJ=kifqo4Utv45s5Yg@mail.gmail.com>
In-Reply-To: <CA+GA0_sZQXACjuzYYvrJq-vF-mmjaq82SJ=kifqo4Utv45s5Yg@mail.gmail.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Thu, 4 Feb 2021 13:48:54 +0100
Message-ID: <CA+GA0_vSA51NbyTDtW-2A4aCCp+xXN_BtJfPFAJesRYM0eo9WQ@mail.gmail.com>
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

czw., 4 lut 2021 o 13:11 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> nap=
isa=C5=82(a):
>
> pon., 1 lut 2021 o 13:16 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> n=
apisa=C5=82(a):
> >
> > pon., 1 lut 2021 o 12:43 Rafael J. Wysocki <rafael@kernel.org> napisa=
=C5=82(a):
> > >
> > > On Fri, Jan 29, 2021 at 9:03 PM Marcin =C5=9Alusarz <marcin.slusarz@g=
mail.com> wrote:
> > > >
> > > > pt., 29 sty 2021 o 19:59 Marcin =C5=9Alusarz <marcin.slusarz@gmail.=
com> napisa=C5=82(a):
> > > > >
> > > > > czw., 28 sty 2021 o 15:32 Marcin =C5=9Alusarz <marcin.slusarz@gma=
il.com> napisa=C5=82(a):
> > > > > >
> > > > > > czw., 28 sty 2021 o 13:39 Rafael J. Wysocki <rafael@kernel.org>=
 napisa=C5=82(a):
> > > > > > > The only explanation for that I can think about (and which do=
es not
> > > > > > > involve supernatural intervention so to speak) is a stack cor=
ruption
> > > > > > > occurring between these two calls in sdw_intel_acpi_cb().  IO=
W,
> > > > > > > something scribbles on the handle in the meantime, but ATM I =
have no
> > > > > > > idea what that can be.
> > > > > >
> > > > > > I tried KASAN but it didn't find anything and kernel actually b=
ooted
> > > > > > successfully.
> > > > >
> > > > > I investigated this and it looks like a compiler bug (or somethin=
g nastier),
> > > > > but I can't find where exactly registers get corrupted because if=
 I add printks
> > > > > the corruption seems on the printk side, but if I don't add them =
it seems
> > > > > the value gets corrupted earlier.
> > > > (...)
> > > > > I'm using gcc 10.2.1 from Debian testing.
> > > >
> > > > Someone on IRC, after hearing only that "gcc miscompiles the kernel=
",
> > > > suggested disabling CONFIG_STACKPROTECTOR_STRONG.
> > > > It helped indeed and it matches my observations, so it's quite like=
ly it
> > > > is the culprit.
> > > >
> > > > What do we do now?
> > >
> > > Figure out why the stack protection kicks in, I suppose.
> > >
> > > The target object is not on the stack, so if the pointer to it is
> > > valid (we need to verify somehow that it is indeed), dereferencing it
> > > shouldn't cause the stack protection to trigger.
> >
> > Well, the problem is not that stack protector finds something, but
> > the feature itself corrupts some registers.
>
> I retract this statement.
>
> Originally I based it on this piece of code:
>    0xffffffff815781f0 <+35>:    mov    %r12,%rdx
>    0xffffffff815781f3 <+38>:    mov    $0xffffffff81eca4c0,%rsi
>    0xffffffff815781fa <+45>:    mov    $0xffffffff82146d46,%rdi
>    0xffffffff81578201 <+52>:    call   0xffffffff818909f1 <printk>
>    0xffffffff81578206 <+57>:    cmpb   $0xf,0x8(%r12)
> where crash is on the last line and I supposedly could see the message
> printed by printk with the correct value of %r12.
> However, after attaching kgdb+kgdboe (it's so much pain...) to the kernel
> I discovered that someting corrupts memory so much that the formatting
> string becomes "", which means that I don't actually see the output of pr=
intk.

Oh crap, I can't reproduce it anymore. I might have tried this before
I disabled KALSR, which would explain why I've seen "" as a formatting
string. (because 0xffffffff82146d46 would not be the real address of it)
