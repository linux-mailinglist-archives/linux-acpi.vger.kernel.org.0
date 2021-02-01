Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8560030A767
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 13:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhBAMRa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 07:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhBAMRV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 07:17:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7F8C061573
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 04:16:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c12so16330523wrc.7
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 04:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oJabRfuTZeECePsHkmJf5HW1b5PdAIVWqevNIinvl8Q=;
        b=G8Jhiphtk8XwIw6iD4FdZHGkvygenNRGNM+WjY5BiAo7fHz4u1XswmFe9wAEZGGFju
         Fx6tWZ3Z2WHcqwZiK6T1jBWsm1W9nsmM9f2tT5JjyJVHIRjAt0FQpjESy4fWYdItUiDW
         CdjkW8WJ0HIGuy7T5lut9ww6biQr9AMxGKeZ61nc2f4xVCwlSfa3XqH2TgUGZm+s1J3t
         2tW57SVmkjqQLKm9iRmtnyK/+ZiIqJWGUUXBpgKX3L/JGanrJLR6gA5LDlYRNqMIsxuY
         aLlalXkufcc7YcdfawsjypWnnT9IUXePdjoj4jgNwuQraTA3ZX/WSCQcQy690cpbH6g8
         V0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oJabRfuTZeECePsHkmJf5HW1b5PdAIVWqevNIinvl8Q=;
        b=QvRu70h+S75HOAaC234C0uXug8QjThy+KKfVpwOxc/pF5GItaKBveH0/kKy42+CVmG
         F3NvmO5IwZNeIJivvHy8sCoHh97eFQjxeFitnhwfDhcLzUbtdgF3bs4ITroFJAQdNbnN
         GT3NAk4se9mBP0IVjqmdoGmIQN4rxZbBS4zIgsQ16rv4s7JWnEL75bxPU+TACRQ9gguS
         0WjM38OX4QhPuNoSx6WYXGw1Uzvho5dEh65HMzUz6sp3mEz6/LIxd+xf2YghoujXz88w
         qeBxVKdwEvx0T7tjcBKRmkJh08CVYRXofQ1ArLe1svEaXu2ueGxqqjS4DOKYKsFQNnDz
         iylg==
X-Gm-Message-State: AOAM5306g5UoU0FZUjMOJtFnHnacdI/4sMjArrBgzfE4TqmGlGb/90XG
        Qw/dN8ZdFuxBfASNoIJH6A9EZeZgIY5g+Bp4C5Y=
X-Google-Smtp-Source: ABdhPJxK8qJ5CahqZe/ffBUqX/rfHLlY78dtxPHbgW380PZEKwltK8wpOq4XF1gJghr9iAOrH4Qk9XYedvW6p9HHEQQ=
X-Received: by 2002:a5d:4c84:: with SMTP id z4mr17338087wrs.289.1612181799212;
 Mon, 01 Feb 2021 04:16:39 -0800 (PST)
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
 <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com> <CAJZ5v0hqHihRdad16Djo+R1ezjFHt2YffgDg59TYYKJSSjmA4Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hqHihRdad16Djo+R1ezjFHt2YffgDg59TYYKJSSjmA4Q@mail.gmail.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Mon, 1 Feb 2021 13:16:16 +0100
Message-ID: <CA+GA0_s7atD4O_DP0NXwVUVvdia2NWwSEfW2Mcw-UoJ9effPvg@mail.gmail.com>
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

pon., 1 lut 2021 o 12:43 Rafael J. Wysocki <rafael@kernel.org> napisa=C5=82=
(a):
>
> On Fri, Jan 29, 2021 at 9:03 PM Marcin =C5=9Alusarz <marcin.slusarz@gmail=
.com> wrote:
> >
> > pt., 29 sty 2021 o 19:59 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com>=
 napisa=C5=82(a):
> > >
> > > czw., 28 sty 2021 o 15:32 Marcin =C5=9Alusarz <marcin.slusarz@gmail.c=
om> napisa=C5=82(a):
> > > >
> > > > czw., 28 sty 2021 o 13:39 Rafael J. Wysocki <rafael@kernel.org> nap=
isa=C5=82(a):
> > > > > The only explanation for that I can think about (and which does n=
ot
> > > > > involve supernatural intervention so to speak) is a stack corrupt=
ion
> > > > > occurring between these two calls in sdw_intel_acpi_cb().  IOW,
> > > > > something scribbles on the handle in the meantime, but ATM I have=
 no
> > > > > idea what that can be.
> > > >
> > > > I tried KASAN but it didn't find anything and kernel actually boote=
d
> > > > successfully.
> > >
> > > I investigated this and it looks like a compiler bug (or something na=
stier),
> > > but I can't find where exactly registers get corrupted because if I a=
dd printks
> > > the corruption seems on the printk side, but if I don't add them it s=
eems
> > > the value gets corrupted earlier.
> > (...)
> > > I'm using gcc 10.2.1 from Debian testing.
> >
> > Someone on IRC, after hearing only that "gcc miscompiles the kernel",
> > suggested disabling CONFIG_STACKPROTECTOR_STRONG.
> > It helped indeed and it matches my observations, so it's quite likely i=
t
> > is the culprit.
> >
> > What do we do now?
>
> Figure out why the stack protection kicks in, I suppose.
>
> The target object is not on the stack, so if the pointer to it is
> valid (we need to verify somehow that it is indeed), dereferencing it
> shouldn't cause the stack protection to trigger.

Well, the problem is not that stack protector finds something, but
the feature itself corrupts some registers.
