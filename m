Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827874D2874
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Mar 2022 06:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiCIFbM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Mar 2022 00:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiCIFbL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2022 00:31:11 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B383FBD2
        for <linux-acpi@vger.kernel.org>; Tue,  8 Mar 2022 21:30:11 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id u124so1098648vsb.10
        for <linux-acpi@vger.kernel.org>; Tue, 08 Mar 2022 21:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+Akldmhfa/6AY9ueZhkjjjhYnFN4TT/Cp/6efYmSQs=;
        b=DJ9A6jNuDK6oZgagAIOQkCURdlyJJJ0m1m0fpXo4TTUYeZtuwaMeKSoLdEdcBzkwwM
         TgvicLAXg5CzCe0D7opbPRcz/KJFCz0VhtuevH3BD93skfXUvLutZuvZt0MK6i6mgKXF
         Vh7vlfdBOU1M+k7xMrXon0IRTD5yfeokjQAJua38ZpEXkT9wmXP3IQFqWPAPPFo3tewQ
         3TqLX4I623/nGCzC40kZpHVePyhSof5AkhHesseOb39J6pDNbwT2C4r6wsew2YxAOYce
         6IG9qtRwktEEjvn+pA/DrcC5ZXyYBKie4B9Mwc3fHmGPQ1nEm3jFgILSER9az4VbufRd
         yrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+Akldmhfa/6AY9ueZhkjjjhYnFN4TT/Cp/6efYmSQs=;
        b=pjVPpYL+XVbWmR7jid8UPQzuedqyuZY++4KCUMT94FcqXc7mX4S+wbfBVQF12U7zJn
         8/Lbf0awzzvV7JAea8ZLoR0MLDTE/CoivR88KtHj7vhvFR36OP6j3atmcepoPVrIG5UC
         2QHpWnr5nYZg13HgUXSeL140qjKOxMW2nWBKb6pJ7U4pxojihyf2bIqt6loBW7BvXJtc
         bqfaBlpS9M18988pur/nxU43L1ZbTEspdTxFIS4vgFqvmFOYGZG1z+ANPIgw0vOi5Z2j
         0ojuKIrCPp/aE5+McYQShHZYupPzXh0yhG2/tKDsFz/Fy3sOSVk4oe7wvYP8byclrNPI
         jkDw==
X-Gm-Message-State: AOAM532gtC3M4h+cqp+S2zl9+9dqYFtmDMEgpy9Zcoh4C6/4zBOp8Nns
        UBdf2BoBg2BhFejmHfumDQFpFQfe0wGaF1rjwAM=
X-Google-Smtp-Source: ABdhPJx92T13uoAu8lqB/WTsdEuyQRRxVklIyBF/m6jv1o/30wDq69fayfoXJrlScyOIyliA+0VChDNUYG7g0hM1/Zo=
X-Received: by 2002:a05:6102:558b:b0:322:8340:393a with SMTP id
 dc11-20020a056102558b00b003228340393amr1342128vsb.62.1646803810674; Tue, 08
 Mar 2022 21:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20220306111838.810959-1-chenhuacai@loongson.cn> <CAJZ5v0hsHMcqd==+cJZUcd3T11NUU6bSphFbBRjvv1ktCuH08w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hsHMcqd==+cJZUcd3T11NUU6bSphFbBRjvv1ktCuH08w@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 9 Mar 2022 13:29:59 +0800
Message-ID: <CAAhV-H7oB9KMSEv-ea-qazSFw+zBowqufO=8mWsPPP7L9Gx9vQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Rafael,

On Wed, Mar 9, 2022 at 2:49 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Mar 6, 2022 at 12:17 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> > boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> > are already added in the next revision of ACPI Specification (current
> > revision is 6.4).
> >
> > This patchset are preparing to add LoongArch support in mainline kernel,
> > we can see a snapshot here:
> > https://github.com/loongson/linux/tree/loongarch-next
> >
> > Cross-compile tool chain to build kernel:
> > https://github.com/loongson/build-tools/releases
> >
> > Loongson and LoongArch documentations:
> > https://github.com/loongson/LoongArch-Documentation
> >
> > ECR for LoongArch-specific interrupt controllers:
> > https://mantis.uefi.org/mantis/view.php?id=2203
> > https://mantis.uefi.org/mantis/view.php?id=2313
> >
> > ACPI changes of LoongArch have been approved in the last year, but the
> > new version of ACPI SPEC hasn't been made public yet.
> >
> > V2: Remove merged patches and update commit messages.
> >
> > Huacai Chen and Jianmin Lv(2):
> >  ACPICA: MADT: Add LoongArch APICs support.
> >  ACPICA: Events: Support fixed pcie wake event.
>
> Both patches in this series are mostly ACPICA material which needs to
> be submitted to the upstream ACPICA project via
> https://github.com/acpica/acpica
>
> It will be pulled by the Linux kernel from there.
I found that you are also a maintainer of the ACPICA project, do you
mean I should submit by github PR, not by maillist?

>
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > ---
> >  drivers/acpi/acpica/evevent.c  |  17 ++++--
> >  drivers/acpi/acpica/hwsleep.c  |  12 ++++
> >  drivers/acpi/acpica/utglobal.c |   4 ++
> >  drivers/acpi/tables.c          |  10 ++++
>
> This tables.c change can be submitted as a separate patch when the
> ACPICA changes get integrated.
Do you mean split the first patch into .h parts and .c parts, then
submit the .h parts and the second patch by github PR, then submit the
.c parts of the first patch by maillist?

Huacai
>
> >  include/acpi/actbl2.h          | 125 ++++++++++++++++++++++++++++++++++++++++-
> >  include/acpi/actypes.h         |   3 +-
> >  6 files changed, 163 insertions(+), 8 deletions(-)
> > --
> > 2.27.0
> >
