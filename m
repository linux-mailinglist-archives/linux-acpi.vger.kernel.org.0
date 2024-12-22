Return-Path: <linux-acpi+bounces-10262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC59FA417
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 06:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD62166D0E
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 05:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F24130A54;
	Sun, 22 Dec 2024 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="nZcUQW1T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E19DDBE;
	Sun, 22 Dec 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734846695; cv=none; b=kqBwP+X8V0AUHj14TbyQKXl+5tcv45h7onjmqyv1ILNdsv89HKj+l5pOnUSZRWydniCEa5g+YTM4YquPMcRRIyyHMfQL2gKn9mPpESVYmRMwMGF1isPCSD6zFzOorgZmIXEIXDkpX66WxPIkGurCzYtdai3QKFQcLRcUSYmeeZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734846695; c=relaxed/simple;
	bh=73Spy65y75EOyPTSc0iJv9YfbS1W2aMnBGueFT4LSeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OcNUsUnk5OzYdLwBXZYQ869ljN3l+rkRyQgOsNo0mmpU7BIKf53yktGTI/UNNRd9LDQpWkkWYGu4hAWCZkU951EnWTnaL7QUQNEhyV/33V150YeBYMGG1wcUHVXf+lJS777R9j49z2J3JNGRw2GKh4wsPSWTJXwgXix6tB9aZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=nZcUQW1T; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1734846684;
	bh=73Spy65y75EOyPTSc0iJv9YfbS1W2aMnBGueFT4LSeE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nZcUQW1TlcYe19vjpWVYF7BGYQbKeGDAvUbN+K0Gsvt9rhGMN7GsZfs/zdpj2lzl1
	 MbBsClXT3mJifINJ7gn7htQxIFD/roKSs0ciA+vaO6anVxMZbCRqy5Nv6Ocs9F+wxn
	 hZMWv9smlpVCNBPl3ehSuaSPQ+cU8zGg2WHY6b7I=
Received: from [192.168.124.9] (unknown [113.200.174.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 16E7F1A3FB1;
	Sun, 22 Dec 2024 00:51:09 -0500 (EST)
Message-ID: <02d042a6590ddb1fadb9f98d95de169c4683b9e7.camel@xry111.site>
Subject: Re: [PATCH v6] mm/memblock: Add memblock_alloc_or_panic interface
From: Xi Ruoyao <xry111@xry111.site>
To: Guo Weikang <guoweikang.kernel@gmail.com>, Andrew Morton
	 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph
 Lameter <cl@linux.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sam Creasey	 <sammy@sammy.net>, Huacai Chen <chenhuacai@kernel.org>, Will
 Deacon	 <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>, rafael.j.wysocki@intel.com,
 Palmer Dabbelt <palmer@rivosinc.com>,  Hanjun Guo <guohanjun@huawei.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, Johannes Berg	
 <johannes.berg@intel.com>, Ingo Molnar <mingo@kernel.org>, Dave Hansen	
 <dave.hansen@intel.com>, Christian Brauner <brauner@kernel.org>, KP Singh	
 <kpsingh@kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
 WANG Xuerui <kernel@xen0n.name>,  Michael Ellerman <mpe@ellerman.id.au>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne	
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
Date: Sun, 22 Dec 2024 13:51:08 +0800
In-Reply-To: <20241222054331.2705948-1-guoweikang.kernel@gmail.com>
References: <20241222054331.2705948-1-guoweikang.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-12-22 at 13:43 +0800, Guo Weikang wrote:
> Before SLUB initialization, various subsystems used memblock_alloc to
> allocate memory. In most cases, when memory allocation fails, an immediat=
e
> panic is required. To simplify this behavior and reduce repetitive checks=
,
> introduce `memblock_alloc_or_panic`. This function ensures that memory
> allocation failures result in a panic automatically, improving code
> readability and consistency across subsystems that require this behavior.
>=20
> Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> ---


Please try to avoid bumping the patch revision number so quickly.

And if you must do it, you should embed a ChangeLog of your patch (below
this "---" line) so people can know what has been changed.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

