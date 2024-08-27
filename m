Return-Path: <linux-acpi+bounces-7892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CCA96151F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 19:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA18B226E6
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4781D318C;
	Tue, 27 Aug 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eLZwaZ7/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE31C8FB0
	for <linux-acpi@vger.kernel.org>; Tue, 27 Aug 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778263; cv=none; b=XNn6TV5MRLuoYyHqXsFHsGQxegh7Y6GN526sGO+jhwOOHDa9OU3vKpCqhP4SYdSwI/rkycVkkqP8axpNmWVRdoNGVgqmW+QZogL8L4BWoxrXXKwJKFAnGlZY3L4ajuZIgF7kZANJdIVlxIHYSG1n6UjmdxTv4eP9FmkBVp63HBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778263; c=relaxed/simple;
	bh=obttAat1+8vwA+epeBCm2vdJfbrMJZxdRheqx2UuBrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NItO5OKAzm5TYlosFChgCD/rN8Mc2eYvIDwKcOX2/q2WcrZVFkugeZmbjOIeNvG4SYTyNj06D5/3Od6uLT+EO7dvexDN+lCSH1tn5qpW3cbo4NKednkskHDI8HE29cvjyo7o+r1VA2WzfvZNJYnZ/6Ncnmq0en3iLNkXwoZCEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eLZwaZ7/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc47abc040so50137915ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Aug 2024 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724778260; x=1725383060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cHVS6GvCBnOPsiOYcG8jjXps+ccwvzgozbmG4OKMFBE=;
        b=eLZwaZ7/lBCiCmg19nB1h9fRXBQrfrswbA/muOcaTQAr3q19mx4HTZOSg3HfcVdetB
         8q8SnYwfVN7L2ODwubGqNTVhR1o+D4BFpQnfGD4rXYSEXJRUooWRb8SGEtI22AqNiRUx
         jfUeIFGP26RdrE7kZQvBmazeqCvrvCJNvnOpLibpRvrxxk4LFBeT1Jzt46ACIqEZ4bzx
         Hlt5d3JH3W3OF6iiYzw99o4C7Y3UPYW5BWef3uuVHkTY4VIvYSFGsdIaPsCkHF0OlJ4o
         w1f5m0zIL7xgNqn0bapJ/drf4UbVzbIuZNtnCvfLw9v+ap3ju474mSZktOgYJgm+ZdzT
         3ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778260; x=1725383060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHVS6GvCBnOPsiOYcG8jjXps+ccwvzgozbmG4OKMFBE=;
        b=h3fHfJb0UgVxhIOZV13zxtT0WWqz1F2Bf1nAsIYeFUyq+AnuGktHml9qaFMusYqGKK
         d1SAa9fcPe25qUZJSVD3w9wYOKSbT90vfQkFD0o+IcQjywp2mObvcaQBZo1VFdNY9UOC
         PhYhgHgxkAJCPvwBaHeG12aTeRf4IUGPo697uduLbVCzPyxTMDDc90nZHGoA5yfRZo1V
         KzUHjB1aj185s8qVxVy4dI5haYVRVIibQEczeHe7NOFSXW4PxTyH64AXMc9Qezn82jBs
         oH4tYuOrUiYm/BUFx56X2XSgN0b5PUnlOcZT9aU62nQIG68dyaaaPd5a3eV00w3QPhoz
         uLww==
X-Forwarded-Encrypted: i=1; AJvYcCVa+z3oZGwDZiTVOn2IJ75An2CDxHAi9tt+XQD6wFWJG3Uv18rB8ueVeVXTy4LwD418OWcvQquNgc6e@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xOjMoWHS6GxAawuzFEjIv/Ck0apuqPCMe5kCPBNvsOX3QPAm
	5tsyGfENekMqlzW/WSz3NAZJtZDDuHZvAq3SLz3HLVXgt+8TuAwJbq86uRlcPHg=
X-Google-Smtp-Source: AGHT+IGpFb01J/dDnA2pToqsW0uyDaKXkNpjJlhzI0wYO6p2DBoqiGpaSi2i/MYfsiurNdOQfC7Pkw==
X-Received: by 2002:a17:903:41cb:b0:1ff:6b6e:d2bb with SMTP id d9443c01a7336-2039e4ef31fmr140578985ad.45.1724778260470;
        Tue, 27 Aug 2024 10:04:20 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855e2075sm85741915ad.120.2024.08.27.10.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:04:19 -0700 (PDT)
Date: Tue, 27 Aug 2024 22:34:09 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller
 support
Message-ID: <Zs4HCZH3M9nRXUvu@sunil-laptop>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop>
 <87mskzcnmf.ffs@tglx>
 <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop>
 <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
 <87jzg3c7bz.ffs@tglx>
 <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>

On Tue, Aug 27, 2024 at 06:20:24PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 26, 2024 at 11:22 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> > > On Mon, Aug 26, 2024 at 7:22 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >> There will be a conflict in PLIC irqchip driver due to a recent patch [1].
> > >> This patch is not in latest RC5 release but in linux-next. I usually base the
> > >> series on latest RC release. Should I rebase to linux-next in this case
> > >> and send the next revision of the series resolving the conflict?
> > >
> > > No, please don't.
> > >
> > > That will be resolved at the merge time.
> >
> > Alternatively you can pull
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-25
> >
> > which I'm about to send to Linus latest tomorrow morning. That contains
> > the conflicting change.
> 
> So I've applied the series on top of the above.
> 
Thanks!

> This included a full-swing rebase of the last patch, which I hope I've
> done correctly, but Sunil please see
>
Yeah, sorry about that. You have resolved most of the conflicts but few
are missing (which were not obvious anyway). Could you please take below
commit and squash?

https://github.com/vlsunil/linux/commit/c85f9d0dc31c0e77916ecdbb457748c05cf4e75a

Thanks!
Sunil 

