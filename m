Return-Path: <linux-acpi+bounces-6511-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CA90E12E
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 03:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68041F22650
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 01:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608DD567F;
	Wed, 19 Jun 2024 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4+WH1b+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA263D0;
	Wed, 19 Jun 2024 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759890; cv=none; b=UiWWam8T3Q9QpRi5OhlWb/3DTcqbeMmGjJ1VFzhIgCLlQZ74Prsle5FHLkP8S8Pe3uBlyTRGjSj5EktttIMhbiVwEWfNwMFIstNnqj8jiJZQ77tu4BuvgoZ9goy+GxeNkmgS9YkNo12eK9IH8JXM1rosC3FaeFnCCrirDvvesNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759890; c=relaxed/simple;
	bh=OM+FRXFB6DpgW4Mn/lTWBgeE0bTKzqdd4rxakX3c1ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfEii238pGtnEBzz2cp6Ik+vJoLnuGPt8dgUVvB3qChOmakWMhKbxrblFPJ2qZGTEYLKObGE+Oyz7SOBZt4v53SJ3XgkH1g47WW+/XHixEIvWdy6EyCHIeJNAb8QZ5kPga1Qk6da/8nDVjZ8iInRM+03CVk0EY6e/eU+TFTEtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4+WH1b+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso100941921fa.1;
        Tue, 18 Jun 2024 18:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718759887; x=1719364687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey5yiVQA8LBP/6zYkNpIcrvI4fFdl2/Q3IQajczTvLM=;
        b=j4+WH1b+dbgoHgWISeILjkNLEnQtiyGV6pCN9cUhDE6BOtAflti221ZQKIqaRLCT+j
         vtK3iJYo6oshgFTuZgQP5MK6OkR5NnbJPfmFto/PX110dzmC6TTXPT9UAmbOrHPMm1fU
         CvmeGVPCTDtrU57UJe8dBGHXXwAAXBmSJOeaGRqA6xKsF8aX3WjMbvv15okPZz9JulIF
         Dz4W9KITk7GLKcQ8pZZHEwS8XYq1fnUjHy4mc2izDI5bLCgRU3Yl+PltmkpLzat4cUOh
         hrPfzI6CwzxKNy7fdH6zHS758nibEDuPg9kwUr2L4Kh5SDQFRjPrazgwp3QYLLVs4+LU
         sftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718759887; x=1719364687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ey5yiVQA8LBP/6zYkNpIcrvI4fFdl2/Q3IQajczTvLM=;
        b=dzw8tTQkRAD0xyMh40KBXp+XzE3N2aFqNKwzmb1u5TLKdETV1cptp+IC/64Hk0QMYd
         NawZnXzfzA0bqvg2+S9uu0jvnwFWEEN999/5o5doafN3h0QTmxaPJ/rqQ9xkaK7FPmcj
         9SKfssBVRZeLiB0JDS0au+X7zXQV3pEf/2wHJ/4+CgbAZU+BCy8P2CMil/DCM0w36WwN
         n2Robs/hpbr9t3stPz17BuefuQVv0f2CGFWzqIEFdcFHTd5pNfr1M+YCmEopShIQuNVA
         ePU1BuGqmF9GifE2TWb84UqlqKu+7pUmCvcktH9D3Qk0QxAJevqgyH2Ngn75hI/oZS7e
         bpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBX/bpkQl6B/o5XoHV9bz+oF/6QmIDpbf7/I6K6THQzJM1KlOrY0/3l0QlLFwaSA2smEMobSn7A8c9PrlruetEzKrysQLWm2OwmmrbCwu6YudQOCz5+MHMpsmQ8+eAyvBK90nrz2gl6w==
X-Gm-Message-State: AOJu0Yy9/eu4iAtZSnr7SY9S4tQbGT6v79KDr5bdxy6I9s2HEjH6+U7A
	bVe+BEzrmEmD3kBCx8P7WhXAf59bS2yqJTSK2yJ8n9H4oNfM9igy9siknG0SLCPp/QXofDuuLhT
	uenSSigHXhr7LBILi/Rcc8khOO44=
X-Google-Smtp-Source: AGHT+IFiTPEbVFgx6S7H+uJNwNOLjAFLVL5/Vnh5jjNpcZV25rpymoEhI57ECx4iXoR1vGPAbIVLdQm2Xan1iCOIji0=
X-Received: by 2002:a2e:9f02:0:b0:2ea:ec52:f594 with SMTP id
 38308e7fff4ca-2ec3ced1896mr8494161fa.29.1718759886352; Tue, 18 Jun 2024
 18:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718268003.git.haibo1.xu@intel.com> <f1f96377b8ecd6e3183f28abf5c9ac21cb9855ea.1718268003.git.haibo1.xu@intel.com>
 <CAJve8o=8thBhU3NyTaS6sE9rQ1VR_Qf4O8FkAxpmp1q8P-6VaQ@mail.gmail.com> <20240618151820.GA2354@willie-the-truck>
In-Reply-To: <20240618151820.GA2354@willie-the-truck>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Wed, 19 Jun 2024 09:17:54 +0800
Message-ID: <CAJve8o=-bZhQS289jwxG=Aq2BOXk5OzdgPKT=nFE9yw_HYYnQQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ACPI: NUMA: change the ACPI_NUMA to a hidden option
To: Will Deacon <will@kernel.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, sunilvl@ventanamicro.com, arnd@arndb.de, 
	ajones@ventanamicro.com, Catalin Marinas <catalin.marinas@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Evan Green <evan@rivosinc.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Zhao Ke <ke.zhao@shingroup.cn>, 
	Andy Chiu <andy.chiu@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Robert Richter <rrichter@amd.com>, Yuntao Wang <ytcoode@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:18=E2=80=AFPM Will Deacon <will@kernel.org> wrot=
e:
>
> On Mon, Jun 17, 2024 at 09:34:18PM +0800, Haibo Xu wrote:
> > @Catalin Marinas @Huacai Chen
> >
> > Could you please have a look at this patch for the ACPI_NUMA config on
> > ARM64 and LOONGARCH respectively.
> >
> > Thanks!
> >
> > On Thu, Jun 13, 2024 at 4:37=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> =
wrote:
> > >
> > > x86/arm64/loongarch would select ACPI_NUMA by default and riscv
> > > would do the same thing, so change it to a hidden option and the
> > > select statements except for the X86_64_ACPI_NUMA can also go away.
> > >
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  arch/arm64/Kconfig        | 1 -
> > >  arch/loongarch/Kconfig    | 1 -
> > >  drivers/acpi/numa/Kconfig | 5 +----
> > >  3 files changed, 1 insertion(+), 6 deletions(-)
>
> This looks fine from an arm64 perspective:
>
> Acked-by: Will Deacon <will@kernel.org>
>

Thank you, Will!

> Will

