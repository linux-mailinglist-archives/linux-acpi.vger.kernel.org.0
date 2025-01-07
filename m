Return-Path: <linux-acpi+bounces-10404-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01D2A043A2
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 16:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8796D162098
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0D91F2381;
	Tue,  7 Jan 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rdj4BTKq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B981F1319;
	Tue,  7 Jan 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262238; cv=none; b=cSeOTXKcFLTs27HTcv/TfLhk4Da3EoDATxJi0TlWutJ6B9XuQx0wUjuh9jn1qsCJ06j1zMgZgHUSCzbEHFTeC3Z8fNcU8sAL3quPmRHHoVYPrJ7OlsG5dJNj0Tl22OjOm3u0AaTH7s2DrhdY6pLLO3Pzf2zTgK2E26sS9pFgKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262238; c=relaxed/simple;
	bh=r02ypHE2EsKzJCKXFySKfOuCF4xrzUgVMqfy3L+w+Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otz/URyyE43X5BEF88Ra26q9K3wksTmKDpwC0H5QWQldiOWw/YInkDsaSNkCJXxu40QTyGznWQCbY4pfNVPuJMPeEQxLxKs+4d9rgPNsGDi+tc10jdU0bckLgaZ5y976sBnEvIrnh05ATL+uvtAkgcbcEXG7AUxt47ZH+lUzc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rdj4BTKq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50785q0m018311;
	Tue, 7 Jan 2025 15:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nGMTr1inoVWG3ARe8QoGoEOSwdCntu
	qZy8bhdK6O/ME=; b=rdj4BTKquX38fA+V7vs9vGrg6z7HxUyoh1JCIFg2qPrBrc
	ovRrqMTxob92ukiN9TlpZCs7CVUaqv6rh4Mi5tAIkhlcCaduaExoYeYLzmHkaH1C
	S0jV8pQzj2Q2N++he2cxLihvsXN9Ws2JTtsztsnqZdNHB0F+gy5J9PuEu1tgZtJk
	XpYyXE/McfMm5JLsDDKSEa0f3gOdZvqdAytY6OUzDZe71qUCT9y2i1ZigqqwPHmx
	1mK+SyY6FXGKya5ump+AzYcnbek4K8yEjS0n+sKJkfNM1URBoiNo/3Sb4PjRN+s0
	zgkOb4fRUrznizbOxQ8cOjfYiVbiPNEGSmJygikg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f39tfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 15:02:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507E2w4n027938;
	Tue, 7 Jan 2025 15:02:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk2t7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 15:02:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507F2nAY55837076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 15:02:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C602420043;
	Tue,  7 Jan 2025 15:02:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 683182004D;
	Tue,  7 Jan 2025 15:02:48 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Jan 2025 15:02:48 +0000 (GMT)
Date: Tue, 7 Jan 2025 16:02:47 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sam Creasey <sammy@sammy.net>, Huacai Chen <chenhuacai@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
        rafael.j.wysocki@intel.com, Palmer Dabbelt <palmer@rivosinc.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Easwar Hariharan <eahariha@linux.microsoft.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Christian Brauner <brauner@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
        WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Geoff Levand <geoff@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v7] mm/memblock: Add memblock_alloc_or_panic interface
Message-ID: <Z31CF9f//ZD+VH59@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241222111537.2720303-1-guoweikang.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241222111537.2720303-1-guoweikang.kernel@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: by_phAXyWBB4rrGUxAvoGmZnyCdgAMa_
X-Proofpoint-ORIG-GUID: by_phAXyWBB4rrGUxAvoGmZnyCdgAMa_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=985
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070126

On Sun, Dec 22, 2024 at 07:15:37PM +0800, Guo Weikang wrote:

Hi Guo,

> Before SLUB initialization, various subsystems used memblock_alloc to
> allocate memory. In most cases, when memory allocation fails, an immediate
> panic is required. To simplify this behavior and reduce repetitive checks,
> introduce `memblock_alloc_or_panic`. This function ensures that memory
> allocation failures result in a panic automatically, improving code
> readability and consistency across subsystems that require this behavior.

I believe, you also want to make similar function against memblock_alloc_low().

Please, find s390 comments below.

...

> diff --git a/arch/s390/kernel/numa.c b/arch/s390/kernel/numa.c
> index ddc1448ea2e1..a33e20f73330 100644
> --- a/arch/s390/kernel/numa.c
> +++ b/arch/s390/kernel/numa.c
> @@ -22,10 +22,7 @@ void __init numa_setup(void)
>  	node_set(0, node_possible_map);
>  	node_set_online(0);
>  	for (nid = 0; nid < MAX_NUMNODES; nid++) {
> -		NODE_DATA(nid) = memblock_alloc(sizeof(pg_data_t), 8);
> -		if (!NODE_DATA(nid))
> -			panic("%s: Failed to allocate %zu bytes align=0x%x\n",
> -			      __func__, sizeof(pg_data_t), 8);
> +		NODE_DATA(nid) = memblock_alloc_or_panic(sizeof(pg_data_t), 8);
>  	}

Please, also remove the cycle body brackets.

>  	NODE_DATA(0)->node_spanned_pages = memblock_end_of_DRAM() >> PAGE_SHIFT;
>  	NODE_DATA(0)->node_id = 0;
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 0ce550faf073..1298f0860733 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -376,11 +376,7 @@ static unsigned long __init stack_alloc_early(void)
>  {
>  	unsigned long stack;
>  
> -	stack = (unsigned long)memblock_alloc(THREAD_SIZE, THREAD_SIZE);
> -	if (!stack) {
> -		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> -		      __func__, THREAD_SIZE, THREAD_SIZE);
> -	}
> +	stack = (unsigned long)memblock_alloc_or_panic(THREAD_SIZE, THREAD_SIZE);
>  	return stack;
>  }
>  
> @@ -504,10 +500,7 @@ static void __init setup_resources(void)
>  	bss_resource.end = __pa_symbol(__bss_stop) - 1;
>  
>  	for_each_mem_range(i, &start, &end) {
> -		res = memblock_alloc(sizeof(*res), 8);
> -		if (!res)
> -			panic("%s: Failed to allocate %zu bytes align=0x%x\n",
> -			      __func__, sizeof(*res), 8);
> +		res = memblock_alloc_or_panic(sizeof(*res), 8);
>  		res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
>  
>  		res->name = "System RAM";
> @@ -526,10 +519,7 @@ static void __init setup_resources(void)
>  			    std_res->start > res->end)
>  				continue;
>  			if (std_res->end > res->end) {
> -				sub_res = memblock_alloc(sizeof(*sub_res), 8);
> -				if (!sub_res)
> -					panic("%s: Failed to allocate %zu bytes align=0x%x\n",
> -					      __func__, sizeof(*sub_res), 8);
> +				sub_res = memblock_alloc_or_panic(sizeof(*sub_res), 8);
>  				*sub_res = *std_res;
>  				sub_res->end = res->end;
>  				std_res->start = res->end + 1;
> @@ -816,9 +806,7 @@ static void __init setup_randomness(void)
>  {
>  	struct sysinfo_3_2_2 *vmms;
>  
> -	vmms = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> -	if (!vmms)
> -		panic("Failed to allocate memory for sysinfo structure\n");
> +	vmms = memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
>  	if (stsi(vmms, 3, 2, 2) == 0 && vmms->count)
>  		add_device_randomness(&vmms->vm, sizeof(vmms->vm[0]) * vmms->count);
>  	memblock_free(vmms, PAGE_SIZE);
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 822d8e6f8717..d77aaefb59bd 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -611,9 +611,9 @@ void __init smp_save_dump_ipl_cpu(void)
>  	if (!dump_available())
>  		return;
>  	sa = save_area_alloc(true);
> -	regs = memblock_alloc(512, 8);
> -	if (!sa || !regs)
> +	if (!sa)
>  		panic("could not allocate memory for boot CPU save area\n");

Please, replace memblock_alloc() with memblock_alloc_or_panic() in
save_area_alloc() and remove the error handling here and also in
smp_save_dump_secondary_cpus().

> +	regs = memblock_alloc_or_panic(512, 8);
>  	copy_oldmem_kernel(regs, __LC_FPREGS_SAVE_AREA, 512);
>  	save_area_add_regs(sa, regs);
>  	memblock_free(regs, 512);
> @@ -792,10 +792,7 @@ void __init smp_detect_cpus(void)
>  	u16 address;
>  
>  	/* Get CPU information */
> -	info = memblock_alloc(sizeof(*info), 8);
> -	if (!info)
> -		panic("%s: Failed to allocate %zu bytes align=0x%x\n",
> -		      __func__, sizeof(*info), 8);
> +	info = memblock_alloc_or_panic(sizeof(*info), 8);
>  	smp_get_core_info(info, 1);
>  	/* Find boot CPU type */
>  	if (sclp.has_core_type) {
> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
> index 0fd56a1cadbd..cf5ee6032c0b 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@ -548,10 +548,7 @@ static void __init alloc_masks(struct sysinfo_15_1_x *info,
>  		nr_masks *= info->mag[TOPOLOGY_NR_MAG - offset - 1 - i];
>  	nr_masks = max(nr_masks, 1);
>  	for (i = 0; i < nr_masks; i++) {
> -		mask->next = memblock_alloc(sizeof(*mask->next), 8);
> -		if (!mask->next)
> -			panic("%s: Failed to allocate %zu bytes align=0x%x\n",
> -			      __func__, sizeof(*mask->next), 8);
> +		mask->next = memblock_alloc_or_panic(sizeof(*mask->next), 8);
>  		mask = mask->next;
>  	}
>  }
> @@ -569,10 +566,7 @@ void __init topology_init_early(void)
>  	}
>  	if (!MACHINE_HAS_TOPOLOGY)
>  		goto out;
> -	tl_info = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> -	if (!tl_info)
> -		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> -		      __func__, PAGE_SIZE, PAGE_SIZE);
> +	tl_info = memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
>  	info = tl_info;
>  	store_topology(info);
>  	pr_info("The CPU configuration topology of the machine is: %d %d %d %d %d %d / %d\n",

Thanks!

