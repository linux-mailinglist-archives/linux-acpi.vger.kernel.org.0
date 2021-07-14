Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEF3C924B
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 22:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhGNUoi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhGNUoh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 16:44:37 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DCAC06175F;
        Wed, 14 Jul 2021 13:41:44 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b14so2902615ilf.7;
        Wed, 14 Jul 2021 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqcSJ3+RdO5AVQF2XIn7OGZkaQyuAY3R+z4rvhGNyD4=;
        b=pQFLoNaGNyjMVOXUkwfQkEuNRkOc+zygrTlctP5bdT4McvO6Ng4hwvedqUBVQUAkqs
         wPtowxZDjSKq+yFESIb64yRfq5QLOkJeWEJIwxxbS3HGpJ7k+koBAXbYMYBM4k1jYjB3
         GsMCfzBHy5/sr6Bxyf84y4zVzXDAWxCKMfxKpzPTMIYJrKlYiWllALzshoMt++Pd+585
         TCgf3rf6QwtRbvM6dXmd6Zxq2nkp//FnnHM+Uq26FcXwqLtTy9zJFJbtZxvkgSNaR6YT
         UaJavclTVfamQ9KqM6AE4kU0FGN1C2933QfUQ2Bxk8kRlOzwMkCpcAFg1MRfozFmTJME
         q8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqcSJ3+RdO5AVQF2XIn7OGZkaQyuAY3R+z4rvhGNyD4=;
        b=mJ4sHfsovJ14gzRaKSuKRvM2yZnaFcSxqxcWIixOuvK9tr2i3vV4LMIUiTf/4EGHy7
         0E+D8P+b8uRkzH+Fccf64xUc/XxxEQcTjqAB7cA1jph01QqKh80ElHBHoOeBC7+aVBzC
         2Hr+hdZiq8dy9ipa6sGlJylpWIEaOEPAiNWG203YzdIAM+6uL7Bt1yN3v928hzgB4Tm5
         xooFKhSzq7LOFr8yKMIdVlZBQ5X9CYef9O0YqbGppRa9dLDIxMf+ujC9XSxku5zXCxRB
         Trh1eXdFvpje+xP7RF9/KCzeB0G4Xnbp7lh4VgjHvgqgb/Ea5cH6JVz5H2g5rIn9Xyjz
         56xA==
X-Gm-Message-State: AOAM532kaiMVV0f4rnQLhubYU3LNYFB44t47yJxWb3viR24iDbIqDZjG
        zrspp+BfdhIqNovVlIumfDKwyErp0utp34XIhBY=
X-Google-Smtp-Source: ABdhPJzO7STrjt80s023NvMYhE0SPvgFGt3L4pny0yb79MK4xbAu75rcqNQ2debzSFJu5KmuzIqVn7PveRA96RL/IS4=
X-Received: by 2002:a92:a005:: with SMTP id e5mr7701226ili.22.1626295304242;
 Wed, 14 Jul 2021 13:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210712124052.26491-1-david@redhat.com> <20210712124052.26491-2-david@redhat.com>
In-Reply-To: <20210712124052.26491-2-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 14 Jul 2021 22:41:33 +0200
Message-ID: <CAM9Jb+ivNvh19Rnt2FGL9PSeUhm4LgU9U5=5BZXd1qCWp1h8iQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: use "unsigned long" for PFN in zone_for_pfn_range()
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
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Checkpatch complained on a follow-up patch that we are using "unsigned"
> here, which defaults to "unsigned int" and checkpatch is correct.
>
> Use "unsigned long" instead, just as we do in other places when handling
> PFNs. This can bite us once we have physical addresses in the range of
> multiple TB.
>
> Fixes: e5e689302633 ("mm, memory_hotplug: display allowed zones in the preferred ordering")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/memory_hotplug.h | 4 ++--
>  mm/memory_hotplug.c            | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index a7fd2c3ccb77..d01b504ce06f 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -339,8 +339,8 @@ extern void sparse_remove_section(struct mem_section *ms,
>                 unsigned long map_offset, struct vmem_altmap *altmap);
>  extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
>                                           unsigned long pnum);
> -extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
> -               unsigned long nr_pages);
> +extern struct zone *zone_for_pfn_range(int online_type, int nid,
> +               unsigned long start_pfn, unsigned long nr_pages);
>  extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
>                                       struct mhp_params *params);
>  void arch_remove_linear_mapping(u64 start, u64 size);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8cb75b26ea4f..93b3abaf9828 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -708,8 +708,8 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
>         return movable_node_enabled ? movable_zone : kernel_zone;
>  }
>
> -struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
> -               unsigned long nr_pages)
> +struct zone *zone_for_pfn_range(int online_type, int nid,
> +               unsigned long start_pfn, unsigned long nr_pages)
>  {
>         if (online_type == MMOP_ONLINE_KERNEL)
>                 return default_kernel_zone_for_pfn(nid, start_pfn, nr_pages);

Reviewed-by: Pankaj Gupta <pankaj.gupta@ionos.com>
