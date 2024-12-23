Return-Path: <linux-acpi+bounces-10275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D29FAAEB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 08:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3C31885F77
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 07:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8181865E3;
	Mon, 23 Dec 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PadoaIur"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E7DEEB5;
	Mon, 23 Dec 2024 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734937969; cv=none; b=snHG42aaUkWPFmaVRpb8BREmdwGNRZN76AzysjEndYLuyR7JIegUbv0vkCz2BEkLhMfKM6Q0KIRTxyvFGlJmNABCB3i/WTWjd8pR+YLNZUJktXdxKCB7RNoik8w4ffblMo6oUx5G5rWNxPJH3gBptWDwQ+VA+HT60FKQaL219jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734937969; c=relaxed/simple;
	bh=KiW6z79yHKtUcMEX/b8/Sp0F2L3XtvvNObnoy9wnwCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKqL7y/ouO2p1OPG7NNYsZ2XpAebYpYtcHhE61Vkq4MGIzc2w8mUtF/E72B59YoaCHwn9/ZJfm5+GcANGXuLplBdPTZPm7sEjbFURC+Vy5pSAWVu2Jw+dF1122NKFhGrfMfSegFw0FnRk5TUJejzqWAKVOXa4n19XQo88HKaRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PadoaIur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2221C4CED4;
	Mon, 23 Dec 2024 07:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734937968;
	bh=KiW6z79yHKtUcMEX/b8/Sp0F2L3XtvvNObnoy9wnwCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PadoaIur+Bq/ska4dZ3htQaJQz4uazLSVowJVHucSNC53reVkWxd5YVJWY/8jYQei
	 G/2ikWxztSp4IduffOwXB0a3mVJH23t9Ex7EGVUz/CnbNl3iJwZRxMrSqxsyp7jx0f
	 g/t903ItkhiEVo2DrupFM7faoTX7/DPcXhBh/bkr20Ay+uNKYZumDkMyBSpawM5raK
	 Ut+5vnDGc2C1sPQD75jm/n63pJiamwi58eI2wR3M3lVdk6xTR5vMn3Ur4QTOlkun8B
	 BK41Buv9qow1NTThvM4tSiBT0cMpdhUu2SLkRibN1ROgpuegs2ZYg313l0II/8FbH3
	 cxXTeCHYfJOYg==
Date: Mon, 23 Dec 2024 09:12:14 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Geoff Levand <geoff@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Message-ID: <Z2kNTjO8hXzN66bX@kernel.org>
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

On Sun, Dec 22, 2024 at 07:15:37PM +0800, Guo Weikang wrote:
> Before SLUB initialization, various subsystems used memblock_alloc to
> allocate memory. In most cases, when memory allocation fails, an immediate
> panic is required. To simplify this behavior and reduce repetitive checks,
> introduce `memblock_alloc_or_panic`. This function ensures that memory
> allocation failures result in a panic automatically, improving code
> readability and consistency across subsystems that require this behavior.
> 
> Changelog:
> ----------
> v1: initial version
> v2: add __memblock_alloc_or_panic support panic output caller
> v3: panic output phys_addr_t use printk's %pap
> v4: make __memblock_alloc_or_panic out-of-line, move to memblock.c
> v6: Fix CI compile error
> Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221000.r1NzXJUO-lkp@intel.com/
> v6: Fix CI compile warinigs
> Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221259.JuGNAUCq-lkp@intel.com/
> v7: add chagelog and adjust function declaration alignment format
> ----------
> 
> Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Xi Ruoyao <xry111@xry111.site>

If people commented on your patch it does not mean you should add
Reviewed-by or Acked-by tags for them. Wait for explicit tags from the
reviewers.

And don't respin that often, "Reviewers are busy people and may not get to
your patch right away" [1].

[1] https://docs.kernel.org/process/submitting-patches.html


-- 
Sincerely yours,
Mike.

