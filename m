Return-Path: <linux-acpi+bounces-10278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16F9FAB60
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 09:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E736C165A15
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 08:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA8717AE1D;
	Mon, 23 Dec 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NwAS/XG2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FEE84E0A;
	Mon, 23 Dec 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734941163; cv=none; b=qN6RfHA8K/PSWaxMFptJiV2ikEisMlo2ShCzP6zowwhLrJXPgTvMecKvkqv5ck+77z7PA1vN7aP88DUWCG2pJPsOXY4oazN0iWxowOpzqfLCqAzu5g+N5/7rbDQnBTfuiaMPzkT6UD5gOHPPbPrwNq56d0m4DV7uWO+psSLaxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734941163; c=relaxed/simple;
	bh=oLAFDpVTm28rpp13OPocO6rqDyE1uCgUFmuvPbVrLjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7XhrutxkwThO2+UJhxIgzSXY5GjLjThZMNE16+NZSrhEbJnt992Tm+LvR0FE6DZjHodE9w5VR5+yub8M4Lghw1kQfsbHg8QXZwZsk12T4HiJHnv7m0AfuM3oTZt4S8mGPnDSsdhvGu1FOAgCbRc02QtXf+c8/g/LJdPFWw6c4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NwAS/XG2 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D012140E0288;
	Mon, 23 Dec 2024 07:59:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IM0pXPZd7px8; Mon, 23 Dec 2024 07:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734940795; bh=oLmiO6e1v7+WwnKur2gbXxPFrWqAvAvJYXOalhGYmh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwAS/XG2uaILqi2tnPoMceO1SFvcdwgB2eUP+lF0E3qtxPsrkKvNIAdwvcYOwYLbg
	 VvqRX9HbNopYUz0E8WqlR4+hwS4evjJxGuAOGasHGtlugkVJp9ywpiKC8EbDZ422zm
	 muU9ukFK3vu7hlaK35oICq0nKKtYMvBJQy2OPsR+mvKsFD61IL8Mw2MAlMJkEryItZ
	 Tzude+wGqe0Sw9wWIR9qCEh9iQ+cGYRJHeuycqd23zgYmnzkMpT5N1DW0p6NrAgCYf
	 olFh8rx2BkdY5or8KF6raR/v2Ni/IFGcDQKB5uSqrYJiXVWNpgp+jX4ZxJgjDbURJ4
	 cSrvSAzFi4ZxrvHZ1a2k5YfgSAP6AQYRPi9NLJBbrvSRcSIni8b7sSzt4BURfuxCE2
	 r4sJGrTU/6kz8jXjqNQu+e5JVOpZaEHuyoW5vdTmIKsc1KmSM8jxmKbimkXbQrlsIH
	 90+POUXhp51ZscIRGQuA125qI7jngipHuMx2xQIaDiLgkkm892NzJLWoWCASuUcIjP
	 t7xw06sq/JRCWhb65oG60xkW3rPq6o8p+BSEtePeDRS1FBXX3NANrTP8cZLWwcZ34D
	 4b4E4Fx232+BRVdx65v4LFgXYODS/oGKPtkkdO7V+2SrY5pMunLK7ADoymYz7xZnXg
	 ml+quzLMltF9PXnz4EArbLUs=
Received: from nazgul.tnic (2-228-221-6.ip193.fastwebnet.it [2.228.221.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C580D40E0286;
	Mon, 23 Dec 2024 07:58:32 +0000 (UTC)
Date: Mon, 23 Dec 2024 08:58:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Weikang Guo <guoweikang.kernel@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20241223075811.GAZ2kYEwZ93CYkatrD@fat_crate.local>
References: <20241222111537.2720303-1-guoweikang.kernel@gmail.com>
 <Z2kNTjO8hXzN66bX@kernel.org>
 <CAOm6qnkRUMnVGj7tnem822nRpJ8R6kFVf6B4W9MhMSBQY8X7Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOm6qnkRUMnVGj7tnem822nRpJ8R6kFVf6B4W9MhMSBQY8X7Kg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 03:32:01PM +0800, Weikang Guo wrote:
> First of all, thank you for your reminder and patience. In fact, this
> is the first time I received a patch discussion when submitting a
> patch.
> About Reviewed-by or Acked-by tags, I will not add it myself in the
> future. Regarding this patch, do I need to provide a new patch to
> update it? Or will you modify it?  Looking forward to your reply

It is all explained here:

https://kernel.org/doc/html/latest/process/development-process.html

Go read it while waiting instead of spamming everyone.

Lemme get your started on that reading:

"Don=E2=80=99t get discouraged - or impatient

After you have submitted your change, be patient and wait. Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without
comment, but the development process works more smoothly than that now.
You should receive comments within a few weeks (typically 2-3); if that
does not happen, make sure that you have sent your patches to the right
place. Wait for a minimum of one week before resubmitting or pinging
reviewers - possibly longer during busy times like merge windows."

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

