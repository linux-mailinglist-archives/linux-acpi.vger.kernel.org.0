Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6793C9271
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 22:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhGNUum (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhGNUul (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 16:50:41 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB707C06175F;
        Wed, 14 Jul 2021 13:47:49 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e2so2935945ilu.5;
        Wed, 14 Jul 2021 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvhFUaJpsKWtTEeD2+NVxurp5yWKuTzZW3b3jtSmo5Y=;
        b=UUnwQaua/H8rwEJ46wBGu21VE3YZ4bJWf1X9TiXDo9vh0gjpsjTI69qTz8pUIOeQmZ
         87sYgU7NQ2/IywPIyzuJgPagS9NB5ilUObP1yaPA/AaIMC2BENX2XW8OmvNHcjIZzcqQ
         lCJKYYFk7pgPjzvPFxoMU8RBALA3Hs5cTmm/buog1pLIyQXWBKa5ks+NtYkm7Xs9p1/4
         9bfr6Tuk3tiShJOZYSkFcJbqC1a6xfK4TJacBP5OeWgIBt7iJpXiEuB2Btyl4Pu/1mqs
         QL/3W25VvEP2vW3CnG/H9MMRVuhf6MAjCdkOTJ68fiKoyj5Vp4y4pfExBy7Ej62pduDV
         nCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvhFUaJpsKWtTEeD2+NVxurp5yWKuTzZW3b3jtSmo5Y=;
        b=UovxUEIqcNVlFrKSnN2F6eUcHEyYlrcCQj0LEifdTr7udouVGuppmOOq5F3lE1qmeF
         IGDAudpEo4LaGQCvNsxuXQJfejo13W4Cvoa8qw1mNVO0CNxZNoJLjrsCUsk5jouzl0sZ
         vIl5DvrYG6pF9s8/ap+V67kYD45bkA9onRKZc5Yo9HZQ1V2xXA7/8+SSwLPUeooIwWCr
         VUNw8Y+wk8sJ1KbNUV8skVdaQxxSipY0esYAEWPGTXj6jvvxkP73cg5Sy1ocZRVqb2Rh
         FFYy0JO0wivBW/BPLm4FBSMB37Y7Xr/hPwwBx/VHlqtXwMhOIpqdD91AOHAu2sHougaD
         cwuQ==
X-Gm-Message-State: AOAM533BASkU180L7vOshtV+bxhepW7FJ5MFHfOVN/bky3qZYGyKr13T
        58kD0N+4e6quVAeKMA+h6NPu61CijRnYCwXx6xw=
X-Google-Smtp-Source: ABdhPJzWAUEodW2mYSrVgx/aVrQIoBL1nE+ROg1S3BgzAtNQwXY0vhRs5znC0NaRsIBHIP11yL7l0nkY7pQ1qsdr6E4=
X-Received: by 2002:a92:a005:: with SMTP id e5mr7715143ili.22.1626295669171;
 Wed, 14 Jul 2021 13:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210712124052.26491-1-david@redhat.com> <20210712124052.26491-3-david@redhat.com>
In-Reply-To: <20210712124052.26491-3-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 14 Jul 2021 22:47:38 +0200
Message-ID: <CAM9Jb+hj8uGc0N16Guui9kaA6W46QHzAET44Zt8C7kRdRAXMOA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] mm/memory_hotplug: remove nid parameter from arch_remove_memory()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jia He <justin.he@arm.com>, Joe Perches <joe@perches.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rich Felker <dalias@libc.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> The parameter is unused, let's remove it.
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Heiko Carstens <hca@linux.ibm.com> (s390)
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Laurent Dufour <ldufour@linux.ibm.com>
> Cc: Sergei Trofimovich <slyfox@gentoo.org>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Michel Lespinasse <michel@lespinasse.org>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Pierre Morel <pmorel@linux.ibm.com>
> Cc: Jia He <justin.he@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arm64/mm/mmu.c            | 3 +--
>  arch/ia64/mm/init.c            | 3 +--
>  arch/powerpc/mm/mem.c          | 3 +--
>  arch/s390/mm/init.c            | 3 +--
>  arch/sh/mm/init.c              | 3 +--
>  arch/x86/mm/init_32.c          | 3 +--
>  arch/x86/mm/init_64.c          | 3 +--
>  include/linux/memory_hotplug.h | 3 +--
>  mm/memory_hotplug.c            | 4 ++--
>  mm/memremap.c                  | 5 +----
>  10 files changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d74586508448..af8ab553a268 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1506,8 +1506,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         return ret;
>  }
>
> -void arch_remove_memory(int nid, u64 start, u64 size,
> -                       struct vmem_altmap *altmap)
> +void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>         unsigned long start_pfn = start >> PAGE_SHIFT;
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index 064a967a7b6e..5c6da8d83c1a 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -484,8 +484,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         return ret;
>  }
>
> -void arch_remove_memory(int nid, u64 start, u64 size,
> -                       struct vmem_altmap *altmap)
> +void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>         unsigned long start_pfn = start >> PAGE_SHIFT;
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index ad198b439222..c3c4e31462ec 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -119,8 +119,7 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>         return rc;
>  }
>
> -void __ref arch_remove_memory(int nid, u64 start, u64 size,
> -                             struct vmem_altmap *altmap)
> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>         unsigned long start_pfn = start >> PAGE_SHIFT;
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 8ac710de1ab1..d85bd7f5d8dc 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -306,8 +306,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         return rc;
>  }
>
> -void arch_remove_memory(int nid, u64 start, u64 size,
> -                       struct vmem_altmap *altmap)
> +void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>         unsigned long start_pfn = start >> PAGE_SHIFT;
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index ce26c7f8950a..506784702430 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -414,8 +414,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         return ret;
>  }
>
> -void arch_remove_memory(int nid, u64 start, u64 size,
> -                       struct vmem_altmap *altmap)
> +void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>         unsigned long start_pfn = PFN_DOWN(start);
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index 74b78840182d..bd90b8fe81e4 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -801,8 +801,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         return __add_pages(nid, start_pfn, nr_pages, params);
>  }
>
> -void arch_remove_memory(int nid, u64 start, u64 size,
> -                       struct vmem_altmap *altmap)
> +void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>         unsigned long start_pfn = start >> PAGE_SHIFT;
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index ddeaba947eb3..a6e11763763f 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1255,8 +1255,7 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
>         remove_pagetable(start, end, true, NULL);
>  }
>
> -void __ref arch_remove_memory(int nid, u64 start, u64 size,
> -                             struct vmem_altmap *altmap)
> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>         unsigned long start_pfn = start >> PAGE_SHIFT;
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index d01b504ce06f..010a192298b5 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -130,8 +130,7 @@ static inline bool movable_node_is_enabled(void)
>         return movable_node_enabled;
>  }
>
> -extern void arch_remove_memory(int nid, u64 start, u64 size,
> -                              struct vmem_altmap *altmap);
> +extern void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap);
>  extern void __remove_pages(unsigned long start_pfn, unsigned long nr_pages,
>                            struct vmem_altmap *altmap);
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 93b3abaf9828..f2a9af3af184 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1106,7 +1106,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>         /* create memory block devices after memory was added */
>         ret = create_memory_block_devices(start, size, mhp_altmap.alloc);
>         if (ret) {
> -               arch_remove_memory(nid, start, size, NULL);
> +               arch_remove_memory(start, size, NULL);
>                 goto error;
>         }
>
> @@ -1892,7 +1892,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>
>         mem_hotplug_begin();
>
> -       arch_remove_memory(nid, start, size, altmap);
> +       arch_remove_memory(start, size, altmap);
>
>         if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
>                 memblock_free(start, size);
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 15a074ffb8d7..ed593bf87109 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -140,14 +140,11 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
>  {
>         struct range *range = &pgmap->ranges[range_id];
>         struct page *first_page;
> -       int nid;
>
>         /* make sure to access a memmap that was actually initialized */
>         first_page = pfn_to_page(pfn_first(pgmap, range_id));
>
>         /* pages are dead and unused, undo the arch mapping */
> -       nid = page_to_nid(first_page);
> -
>         mem_hotplug_begin();
>         remove_pfn_range_from_zone(page_zone(first_page), PHYS_PFN(range->start),
>                                    PHYS_PFN(range_len(range)));
> @@ -155,7 +152,7 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
>                 __remove_pages(PHYS_PFN(range->start),
>                                PHYS_PFN(range_len(range)), NULL);
>         } else {
> -               arch_remove_memory(nid, range->start, range_len(range),
> +               arch_remove_memory(range->start, range_len(range),
>                                 pgmap_altmap(pgmap));
>                 kasan_remove_zero_shadow(__va(range->start), range_len(range));
>         }

Reviewed-by: Pankaj Gupta <pankaj.gupta@ionos.com>
