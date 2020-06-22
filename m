Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575EF204274
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 23:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgFVVJo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 17:09:44 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:33909 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbgFVVJo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jun 2020 17:09:44 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 8f726b0f
        for <linux-acpi@vger.kernel.org>;
        Mon, 22 Jun 2020 20:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=WB+AA0+qznfgGp7h2dMI5DSl7Dw=; b=kuoU3J
        KxH+OfrjrRvGxIek0+fOsv+QSU9gdtszXNibIuukgHE29GJxu87CKEIfXUH/X8R0
        ttUAdr5KtnzScR2wjk/qZH4/R/9JoXRhyhpkLDYJyhen2iv5avmSDMm83iHjXwnZ
        c2bjNIffxtz4gYEiz/D/ejJtmBIK9fKSfxf7DVUq234GVifw3b5+Eg2u4qGh/zzk
        kKIXm3pO0W29rTp1dVVSqhTslEmGl+obUFu2etP22bvrcfMXMw2q+ZaRVzyISZhP
        mLD6VVWZ4MmIp6dRtk8irlS78hI/KPJqLrpJ0+7nbJRVDMNMcW/EQHDRDWVPbkGK
        CDRJNWmGs8YeFpSw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5f4713bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-acpi@vger.kernel.org>;
        Mon, 22 Jun 2020 20:50:52 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id c16so6080235ioi.9
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2020 14:09:39 -0700 (PDT)
X-Gm-Message-State: AOAM531FQt1wsqnYr0RCGQltNPz7gSGN/xAdqOQYs3e8phr1mrRqutEW
        raDnK9yupKuiAt9LWgocIpMxglium/T0qYM09iI=
X-Google-Smtp-Source: ABdhPJzWnao8S3eeG+rKEh98PlH/ZTKC81HRz2YXJrgE8GehXe0vIj6M/DRWvrlBlF61wQNWmKcKGm2gFEfOGwZYGJY=
X-Received: by 2002:a05:6638:1405:: with SMTP id k5mr19410981jad.108.1592860178846;
 Mon, 22 Jun 2020 14:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200622092719.1380968-1-ardb@kernel.org>
In-Reply-To: <20200622092719.1380968-1-ardb@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 22 Jun 2020 15:09:28 -0600
X-Gmail-Original-Message-ID: <CAHmME9oNwDra2Vi+jsy4YZ81HVygyyRXTJeni58CaJqOmfmepA@mail.gmail.com>
Message-ID: <CAHmME9oNwDra2Vi+jsy4YZ81HVygyyRXTJeni58CaJqOmfmepA@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64/acpi: disallow AML memory opregions to access
 kernel memory
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 22, 2020 at 3:27 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> ACPI provides support for SystemMemory opregions, to allow AML methods
> to access MMIO registers of, e.g., GPIO controllers, or access reserved
> regions of memory that are owned by the firmware.
>
> Currently, we also permit AML methods to access memory that is owned by
> the kernel and mapped via the linear region, which does not seem to be
> supported by a valid use case, and exposes the kernel's internal state
> to AML methods that may be buggy and exploitable.
>
> So close the door on this, and simply reject AML remapping requests for
> any memory that has a valid mapping in the linear region.
>
> Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/acpi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index a45366c3909b..18dcef4e6764 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -50,9 +50,9 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>                                             acpi_size size)
>  {
> -       /* For normal memory we already have a cacheable mapping. */
> +       /* Don't allow access to kernel memory from AML code */
>         if (memblock_is_map_memory(phys))
> -               return (void __iomem *)__phys_to_virt(phys);
> +               return NULL;

I'm happy to see that implementation-wise it's so easy. Take my
Acked-by, but I'd really prefer somebody with some ACPI experience and
has looked at tons of DSDTs over the years to say whether or not this
will break hardware.

[As an aside, the current implementation is actually "wrong", since
that will trap when an ASL tries to write to regions mapped as
read-only, which shouldn't happen when selecting physical addresses. I
learned this the ~hard way when writing those exploits last week. :-P]
