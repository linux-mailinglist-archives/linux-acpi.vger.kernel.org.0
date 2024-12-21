Return-Path: <linux-acpi+bounces-10245-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD569F9FF8
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 11:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8124D1888ADF
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79A51F0E4E;
	Sat, 21 Dec 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKFyDNzL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB511F0E2B;
	Sat, 21 Dec 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734775196; cv=none; b=OEd2PpHP5msXOCMFfXe0AlKxRpNnMFnOsY0K3wtv0jFkrlSL0TLXPxVrlCVn26DLGgwbKhVlDJK91KpKgb1ExKkt9FYKcWfO/EEMCA22FflWo+gOhCUOGtyh2cdfWNDX3brn+Y/HsuCo1Rf7pSv365BJwsJcoFnQzcW2o3KMZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734775196; c=relaxed/simple;
	bh=UX21hNvTWNwf1sQ6BEmkIlxoXTRStqcI03IcAjwyENI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmrsn9CJd7WmwfKsytBI3jOBAcMLr3z8+Q8mCPKINypVWg/N/w8QKqQxHONpeyER23uupokonh/5Wyt9xLuQxz79WjZ6NQZWgcDrrQM12Th3u8qFEeneyLoaDGvlP6qhRSApXj+J9Btr1Nc7be0LH2j+f3IoWT7Q4KdS6h/Pduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKFyDNzL; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so166053276.3;
        Sat, 21 Dec 2024 01:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734775194; x=1735379994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egHprya5wIN6bGofZtv4dfpbBXKQe0iUzhyvNvr/kt4=;
        b=JKFyDNzL3fu96ShiWdiDcfm9VOzfV+e8I6yOQaG22HmL26BafGDxqk7yP44zR0fsgt
         S6WB2Epo520+xNobEgnwDz26BDSz4arNyyWLRrQ5YzsfskbX456SqOYmifhEEmHUaZn3
         7x183vwVBMenpskOiD92bcYPswjEAs6vEoM4AkS1zcmHxzQbNU7iJD+dDMHxcmRSIoVS
         lRhknZAhUpRRLPZRPy4R7qFTxrK9HxfiIPR+P1IJCzXDfOJubTTM/UTvsWiW2D47g1rc
         0sRGnb2iJe0iFNMPFbWl10tAfXO/ADdnKZE25FVU3N2yKAq85OfA1gDBUai8CwNNFAgm
         GX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734775194; x=1735379994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egHprya5wIN6bGofZtv4dfpbBXKQe0iUzhyvNvr/kt4=;
        b=rhKh6uvZL1NwhEZtYk7B4HeDULXRvzpkGmLVTpkbiDthH5f8EPsPlFgFmizDiKz/0l
         gbAwMcV0UabE77z5JNLtu0J4ArCwlWQzUo5Hzgh/OjPlQL7+i6trKYT1maZ6Q+ugZtba
         0ylCnwC7XhM7Y62yBsBs+qx6JdgQW4qByHRJrwYXsZt16O2YoaGULfIz4kSLNxvDAkZM
         +g/lTCkEHvEcj8rCzaQLUeltJ3Ir7Txu4a2DAqyPffx7QJYMCC4Jb6VRWUUBPqynntfS
         JnZLYCXjqBg8HTsgZxg9qpEaJ7rivNcbsEouZl3YLLiNze9mvpaxTmGRNDXK/dbVbOHg
         A41A==
X-Forwarded-Encrypted: i=1; AJvYcCU9YwFYMq/89cVdZVc6t4Rg08ztZ8n1c8J96ZPxPJ91xotPNZoKXOg7tGyW06U7DlnBEFVrxVIG1CfbY6rhs6Q=@vger.kernel.org, AJvYcCUilOn5VK4XdQrLH6rpMljRPoGef0MgncCmhDuWbGnwe4pLon2qUZbSzYScRzS+95XTtzlz7pcWjM+qiY0=@vger.kernel.org, AJvYcCUtj9aRehurQY1qnyajKZw5O/vt+VwnvcPBplx43fbIUdMfwyFgWXf9AFGl0KaRy/wkErRFxNrgUN3qeA==@vger.kernel.org, AJvYcCVBEXraE5OLo0UhRA5CuPv9lwGGJVrH2RxDdFdToGBdkh3XMxvxz7GTKIpy/YwkH5TOVD5abPKCEQTFMO7u@vger.kernel.org, AJvYcCWN7MysRUurvskwgNIC3FUUQhrALqVC4crgVyvDLZYYByyvWvLL0F7NGmhQaaxWm8e7Kh3sJG+T33M3@vger.kernel.org, AJvYcCWpqHDHQUUjWWkgq2OkLCHQxmgXMq7PYQtKhPOjWLmpULMNHeAkBhHMKgNU17U893qUgnmhHX4CFSdOKPpR@vger.kernel.org, AJvYcCX3ls6tQ6VK32tA7jypajaRHy8pykfc2LKu+PxJ3UMugI/8VSgL8ygRufQPssDvxakYJBi1pTpTC9sYwA==@vger.kernel.org, AJvYcCXCYshp4Xznt5S74Ig5H2jV0suuAqP+jB1XzrKjVYYaTibX17Xyk7+ihgdxZSwyG8f6/bHpHc1V9BF/nA==@vger.kernel.org, AJvYcCXDpvsB8SWrd+I3he2DNvLxlAkLUNzdH4l/6yCxx6s0wwHDuqyA88nH62AcJtNeNH/OzR/hPzDZlA3dVw==@vger.kernel.org, AJvYcCXPbUdaWee7
 G82DkG57BUOuQXeoTHYeh9KJoUslz8nhkXR0+yUoZFemlUotM7HuWg75BHvXOl7q8FuY@vger.kernel.org, AJvYcCXPnqjWsR1N8+t63t9DJrBrW2V+AwDN2djfk7ZxeslienaLOYAyDVpUQM6JXFYzBuga74NGgjA5We4=@vger.kernel.org, AJvYcCXQcDqgHAj7/aa5uGb0oHT5qLkEVp8dHLc+SbWaqzSQKpYXekDWqAh+nfGA8U61KYaj0HpLwKVQ5Hg=@vger.kernel.org, AJvYcCXk8H2BeXpvIXVfh/Rm0Z5FG8NFVCHlRMZwttXyM//qwXoiZ9SYBg28yOc/fqBTVVS5ygNQVe9tv/vvUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzP0A3MhPd8dWTkC+MqohsI3On/Ktj8BK2197QwXl6A9zffpL
	tbGPvA3Z76TA0jJQqS9MpMhGMfirYwitPakbgpOuXRUiA1Rr12DCT6yr6l54DyHE944HST/oQ20
	2/sDuhQeL/sZcFUJ2S+C5A6hLm18=
X-Gm-Gg: ASbGncsMbJRQf6rMCocxjkCra1OxZjxCae9XecvfnNmngyNyYlGuhdyBEYBmGsApH1S
	YpLcFl/eU0JGHtMywaIERN9pX3+vnueDX/4sCW9U=
X-Google-Smtp-Source: AGHT+IG9hgHXPNsbBNiOuY+6OAJ+D2q82bPj4v1OfjOz7h337kMTVjsW2qLUpiuBZXc33tZc49lNKi5hOGaIXzFbkh0=
X-Received: by 2002:a05:690c:4b13:b0:6ef:7036:3b25 with SMTP id
 00721157ae682-6f3f8216b3cmr49229327b3.31.1734775193934; Sat, 21 Dec 2024
 01:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220092638.2611414-1-guoweikang.kernel@gmail.com> <20241220150623.278e8fa9f073b66dc81edfe6@linux-foundation.org>
In-Reply-To: <20241220150623.278e8fa9f073b66dc81edfe6@linux-foundation.org>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Sat, 21 Dec 2024 17:59:43 +0800
Message-ID: <CAOm6qnnFDjyiQvUmyVA4iq5aJAO8NC=wcAvpKscvfRZKPnzkYw@mail.gmail.com>
Subject: Re: [PATCH] mm/memblock: Add memblock_alloc_or_panic interface
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Sam Creasey <sammy@sammy.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>, rafael.j.wysocki@intel.com, 
	Palmer Dabbelt <palmer@rivosinc.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>, Johannes Berg <johannes.berg@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	Christian Brauner <brauner@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, WANG Xuerui <kernel@xen0n.name>, 
	Michael Ellerman <mpe@ellerman.id.au>, Jonas Bonn <jonas@southpole.se>, 
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
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Tero Kristo <kristo@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Pavel Machek <pavel@ucw.cz>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@linux-foundation.org> wrote on Saturday, 21
December 2024 07:06:
>
> On Fri, 20 Dec 2024 17:26:38 +0800 Guo Weikang <guoweikang.kernel@gmail.c=
om> wrote:
>
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
>
> Seems nice.
>
> > ...
> >
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -417,6 +417,19 @@ static __always_inline void *memblock_alloc(phys_a=
ddr_t size, phys_addr_t align)
> >                                     MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_=
NODE);
> >  }
> >
> > +static __always_inline void *memblock_alloc_or_panic(phys_addr_t size,=
 phys_addr_t align)
>
> We lost the printing of the function name, but it's easy to retain with
> something like
>
> #define memblock_alloc_or_panic(size, align)    \
>                 __memblock_alloc_or_panic(size, align, __func__)
>
You're absolutely right, this was an oversight on my part. I=E2=80=99ll mak=
e
sure to update it with the correct function name.
> > +{
> > +     void *addr =3D memblock_alloc(size, align);
> > +
> > +     if (unlikely(!addr))
> > +#ifdef CONFIG_PHYS_ADDR_T_64BIT
> > +             panic("%s: Failed to allocate %llu bytes\n", __func__, si=
ze);
>
> Won't this always print "memblock_alloc_or_panic: Failed ..."?  Not
> very useful.
>
As mentioned above.
> > +#else
> > +             panic("%s: Failed to allocate %u bytes\n", __func__, size=
);
> > +#endif
>
> We can avoid the ifdef with printk's "%pap"?
>
I appreciate you pointing this out. I wasn=E2=80=99t aware of this approach=
,
but it=E2=80=99s a great idea. It definitely simplifies things, and I=E2=80=
=99ve
learned something new in the process. I'll incorporate this into the
code.
> > +     return addr;
> > +}
>

