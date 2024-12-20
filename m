Return-Path: <linux-acpi+bounces-10235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 761569F9CFD
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 00:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CDD188FC1C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 23:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547BF225789;
	Fri, 20 Dec 2024 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ko0NoC85"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9531AAA00;
	Fri, 20 Dec 2024 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734735989; cv=none; b=AEEhS997a/E77qiLD4RxVb7iX70rD009DOEiC1QndK4tleHmYBiaDGj8LLb9mO8BCmvAuni+KmNFGGk7heWDNa/Yx6gnZ2qF/d1YXj4Rn5K7sMFCNlZ3+rpXutqSFFey59rLjZruDKHGZmAEZBG9KGtXGe4RR12ACpsJ2BrPMOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734735989; c=relaxed/simple;
	bh=rDnT4CiiEQHDei+WTY8t89wAldSK7/wzy9hzuNQ2FY0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mR9kqnewnuKbl4Z6HKX782zc6ZZY4ffOkl8y89IwF3ijfVzjD0RbX27USRLC159FaDuSuyd7NUSOJE8/OXSOBBawVmJms95i9/qtPJtetAe58F47wxu7KZXAN7QgK8e4bcHWohEozn+w06AOc3PBkG39JKGUGyQJBhltZ0C3u5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ko0NoC85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D4DC4CECD;
	Fri, 20 Dec 2024 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734735987;
	bh=rDnT4CiiEQHDei+WTY8t89wAldSK7/wzy9hzuNQ2FY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ko0NoC85TGcP1IppTBQ7r5GFZyBBTG2SpQ0tFrc/AJkG+/T9Itx2K+hPhmLUjOFT3
	 W/JopMsDfKdWQ+Sgte/CaZu5u4oCC9X7AhqHTGt1/QNG5SKrdk/OmLPnondMcorXOq
	 YK2sRjfqtNIqcRTWYGNAXSYWTaR7HQTBx80wOGXo=
Date: Fri, 20 Dec 2024 15:06:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun
 Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Sam Creasey <sammy@sammy.net>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Huacai Chen <chenhuacai@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>, rafael.j.wysocki@intel.com,
 Palmer Dabbelt <palmer@rivosinc.com>, Hanjun Guo <guohanjun@huawei.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, Johannes Berg
 <johannes.berg@intel.com>, Ingo Molnar <mingo@kernel.org>, Dave Hansen
 <dave.hansen@intel.com>, Christian Brauner <brauner@kernel.org>, KP Singh
 <kpsingh@kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
 WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
 Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Geoff
 Levand <geoff@infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson
 <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Len Brown <lenb@kernel.org>,
 Juergen Gross <jgross@suse.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Chris Zankel <chris@zankel.net>, Max Filippov
 <jcmvbkbc@gmail.com>, Tero Kristo <kristo@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Pavel Machek
 <pavel@ucw.cz>, Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Marco Elver <elver@google.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-omap@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] mm/memblock: Add memblock_alloc_or_panic interface
Message-Id: <20241220150623.278e8fa9f073b66dc81edfe6@linux-foundation.org>
In-Reply-To: <20241220092638.2611414-1-guoweikang.kernel@gmail.com>
References: <20241220092638.2611414-1-guoweikang.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 17:26:38 +0800 Guo Weikang <guoweikang.kernel@gmail.com> wrote:

> Before SLUB initialization, various subsystems used memblock_alloc to
> allocate memory. In most cases, when memory allocation fails, an immediate
> panic is required. To simplify this behavior and reduce repetitive checks,
> introduce `memblock_alloc_or_panic`. This function ensures that memory
> allocation failures result in a panic automatically, improving code
> readability and consistency across subsystems that require this behavior.
> 

Seems nice.

> ...
>
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -417,6 +417,19 @@ static __always_inline void *memblock_alloc(phys_addr_t size, phys_addr_t align)
>  				      MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
>  }
>  
> +static __always_inline void *memblock_alloc_or_panic(phys_addr_t size, phys_addr_t align)

We lost the printing of the function name, but it's easy to retain with
something like

#define memblock_alloc_or_panic(size, align)	\
		__memblock_alloc_or_panic(size, align, __func__)

> +{
> +	void *addr = memblock_alloc(size, align);
> +
> +	if (unlikely(!addr))
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
> +		panic("%s: Failed to allocate %llu bytes\n", __func__, size);

Won't this always print "memblock_alloc_or_panic: Failed ..."?  Not
very useful.

> +#else
> +		panic("%s: Failed to allocate %u bytes\n", __func__, size);
> +#endif

We can avoid the ifdef with printk's "%pap"?

> +	return addr;
> +}


