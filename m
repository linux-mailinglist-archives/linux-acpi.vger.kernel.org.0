Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FAF24DFA0
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Aug 2020 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHUSai (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Aug 2020 14:30:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46102 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgHUSad (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Aug 2020 14:30:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id v6so2292641ota.13
        for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2020 11:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1MxKkpVnvU7d5UWkGrBlz8uQLORh5UJqQAND9p37pU=;
        b=jdXqenQHo0gN4kagYzuWFiwVSqjVYmayLh8uT9Ifiq9pa0IEeAu4Pe2c0PG/eJ5x6Z
         GEgAqqitEphKyyjsYw4nN6KEpa2tZcfNVvSs2iflEXfLrvVVl5pUB+Phk5pBg0XzmopJ
         x5XTuTSNCrIGi5MC7fkWg7UyXf9ScbhLE82Vxx1btfwsA9D2ft8TttArUSLUE9EWJRmF
         tG42ucmyYul5fkrtNbm81pyUg2BaF4JOAVAMJy4gNvyUbKrIqgWUj0SYTzV593wx60u4
         1e6/+h/KU8MEJ5SeDpPh4o+C/5ux64yXnbnJ2PP8nShIr9xWs4DXf5CKKW3fyuQo+Gmi
         Ve0A==
X-Gm-Message-State: AOAM532QbB60icXUCiYQcRHC5iLh/Ow3lcMAa2iYO4enl487GSPQ8aAK
        RCmyPn6daBOqa7dennx3eZN/gbWYG9Mwv6bpj/E=
X-Google-Smtp-Source: ABdhPJyMsaGoi2Sui5e/8V7fSM1j1I/QJXf475TP+CksiyYjMsM5SKWUWZNEk8JREAa+sg9kjBcbpG/MvNWVgvdA1uA=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr2877167otk.262.1598034632409;
 Fri, 21 Aug 2020 11:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200818091353.20097-1-ardb@kernel.org>
In-Reply-To: <20200818091353.20097-1-ardb@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Aug 2020 20:30:21 +0200
Message-ID: <CAJZ5v0i2+9thbzNTzWA2cUCSvm1JQRtV9XB8fGKQk34ybBfYdQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: ioremap: avoid redundant rounding to OS page size
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 18, 2020 at 11:14 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The arm64 implementation of acpi_os_ioremap() was recently updated to
> tighten the checks around which parts of memory are permitted to be
> mapped by ACPI code, which generally only needs access to memory regions
> that are statically described by firmware, and any attempts to access
> memory that is in active use by the OS is generally a bug or a hacking
> attempt. This tightening is based on the EFI memory map, which describes
> all memory in the system.
>
> The AArch64 architecture permits page sizes of 16k and 64k in addition
> to the EFI default, which is 4k, which means that the EFI memory map may
> describe regions that cannot be mapped seamlessly if the OS page size is
> greater than 4k. This is usually not a problem, given that the EFI spec
> does not permit memory regions requiring different memory attributes to
> share a 64k page frame, and so the usual rounding to page size performed
> by ioremap() is sufficient to deal with this. However, this rounding does
> complicate our EFI memory map permission check, due to the loss of
> information that occurs when several small regions share a single 64k
> page frame (where rounding each of them will result in the same 64k
> single page region).
>
> However, due to the fact that the region check occurs *before* the call
> to ioremap() where the necessary rounding is performed, we can deal
> with this issue simply by removing the redundant rounding performed by
> acpi_os_map_iomem(), as it appears to be the only place where the
> arguments to a call to acpi_os_ioremap() are rounded up. So omit the
> rounding in the call, and instead, apply the necessary masking when
> assigning the map->virt member.
>
> Fixes: 1583052d111f ("arm64/acpi: disallow AML memory opregions to access kernel memory")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: return the correct virtual address for hits in the cached mappings array
>
>  drivers/acpi/osl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 6ad8cb05f672..acf6abc693a0 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -350,7 +350,7 @@ void __iomem __ref
>
>         pg_off = round_down(phys, PAGE_SIZE);
>         pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
> -       virt = acpi_map(pg_off, pg_sz);
> +       virt = acpi_map(phys, size);
>         if (!virt) {
>                 mutex_unlock(&acpi_ioremap_lock);
>                 kfree(map);
> @@ -358,7 +358,7 @@ void __iomem __ref
>         }
>
>         INIT_LIST_HEAD(&map->list);
> -       map->virt = virt;
> +       map->virt = (void __iomem __force *)((unsigned long)virt & PAGE_MASK);
>         map->phys = pg_off;
>         map->size = pg_sz;
>         map->track.refcount = 1;
> --

Applied as 5.9-rc material, thanks!
