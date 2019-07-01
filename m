Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6994D2AC
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 18:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFTQFN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 12:05:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46289 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTQFN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2019 12:05:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so5389266edr.13;
        Thu, 20 Jun 2019 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uWavFABFzAWag3agb+1ixBf4/NsmQ/Jk55lG7/RwZvs=;
        b=Rgl51jjfve9zspKM7TBc2Hsuz0I+OEUa6feRk9BqadSjiIy2ew9sutrYPIIIiDkPkd
         WUFu8tsHOrndtIM4hkN9mSFzkHV2ZTgCxN3FOVwsjwj0iiZCDOMkowLNEkE8bBi4QqMi
         y0wXGtmI2GHK12pmj8+HWwOML7Ly1AZE+F070527fMXIk44GFVrWAkwMc4+JvvGhyA4k
         V63n25adUFYwJ/rGBRqbxWVu9EF8e8pCr/zIy3eCz+rZ8ULWtPp9U7XsX5TN4rMo7gaS
         VgKaDLcIiaDNxvrF4ANklg7EBz6RQPBJkrKYClXPKNyJCwpVTsFxBnzroy6ibnecty1j
         wUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uWavFABFzAWag3agb+1ixBf4/NsmQ/Jk55lG7/RwZvs=;
        b=spqTgwOEfadTfWijQOxQ9F4VEO34pKX68BgCYf+f+6TqjjlXhxjJ2cb/Uo7j3ZQqsk
         wEPZH6tY0vWmHU4e+hHc21xVCm8DYZo0yh3OsPlve328/H1e1mr5BwNwEvA9ezjd/50K
         uKYpIg1Y2XKumbs56dKPa2FgCtlnqc2epkSUCAXJTOKzPzlK2p1iScrCl+OQJ+2dullJ
         qUjAx6Yi8ZBDFl2xQpa99ffBkj5ZE39HXQEwdN1FPQH6UJHjK4onRSFBSsv1LhP3ogk+
         JhEjYuO/k333aN+6RFmNKAWXIBhnFLA96yliJvyrMXmllqWw5dWiwcbmOkgvv11iE7W+
         QtYA==
X-Gm-Message-State: APjAAAWcnWFY9YiWZYxPvBi9ucmCFEElH4i2d8kJxkjBVmmMi8cmL6an
        jLSj/vDSLs21V8MJFbFLi+A=
X-Google-Smtp-Source: APXvYqyWjLuoM8jMXFMhzcvs2toTW2e3AF4u6C8PLjKPkwgtBawqbYKjpPYtthFm5oPurgKp6zQ0WA==
X-Received: by 2002:a05:6402:134c:: with SMTP id y12mr39686504edw.96.1561046710496;
        Thu, 20 Jun 2019 09:05:10 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id h10sm6974892eda.85.2019.06.20.09.05.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 09:05:09 -0700 (PDT)
Date:   Thu, 20 Jun 2019 09:05:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Juergen Gross <jgross@suse.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>
Subject: Re: [PATCH v2 4/6] mm/memory_hotplug: Rename walk_memory_range() and
 pass start+size instead of pfns
Message-ID: <20190620160507.GA34841@archlinux-epyc>
References: <20190620103520.23481-1-david@redhat.com>
 <20190620103520.23481-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620103520.23481-5-david@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 20, 2019 at 12:35:18PM +0200, David Hildenbrand wrote:
> walk_memory_range() was once used to iterate over sections. Now, it
> iterates over memory blocks. Rename the function, fixup the
> documentation. Also, pass start+size instead of PFNs, which is what most
> callers already have at hand. (we'll rework link_mem_sections() most
> probably soon)
> 
> Follow-up patches wil rework, simplify, and move walk_memory_blocks() to
> drivers/base/memory.c.
> 
> Note: walk_memory_blocks() only works correctly right now if the
> start_pfn is aligned to a section start. This is the case right now,
> but we'll generalize the function in a follow up patch so the semantics
> match the documentation.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Arun KS <arunks@codeaurora.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/powernv/memtrace.c | 22 ++++++++++-----------
>  drivers/acpi/acpi_memhotplug.c            | 19 ++++--------------
>  drivers/base/node.c                       |  5 +++--
>  include/linux/memory_hotplug.h            |  2 +-
>  mm/memory_hotplug.c                       | 24 ++++++++++++-----------
>  5 files changed, 32 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index 5e53c1392d3b..8c82c041afe6 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -70,23 +70,24 @@ static int change_memblock_state(struct memory_block *mem, void *arg)
>  /* called with device_hotplug_lock held */
>  static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
>  {
> +	const unsigned long start = PFN_PHYS(start_pfn);
> +	const unsigned long size = PFN_PHYS(nr_pages);
>  	u64 end_pfn = start_pfn + nr_pages - 1;

This variable should be removed:

arch/powerpc/platforms/powernv/memtrace.c:75:6: warning: unused variable 'end_pfn' [-Wunused-variable]
        u64 end_pfn = start_pfn + nr_pages - 1;
            ^
1 warning generated.

https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/209576737

Cheers,
Nathan

>  
> -	if (walk_memory_range(start_pfn, end_pfn, NULL,
> -	    check_memblock_online))
> +	if (walk_memory_blocks(start, size, NULL, check_memblock_online))
>  		return false;
>  
> -	walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
> -			  change_memblock_state);
> +	walk_memory_blocks(start, size, (void *)MEM_GOING_OFFLINE,
> +			   change_memblock_state);
>  
>  	if (offline_pages(start_pfn, nr_pages)) {
> -		walk_memory_range(start_pfn, end_pfn, (void *)MEM_ONLINE,
> -				  change_memblock_state);
> +		walk_memory_blocks(start, size, (void *)MEM_ONLINE,
> +				   change_memblock_state);
>  		return false;
>  	}
>  
> -	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
> -			  change_memblock_state);
> +	walk_memory_blocks(start, size, (void *)MEM_OFFLINE,
> +			   change_memblock_state);
>  
>  
>  	return true;
> @@ -242,9 +243,8 @@ static int memtrace_online(void)
>  		 */
>  		if (!memhp_auto_online) {
>  			lock_device_hotplug();
> -			walk_memory_range(PFN_DOWN(ent->start),
> -					  PFN_UP(ent->start + ent->size - 1),
> -					  NULL, online_mem_block);
> +			walk_memory_blocks(ent->start, ent->size, NULL,
> +					   online_mem_block);
>  			unlock_device_hotplug();
>  		}
>  
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index db013dc21c02..e294f44a7850 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -155,16 +155,6 @@ static int acpi_memory_check_device(struct acpi_memory_device *mem_device)
>  	return 0;
>  }
>  
> -static unsigned long acpi_meminfo_start_pfn(struct acpi_memory_info *info)
> -{
> -	return PFN_DOWN(info->start_addr);
> -}
> -
> -static unsigned long acpi_meminfo_end_pfn(struct acpi_memory_info *info)
> -{
> -	return PFN_UP(info->start_addr + info->length-1);
> -}
> -
>  static int acpi_bind_memblk(struct memory_block *mem, void *arg)
>  {
>  	return acpi_bind_one(&mem->dev, arg);
> @@ -173,9 +163,8 @@ static int acpi_bind_memblk(struct memory_block *mem, void *arg)
>  static int acpi_bind_memory_blocks(struct acpi_memory_info *info,
>  				   struct acpi_device *adev)
>  {
> -	return walk_memory_range(acpi_meminfo_start_pfn(info),
> -				 acpi_meminfo_end_pfn(info), adev,
> -				 acpi_bind_memblk);
> +	return walk_memory_blocks(info->start_addr, info->length, adev,
> +				  acpi_bind_memblk);
>  }
>  
>  static int acpi_unbind_memblk(struct memory_block *mem, void *arg)
> @@ -186,8 +175,8 @@ static int acpi_unbind_memblk(struct memory_block *mem, void *arg)
>  
>  static void acpi_unbind_memory_blocks(struct acpi_memory_info *info)
>  {
> -	walk_memory_range(acpi_meminfo_start_pfn(info),
> -			  acpi_meminfo_end_pfn(info), NULL, acpi_unbind_memblk);
> +	walk_memory_blocks(info->start_addr, info->length, NULL,
> +			   acpi_unbind_memblk);
>  }
>  
>  static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index e6364e3e3e31..d8c02e65df68 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -833,8 +833,9 @@ void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>  
>  int link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn)
>  {
> -	return walk_memory_range(start_pfn, end_pfn, (void *)&nid,
> -					register_mem_sect_under_node);
> +	return walk_memory_blocks(PFN_PHYS(start_pfn),
> +				  PFN_PHYS(end_pfn - start_pfn), (void *)&nid,
> +				  register_mem_sect_under_node);
>  }
>  
>  #ifdef CONFIG_HUGETLBFS
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 79e0add6a597..d9fffc34949f 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -340,7 +340,7 @@ static inline void __remove_memory(int nid, u64 start, u64 size) {}
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
>  extern void __ref free_area_init_core_hotplug(int nid);
> -extern int walk_memory_range(unsigned long start_pfn, unsigned long end_pfn,
> +extern int walk_memory_blocks(unsigned long start, unsigned long size,
>  		void *arg, int (*func)(struct memory_block *, void *));
>  extern int __add_memory(int nid, u64 start, u64 size);
>  extern int add_memory(int nid, u64 start, u64 size);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index a88c5f334e5a..122a7d31efdd 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1126,8 +1126,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
>  
>  	/* online pages if requested */
>  	if (memhp_auto_online)
> -		walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1),
> -				  NULL, online_memory_block);
> +		walk_memory_blocks(start, size, NULL, online_memory_block);
>  
>  	return ret;
>  error:
> @@ -1665,20 +1664,24 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
>  /**
> - * walk_memory_range - walks through all mem sections in [start_pfn, end_pfn)
> - * @start_pfn: start pfn of the memory range
> - * @end_pfn: end pfn of the memory range
> + * walk_memory_blocks - walk through all present memory blocks overlapped
> + *			by the range [start, start + size)
> + *
> + * @start: start address of the memory range
> + * @size: size of the memory range
>   * @arg: argument passed to func
> - * @func: callback for each memory section walked
> + * @func: callback for each memory block walked
>   *
> - * This function walks through all present mem sections in range
> - * [start_pfn, end_pfn) and call func on each mem section.
> + * This function walks through all present memory blocks overlapped by the
> + * range [start, start + size), calling func on each memory block.
>   *
>   * Returns the return value of func.
>   */
> -int walk_memory_range(unsigned long start_pfn, unsigned long end_pfn,
> +int walk_memory_blocks(unsigned long start, unsigned long size,
>  		void *arg, int (*func)(struct memory_block *, void *))
>  {
> +	const unsigned long start_pfn = PFN_DOWN(start);
> +	const unsigned long end_pfn = PFN_UP(start + size - 1);
>  	struct memory_block *mem = NULL;
>  	struct mem_section *section;
>  	unsigned long pfn, section_nr;
> @@ -1824,8 +1827,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  	 * whether all memory blocks in question are offline and return error
>  	 * if this is not the case.
>  	 */
> -	rc = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
> -			       check_memblock_offlined_cb);
> +	rc = walk_memory_blocks(start, size, NULL, check_memblock_offlined_cb);
>  	if (rc)
>  		goto done;
>  
> -- 
> 2.21.0
> 
