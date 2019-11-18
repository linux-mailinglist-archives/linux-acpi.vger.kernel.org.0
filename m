Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B1100C5A
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 20:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfKRTod (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 14:44:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36854 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfKRTod (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2019 14:44:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id d7so10356190pls.3;
        Mon, 18 Nov 2019 11:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TC5IKXkEeLvUIaKix78ztNNc8pykt/x5bB2H11fvT/g=;
        b=VTpZ6pSli/VDtzsKnZzYR/zf6tW/PLbkRZ9njXbP6NAzL/LV0QjNlb1CWoA66IbQ6T
         Wlz88NkWn8/vyfhmIlkE/ogrUYLZSqVZjwlxHXsftWSCeFDRL6lL3GQZM9uTZ0WxQ0A8
         c1oLE6NKGj8WEIHCHYYUVS2sfDo6n2+oLQDM35zaGfpzPOIcmy2lvLq4adnexszJT8HA
         BlIGnGMxRyitb/dPEF1OgC0Rogv7HIeqpE5kY+jmDh4m5zks9K2fAD1P/UDnY3VNVd7O
         f94lFwqpRYaB0vaIys2FqGO3We8Y6RpW+BNk9YZAOjpDbZuHso11aaarOntsmQ+O4wIK
         nCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TC5IKXkEeLvUIaKix78ztNNc8pykt/x5bB2H11fvT/g=;
        b=q9wPYIX2t2HGmBPLCQw+aF5dLMbTdYwNdkJAitHCK7F6irvKQ37ua6fwXwmVdv6g+W
         4fj/QNvVLozporYLuZZABxWE+HzL7PqW6M3/7uUnfWF9Lr8D8YbNgUDm2bMMxyTawSTq
         MbTUXSdgPw73fU3DfiKUENdn9eFSjBAEy30zo58PN9maH7rnuhuj84MB/VrWyUT17odn
         3Zg67O48R5tUXtevkIn7mNv0iIF98z5UCDjLAtxgUsUj+5MKYoVovAwcHk+bz5w5rnkx
         miojwrRyY/e2X0KTHDr4BedGa1ZJPl8j6rMC+3zhYGwiTqiYViX87MwqLSJlJCjQ613X
         HA4g==
X-Gm-Message-State: APjAAAWIids6xsKXfmdDyEm9q3hvDc5ftrzWhcNoQFgcEuo4AS7OBVAx
        GXaXvWocVa2790CYt9jK5aNX02wJ9nF3Qicy3+Y=
X-Google-Smtp-Source: APXvYqzs5xYyJ8AQV6D1X6BIce0Bke3mK70h6gr2XlSDndWOLPYFvxNLcYKnFnJ0zr4FjyUHs11TJjkfoio672E/stE=
X-Received: by 2002:a17:90a:bb82:: with SMTP id v2mr888586pjr.90.1574106272898;
 Mon, 18 Nov 2019 11:44:32 -0800 (PST)
MIME-Version: 1.0
References: <cc03ba18-4949-9244-639c-94f461f03361@huawei.com>
 <CAA9_cmc7BuWkBHadHRAxfch43KWovb6rSr2AR9y3bVue0M9EhQ@mail.gmail.com> <CAJZ5v0g35zvSB88d7qK8n1uRGCuO5VNK11jHVQRNKwyQW4vZSQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g35zvSB88d7qK8n1uRGCuO5VNK11jHVQRNKwyQW4vZSQ@mail.gmail.com>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Mon, 18 Nov 2019 11:44:22 -0800
Message-ID: <CAA42JLYCod=mymBiDDXxQ1sts7e-Ot_q9SKdJxjSkcsZRVGDTQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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

On Mon, Nov 18, 2019 at 1:04 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Nov 16, 2019 at 9:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Wed, Nov 13, 2019 at 11:17 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> > >
> > > The commit 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel
> > > parameter cover all GPEs") says:
> > >   "Use a bitmap of size 0xFF instead of a u64 for the GPE mask so 256
> > >    GPEs can be masked"
> > >
> > > But the masking of GPE 0xFF it not supported and the check condition
> > > "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of gpe is
> > > u8.
> > >
> > > So modify the macro ACPI_MASKABLE_GPE_MAX to 0x100, and drop the "gpe >
> > > ACPI_MASKABLE_GPE_MAX" check. In addition, update the docs "Format" for
> > > acpi_mask_gpe parameter.
> > >
> > > Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
> > > Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> > > ---
> > > v1 -> v2:
> > >  - drop the "gpe > ACPI_MASKABLE_GPE_MAX" check
> > >  - update the docs "Format" from <int> to <byte> for acpi_mask_gpe parameter
> > >  - update the commit comment
> > >
> > >  Documentation/admin-guide/kernel-parameters.txt | 2 +-
> > >  drivers/acpi/sysfs.c                            | 4 ++--
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > Bisect flags commit eb09878e1301 "ACPI: sysfs: Change
> > ACPI_MASKABLE_GPE_MAX to 0x100" in -next as the reason for a boot
> > regression in my qemu-kvm test environment. It spews:
> >
> > [    1.456728] ACPI: Masking GPE 0x0.
> > ...
> > [  161.721420] ACPI: Masking GPE 0x0.
> >
> > ...and then hangs.
> >
> > A straight revert gets the configuration back on its feet.
> >
> > qemu-system-x86_64 --version
> > QEMU emulator version 4.0.50 (v4.0.0-928-g49c6c6ac0cd8)
>
> OK, I'll drop it then, thanks!

We're seeing the same issue wtih 5.4.0-rc7-next-20191118 on a Linux VM
running on Hyper-V :

[    0.133029] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.144023] ACPI: Interpreter enabled
[    0.145023] ACPI: (supports S0 S5)
[    0.146023] ACPI: Using IOAPIC for interrupt routing
[    0.147024] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.148031] ACPI: Masking GPE 0x0.
...
[  774.839023] ACPI: Masking GPE 0x0.
[  774.840023] ACPI: Masking GPE 0x0.

I guess the patch is only tested on a physical machine and not on a VM...

Thanks,
Dexuan
