Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986E24D5C6D
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Mar 2022 08:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244289AbiCKHg0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Mar 2022 02:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242566AbiCKHgW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Mar 2022 02:36:22 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B5D1B71A9
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 23:35:19 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id j201so4245186vke.11
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 23:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK8jJe5p0CmtAP9GGVmcx4LMpBtc3WqynwWuA7UMUt8=;
        b=dua3ythHZ4ZLzaVF9KNqhLPkaYPqp2C4fVWilOtuDEH526RQDQFUjJ2I3ZREdj+erV
         oNMQs84sKZGhN6V/PQ7CYFjyYLLFJTf/bCNuJV+5PNBAIjUuTvWg9mPZkTW9PH2LEO3x
         k32N3Tpg5/tvxmzMScumAnOenxJ5gcUzJEMckYSfMv+qINjouIp154gbQeFdt6FiZGiZ
         fzhOMZBch3Mum0+Hjs9kAQOlTksm16NdG3xLhDfCHL3v1gvt2ixMIq5mhav8OtDTrZ2i
         0kW/w1CmtHalQZjBrSc/WsBgs5O1wHIKV0fX4xk6Z2DC07CsDMvHDarJoABPYplju4pz
         DbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK8jJe5p0CmtAP9GGVmcx4LMpBtc3WqynwWuA7UMUt8=;
        b=2U6Rro7MWOzCC+gASDfJ4XiJ3+MsigFYvLT0oWN78j09+XT1U6dBAPSSTbReMr1X6g
         HrQt/5yq0dHapC5YWGx3aqW65rXz3f2dmqxj0QnMrD/ibF0WVKQSCoOqu1DIyQLEOAzA
         3tf6BOATDApMuqlVL144+wqv2TXEOy8auVtjuvtqU5JZrL54jrYOamV8BUZzXgnSAj12
         9OEgg/KRUj7sUXMYrfwsTvtyJyESrwwgX0bX10H8EgmE/bFoQYyvwI6W/Ls2O/6hVZCc
         cTt3CZLL46+jCGa9QDkCkKWdBAjJ6DMBzwIRzM0hp7JWBhslJpLgULItpOCUOU6ie7vH
         9q5Q==
X-Gm-Message-State: AOAM531lyGFeqbrlQrHFxxT/CWhiiGvyT86AVBHU2KvXp23u6aokxhkx
        BiIImR7kFRszLwq3I+jkF75U0scaZmOkSL7qF6o=
X-Google-Smtp-Source: ABdhPJyE4G4GVup4tTVrpyUDLaEMUnMTwLjQea3AwHSsOTr89XHqNWWWDyWxhMnSD4aBtOUCZN4lEc4tS36/NST6HIE=
X-Received: by 2002:a1f:1dce:0:b0:333:21cc:1a81 with SMTP id
 d197-20020a1f1dce000000b0033321cc1a81mr4112931vkd.18.1646984118292; Thu, 10
 Mar 2022 23:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20220306111838.810959-1-chenhuacai@loongson.cn>
 <CAJZ5v0hsHMcqd==+cJZUcd3T11NUU6bSphFbBRjvv1ktCuH08w@mail.gmail.com> <CAAhV-H7oB9KMSEv-ea-qazSFw+zBowqufO=8mWsPPP7L9Gx9vQ@mail.gmail.com>
In-Reply-To: <CAAhV-H7oB9KMSEv-ea-qazSFw+zBowqufO=8mWsPPP7L9Gx9vQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 11 Mar 2022 15:35:06 +0800
Message-ID: <CAAhV-H6SLk9z4VkJ98RAwkEpTLvpW3nd9Cq+bsB-gW1-LdUnYA@mail.gmail.com>
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

On Wed, Mar 9, 2022 at 1:29 PM Huacai Chen <chenhuacai@gmail.com> wrote:
>
> Hi, Rafael,
>
> On Wed, Mar 9, 2022 at 2:49 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Sun, Mar 6, 2022 at 12:17 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > > LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> > > version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> > > boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> > > are already added in the next revision of ACPI Specification (current
> > > revision is 6.4).
> > >
> > > This patchset are preparing to add LoongArch support in mainline kernel,
> > > we can see a snapshot here:
> > > https://github.com/loongson/linux/tree/loongarch-next
> > >
> > > Cross-compile tool chain to build kernel:
> > > https://github.com/loongson/build-tools/releases
> > >
> > > Loongson and LoongArch documentations:
> > > https://github.com/loongson/LoongArch-Documentation
> > >
> > > ECR for LoongArch-specific interrupt controllers:
> > > https://mantis.uefi.org/mantis/view.php?id=2203
> > > https://mantis.uefi.org/mantis/view.php?id=2313
> > >
> > > ACPI changes of LoongArch have been approved in the last year, but the
> > > new version of ACPI SPEC hasn't been made public yet.
> > >
> > > V2: Remove merged patches and update commit messages.
> > >
> > > Huacai Chen and Jianmin Lv(2):
> > >  ACPICA: MADT: Add LoongArch APICs support.
> > >  ACPICA: Events: Support fixed pcie wake event.
> >
> > Both patches in this series are mostly ACPICA material which needs to
> > be submitted to the upstream ACPICA project via
> > https://github.com/acpica/acpica
> >
> > It will be pulled by the Linux kernel from there.
> I found that you are also a maintainer of the ACPICA project, do you
> mean I should submit by github PR, not by maillist?
I submit ACPICA project, please review:
https://github.com/acpica/acpica/pull/757

Huacai
>
> >
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > > ---
> > >  drivers/acpi/acpica/evevent.c  |  17 ++++--
> > >  drivers/acpi/acpica/hwsleep.c  |  12 ++++
> > >  drivers/acpi/acpica/utglobal.c |   4 ++
> > >  drivers/acpi/tables.c          |  10 ++++
> >
> > This tables.c change can be submitted as a separate patch when the
> > ACPICA changes get integrated.
> Do you mean split the first patch into .h parts and .c parts, then
> submit the .h parts and the second patch by github PR, then submit the
> .c parts of the first patch by maillist?
>
> Huacai
> >
> > >  include/acpi/actbl2.h          | 125 ++++++++++++++++++++++++++++++++++++++++-
> > >  include/acpi/actypes.h         |   3 +-
> > >  6 files changed, 163 insertions(+), 8 deletions(-)
> > > --
> > > 2.27.0
> > >
