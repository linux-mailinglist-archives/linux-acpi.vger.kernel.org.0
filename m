Return-Path: <linux-acpi+bounces-10267-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D620D9FA53A
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 11:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671717A212B
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5E188CC9;
	Sun, 22 Dec 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC0F6jJ3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC816FF4E;
	Sun, 22 Dec 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734862996; cv=none; b=qZkfCzLDWCOfQb/kuCmRW/HrLtuIdXnnYpK+/Jw2OwnLKlgUUIoB54flwYBFVFD0WN1METlKx+yQ5u+FABtXyceFvaYkQybVud5Zcr1KJpLTJb2ccEW8yKsCI0+wvElffYLlT3wPMwmOIMiRgQDxAenwlNeBnjjOBD4fyoGEJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734862996; c=relaxed/simple;
	bh=dEo66FcDI4p/fSRRaGCbLAsywaZZ62dxKOVN94rpPqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaVklAnmbhku5UH8YjbPmjvCFuxkFS/eYXJIfqKvkTsFCRZb7Wj6rCrcg6wlKih5qVUTkqNwqcv9KLqvB9vzmDI5erZaW73dqJ25PqWV3PAIN5iZx9xDYu8fqk5t4SHlJVc/VITutmY8HWM53LQaU3lvZH1oBg1YMD9tFnS3jTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC0F6jJ3; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef81222be7so29025937b3.3;
        Sun, 22 Dec 2024 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734862993; x=1735467793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ONVNbxYIwyadSLDvwLNaPGVW+13KFD/yyNlBVYXNzc=;
        b=GC0F6jJ3M3IAe0WzNCWgVzkuhlUbmV8JSBcGfh92DeWPjE2gNVg5PcNdCk5zI0xZAp
         U0I/Uuhndk6EdRhaQqX21r/o299XHojeWzUwAh3XVfxxsJ5Z5pgFhse5gDFo4beK+3bz
         f22Ug/6FIyZjayWQb9UaJpiXKayRBN4j9nM1uGrAvaCcP4Dv+/wrXsQSi2NR0+M6CdPw
         GizMQf9RpVgMCxidgverv61x2OXCwIWQSI8Ey36wvzND6hNtWHIDdjE/NxXHo0brmHC/
         SlNBaT/pCsUybT2JD2lyF2OjOre4h5V9YdIRaGikOpYnOqZhktOY9VzoZ0hhlBFmXWUh
         GRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734862993; x=1735467793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ONVNbxYIwyadSLDvwLNaPGVW+13KFD/yyNlBVYXNzc=;
        b=hb74LxWuxht6DNeUl8/PiVKKQjyOCCXmBZTCVcp/B1fnWStwX+J8oOUK1nE30gmB/G
         LXYRxQNGNjQkYjxQIDIhzPMJm5N72R287BJ9V3p0IXaz2uU5bQdFMc3bx59m3HHbSvS8
         MN/VYkaQ1sWmwwerqMvFPfwBTwcL+EsKHHJy621yZOSmRroTgmwwjWqJ9frR39Lmp2ni
         o2092AHYmj1OLwpgH+FiCHilx3s17c84OVQkopH/antqRQ1tYk3DQyuwt6dSVeVI6H8/
         cKfAPmeu2p3VEszem/MRocU23em6Sl0q2R2rJV9pivLe81M2Jq4sPK2+WN9epu7wzO8x
         qWYA==
X-Forwarded-Encrypted: i=1; AJvYcCU52zU5eGJph97yW+oIx0eJX2xlhSGYRERxmUDdzZcmlkM3hvrbCDlMva4hdvbofj/pCbSmvh6qxYg=@vger.kernel.org, AJvYcCUGsSxLqGdxSSR4q4sVFOjaWsdpjkt599D58N9VwPCX1sjvCs7mLsPSmydPW41P/rc9x+9Qxxyy0RZwE68rxzs=@vger.kernel.org, AJvYcCUInUsqxovThE5xH2qHnYR71ys5BbIlKZWutbTjBWDJeqcJ80ZcJkOSga+Uig3DRkqMHHFIGOdvV5ZITms=@vger.kernel.org, AJvYcCV1MSriMlF9TR0/GzsxqlRvW7Z4lEF25wjwV0CX0kEv4Z4tDv6iLPn5GBK6L+m3e8StoFtxf28IDnw=@vger.kernel.org, AJvYcCV77Nkfl0iJhfAKN4DjRkvQRBMhFguu2wSKir/Y2Wz9UMthk7WxnG1SGZAQ2e4vzgAp3A1lB+R6EFsLORMY@vger.kernel.org, AJvYcCVMrvcq6WLyEmFDJCStw5cFIF/9qnorfmFm1m1A3J9n3r9og/2n4Oy5baxGSZ0v309Nl805KIEstVJnzA==@vger.kernel.org, AJvYcCVNZvNxFpa5LL7Hqi+JfUN0dvMFsDj0VkI/8Gi7nLx6wqgZ918ZXBRuIY160p6DyNbnuAmlnDnR/h32qA==@vger.kernel.org, AJvYcCVbRhZTBQtkaWg98I/Jco0zdOMS3SM8UQEu7SXfPxUiDFtQ84VvxerNEARRSY5Fm5J8BGAk/MmcSfzJMg==@vger.kernel.org, AJvYcCVyzhwHh26a34O0mM+ESdHdk16SbJjXwcxsjBGUDdpOpO8kOqBXAm4Ln+nwOYhWAG9jXqnQ0fsiGCiZ@vger.kernel.org, AJvYcCWKUh6ja2W8L9fVH/Ew
 y7IVSGsN8BHBgafZrqXIS7oPLNB1qYfbV6F0ouyna+KiRgXzp3E54ZV2ad8vsw==@vger.kernel.org, AJvYcCWzmCQoPYpLUdujGCokWFYX/lnbqQfrZid/YfkVUosk5qnp2Ph3FPIVMXKWzqluToIfwEQ7qy2Ny2snjQ==@vger.kernel.org, AJvYcCXgEeJhlKIhzhsdnfkPqRwqvsJQLA65WLQuAjz7xliEMAy0WGuWG+J+Way3QFF+aPYq7YeTZOG8eUPl5Kab@vger.kernel.org, AJvYcCXpCE2ymZ4sQqvloZW3mbN11Isjt0bVgnNfN1tittrFisu7N26xciaYaHBX5lKWnUXW14URvhPoc7QN@vger.kernel.org
X-Gm-Message-State: AOJu0YzGto3ioYXp7qlv99mFq5w0ywAFm8wfeZMDhsNqAztWUE4eVnca
	1QL2D8lFmEXR94XFzPsahig2UAN6D0Zbf2phlwXPiK/K/V1+b12NTDuTtb7VEU7RFryV5Jpu5yJ
	jrF9WET/eReVjytYB/LW0dPdCwlE=
X-Gm-Gg: ASbGncsFlKM9BPfoM2VnvzPfGThQ3firgSFdYXUMtjR3kYay4dU6XxEEmqCbnSrHJtc
	LDU/veT6iLOePvgTfYK1UnD/ttsQ77/SVL6qalQo=
X-Google-Smtp-Source: AGHT+IHX0mjmsoNFu7Nk/P1ylkLtsHAmn22nfKbaHPnh1Btm1p2RULi24EAOG9MYK2JmawFo9lS/pEKQIPK2LOk3TLc=
X-Received: by 2002:a05:690c:360c:b0:6f2:9704:405c with SMTP id
 00721157ae682-6f3f8125edfmr74773997b3.15.1734862992817; Sun, 22 Dec 2024
 02:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222054331.2705948-1-guoweikang.kernel@gmail.com> <Z2fknmnNtiZbCc7x@kernel.org>
In-Reply-To: <Z2fknmnNtiZbCc7x@kernel.org>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Sun, 22 Dec 2024 18:23:02 +0800
Message-ID: <CAOm6qn=L0GzX4z4Mak1LH6R4wD282dz6qafMFmA39ADaBuLJJQ@mail.gmail.com>
Subject: Re: [PATCH v6] mm/memblock: Add memblock_alloc_or_panic interface
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Sam Creasey <sammy@sammy.net>, 
	Huacai Chen <chenhuacai@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	rafael.j.wysocki@intel.com, Palmer Dabbelt <palmer@rivosinc.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Easwar Hariharan <eahariha@linux.microsoft.com>, 
	Johannes Berg <johannes.berg@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Christian Brauner <brauner@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Geoff Levand <geoff@infradead.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Mike Rapoport <rppt@kernel.org> wrote on Sunday, 22 December 2024 18:06
>
> On Sun, Dec 22, 2024 at 01:43:31PM +0800, Guo Weikang wrote:
> > Before SLUB initialization, various subsystems used memblock_alloc to
> > allocate memory. In most cases, when memory allocation fails, an immediate
> > panic is required. To simplify this behavior and reduce repetitive checks,
> > introduce `memblock_alloc_or_panic`. This function ensures that memory
> > allocation failures result in a panic automatically, improving code
> > readability and consistency across subsystems that require this behavior.
> >
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> > ---
>
> ...
>
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 673d5cae7c81..73af7ca3fa1c 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -417,6 +417,12 @@ static __always_inline void *memblock_alloc(phys_addr_t size, phys_addr_t align)
> >                                     MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE);
> >  }
> >
> > +void *__memblock_alloc_or_panic(phys_addr_t size, phys_addr_t align,
> > +                                    const char *func);
>
> Please align this line with the first parameter to the function.
> Other than that
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>

Got it!  Thanks for the feedback!

> > +
> > +#define memblock_alloc_or_panic(size, align)    \
> > +      __memblock_alloc_or_panic(size, align, __func__)
> > +
> >  static inline void *memblock_alloc_raw(phys_addr_t size,
> >                                              phys_addr_t align)
> >  {
>
>
> --
> Sincerely yours,
> Mike.

Best regards.
Guo

