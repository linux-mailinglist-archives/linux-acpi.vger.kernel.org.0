Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B8100D7C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 22:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKRVQA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 16:16:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42231 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfKRVQA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2019 16:16:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id o12so6612294oic.9;
        Mon, 18 Nov 2019 13:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGmcPUR8/fSmoKZT8wNG542Hx4EddFL0Aj04F8QGfeY=;
        b=ThXvTYCc91LVt5IxL/YqWcKw7vlFNAQzx/sSiAgA0RyYzwDMU0Vs1X2c5KhzkJoWOf
         CxN6Ys5n9WaFf7SbhUYCupaiIyPQSZl5LXmyUz3Gua6NSOx+XsRrcvEbunGr6P56Xub5
         WXQSvcc1koJoDCPlPUmrBEvtQghvPwACN+XUZK4ByzTPGZcMc2JH46gV97sh/qa4RhLh
         8/V2aX2jQbeEl2VW36B9XbSGIqaDrjceEi6FsnucAaPCWXgaK14vU3FEUQnfFfH3dvYv
         9XnYJZ2Mt0wy0L2hc1wbvbE21PGdwCUh4mM8tm5lp+8cKGiwo7Tjf6u7QxlfSHuvoMwr
         9Vvw==
X-Gm-Message-State: APjAAAVDNCtNQdk6qLsmGPcNWRljODVJw4VmPjkhlCn5LG3MLi8FDtKx
        OBQLqyK/xz/57kY3KbmPkBcZ25WdkDfSbfTeW2c=
X-Google-Smtp-Source: APXvYqxKvx5v2bCoNyNp2j7oV6Nv/3O62/Y0L4stjW1SPiCGZ4joqQakDM+BdHFoJFd/VP2iZTuRGld/2iYKJrPlnDw=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr903647oig.68.1574111759293;
 Mon, 18 Nov 2019 13:15:59 -0800 (PST)
MIME-Version: 1.0
References: <cc03ba18-4949-9244-639c-94f461f03361@huawei.com>
 <CAA9_cmc7BuWkBHadHRAxfch43KWovb6rSr2AR9y3bVue0M9EhQ@mail.gmail.com>
 <CAJZ5v0g35zvSB88d7qK8n1uRGCuO5VNK11jHVQRNKwyQW4vZSQ@mail.gmail.com> <CAA42JLYCod=mymBiDDXxQ1sts7e-Ot_q9SKdJxjSkcsZRVGDTQ@mail.gmail.com>
In-Reply-To: <CAA42JLYCod=mymBiDDXxQ1sts7e-Ot_q9SKdJxjSkcsZRVGDTQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Nov 2019 22:15:48 +0100
Message-ID: <CAJZ5v0iAbf7qQeyeR6CVYTX8v=OpEcbFksTHgQ0LAZk-QKqHpQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
To:     Dexuan-Linux Cui <dexuan.linux@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
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

On Mon, Nov 18, 2019 at 8:44 PM Dexuan-Linux Cui <dexuan.linux@gmail.com> wrote:
>
> On Mon, Nov 18, 2019 at 1:04 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Sat, Nov 16, 2019 at 9:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Wed, Nov 13, 2019 at 11:17 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> > > >
> > > > The commit 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel
> > > > parameter cover all GPEs") says:
> > > >   "Use a bitmap of size 0xFF instead of a u64 for the GPE mask so 256
> > > >    GPEs can be masked"
> > > >
> > > > But the masking of GPE 0xFF it not supported and the check condition
> > > > "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of gpe is
> > > > u8.
> > > >
> > > > So modify the macro ACPI_MASKABLE_GPE_MAX to 0x100, and drop the "gpe >
> > > > ACPI_MASKABLE_GPE_MAX" check. In addition, update the docs "Format" for
> > > > acpi_mask_gpe parameter.
> > > >
> > > > Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
> > > > Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> > > > ---
> > > > v1 -> v2:
> > > >  - drop the "gpe > ACPI_MASKABLE_GPE_MAX" check
> > > >  - update the docs "Format" from <int> to <byte> for acpi_mask_gpe parameter
> > > >  - update the commit comment
> > > >
> > > >  Documentation/admin-guide/kernel-parameters.txt | 2 +-
> > > >  drivers/acpi/sysfs.c                            | 4 ++--
> > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > Bisect flags commit eb09878e1301 "ACPI: sysfs: Change
> > > ACPI_MASKABLE_GPE_MAX to 0x100" in -next as the reason for a boot
> > > regression in my qemu-kvm test environment. It spews:
> > >
> > > [    1.456728] ACPI: Masking GPE 0x0.
> > > ...
> > > [  161.721420] ACPI: Masking GPE 0x0.
> > >
> > > ...and then hangs.
> > >
> > > A straight revert gets the configuration back on its feet.
> > >
> > > qemu-system-x86_64 --version
> > > QEMU emulator version 4.0.50 (v4.0.0-928-g49c6c6ac0cd8)
> >
> > OK, I'll drop it then, thanks!
>
> We're seeing the same issue wtih 5.4.0-rc7-next-20191118 on a Linux VM
> running on Hyper-V :
>
> [    0.133029] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    0.144023] ACPI: Interpreter enabled
> [    0.145023] ACPI: (supports S0 S5)
> [    0.146023] ACPI: Using IOAPIC for interrupt routing
> [    0.147024] PCI: Using host bridge windows from ACPI; if necessary,
> use "pci=nocrs" and report a bug
> [    0.148031] ACPI: Masking GPE 0x0.
> ...
> [  774.839023] ACPI: Masking GPE 0x0.
> [  774.840023] ACPI: Masking GPE 0x0.
>
> I guess the patch is only tested on a physical machine and not on a VM...

It looks like the patch hasn't been tested at all.

Please try to change the data type of gpe in
acpi_gpe_apply_masked_gpes() to u16 and see if that helps.
