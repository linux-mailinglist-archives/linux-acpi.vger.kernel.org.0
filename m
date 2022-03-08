Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3764B4D207D
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Mar 2022 19:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349710AbiCHSua (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Mar 2022 13:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349696AbiCHSuW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2022 13:50:22 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F81552E3C
        for <linux-acpi@vger.kernel.org>; Tue,  8 Mar 2022 10:49:26 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2dc348dab52so178631467b3.6
        for <linux-acpi@vger.kernel.org>; Tue, 08 Mar 2022 10:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nyh3q5AmkurI2j9g19+bjblbFKnL13Pmrx5aakYOePA=;
        b=3DVj/kSuP3h4ldcq9MNxz7Q9WaBh7bFB1Lf3YGy7DqYyPcSVYi79mLR2CdEf3Saj2r
         V6jpHrJg/0xgMk5qrCwkhVd/9So6YOE0krDpi3Mdgjc3xgVBKVRUu6OE8D4xl/+6iRgz
         NKZWtYdAKk/l/YsmTTbH2CVIZc8jREdKdKkBYPqAeUS70eylnqM3nf0JhIlPwhR0HsbF
         x/dQgI/+NmnXUd9eLdDebqgaTbfJax/v0YEtiVOQtDw3Vi+6pFZbhanjhF59RrH8t35e
         +UuVZGBz0UuBhzyS7klbKA6FiuJBcIeiXupSl/1JPsj1Rq0QwFI+U5KuaNaddXzu5HIs
         R9aQ==
X-Gm-Message-State: AOAM532E+rlVF985aDzwibFe8WkQ8lUmGYACEEfhnaO+vSzIJKnHbeMc
        lxvs3UlQWpxN6iFrcG4Jm1KIpYsTn1pHPSiphEc=
X-Google-Smtp-Source: ABdhPJyl72NZ6wDli1DHB6/e0VogH4/zmns8SSrZS40ksbFAEj7L52VY5eIm2zoGpaWqlSF/Urmx0lmT7Wj83M3eSq8=
X-Received: by 2002:a81:19c3:0:b0:2dc:2686:14e3 with SMTP id
 186-20020a8119c3000000b002dc268614e3mr14009637ywz.515.1646765365090; Tue, 08
 Mar 2022 10:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20220306111838.810959-1-chenhuacai@loongson.cn>
In-Reply-To: <20220306111838.810959-1-chenhuacai@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 19:49:14 +0100
Message-ID: <CAJZ5v0hsHMcqd==+cJZUcd3T11NUU6bSphFbBRjvv1ktCuH08w@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] ACPI: Add LoongArch-related definitions
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 6, 2022 at 12:17 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> are already added in the next revision of ACPI Specification (current
> revision is 6.4).
>
> This patchset are preparing to add LoongArch support in mainline kernel,
> we can see a snapshot here:
> https://github.com/loongson/linux/tree/loongarch-next
>
> Cross-compile tool chain to build kernel:
> https://github.com/loongson/build-tools/releases
>
> Loongson and LoongArch documentations:
> https://github.com/loongson/LoongArch-Documentation
>
> ECR for LoongArch-specific interrupt controllers:
> https://mantis.uefi.org/mantis/view.php?id=2203
> https://mantis.uefi.org/mantis/view.php?id=2313
>
> ACPI changes of LoongArch have been approved in the last year, but the
> new version of ACPI SPEC hasn't been made public yet.
>
> V2: Remove merged patches and update commit messages.
>
> Huacai Chen and Jianmin Lv(2):
>  ACPICA: MADT: Add LoongArch APICs support.
>  ACPICA: Events: Support fixed pcie wake event.

Both patches in this series are mostly ACPICA material which needs to
be submitted to the upstream ACPICA project via
https://github.com/acpica/acpica

It will be pulled by the Linux kernel from there.

>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>  drivers/acpi/acpica/evevent.c  |  17 ++++--
>  drivers/acpi/acpica/hwsleep.c  |  12 ++++
>  drivers/acpi/acpica/utglobal.c |   4 ++
>  drivers/acpi/tables.c          |  10 ++++

This tables.c change can be submitted as a separate patch when the
ACPICA changes get integrated.

>  include/acpi/actbl2.h          | 125 ++++++++++++++++++++++++++++++++++++++++-
>  include/acpi/actypes.h         |   3 +-
>  6 files changed, 163 insertions(+), 8 deletions(-)
> --
> 2.27.0
>
