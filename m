Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127134D6C98
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Mar 2022 06:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiCLFTy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Mar 2022 00:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLFTx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Mar 2022 00:19:53 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1EB6394
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 21:18:47 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id b37so4475947uad.12
        for <linux-acpi@vger.kernel.org>; Fri, 11 Mar 2022 21:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6gvOTjJhyxTrlDwG/7lyMFgff9/CjZtt/ONEhrVL8ok=;
        b=YjfNJ277SCkDJ5tsr3RbrcxDhPK2nE5+hoajU2AUdYExJY6cqEcJAaaoWLXLj5LMYy
         35xShfWJMf7KzqoIrO4tg5LlYQ6FztRyf3ynp1FrhJvFIYqy0ap0tiyuWh7H8vict+Gk
         xt2n45yRPVqTjnC/jpOUiREWqkAn4P75lXvyTQP804fDdiUYVUsSBpW/sVP9YTFmolXy
         S2cUK6NTZ1++e2XT9uVf7bIhq/4hRyb1/amQBCDW6lvLWPZuBEYHMHEDguhzdtVonikO
         4fWvlqt1VLKEi63IfZmEOXPFokb3M3PrDC29xpLhUzi1LTey4u1b0rEXMURsDrcYtMyh
         b7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6gvOTjJhyxTrlDwG/7lyMFgff9/CjZtt/ONEhrVL8ok=;
        b=F/g1qU4Iy1WisicBdDBWFf6wRLHq8oLrXB6xi65bxSctPKr2gkOhv2DIW1YaYVN09V
         WNVzYNcakv6JLst/SFUNvO8Og7D242BF4dPpOgI9VN4pxmZm+M5q93miqX3oxVmo67K3
         IpoRTnxeF2UF8IXDTrP6AcXk+Re4yZF53Df2MFEeqGES4HcOqdsjCceDB9mN8DxFCZIc
         tvH4GQsmvCLdxZvO/uUGcelQXBUmWbM83eB2vAv1pDFUN6OrM2QlNt/CJN76FQ6HgDMs
         wSs92amHXuTd4vyXoEAVRHH32/GIQxTu1vpBcEJQjHuWJBrd1sSutkrj79qQILY2pWMN
         1mqA==
X-Gm-Message-State: AOAM532nAxejvsxMp3bbA9d8gO+T5bsTPHbBid6gu3IcWeZx61e0rsFc
        hcFn5/91Y7LCU1BgCPS06C1D7g6atoyzA7fH0XGdO+uearW6sA==
X-Google-Smtp-Source: ABdhPJyDfL6ipzyf1UBgacnfrR6o/IlSEqw8OKuNPOOT66RIM+LdsSTqS6oDF3i5P2c7W2VaIXs5rAjfpOqfAr8QT7I=
X-Received: by 2002:ab0:7149:0:b0:34b:6c41:6caa with SMTP id
 k9-20020ab07149000000b0034b6c416caamr5747184uao.27.1647062326318; Fri, 11 Mar
 2022 21:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20220306111838.810959-1-chenhuacai@loongson.cn>
 <CAJZ5v0hsHMcqd==+cJZUcd3T11NUU6bSphFbBRjvv1ktCuH08w@mail.gmail.com>
 <CAAhV-H7oB9KMSEv-ea-qazSFw+zBowqufO=8mWsPPP7L9Gx9vQ@mail.gmail.com> <BYAPR11MB3256DACFEA49CBB8DBBC353C870C9@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256DACFEA49CBB8DBBC353C870C9@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 12 Mar 2022 13:18:35 +0800
Message-ID: <CAAhV-H7715fdxcq4kvkHZ5hsZPjYQ5O6+M+G4M8_x7gsZuFDNg@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Moore,

On Fri, Mar 11, 2022 at 11:16 PM Moore, Robert <robert.moore@intel.com> wro=
te:
>
>
>
> -----Original Message-----
> From: Huacai Chen <chenhuacai@gmail.com>
> Sent: Tuesday, March 08, 2022 9:30 PM
> To: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Huacai Chen <chenhuacai@loongson.cn>; Rafael J . Wysocki <rjw@rjwysoc=
ki.net>; Len Brown <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com=
>; Erik Kaneda <erik.kaneda@intel.com>; ACPI Devel Maling List <linux-acpi@=
vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE (ACPICA) <devel@acp=
ica.org>; Xuefeng Li <lixuefeng@loongson.cn>; Jiaxun Yang <jiaxun.yang@flyg=
oat.com>; Jianmin Lv <lvjianmin@loongson.cn>
> Subject: Re: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions
>
> Hi, Rafael,
>
> On Wed, Mar 9, 2022 at 2:49 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
> >
> > On Sun, Mar 6, 2022 at 12:17 PM Huacai Chen <chenhuacai@loongson.cn> wr=
ote:
> > >
> > > LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> > > LoongArch includes a reduced 32-bit version (LA32R), a standard
> > > 32-bit version (LA32S) and a 64-bit version (LA64). LoongArch use
> > > ACPI as its boot protocol LoongArch-specific interrupt controllers
> > > (similar to APIC) are already added in the next revision of ACPI
> > > Specification (current revision is 6.4).
> > >
> > > This patchset are preparing to add LoongArch support in mainline
> > > kernel, we can see a snapshot here:
> > > https://github.com/loongson/linux/tree/loongarch-next
> > >
> > > Cross-compile tool chain to build kernel:
> > > https://github.com/loongson/build-tools/releases
> > >
> > > Loongson and LoongArch documentations:
> > > https://github.com/loongson/LoongArch-Documentation
> > >
> > > ECR for LoongArch-specific interrupt controllers:
> > > https://mantis.uefi.org/mantis/view.php?id=3D2203
> > > https://mantis.uefi.org/mantis/view.php?id=3D2313
> > >
> > > ACPI changes of LoongArch have been approved in the last year, but
> > > the new version of ACPI SPEC hasn't been made public yet.
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
> I found that you are also a maintainer of the ACPICA project, do you mean=
 I should submit by github PR, not by maillist?
>
> Yes.
I have already submit by github PR.

Huacai
> >
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > > ---
> > >  drivers/acpi/acpica/evevent.c  |  17 ++++--
> > > drivers/acpi/acpica/hwsleep.c  |  12 ++++
> > >  drivers/acpi/acpica/utglobal.c |   4 ++
> > >  drivers/acpi/tables.c          |  10 ++++
> >
> > This tables.c change can be submitted as a separate patch when the
> > ACPICA changes get integrated.
> Do you mean split the first patch into .h parts and .c parts, then submit=
 the .h parts and the second patch by github PR, then submit the .c parts o=
f the first patch by maillist?
>
> No, that is not necessary.
>
> Huacai
> >
> > >  include/acpi/actbl2.h          | 125 +++++++++++++++++++++++++++++++=
+++++++++-
> > >  include/acpi/actypes.h         |   3 +-
> > >  6 files changed, 163 insertions(+), 8 deletions(-)
> > > --
> > > 2.27.0
> > >
