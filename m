Return-Path: <linux-acpi+bounces-10258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D39FA325
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 01:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82FA188B22D
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 00:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB9C4A1A;
	Sun, 22 Dec 2024 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjhtN6Ln"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5F1854;
	Sun, 22 Dec 2024 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734828747; cv=none; b=CsIKqhynanBcSDgocXXWD5omDbd4GDkvwJutwhyqKZeM7GibbR7KYkazkuqAtXnX3fzgV8aJOooNyDOJNqKKUsCKuPh4urinYyXEueSJ6Twhxh3mRn51Q3KoXD9G5mwHd7lsfHoWxLIPYLDAaW+BgGh/AF3j62n6sdwQTixldeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734828747; c=relaxed/simple;
	bh=Lwv+95ot2twUX6GsOV+1rAqhwnRBzkh6SEQLcu7rgjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcFmSGUb/24nLXjLwQ0qXnXTMu3J67o+NWeokHvVmhv0NYTMbdNBEPPHF1Pw+2m97UjUOebMNuXmDLEgf98EOKnO/IKSZmzfdgJN0Vrl6+u7TpJEK0GemTioT7ivA0/GebrIPW1N3C8EiKGC81yGqlUvZaPZlIW8O12OxLwucZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjhtN6Ln; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f2c8aea797so24963377b3.1;
        Sat, 21 Dec 2024 16:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734828744; x=1735433544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G56dFj5BRaIttSoRxhRi+K83W3sP81bwdAaZ6QoaIrc=;
        b=VjhtN6Lnq/b5eUHhbxrAlUyqLeDNSkb1rLqw0Mmq/DxufZDAp8MxvvEFxG+3zAcpSo
         dCzocuDfMr97+DA4APKECYQu5Y3e646hQ1yKwc9CPObBRVxDIWBdW0ubqOsIGl9DIPfC
         Mue4ee7f0+2aQGmuAeE0BTfbKQuD4Nu0wXBueFNeDaPCS91VaqvvlHwfA/57+2LmxYsk
         RMrXGDJqDTdsp7foaMxJUZqXx61mN6HiP0i1XNBsYl5fdq7pJezBmbWyacC16QnZuc+s
         zO1VSTKmBWTeqhsGfssI+pDEkmYsic7JsV2YyuhjmixtIbMeJzPveUHZwdi5/bVG+C6B
         7hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734828744; x=1735433544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G56dFj5BRaIttSoRxhRi+K83W3sP81bwdAaZ6QoaIrc=;
        b=BtRzjPDNsh9uVptfyswBW9KNADDkT18bFzGqRgSP/wNlbZ7M3j49VPsCO3KjGvPTm4
         Y+JeSfrdL7omfrJUy882n/xf4CGecT4T/QFAzmW9ECn2B3EVCoqy0wPyWmeIUAajvvta
         VXRAVAqLRAzzFhAQLCJuUp4yE6Ce+MlqrTDEJOlzNFYT3Ow+CFOwj75SKHq/BG991Ff6
         PebZ+ezqPYEyX3Dd/NeMAh811r3zgxEgYPcabmdkEj2yT0/Ev5hLdNEYADFOZzJEyGG6
         ShpqEqDlYkwcS3riO9T/EniyR2fDZGBbp07geVCXjR4t7d30hkrAMBPyfSpbj+GNi7DL
         SmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT/h1J7NHBvtpBl62RdbisEE9LC937abaMU4Ps+nnNIjLr1PsAOPKrahG05JXH6lwXvLOtpp8NlZk=@vger.kernel.org, AJvYcCUmaEeOFasPm2LaeRQXUsX+ODFFpe9XkFzqPiTCuDaNcBO3gEc8N7Y44jBuULoCJg0an2qZwJi9wJeo@vger.kernel.org, AJvYcCUz6i49DgS/sw0XTg14Br9qCW55fvJhhS+7XjxgGTFQTCM40aPOja8P/4BcYtbBWyRsE729djRibrFB8g==@vger.kernel.org, AJvYcCW/vYFnIclr0YTxdixHF7nhY+Rbnxly7q8YWaANHj+AbGyE7xmDZhgiAcctMLczDN8/nILC+5dP02yHVFCW@vger.kernel.org, AJvYcCW4JJWRGzn6cMshFvUHT+pS7cFpD6i1y5m/Cta7OS1omFW2FLh6nDo+x+Co6PGOYNo3NDJhFgPMvoMf59eEdsU=@vger.kernel.org, AJvYcCWHkGBTPd0QM8JRKJTFKdduFMzHc9Qa6U6/s/6109C/+JP+uGEcL0y+wxrlTHnVhT4ivVh/LEpCZTFG@vger.kernel.org, AJvYcCWaTlcolB0Bi+b8gUuLQWvhQEG5MTHOxOuTbdCYQWlvXqFIwLbA8QoC0D3v6aDqS/nvwtfcmFbNeIK/tBY8@vger.kernel.org, AJvYcCWyf5v18KtaCukhYhVMfydZg7Y1lZNi7QJ7YVQxhZajGO2sjWqjZssGA/RjPNSsFx75clV+n18kloQ=@vger.kernel.org, AJvYcCWzHaQwDZeQ9L4dOZKAqRRs3l4EED80r2ao3DFKM1uGxSRmOUwBrGqHhFUb8rgNdzFbN29PIRlk38dmAw==@vger.kernel.org, AJvYcCX+1THZNZ3p0QG4HqTUB/Ig
 JzhTAOXxdIqlRammgikTSfl3yOjqleORnwLfjK3cHCfQSwqOEL/+HA6G1Q==@vger.kernel.org, AJvYcCXa31wyMV+5+YOaSnPsdBJeFF8QEUs+tpOJLjMkouYeMDxVbmin8CALb9UNKnb1+vkvoqTzlW4PsRrtn0M=@vger.kernel.org, AJvYcCXg7EKIhe7F/H7Z5Wp0zd3i4uMgDBy3u0tXxd73EqEQVeeDmh229I2AvzjCyOYYwhnt4Muq3Fcwf5ba9Q==@vger.kernel.org, AJvYcCXmkyHrkeowEB2H/9Xgr3/AwkB1KJKB1xXNKFLW0u8N+ORU4CBvJJhEDymmcZwBXic/fgry1YQcfGgbag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNSvkn64ncZxlTFV7M4vUj/3q5JY3nh+e2Wlp+3JOIeIvD5R5s
	O6N7lo2uUQYmXerF1gSWscnr+mIupp60DkJ1fFaNTJjP1QHVGRaD8wJEFQ7bi7ec7N8noZX4SIo
	dWQVyrX7BtMiA4ttQ6ENbyp17rJc=
X-Gm-Gg: ASbGncudvlwzbf6/dUj9SGQHM7Zbf0pmYNLJR0EATPOVBFQFJvyk4TiCm63tSZxioOS
	eDO1106OS96H5zQS4KUwFMSz4Zw5CKvrgwdRN4ko=
X-Google-Smtp-Source: AGHT+IHH5gTAOmFubOYjlrK+2+jdIvePBlyZPYVyBZBy90RljxEGCQgcvHQMo3bTypvAoytVk58QJl8i95oeqQUdh1w=
X-Received: by 2002:a05:690c:4e82:b0:6f0:21d6:4497 with SMTP id
 00721157ae682-6f3f80d911amr42730727b3.9.1734828744363; Sat, 21 Dec 2024
 16:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221104304.2655909-1-guoweikang.kernel@gmail.com> <CAMuHMdXbB-ksxZ9+YRz86wazPGSM09ZFX7JZoyH--=UDndS=TQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXbB-ksxZ9+YRz86wazPGSM09ZFX7JZoyH--=UDndS=TQ@mail.gmail.com>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Sun, 22 Dec 2024 08:52:14 +0800
Message-ID: <CAOm6qn=aN_n3jRc79wr-AGVaQXCbZoyE0yXYcZfw28-uBv+zuQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memblock: Add memblock_alloc_or_panic interface
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
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
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert@linux-m68k.org> wrote on Saturday, 21
December 2024 at 22:10
>
> Hi Guo,
>
> On Sat, Dec 21, 2024 at 11:43=E2=80=AFAM Guo Weikang
> <guoweikang.kernel@gmail.com> wrote:
> > Before SLUB initialization, various subsystems used memblock_alloc to
> > allocate memory. In most cases, when memory allocation fails, an immedi=
ate
> > panic is required. To simplify this behavior and reduce repetitive chec=
ks,
> > introduce `memblock_alloc_or_panic`. This function ensures that memory
> > allocation failures result in a panic automatically, improving code
> > readability and consistency across subsystems that require this behavio=
r.
> >
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
>
> Thanks for your patch!
>
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -417,6 +417,20 @@ static __always_inline void *memblock_alloc(phys_a=
ddr_t size, phys_addr_t align)
> >                                       MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_N=
O_NODE);
> >  }
> >
> > +static __always_inline void *__memblock_alloc_or_panic(phys_addr_t siz=
e,
> > +                                                      phys_addr_t alig=
n,
> > +                                                      const char *func=
)
> > +{
> > +       void *addr =3D memblock_alloc(size, align);
> > +
> > +       if (unlikely(!addr))
> > +               panic("%s: Failed to allocate %llu bytes\n", func, size=
);
> > +       return addr;
> > +}
>
> Please make this out-of-line, and move it to mm/memblock.c, so we have
> just a single copy in the final binary.
>
Got it, I'll make the change
> > +
> > +#define memblock_alloc_or_panic(size, align)    \
> > +        __memblock_alloc_or_panic(size, align, __func__)
> > +
> >  static inline void *memblock_alloc_raw(phys_addr_t size,
> >                                                phys_addr_t align)
> >  {
> > diff --git a/init/main.c b/init/main.c
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

Best regards
             Guo

