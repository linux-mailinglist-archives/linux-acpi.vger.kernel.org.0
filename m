Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5526A3E8B21
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Aug 2021 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhHKHih (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Aug 2021 03:38:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233182AbhHKHif (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Aug 2021 03:38:35 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B7WfeJ028233;
        Wed, 11 Aug 2021 03:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=m+JtjjEy5TsJLd92ur6KCDzzzlMk9GDK4ppT5WWK7Q0=;
 b=RU7eOxjOmXTZY2NqL9Q2cCuGnoWfL2JgSObPvFj5X5DUCQvy3CJr9sGoOyIHy4gs1uJS
 zKurjIFs2AOq3JH0/9P6p/Y+jKNeXIncxqqpyBtP7qrVznqmYwdUz9+GVWQuHB4Lla05
 VnT+CjdpRKwM+2fY+BC6RWU12bpiYjqvgKLI+EBh+VYkhM76FTA8tivMKVcKizKleVHn
 Jo0i+rCVp/3i/ZQI1h5EMEQmO4EnsvEBL+7njB1XMu91FzPXwHS83Yqt586eIKoZh6no
 o17X+hxzAyptv2YldcDCXHKCd7rtF4qLS9LpxW4gTUr79zYKkwn/eCRnHPQNaKQ3f8fS GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab8km2c1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 03:36:42 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17B7XWlk030716;
        Wed, 11 Aug 2021 03:36:41 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab8km2c0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 03:36:41 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17B7Wo1l024116;
        Wed, 11 Aug 2021 07:36:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3a9ht8yjww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 07:36:38 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17B7aZTb55968192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 07:36:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38D9BAE06A;
        Wed, 11 Aug 2021 07:36:35 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C14C5AE079;
        Wed, 11 Aug 2021 07:36:31 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.154.55])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 11 Aug 2021 07:36:31 +0000 (GMT)
Date:   Wed, 11 Aug 2021 10:36:29 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
        linux-acpi@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        x86@kernel.org, Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v3] memblock: make memblock_find_in_range method private
Message-ID: <YRN9/XrHiPUMdDPJ@linux.ibm.com>
References: <20210803064218.6611-1-rppt@kernel.org>
 <20210809190641.GA1176508@roeck-us.net>
 <YRLLpImNhZaLzs3z@kernel.org>
 <7db20940-cbd9-e900-db28-774c5782601c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7db20940-cbd9-e900-db28-774c5782601c@roeck-us.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KjgETmJ2ZlBV_z9jVvzjB2ISzeMnuxs6
X-Proofpoint-ORIG-GUID: xIQ81LmHYZOWObinE8T8p_gKjQgiq9Cz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_02:2021-08-10,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110048
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 10, 2021 at 12:21:46PM -0700, Guenter Roeck wrote:
> On 8/10/21 11:55 AM, Mike Rapoport wrote:
> > On Mon, Aug 09, 2021 at 12:06:41PM -0700, Guenter Roeck wrote:
> > > On Tue, Aug 03, 2021 at 09:42:18AM +0300, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > There are a lot of uses of memblock_find_in_range() along with
> > > > memblock_reserve() from the times memblock allocation APIs did not exist.
> > > > 
> > > > memblock_find_in_range() is the very core of memblock allocations, so any
> > > > future changes to its internal behaviour would mandate updates of all the
> > > > users outside memblock.
> > > > 
> > > > Replace the calls to memblock_find_in_range() with an equivalent calls to
> > > > memblock_phys_alloc() and memblock_phys_alloc_range() and make
> > > > memblock_find_in_range() private method of memblock.
> > > > 
> > > > This simplifies the callers, ensures that (unlikely) errors in
> > > > memblock_reserve() are handled and improves maintainability of
> > > > memblock_find_in_range().
> > > > 
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > I see a number of crashes in next-20210806 when booting x86 images from efi.
> > > 
> > > [    0.000000] efi: EFI v2.70 by EDK II
> > > [    0.000000] efi: SMBIOS=0x1fbcc000 ACPI=0x1fbfa000 ACPI 2.0=0x1fbfa014 MEMATTR=0x1f25f018
> > > [    0.000000] SMBIOS 2.8 present.
> > > [    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > > [    0.000000] last_pfn = 0x1ff50 max_arch_pfn = 0x400000000
> > > [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> > > [    0.000000] Kernel panic - not syncing: alloc_low_pages: can not alloc memory
> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.0-rc4-next-20210806 #1
> > > [    0.000000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > > [    0.000000] Call Trace:
> > > [    0.000000]  ? dump_stack_lvl+0x57/0x7d
> > > [    0.000000]  ? panic+0xfc/0x2c6
> > > [    0.000000]  ? alloc_low_pages+0x117/0x156
> > > [    0.000000]  ? phys_pmd_init+0x234/0x342
> > > [    0.000000]  ? phys_pud_init+0x171/0x337
> > > [    0.000000]  ? __kernel_physical_mapping_init+0xec/0x276
> > > [    0.000000]  ? init_memory_mapping+0x1ea/0x2aa
> > > [    0.000000]  ? init_range_memory_mapping+0xdf/0x12e
> > > [    0.000000]  ? init_mem_mapping+0x1e9/0x26f
> > > [    0.000000]  ? setup_arch+0x5ff/0xb6d
> > > [    0.000000]  ? start_kernel+0x71/0x6b4
> > > [    0.000000]  ? secondary_startup_64_no_verify+0xc2/0xcb
> > > 
> > > Bisect points to this patch. Reverting it fixes the problem. Key seems to
> > > be the amount of memory configured in qemu; the problem is not seen if
> > > there is 1G or more of memory, but it is seen with all test boots with
> > > 512M or 256M of memory. It is also seen with almost all 32-bit efi boots.
> > > 
> > > The problem is not seen when booting without efi.
> > 
> > It looks like this change uncovered a problem in
> > x86::memory_map_top_down().
> > 
> > The allocation in alloc_low_pages() is limited by min_pfn_mapped and
> > max_pfn_mapped. The min_pfn_mapped is updated at every iteration of the
> > loop in memory_map_top_down, but there is another loop in
> > init_range_memory_mapping() that maps several regions below the current
> > min_pfn_mapped without updating this variable.
> > 
> > The memory layout in qemu with 256M of RAM and EFI enabled, causes
> > exhaustion of the memory limited by min_pfn_mapped and max_pfn_mapped
> > before min_pfn_mapped is updated.
> > 
> > Before this commit there was unconditional "reservation" of 2M in the end
> > of the memory that moved the initial min_pfn_mapped below the memory
> > reserved by EFI. The addition of check for xen_domain() removed this
> > reservation for !XEN and made alloc_low_pages() use the range already busy
> > with EFI data.
> > 
> > The patch below moves the update of min_pfn_mapped near the update of
> > max_pfn_mapped so that every time a new range is mapped both limits will be
> > updated accordingly.
> > 
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index 1152a29ce109..be279f6e5a0a 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -1,3 +1,4 @@
> > +#define DEBUG
> >   #include <linux/gfp.h>
> >   #include <linux/initrd.h>
> >   #include <linux/ioport.h>
> > @@ -485,6 +486,7 @@ static void add_pfn_range_mapped(unsigned long start_pfn, unsigned long end_pfn)
> >   	nr_pfn_mapped = clean_sort_range(pfn_mapped, E820_MAX_ENTRIES);
> >   	max_pfn_mapped = max(max_pfn_mapped, end_pfn);
> > +	min_pfn_mapped = min(min_pfn_mapped, start_pfn);
> >   	if (start_pfn < (1UL<<(32-PAGE_SHIFT)))
> >   		max_low_pfn_mapped = max(max_low_pfn_mapped,
> > @@ -643,7 +645,6 @@ static void __init memory_map_top_down(unsigned long map_start,
> >   		mapped_ram_size += init_range_memory_mapping(start,
> >   							last_start);
> >   		last_start = start;
> > -		min_pfn_mapped = last_start >> PAGE_SHIFT;
> >   		if (mapped_ram_size >= step_size)
> >   			step_size = get_new_step_size(step_size);
> >   	}
> 
> The offending patch was removed from next-20210810, but I applied the above change
> to next-20210809 and it does indeed fix the problem. If it is added as separate patch,
> please feel free to add
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks!

I wonder now about that comment saying "xen has big range in reserved near
end of ram". Maybe it was the same issue with Xen and we can entirely drop
the reservation of the top 2M?

x86 folks, what do you say?

-- 
Sincerely yours,
Mike.
