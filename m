Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69BED101E2B
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 09:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKSInS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 03:43:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41912 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSInR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2019 03:43:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id 94so17145423oty.8;
        Tue, 19 Nov 2019 00:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLWDK5bcLE7hl1oQBmKL/QSkLfiCovIMYar92vueUXk=;
        b=i36lthW+vDi3Fq4WkIZJyygob9g5mM9LxWvf3G/QvFsfe89NJVnlRNhCpVTMd+SPG7
         yQ6MA311OVqaG8fFem6gHf4hdkDOrKgiPflzPAQE9/T3ZGe1ZZS6bXHpjUMdBcOoKBAM
         wxI9+6A6vKRzCeuXq/GjJ9MNhXzQEUcP9gFM/yQNYOtfxX90dabNgG4vrqdcaMwQF8dR
         LUvGEdWEdNj6ON73pv5gcErm3STnzacppfk7tip4/KyYjQ/TUVQIEp6EyINNFG3vXjr3
         sAm83uN7KuD8kaREZ07Xrx/BrTAoRsmZZfSAv8PdnJG67hHYX8wYdub90/wlyrbJQ43B
         qY3w==
X-Gm-Message-State: APjAAAXvtKATPuU8nmXKY3T251m9DDZqayq1qqThbCU/MUj7QSU1KFDp
        BDxv2SkFyWGCceAnOQAcDU1XXYCrzqIThIDZFoILvssO
X-Google-Smtp-Source: APXvYqyi3eCXBMMch5CtVbQEo2KQ1dQxzAcuZxmaAX4zIZ97CAY0YQWL30MNgoAvRbeC/ixOij26w94cyE9/Tx6JGzk=
X-Received: by 2002:a9d:4c85:: with SMTP id m5mr2748250otf.118.1574152996610;
 Tue, 19 Nov 2019 00:43:16 -0800 (PST)
MIME-Version: 1.0
References: <cc03ba18-4949-9244-639c-94f461f03361@huawei.com>
 <CAA9_cmc7BuWkBHadHRAxfch43KWovb6rSr2AR9y3bVue0M9EhQ@mail.gmail.com>
 <CAJZ5v0g35zvSB88d7qK8n1uRGCuO5VNK11jHVQRNKwyQW4vZSQ@mail.gmail.com>
 <CAA42JLYCod=mymBiDDXxQ1sts7e-Ot_q9SKdJxjSkcsZRVGDTQ@mail.gmail.com>
 <CAJZ5v0iAbf7qQeyeR6CVYTX8v=OpEcbFksTHgQ0LAZk-QKqHpQ@mail.gmail.com> <9eff3584-a25b-ca47-d38f-ce83862baa18@huawei.com>
In-Reply-To: <9eff3584-a25b-ca47-d38f-ce83862baa18@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Nov 2019 09:43:04 +0100
Message-ID: <CAJZ5v0h9xQeebYst8mg6YOzSXoY=JDg0F8wDXw1QPEatiC-=UA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>,
        Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 3:22 AM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>
>
>
> On 2019/11/19 5:15, Rafael J. Wysocki wrote:
> > On Mon, Nov 18, 2019 at 8:44 PM Dexuan-Linux Cui <dexuan.linux@gmail.com> wrote:
> >>
> >> On Mon, Nov 18, 2019 at 1:04 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>
> >>> On Sat, Nov 16, 2019 at 9:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >>>>
> >>>> On Wed, Nov 13, 2019 at 11:17 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> >>>>>
> >>>>> The commit 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel
> >>>>> parameter cover all GPEs") says:
> >>>>>   "Use a bitmap of size 0xFF instead of a u64 for the GPE mask so 256
> >>>>>    GPEs can be masked"
> >>>>>
> >>>>> But the masking of GPE 0xFF it not supported and the check condition
> >>>>> "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of gpe is
> >>>>> u8.
> >>>>>
> >>>>> So modify the macro ACPI_MASKABLE_GPE_MAX to 0x100, and drop the "gpe >
> >>>>> ACPI_MASKABLE_GPE_MAX" check. In addition, update the docs "Format" for
> >>>>> acpi_mask_gpe parameter.
> >>>>>
> >>>>> Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
> >>>>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> >>>>> ---
> >>>>> v1 -> v2:
> >>>>>  - drop the "gpe > ACPI_MASKABLE_GPE_MAX" check
> >>>>>  - update the docs "Format" from <int> to <byte> for acpi_mask_gpe parameter
> >>>>>  - update the commit comment
> >>>>>
> >>>>>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
> >>>>>  drivers/acpi/sysfs.c                            | 4 ++--
> >>>>>  2 files changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> Bisect flags commit eb09878e1301 "ACPI: sysfs: Change
> >>>> ACPI_MASKABLE_GPE_MAX to 0x100" in -next as the reason for a boot
> >>>> regression in my qemu-kvm test environment. It spews:
> >>>>
> >>>> [    1.456728] ACPI: Masking GPE 0x0.
> >>>> ...
> >>>> [  161.721420] ACPI: Masking GPE 0x0.
> >>>>
> >>>> ...and then hangs.
> >>>>
> >>>> A straight revert gets the configuration back on its feet.
> >>>>
> >>>> qemu-system-x86_64 --version
> >>>> QEMU emulator version 4.0.50 (v4.0.0-928-g49c6c6ac0cd8)
> >>>
> >>> OK, I'll drop it then, thanks!
> >>
> >> We're seeing the same issue wtih 5.4.0-rc7-next-20191118 on a Linux VM
> >> running on Hyper-V :
> >>
> >> [    0.133029] ACPI: 1 ACPI AML tables successfully acquired and loaded
> >> [    0.144023] ACPI: Interpreter enabled
> >> [    0.145023] ACPI: (supports S0 S5)
> >> [    0.146023] ACPI: Using IOAPIC for interrupt routing
> >> [    0.147024] PCI: Using host bridge windows from ACPI; if necessary,
> >> use "pci=nocrs" and report a bug
> >> [    0.148031] ACPI: Masking GPE 0x0.
> >> ...
> >> [  774.839023] ACPI: Masking GPE 0x0.
> >> [  774.840023] ACPI: Masking GPE 0x0.
> >>
> >> I guess the patch is only tested on a physical machine and not on a VM...
> >
> > It looks like the patch hasn't been tested at all.
> >
> > Please try to change the data type of gpe in
> > acpi_gpe_apply_masked_gpes() to u16 and see if that helps.
> >
> Sorry for this problem, I have no good test after modification according to
> inspection opinions.

I see.

Well, reviewers make mistakes too ...

> The first version patch is ok, the type of gpe is changed to u32. and I have
> test it before.

OK

So I have added the u8 -> u16 change for gpe in
acpi_gpe_apply_masked_gpes() and applied it again, as that should work
AFAICS.
