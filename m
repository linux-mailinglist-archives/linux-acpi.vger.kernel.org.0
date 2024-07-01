Return-Path: <linux-acpi+bounces-6695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE6491D7A8
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 07:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51211F22B91
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 05:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC7433D8;
	Mon,  1 Jul 2024 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NQCaENbu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD143D96D
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jul 2024 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812989; cv=none; b=Oq7+38ogRnx6JxS0/uStpX9zPCuEL1KCr/CsGijJrQKaWEXY2vmkbVBcmZwijlE+8KR/pYoc++DC3umWwxGbMYFrV0gKrvSp+kpMGyLtWDhgZcvX4Ke7Dxm1mF74pSeNaU5CDPEeQeCl1HZkzE/ZYKN8g60/Of4JafzZUto91bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812989; c=relaxed/simple;
	bh=mqqGdxTAEmXRIjGTDLRjrJRNNyk8TOJ/9inqH08rFms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uruBEOI00HGH27yOkm3QvwSqEhK3phZaaXXfTKMT+5IYzDdlQQtPy1XoxwkkkwOSOB1G2nRR1gP/4ADAUFXPwXXkD1fOPLhh6zFNKfb9sHGYoP9kPiPX7cDRrvPRA/v0t2MS/C1jafusyY4bvRgG0iecWnwGILfI1foJAzFwu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NQCaENbu; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9cc66c649so1656668b6e.1
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jun 2024 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1719812986; x=1720417786; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4s/WBvVl/dst1lHjWFZpMEMdrWEWEKJym4uGaWtNax0=;
        b=NQCaENbuY22ees4p2Z4dKnlXLHK1hiHxuS9HYo2/1vL/sRXH050PwZ3ArdngMJXiXG
         MfI+vlsmVSiPqFC5tV/87IkP63vgZbpQEb5yBcP8CaOXWrnIYWyF1DdD6FpQQFTsE0+0
         5hFRhtuggvSMadFf3KYbsMoPsuKvs+KXPN4m2Tsd18KxC2SPEeuoCifdkR1pXrOyBwy7
         TsOOV9gMR9gpPdbhU9jT3e2Zv65URBKh5gYmbZkDvXQL83UX0goK/I7CnWDL6P51biZ+
         V40W9vLc/h/FsNyRMA153bl7Pce4Qg0setvvwND8aGQD/URWU1sT/+dw+uyFgJBhpabZ
         do8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719812986; x=1720417786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4s/WBvVl/dst1lHjWFZpMEMdrWEWEKJym4uGaWtNax0=;
        b=RnKjX6nM9uqFbpEcNka86z/CSJEfJQA++EjXfbzitJDQ1HPVOa1A3tJG9LDYDMZ4xN
         cWif5YDQsanmyxThlLBOTHqhWD5ewXipDUVqvoaN0e9A47I5cBZelVSfwM+XRzysun6o
         IEOX8ksmswPCmwODajwjC4UmLZllaREMRZ+Mvf3NlWZq/PU72e7drPeCZuX9bm2Hlz7T
         L5FEPTFv0c1mng18tpAY37cb01I0uDHcjeeoX+G5kDfBaTDt/pSvxx78zna38NE8hnrF
         bXcpuVGugEgJzN8F/GiA9EN97i0SK3x7pUzYREhv+N9OPaJTbax/xDZSqLZ8ti3FcS2O
         54QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBRqpwoGJKpcaevo38/iWln5lmPr7p7LMFodDJttyoDhVYbtLwvVO4AehlhWeHfWhn4/sk48vDo8UENVKQg1dvRuoglIpWAh/hzQ==
X-Gm-Message-State: AOJu0Yz6Nz7Ie/neU1DHi1yIXC9Eo+wsQU3LnWqA5guwdtaV4mQMNbtO
	CmltGFNV0y0ylA/TgD6CL5anfT5lLK4jDhd/vVBZv+QyVXcH75CPMhU43wZ0c18=
X-Google-Smtp-Source: AGHT+IFkbfzSyeGbbMoYBWXleU/NPIjZpuMJZvhBR4F8gn5oN8vBjv/YM3Be+WxqxSc8Jn7yn+W2+w==
X-Received: by 2002:a05:6808:1706:b0:3d6:32d2:2c15 with SMTP id 5614622812f47-3d6b5686a2dmr6011108b6e.59.1719812985837;
        Sun, 30 Jun 2024 22:49:45 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fb48ab1sm1228661b6e.54.2024.06.30.22.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 22:49:45 -0700 (PDT)
Date: Mon, 1 Jul 2024 11:19:35 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jeremy.linton@arm.com,
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com,
	sudeep.holla@arm.com, tiantao6@huawei.com
Subject: Re: [External] Re: [PATCH v6 3/3] RISC-V: Select ACPI PPTT drivers
Message-ID: <ZoJDb9PQX2oEISrI@sunil-laptop>
References: <20240617131425.7526-1-cuiyunhui@bytedance.com>
 <20240617131425.7526-3-cuiyunhui@bytedance.com>
 <CAEEQ3wnkQsfmLbyMrG_YBvWvhHJdSTg7dG5W_mxv_wxCjatgCA@mail.gmail.com>
 <ZnLY3mNxyv9QOmGn@sunil-laptop>
 <CAEEQ3wmarOoWWYrdpf7YNQdZG4rf_O4dHkeiO3W1cuavVh8TMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmarOoWWYrdpf7YNQdZG4rf_O4dHkeiO3W1cuavVh8TMQ@mail.gmail.com>

On Thu, Jun 20, 2024 at 09:28:18AM +0800, yunhui cui wrote:
> Hi Sunil,
> 
> On Wed, Jun 19, 2024 at 9:11 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Wed, Jun 19, 2024 at 07:32:18PM +0800, yunhui cui wrote:
> > > Hi Sunil,
> > >
> > > On Mon, Jun 17, 2024 at 9:14 PM Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > > >
> > > > After adding ACPI support to populate_cache_leaves(), RISC-V can build
> > > > cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> > > > configuration.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > ---
> > > >  arch/riscv/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 9f38a5ecbee3..1b4c310a59fb 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -13,6 +13,7 @@ config 32BIT
> > > >  config RISCV
> > > >         def_bool y
> > > >         select ACPI_GENERIC_GSI if ACPI
> > > > +       select ACPI_PPTT if ACPI
> > > >         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > > >         select ARCH_DMA_DEFAULT_COHERENT
> > > >         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> > > > --
> > > > 2.20.1
> > > >
> > >
> > > Gentle ping.
> > >
> > Actually, my RB is still valid. Anyway, here again.
> >
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> >
> > Thanks,
> > Sunil
> 
> Okay, thank you. BTW, when will this patchset be picked up to linux-next?
> 
Hi Palmer,

Can this series be picked up for -next? Looks like it has got sufficient
reviews.

Thanks,
Sunil

