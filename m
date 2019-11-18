Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 759E71000E9
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 10:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfKRJDj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 04:03:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43647 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfKRJDj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2019 04:03:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so14591700oie.10;
        Mon, 18 Nov 2019 01:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRVAj0cF1NIKTcp+3jim6uMgDs77PK8ocSRvRnJzR94=;
        b=AwO96G7XUA4VfSbV1oC2/a3Q/tKaQVWb9UWV4Iiw3wKK+A5adzSGD6rbXZe0ATVLpt
         BreQ077xtWOs3U7nfKdderH46R+594p+8CYdQXBMHlFQddGXAI5rm39JZPS7KqMTvnBu
         X5t4P3O7TEPW925vm+6Z0B9Uc2bs0+2mzP9wEMxR5ZSZT/+rcIrArz/777KXU04MbEIX
         kGIDy5uvH+Tjg4avXv82Ag42hcIBWdE0MpT4wdEvIxfOUQSThQyX10tNmmbJALX5vfGw
         y1KrttjjZhFHLtBQiIj4qOaQuYszutVU5fIOyqZQ7Z4qNv+mz90ewZxvGGmIRwOt0joW
         HxjQ==
X-Gm-Message-State: APjAAAWfMsbjQBVpYe0fGXZYrA2EXHC7yN78bZItTUpJtBf3DKhhyk91
        /9BlQjSnyAknfkaRlRki/la0/WAN6CbzX6q1j5c=
X-Google-Smtp-Source: APXvYqyBDTzWxnZlIn+OcEtjaknZIU05ZVRZB/B4xtaRjHOpaHd+6Vld9DL+9/LerspgASk0JbvmGCBQUNVTX+avAag=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr18741190oig.68.1574067818299;
 Mon, 18 Nov 2019 01:03:38 -0800 (PST)
MIME-Version: 1.0
References: <cc03ba18-4949-9244-639c-94f461f03361@huawei.com> <CAA9_cmc7BuWkBHadHRAxfch43KWovb6rSr2AR9y3bVue0M9EhQ@mail.gmail.com>
In-Reply-To: <CAA9_cmc7BuWkBHadHRAxfch43KWovb6rSr2AR9y3bVue0M9EhQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Nov 2019 10:03:27 +0100
Message-ID: <CAJZ5v0g35zvSB88d7qK8n1uRGCuO5VNK11jHVQRNKwyQW4vZSQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 16, 2019 at 9:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Nov 13, 2019 at 11:17 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> >
> > The commit 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel
> > parameter cover all GPEs") says:
> >   "Use a bitmap of size 0xFF instead of a u64 for the GPE mask so 256
> >    GPEs can be masked"
> >
> > But the masking of GPE 0xFF it not supported and the check condition
> > "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of gpe is
> > u8.
> >
> > So modify the macro ACPI_MASKABLE_GPE_MAX to 0x100, and drop the "gpe >
> > ACPI_MASKABLE_GPE_MAX" check. In addition, update the docs "Format" for
> > acpi_mask_gpe parameter.
> >
> > Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
> > Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> > ---
> > v1 -> v2:
> >  - drop the "gpe > ACPI_MASKABLE_GPE_MAX" check
> >  - update the docs "Format" from <int> to <byte> for acpi_mask_gpe parameter
> >  - update the commit comment
> >
> >  Documentation/admin-guide/kernel-parameters.txt | 2 +-
> >  drivers/acpi/sysfs.c                            | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Bisect flags commit eb09878e1301 "ACPI: sysfs: Change
> ACPI_MASKABLE_GPE_MAX to 0x100" in -next as the reason for a boot
> regression in my qemu-kvm test environment. It spews:
>
> [    1.456728] ACPI: Masking GPE 0x0.
> ...
> [  161.721420] ACPI: Masking GPE 0x0.
>
> ...and then hangs.
>
> A straight revert gets the configuration back on its feet.
>
> qemu-system-x86_64 --version
> QEMU emulator version 4.0.50 (v4.0.0-928-g49c6c6ac0cd8)

OK, I'll drop it then, thanks!
