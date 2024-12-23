Return-Path: <linux-acpi+bounces-10276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 271E99FAAFC
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 08:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F33B164416
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AEA18A6B5;
	Mon, 23 Dec 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="dYLhBand"
X-Original-To: linux-acpi@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5827E61FFE;
	Mon, 23 Dec 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734938174; cv=none; b=K3wN3h9HNh9Oeos+GZSNMdTVzduL1znsOmCIXcQ+Ls8pP3n/PtLI0EmglhT6GhEcnC/w5AG/6RDwbeW2paHaVnFaDFJNsLMWrHaAyTnMaD4BRMICRDaBgD0Yzd7yYQ6n/MTzmHA4r7DvqX0xmUe04jD3kbHoUhKSzIUSsinMW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734938174; c=relaxed/simple;
	bh=ZrcgZL9/LrEEus6L4Sj0r3Gfl0Npm9SW91wzmtQUfGo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tFh1YzTy6DuDUV6iTMIG9ynF9nMuaN1Ho49aA+xmM95gY2ppN+sr0pMp0PCKxyXDgPTCp+ZOLZwOuSba1l7q0OEGImco2hIJnP9uHwgvArOtPcE1ffXt7hiFlwmIpbzq3ZLFX+pZzI5wmyVv0/DU60MQdpZzHrQOGoo5vXwJlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=dYLhBand; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1734938153;
	bh=ecGpjQJ+dPTMtl9IS6T8Zx3DPG9sUHrYzmuZ6ugsSWw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dYLhBandMXiOWoijdab1gHiwxN4eR/VOe1BsVjVz9qXmRVOFQ3esRLy431bdS1dZk
	 XfvgNo/mfzBUiJSkzYWjXUz9VNZqGIoxmAEmuMRQld4Umwy3a2m4Fwo8gIpR4U1JmC
	 QNQagNSSgXTyOhRij3RWOWxKAWCl+3mSvRV2S1v8=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1944F67671;
	Mon, 23 Dec 2024 02:15:35 -0500 (EST)
Message-ID: <6ac0e0f71990e5a8dc52f00c737cdf56916e0d4e.camel@xry111.site>
Subject: Re: [PATCH v7] mm/memblock: Add memblock_alloc_or_panic interface
From: Xi Ruoyao <xry111@xry111.site>
To: Mike Rapoport <rppt@kernel.org>, Guo Weikang
 <guoweikang.kernel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven	
 <geert@linux-m68k.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>,  Christoph Lameter	 <cl@linux.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Sam Creasey	 <sammy@sammy.net>, Huacai Chen
 <chenhuacai@kernel.org>, Will Deacon	 <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
 rafael.j.wysocki@intel.com, Palmer Dabbelt <palmer@rivosinc.com>,  Hanjun
 Guo <guohanjun@huawei.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Johannes Berg	 <johannes.berg@intel.com>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen	 <dave.hansen@intel.com>,
 Christian Brauner <brauner@kernel.org>, KP Singh	 <kpsingh@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, Matt Turner
 <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, WANG Xuerui
 <kernel@xen0n.name>,  Michael Ellerman <mpe@ellerman.id.au>, Stefan
 Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne	
 <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Nicholas Piggin	
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen
 N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Geoff
 Levand	 <geoff@infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt	 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrey Ryabinin	 <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino	 <vincenzo.frascino@arm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Yoshinori
 Sato	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson
 <andreas@gaisler.com>, Richard Weinberger	 <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar	 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org, linux-alpha@vger.kernel.org,
 	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 linux-omap@vger.kernel.org, 	linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org, 	linux-pm@vger.kernel.org
Date: Mon, 23 Dec 2024 15:15:34 +0800
In-Reply-To: <Z2kNTjO8hXzN66bX@kernel.org>
References: <20241222111537.2720303-1-guoweikang.kernel@gmail.com>
	 <Z2kNTjO8hXzN66bX@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-23 at 09:12 +0200, Mike Rapoport wrote:
> On Sun, Dec 22, 2024 at 07:15:37PM +0800, Guo Weikang wrote:
> > Before SLUB initialization, various subsystems used memblock_alloc to
> > allocate memory. In most cases, when memory allocation fails, an immedi=
ate
> > panic is required. To simplify this behavior and reduce repetitive chec=
ks,
> > introduce `memblock_alloc_or_panic`. This function ensures that memory
> > allocation failures result in a panic automatically, improving code
> > readability and consistency across subsystems that require this behavio=
r.
> >=20
> > Changelog:
> > ----------
> > v1: initial version
> > v2: add __memblock_alloc_or_panic support panic output caller
> > v3: panic output phys_addr_t use printk's %pap
> > v4: make __memblock_alloc_or_panic out-of-line, move to memblock.c
> > v6: Fix CI compile error
> > Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221000.r1NzXJU=
O-lkp@intel.com/
> > v6: Fix CI compile warinigs
> > Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221259.JuGNAUC=
q-lkp@intel.com/
> > v7: add chagelog and adjust function declaration alignment format
> > ----------
> >=20
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Acked-by: Xi Ruoyao <xry111@xry111.site>
>=20
> If people commented on your patch it does not mean you should add
> Reviewed-by or Acked-by tags for them. Wait for explicit tags from the
> reviewers.

And:

 - Acked-by: indicates an agreement by another developer (often a
   maintainer of the relevant code) that the patch is appropriate for
   inclusion into the kernel.=20

I'm not a maintainer so I even don't have the right to use Acked-by :).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

