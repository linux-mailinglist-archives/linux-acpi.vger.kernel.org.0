Return-Path: <linux-acpi+bounces-10263-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6B9FA437
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 07:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAC4188963E
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 06:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E19153800;
	Sun, 22 Dec 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBGRRdBu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28D0224FA;
	Sun, 22 Dec 2024 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734847641; cv=none; b=RH1ZA4jcL35mDeLrODBI96aHzsKVOMQrk2up52x7bvl2abzeKV483hV1gYRul5L4sQ13H/s/cTlm+crdd9yaneNByGMqktJYI+c4xbioYfuflsJlDjdsRaKLx5H1adZtZVP30CqGiiy2G5vSD1yp+9fdkRDB0FCTswXLq1m1Olg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734847641; c=relaxed/simple;
	bh=ZI7mtoNdl+3R+xCvx6C6G12E13skabgOFMAvirAjF+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blWHpgKaDL3HwuGj+qXmB48ePz/9NL6gMqWyW8FxyfujIZmY3EGyGAcjpXp7unGXjvoIL4Lp/BpnLwF33d2GjVHhJQFBtc0fhNQvzBFjlhvNuYPByDl3wXwmM97NPraH2lKxubjsZWsF+FjyWGgXKnhiDXTWrXBG6X9wI6JO7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBGRRdBu; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3fd6cd9ef7so3434396276.1;
        Sat, 21 Dec 2024 22:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734847639; x=1735452439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=htlpToW+3tDMXYk9LHSjN7kEjprwT0u1X/m/1Vl/oro=;
        b=QBGRRdBuOr5GMZySiiLbNqypnvhh/Yx6dizJLtITvOav1Gx0J+VId0P26jpk03yBTS
         99zppBa/1orI36oLn1Ve+eWvcJfDTMNpTMVnhdDUYidLCvHn7KsJ8ytX31syQ39xntET
         4iQuIEpK2hNP86UgYCjbUzq9+c3L2cAAwYs9lK0y1Fdhvy/MBQzosCTQGHvhSkHt+MyU
         W94bql7ATY+IFwwxzLTnYrIo6SQjgdMypcUuegXI6akCUtq3NvBW7Q9hKmWc/Kde6T0P
         eWb3gSAIA/PQlwgH3OLKx3+7M/03bycnuXm+/4fIGBID+WGzN7v7OUy46BqXWzenArjn
         rKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734847639; x=1735452439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htlpToW+3tDMXYk9LHSjN7kEjprwT0u1X/m/1Vl/oro=;
        b=JAJNkW5NJ4LVrqcCCCdIX0c+wwZ97jZxJM4lFQKf9RCfhT7LsG1agHxnJY3NIqKbZB
         Ux29rMVivN19hny42u3ysSZPVKuG/2aTePrWpu6GKCMxtAIRIBbIcz7rDptgxIWTp64H
         RsRJuiv/f+Glo+xc5pgKmQlcMwgU2P5o1tIaMy/OyJ0fELPg1cz0U0phs4IHpGs05aYM
         lz2oY+WcsAFfTNw3XgiJYLeObYZxs01aNDwIpJnFK20OtjmS9B6w9++M0GfO9QdpQoUw
         /AIpjJrMqOxd5xo3jS1kn2+VDgosNQSdTqpFK2gjORaG8ze6DUsiPqG4WfOV0oRMkka4
         /JCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+imrt3MmdCz/fooXLswRnu65ed8BLg3ZNxuEdgn/c8NK0A1ip+U6vEnPdv563s6zmB9anCFPvsWNfQA4M@vger.kernel.org, AJvYcCU82v7t5podpR8V2mEC7UU3b58G0QFI0ozLVvC0xQbUBP+UJVOohkUmxPy3tGVA30bQXAZ6HrLEnq4MMQ==@vger.kernel.org, AJvYcCUA3YBVro9rVx5l7yEaHVXqXCrGoGkLiKxUeiug4hwUatGUOrU3kL03UdwVM5+YVNstC81cScuTGn7h3Q==@vger.kernel.org, AJvYcCV4AheVfLYMaq0Uc+uoUGjnWxiU46pOUWUn8/FCwEwae07IbUwtC4tQ8nyUwmnB/AkZY/yTisy97HEk@vger.kernel.org, AJvYcCVBZf+XPmpSVW5om9bvAtMRg0jewZoPNJaae4NDwXvitqZ3qE768cajzIyHj4QltHPf15/Fo7UJh2gCtw==@vger.kernel.org, AJvYcCVCE3eEDuaN/UMO/Zb/y0P/vzsXeRoBHXCbFDoHA1wB+cLQ0ESn2zA+nJn1jbDkgxzhZX9I6ZOmVtri0p0m@vger.kernel.org, AJvYcCVUvsQ1pFYF3T2OcmIHFgsx2ZAx3QL96X+4xqgWUIoA9KPoWGJXRW2RVyg+Yr9lPIvGk2iJKGWAGNw6mw==@vger.kernel.org, AJvYcCVXk9ksaS9HPImXgVqm1udtJHi4C+pu+voPnopNnSS6wzqhZrQottwpXcrGtilrayrcbgbb7ivstqOO6VGirt8=@vger.kernel.org, AJvYcCVhRCnjcfmArWxdhRzF11YkOUQtWkOsAW0C2zK7oaf3G39X9cxtMHvnUvOql4YRwI4FBgYq0dtj8mE=@vger.kernel.org, AJvYcCWdPWJhwF7ytF/y
 PM/dvh7EYDsUMzC4oor+qXhQGfC/HuNYT4/dxztNtvWqrHctzs32lyOMtColJdj0Fg==@vger.kernel.org, AJvYcCWwDdeMvcNp9XrX6NdAuERUZRsuhzXFQewmd2y7EAOCAz0eBcV2tro+mrBjgoBpzVrjo81C74oVw3o=@vger.kernel.org, AJvYcCXBvAqbWcYP3mdqsThOp01RC1i1I7ztNGZ9YUNmBZY/sFmLwJtI6qJl9ro/r+RFlf0rV8nPpNOP+uGU@vger.kernel.org, AJvYcCXL0h4BXhpqHTCEJHPTcUUk1wmvLCcbvC1z0zRTqjsjPPjVf6eAPoTt5pq1yKuFslaR/Vod+bhmwr1wVF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwstGfBq3ffKbylcLgM5DKQ/Hfv1gabGh4ciss8XkY1glVQ3r8r
	sW0vLJs9vd11vrYMwjOBua1T0RXoKN7v3nViKPjsSkJZZURqAYQ1wFAM84T/+ge7wlvWNpAO3te
	z5r7V1xuPIy6P9OiM9+OsE8QlSS4=
X-Gm-Gg: ASbGncuCpW1mLvDu0I3nJuopxRxpCejhg1+8GTQk7TESot0oCztr6Wrr2wHmfUn8b3V
	LR7W/EQ3zMmoIdNjYPreBe+wo2XXX8hqvc9NEYDI=
X-Google-Smtp-Source: AGHT+IHTObibTWvFBx2RCqB+bk/1ZpT+xydtv33cOquvAas7ggMPQiaYSrqKqDsv5/UZU90VEPoAsSH6qDx1lw2KYn4=
X-Received: by 2002:a05:690c:6908:b0:664:74cd:5548 with SMTP id
 00721157ae682-6f3e2a65668mr105552167b3.1.1734847638651; Sat, 21 Dec 2024
 22:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222054331.2705948-1-guoweikang.kernel@gmail.com> <02d042a6590ddb1fadb9f98d95de169c4683b9e7.camel@xry111.site>
In-Reply-To: <02d042a6590ddb1fadb9f98d95de169c4683b9e7.camel@xry111.site>
From: Weikang Guo <guoweikang.kernel@gmail.com>
Date: Sun, 22 Dec 2024 14:07:09 +0800
Message-ID: <CAOm6qnk0KYJXuCLU=7Y10wjMjWnUQ+n_RDsJZv5rAqBmq9bkug@mail.gmail.com>
Subject: Re: [PATCH v6] mm/memblock: Add memblock_alloc_or_panic interface
To: Xi Ruoyao <xry111@xry111.site>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Sam Creasey <sammy@sammy.net>, 
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

Xi Ruoyao <xry111@xry111.site> wrote on Sunday, 22 December 2024 13:51:
>
> On Sun, 2024-12-22 at 13:43 +0800, Guo Weikang wrote:
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
>
> Please try to avoid bumping the patch revision number so quickly.
>
you are right,  I'll pay more attention to this in the future.
> And if you must do it, you should embed a ChangeLog of your patch (below
> this "---" line) so people can know what has been changed.
>
The update was indeed due to my problem. CI prompted me that there
were some compilation warnings that needed to be dealt with, so this
update was to fix the CI warnings. Refer to this:
- https://lore.kernel.org/oe-kbuild-all/202412221259.JuGNAUCq-lkp@intel.com/

> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

