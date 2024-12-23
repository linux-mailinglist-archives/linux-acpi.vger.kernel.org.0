Return-Path: <linux-acpi+bounces-10277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E79FAB22
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 08:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3881885E34
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0123190054;
	Mon, 23 Dec 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP22g1SQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5017E473;
	Mon, 23 Dec 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734939134; cv=none; b=C3V1k0A54CTuiXsy3u8WkQrmNkb1ykfYjGXJtl+HDn2/GdrE5A30fgDwWe7CGhUspIvIBFIQedte4VFH/k13RW6gDIWo6rGuiPCZSd3wOQ8ycGJbH6bTN+4ArldYqnpwFch7WREEz2wh8u1L9FI3M1KikugwuR9ksQiGEsg/Myo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734939134; c=relaxed/simple;
	bh=OHoKVoEfq+gvl63nyXxm0Fs3Th2pjhxHONc5vMgjP0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeWFbkF6OBjvE4Wwm5drn7OEGmbID8CvsmVYPOa9LKe/TCGqDN5ACEqAVhyNhO72LPHVgW7fQiwpRRf8xcF7ouu7iF3AymDaplextW3pVbIi3yjKR9pFhXPdownxC0/MBWtFwFjiEuELvLONl+2xLc/5b0mkr0tNz8WaLKFz0WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP22g1SQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6eff4f0d627so33673057b3.1;
        Sun, 22 Dec 2024 23:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734939132; x=1735543932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0v6aG1YFkKVxPZgrKFkppCnD7setaclMAdKcShBz7Ms=;
        b=BP22g1SQZbY9i1od9T1kbvclOQnH3UsBl9Mka2uHPJPhZs7CGx7onXRvo88+2mgqNW
         g3K3qwzYPZKbVJaDCQOjTCeD5ldUP+p+eAknIbqtARokWH6vsYF1vX/C8s922zGNViBO
         py1wDEqnHzNuHxuuTcyCCGscnoLR1ZwpoiWbfUdTTWt2Tw2x/06i9iWDoNqpEZ6qnfrT
         DmRyhhJr89bPZKMhIfLRJwrtDJ2pFmMbJCIWov4OK0emlTuDCOlt4MycWH47ICOHLNKX
         Ps/Bra3ALoIPlLWex5UzdG5yBMZ/4aJ7Rz7A+VehvZtjfa++2zUjc6f42eab+eMeumIk
         hJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734939132; x=1735543932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0v6aG1YFkKVxPZgrKFkppCnD7setaclMAdKcShBz7Ms=;
        b=X9Y1Z9Qi2cTcN2++HNHF0ZNFZRFV+qiM2xtBgqJxSr/ARtq9PkzqjCaYWsGlUJvtJx
         2uhLwMyGxP/Wb3eVZuE+CZsh1u4YLudAQ5wiQDRVSS7mOGHZ0NEdOr3AQtzcRoeNQ1qG
         +SGqWT/gSyUOEUhH8JxF+dZiaEA9e33pcmujqjJhCYVjfr8N/lF1f6BF+MUua/iiskYA
         RGSitURlTZAZ2GNVxrEke+ddBzw9DpBxdsrcODimznDOlBtTkW13+awkOG6C34oVblF9
         33GvZpu8A2Y+N+MQkUfe7uWnuxR/fwkUCpE0Pox0iVePxiQ1E5AHhS8fWMVFniCxoXQi
         vjhg==
X-Forwarded-Encrypted: i=1; AJvYcCU0gUzov8039tC6llGwkPckrSz06aWG4/zzZw86VUQfcVuv1pqCcq9hD7nVq/p3HfJM48ykseCBzbs=@vger.kernel.org, AJvYcCU9tax9EQ4iLlAr9lKPq1cP+yOz/KyCuERxxC95zQSTgIipdCsXuLVExUN5gNHviutdNScQnOqFO9yjnA==@vger.kernel.org, AJvYcCUMG8ACjtWY4lA5mmFuoMm4VQT2qeBPkAEg3wzqrISO7WcUiY0bH70fyg493Ctt81n+19oKNVlE/wBA30Y=@vger.kernel.org, AJvYcCUcxdMRlqWc2gWBG3WEnuCPsccHiIM9DV6NsanKb14I8uiBOr6p51PBjSibpAigPquhjy3/XgAwq4N2@vger.kernel.org, AJvYcCUvBZYEufWrncCeJuGQfXDFluLbMWLHn+RL5hsy8QZ++W4q4smrcsSCYtVJLTGuEUEpVaSILZ4WEhS4Deam@vger.kernel.org, AJvYcCV/S3DFRNc1G+aRSYwLd+PAkGMyjFFTzleUHRIL+iBBHakVQkajRXWdR6+Hg+KZw7/QbiP32QIFeafq/ufS@vger.kernel.org, AJvYcCVEDGcRO4DcpIBIEx3SmHK85Ba6wEPx3qZ9GOA/wLAGW//feGj/8+HCjS/fw2Zn07LBt9AahsDA9mPs/A==@vger.kernel.org, AJvYcCVaUsfHj5FAAtSoQBJn9a1xHrHIJQHI3+nIf81n8cd8bfkI3hJHGZEsjtBMMdIrRIR6OolgtQwwhSaPvg==@vger.kernel.org, AJvYcCW+R5duvAk+mkTVcOrqZpUb3Uige0W6XK1JP7QCZCcCfAaBma/wNrFAPzB6w1OSpXiTg4AXKoep9N+ARanUK5I=@vger.kernel.org, AJvYcCWAwlzq3LM0ioyt
 EJvWoPV6vjsTUq7z7Veu2ljWFluOvVB3++Zz0tl+RLTpCWLUX+VbK3zl5QOx4AgiUg==@vger.kernel.org, AJvYcCWWci2QX4PvBsf06e9b3Ye5s51Ag352ZAzWVjQDBE9/mxeHRY6eabit0/zt/wVDZLyjT4hJW2my6MIcqw==@vger.kernel.org, AJvYcCWbpyJGeKVUulH5t6cRXti41VJ9KoFhzPhpC5Q9E0Z9+w0UlSC/GAqdDsxy72zrtVtnHKRyzRZsCfY7@vger.kernel.org, AJvYcCX9EbXXRiQiS/vjgsdbFXU4yFWqtugccQr+YIuZyYMX14H+aCkouFTyvKt4j6fsWaCcIwBRe0qbVsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEY7S8Xm9nhlPmnKYmk1GVw/obRqTr8r/eKAcFAURue957d6kE
	yltRt9EEOWedqFFY03TnSBC5gLGogI/Lho60KN0V4uWTj58O2biA+uVj0phlDIEhk6I/OondMDk
	vp7gze5RB7Q7oTaFipK+noaMTx3A=
X-Gm-Gg: ASbGncsRWRfUa+x3zY+Iez1jWv6JqvDfSlFJA+xH+ux2OmITjlrNwiMb23B6ZPrVH9b
	z+DCfU8Tuou3JiZPQS5g9jfpkS6E6tpYAqes4NHM=
X-Google-Smtp-Source: AGHT+IE9Zx6rrSxmo/TfVMJEMfCSEvv5kTOAJj2WU/ZWv6yREWR2EgA4NDWJv08ZAUMMHtBOTiCxaj5H+lZ0CIJRFqw=
X-Received: by 2002:a05:690c:6e0c:b0:6ef:6b56:fb46 with SMTP id
 00721157ae682-6f3f824cb08mr87351047b3.40.1734939131915; Sun, 22 Dec 2024
 23:32:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222111537.2720303-1-guoweikang.kernel@gmail.com> <Z2kNTjO8hXzN66bX@kernel.org>
In-Reply-To: <Z2kNTjO8hXzN66bX@kernel.org>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Mon, 23 Dec 2024 15:32:01 +0800
Message-ID: <CAOm6qnkRUMnVGj7tnem822nRpJ8R6kFVf6B4W9MhMSBQY8X7Kg@mail.gmail.com>
Subject: Re: [PATCH v7] mm/memblock: Add memblock_alloc_or_panic interface
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
	devicetree@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

Mike Rapoport <rppt@kernel.org> wrote on Monday 23 December 2024 at 15:12
>
> On Sun, Dec 22, 2024 at 07:15:37PM +0800, Guo Weikang wrote:
> > Before SLUB initialization, various subsystems used memblock_alloc to
> > allocate memory. In most cases, when memory allocation fails, an immediate
> > panic is required. To simplify this behavior and reduce repetitive checks,
> > introduce `memblock_alloc_or_panic`. This function ensures that memory
> > allocation failures result in a panic automatically, improving code
> > readability and consistency across subsystems that require this behavior.
> >
> > Changelog:
> > ----------
> > v1: initial version
> > v2: add __memblock_alloc_or_panic support panic output caller
> > v3: panic output phys_addr_t use printk's %pap
> > v4: make __memblock_alloc_or_panic out-of-line, move to memblock.c
> > v6: Fix CI compile error
> > Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221000.r1NzXJUO-lkp@intel.com/
> > v6: Fix CI compile warinigs
> > Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221259.JuGNAUCq-lkp@intel.com/
> > v7: add chagelog and adjust function declaration alignment format
> > ----------
> >
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Acked-by: Xi Ruoyao <xry111@xry111.site>
>
> If people commented on your patch it does not mean you should add
> Reviewed-by or Acked-by tags for them. Wait for explicit tags from the
> reviewers.

First of all, thank you for your reminder and patience. In fact, this
is the first time I received a patch discussion when submitting a
patch.
About Reviewed-by or Acked-by tags, I will not add it myself in the
future. Regarding this patch, do I need to provide a new patch to
update it? Or will you modify it?  Looking forward to your reply

>
> And don't respin that often, "Reviewers are busy people and may not get to
> your patch right away" [1].
>

OK, I will be more patient and update after confirming that there are
no more comments.

> [1] https://docs.kernel.org/process/submitting-patches.html
>
>
> --
> Sincerely yours,
> Mike.


--
Best regards,
Guo

