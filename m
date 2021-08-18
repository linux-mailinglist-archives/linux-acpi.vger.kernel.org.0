Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5367B3EF6BE
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Aug 2021 02:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhHRANp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Aug 2021 20:13:45 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35835 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbhHRANo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Aug 2021 20:13:44 -0400
Received: by mail-oi1-f170.google.com with SMTP id r26so1923905oij.2;
        Tue, 17 Aug 2021 17:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=++h8bUGhJWF7B6yyYyoh0nKkVdcF8eCL74y7f9GeZ4Y=;
        b=Esyhn++GGRyGardw9fIXTWifL8fvOZt6fykSP9iSa0raEb9BbTcKdmv5NsNQI0lPns
         Xv9Y8RWR01erZS5dHw2MV+fJAfgyK91xNoZ7z9icBh+9bwO24I0gw3e2i7oWbKmPh3Ex
         OveBjXnLV8ori/ReyC2YhPw9wGycyenqXmmbt+hGPnqc4w5jghaNQKtJP47LXDE5uGvm
         pay1S1s07OJXsTvbhoO6mlvRzI9mPj7bEhjDWN+FLx60W9j9zJXYQ+P+tJdR2vRYkZq0
         o5UMMROtPLkIYLdGGPSCugb8eF8hSQedA2312ZBByNie0RJODz9mo6YrlbDcMhrf+Vq5
         sYEA==
X-Gm-Message-State: AOAM533xuwd9jKOgJeP+qPl5jqhGHTHyjyDQPofJQLij14BtWkWXK3KO
        VmZLCfCo6IJy2cmt7TYO3g==
X-Google-Smtp-Source: ABdhPJyJOifM/j6dYvgpX8URevK/gXq/UxE91n+1ytfa41bf6TcZ7UPHLnQ6y0p94fi4QGOLVqhW9w==
X-Received: by 2002:aca:b984:: with SMTP id j126mr4666629oif.32.1629245590250;
        Tue, 17 Aug 2021 17:13:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k16sm738270oor.16.2021.08.17.17.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 17:13:09 -0700 (PDT)
Received: (nullmailer pid 1094241 invoked by uid 1000);
        Wed, 18 Aug 2021 00:13:07 -0000
Date:   Tue, 17 Aug 2021 19:13:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shtuemov@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5] memblock: make memblock_find_in_range method private
Message-ID: <YRxQk0Cjj5yzmvBA@robh.at.kernel.org>
References: <20210816122622.30279-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816122622.30279-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 16 Aug 2021 15:26:22 +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are a lot of uses of memblock_find_in_range() along with
> memblock_reserve() from the times memblock allocation APIs did not exist.
> 
> memblock_find_in_range() is the very core of memblock allocations, so any
> future changes to its internal behaviour would mandate updates of all the
> users outside memblock.
> 
> Replace the calls to memblock_find_in_range() with an equivalent calls to
> memblock_phys_alloc() and memblock_phys_alloc_range() and make
> memblock_find_in_range() private method of memblock.
> 
> This simplifies the callers, ensures that (unlikely) errors in
> memblock_reserve() are handled and improves maintainability of
> memblock_find_in_range().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Kirill A. Shutemov <kirill.shtuemov@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>	# ACPI
> Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Acked-by: Nick Kossifidis <mick@ics.forth.gr>			# riscv
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>		# arm64
> ---
> v5:
> * restore the original behaviour on x86 with addition of more elaborate
>   comment; I will address the issue in memory_map_top_down() in a separate
>   series.
> 
> v4: https://lore.kernel.org/lkml/20210812065907.20046-1-rppt@kernel.org
> * Add patch that prevents the crashes reported by Guenter Roeck on x86/i386
>   on QEMU with 256M or 512M of memory and EFI boot enabled.
> * Add Acked-by and Reviewed-by, thanks everybidy!
> 
> v3: https://lore.kernel.org/lkml/20210803064218.6611-1-rppt@kernel.org
> * simplify check for exact crash kerenl allocation on arm, per Rob
> * make crash_max unsigned long long on arm64, per Rob
> 
> v2: https://lore.kernel.org/lkml/20210802063737.22733-1-rppt@kernel.org
> * don't change error message in arm::reserve_crashkernel(), per Russell
> 
> v1: https://lore.kernel.org/lkml/20210730104039.7047-1-rppt@kernel.org
> 
> 
>  arch/arm/kernel/setup.c           | 20 +++++---------
>  arch/arm64/kvm/hyp/reserved_mem.c |  9 +++----
>  arch/arm64/mm/init.c              | 36 ++++++++-----------------
>  arch/mips/kernel/setup.c          | 14 +++++-----
>  arch/riscv/mm/init.c              | 44 ++++++++++---------------------
>  arch/s390/kernel/setup.c          | 10 ++++---
>  arch/x86/kernel/aperture_64.c     |  5 ++--
>  arch/x86/mm/init.c                | 23 ++++++++++------
>  arch/x86/mm/numa.c                |  5 ++--
>  arch/x86/mm/numa_emulation.c      |  5 ++--
>  arch/x86/realmode/init.c          |  2 +-
>  drivers/acpi/tables.c             |  5 ++--
>  drivers/base/arch_numa.c          |  5 +---
>  drivers/of/of_reserved_mem.c      | 12 ++++++---
>  include/linux/memblock.h          |  2 --
>  mm/memblock.c                     |  2 +-
>  16 files changed, 81 insertions(+), 118 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
