Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA5417709E
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2020 09:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgCCIBX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Mar 2020 03:01:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54833 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgCCIBX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Mar 2020 03:01:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id i9so530575wml.4
        for <linux-acpi@vger.kernel.org>; Tue, 03 Mar 2020 00:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KFVCRDxDtzub9zZu4H3xTogihEXNQAo7KqjGf/X5ds=;
        b=EIYNgH7ltAnh/xuunt1NPohmKiypqOkqB+g7AB19td4meB3xEI9LzjrtpsSEUoFA5m
         k93KAhkLIKXtXdu7WekEm5Ofn7EhY8huVn18GNJ8633kgdpWpBuy6oHiZ1K+n5AqYgQR
         r7BvnXMo2/BIDIYw95KSNU/+OQ60UQ5SnAwOZjrN0WTKL/2dE1yBSMn/wJTVX4Uk9wcx
         dxXcZtrLUfz1BbCJLrvANf3UVMyKyjWC7UMrixWttACi937C0WGvGAFkZ1tZ/vTI8IeT
         XULbHPuvRIn69wpxyQ/CKRMwi4sR1bIN8ikjjR57ijE3aQMmVAlYzj8Sf7nJk7v+ZNXA
         grqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KFVCRDxDtzub9zZu4H3xTogihEXNQAo7KqjGf/X5ds=;
        b=acYL7spla1c5SQDo4ds9uczoA39qfF2Qo2T+HdiDidrqGgyWNmeW387BTZuwtkYZAw
         j5gulJxcpddwDLlrcLrTv8MrjxEpaE6kUdGKuce0iok6Mer57BZfnNuQ4kTciSkFKC1J
         f+hJl4h/WwnFziAWaiM6P3hhXWo/Hxj8iduoGv0RrFYNP8kwscpIQI68a1r+n8ICb53x
         okn5AW5v2d0jvx2EYxoURjHNEHMTBTqs7x2v7XI5IgfEnxfK+mEXxGCeW98pjxxoBUNW
         vSJMDHvs6h/XNEs7JmpANfsTAbMRC9V9zqKWp4dmWTJOXj35VU22vpd6J3DC7dkEUYAn
         7aUA==
X-Gm-Message-State: ANhLgQ35JaaSMETXxLxBQS0jYSSrw75fyv+uu3phqGi/+dq2HJ2iJ330
        rupHQYs0HV9Lfjy3MXyqw6/LVKBTmaQtWNzGap68QA==
X-Google-Smtp-Source: ADFU+vtMD9Hn+PWCo8WlKQENvA+VrRYcQgo1HZGruvYLZljw/sATAP3ygGaVLtX5UMG/zzD28ojIn4NQgBpDcfFk/dI=
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr2902120wmj.1.1583222480788;
 Tue, 03 Mar 2020 00:01:20 -0800 (PST)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318760967.2216124.7838939599184768260.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158318760967.2216124.7838939599184768260.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 3 Mar 2020 09:01:09 +0100
Message-ID: <CAKv+Gu_Erea9q4Ay2wmq70EQ8844baBtvVQsv0T1DM8U8eHY6Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] efi/fake_mem: Arrange for a resource entry per
 efi_fake_mem instance
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2 Mar 2020 at 23:36, Dan Williams <dan.j.williams@intel.com> wrote:
>
> In preparation for attaching a platform device per iomem resource teach
> the efi_fake_mem code to create an e820 entry per instance. Similar to
> E820_TYPE_PRAM, bypass merging resource when the e820 map is sanitized.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/kernel/e820.c              |   16 +++++++++++++++-
>  drivers/firmware/efi/x86_fake_mem.c |   12 +++++++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c5399e80c59c..96babb3a6629 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -305,6 +305,20 @@ static int __init cpcompare(const void *a, const void *b)
>         return (ap->addr != ap->entry->addr) - (bp->addr != bp->entry->addr);
>  }
>
> +static bool e820_nomerge(enum e820_type type)
> +{
> +       /*
> +        * These types may indicate distinct platform ranges aligned to
> +        * numa node, protection domain, performance domain, or other
> +        * boundaries. Do not merge them.
> +        */
> +       if (type == E820_TYPE_PRAM)
> +               return true;
> +       if (type == E820_TYPE_SOFT_RESERVED)
> +               return true;
> +       return false;
> +}
> +
>  int __init e820__update_table(struct e820_table *table)
>  {
>         struct e820_entry *entries = table->entries;
> @@ -380,7 +394,7 @@ int __init e820__update_table(struct e820_table *table)
>                 }
>
>                 /* Continue building up new map based on this information: */
> -               if (current_type != last_type || current_type == E820_TYPE_PRAM) {
> +               if (current_type != last_type || e820_nomerge(current_type)) {
>                         if (last_type != 0)      {
>                                 new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
>                                 /* Move forward only if the new size was non-zero: */
> diff --git a/drivers/firmware/efi/x86_fake_mem.c b/drivers/firmware/efi/x86_fake_mem.c
> index e5d6d5a1b240..0bafcc1bb0f6 100644
> --- a/drivers/firmware/efi/x86_fake_mem.c
> +++ b/drivers/firmware/efi/x86_fake_mem.c
> @@ -38,7 +38,7 @@ void __init efi_fake_memmap_early(void)
>                 m_start = mem->range.start;
>                 m_end = mem->range.end;
>                 for_each_efi_memory_desc(md) {
> -                       u64 start, end;
> +                       u64 start, end, size;
>
>                         if (md->type != EFI_CONVENTIONAL_MEMORY)
>                                 continue;
> @@ -58,11 +58,17 @@ void __init efi_fake_memmap_early(void)
>                          */
>                         start = max(start, m_start);
>                         end = min(end, m_end);
> +                       size = end - start + 1;
>
>                         if (end <= start)
>                                 continue;
> -                       e820__range_update(start, end - start + 1, E820_TYPE_RAM,
> -                                       E820_TYPE_SOFT_RESERVED);
> +
> +                       /*
> +                        * Ensure each efi_fake_mem instance results in
> +                        * a unique e820 resource
> +                        */
> +                       e820__range_remove(start, size, E820_TYPE_RAM, 1);
> +                       e820__range_add(start, size, E820_TYPE_SOFT_RESERVED);
>                         e820__update_table(e820_table);
>                 }
>         }
>
