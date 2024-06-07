Return-Path: <linux-acpi+bounces-6264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91DE90016A
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 13:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41FF1C219C3
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9D15DBC3;
	Fri,  7 Jun 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ifdgd5ra"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316715CD65
	for <linux-acpi@vger.kernel.org>; Fri,  7 Jun 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758097; cv=none; b=lninHiMIRtROgyd5TpvzDUvxm7vDoh0Z+sFCw4NwPHNNGV5OJnE2YqgbLf7G6lMcuizaDKuRnAAi0e2jCPou8Q9jTtVrxxCZzpbtH7g3NABXJbWg/OgA47IPhS4d55nDG1MB8Lwq5YLBiXaahPKw5w68S/iNFb2r8NA2jFyj7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758097; c=relaxed/simple;
	bh=N7sOJlTNoiRhSTfc25d+b3OOEAnwL2reEju+8B7R8vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf9ww+TlkFTNJYFjbCa9A5lBGf34TnH6L5CH+dNupWv1pzRAQVVzbxBxcp212vo8L5HyQMfiKrX+q8DdO/GYC89vaE+FIcBVnxpz9YCgXyPE6xtbWGONW81chutCB+6aTEDBMSh0RBryEhtC77jcsCb7SnLly1nDBJ71Luhokhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ifdgd5ra; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70244776719so1585950b3a.2
        for <linux-acpi@vger.kernel.org>; Fri, 07 Jun 2024 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717758095; x=1718362895; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DI5Qf78GNH3tyySodkUT6XiaCdZX8TQYwnH9rITzZzQ=;
        b=ifdgd5raf7Y912BX468ZFTA9UgFhullNAB7QxTNGY82fvV5yyk7kYIYuJencvdEWVg
         bpSVt3dgbZbmPZVSIwZEdQKl9+Jl9ofAvh6YWV1AiPwwKLd6OE4FOgM6D/tpXLYEBG/i
         urGUcUckN0q1mDnxUBd30osMv6FQYyLkF8+oG/gKBT8ckTnUCj5HeqtcZGDd9x3+9ecR
         TbPrC2TWvBKT6DVQr6vrQIg68m8ya2nyLpIxnN4ruGUexu+SjXHRsmrLZslhkkIlx/6P
         /ixXMUVnQr30gA1txCwfcOYxV9Y4LxT6EqYKr0VzXF+xZIotZWFmWa7d9ZZCDCEachb1
         OArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758095; x=1718362895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DI5Qf78GNH3tyySodkUT6XiaCdZX8TQYwnH9rITzZzQ=;
        b=kg8HhYCxgyG5TjoHvyC+A1R6x4rr45yA9naaUl1Ht1UPH04wD3KNR3mkXr+OGGS0OW
         FNvWA1CwTdEgkvYXiuOQYiEK7v92Y24plv2b5vCukZ9QDvAC2faT4lR6krxQHZy1qenZ
         5gDIspsLIQ8Jz+/1mITea7Ktut1kFSxWku9hBG5zu394KZawXDSkkriXy9qOsLkmcZYY
         Guwjh4Pmk8vzVvk0pQ+n5jaRBjqa7GlZRWNGsws9dErYr+xyfKFijXCtFURrWjYJt4CD
         Fr4Xn+vggFIul32EVzWBuLm8lMjW03O4QGi94aMYT4OmnjLFXf2pFNLo9y/XxVEwPO8G
         Dnpw==
X-Forwarded-Encrypted: i=1; AJvYcCWW1LO5a9tcZl7Zhi7k6jY4JD0BzgV/qcsTl0BpLpjXGHNGI47xTpxgfGUjRmFi3EWRGwH+0VDZPoOHlEflTcYwIL5HTtysiAUfhA==
X-Gm-Message-State: AOJu0Yx8EiWZpSpQ1GnBBmpm8AgqXBbSZ64hZjN7WvhnBHom8SCoIsDR
	BLSUNdOyBe4orPPJHmc2qRWud3X6s7s4pAlxbs/nrWAP1+Z17VPdK1wTgDVcvzY=
X-Google-Smtp-Source: AGHT+IEb2Nma4FnB/zziymAMKluh4Fz3EE1abFeJCDOUaSefKlw97fNpT7MhuwmeNDFnkSZNMABPCw==
X-Received: by 2002:a05:6a00:982:b0:6f0:f54a:4e7a with SMTP id d2e1a72fcca58-7040c61952bmr2257589b3a.2.1717758095122;
        Fri, 07 Jun 2024 04:01:35 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4951ffsm2371289b3a.131.2024.06.07.04.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:01:34 -0700 (PDT)
Date: Fri, 7 Jun 2024 16:31:25 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jeremy.linton@arm.com,
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com,
	sudeep.holla@arm.com, tiantao6@huawei.com
Subject: Re: [PATCH RESEND v5 3/3] RISC-V: Select ACPI PPTT drivers
Message-ID: <ZmLohXMgGrIvL7s7@sunil-laptop>
References: <20240523111322.19243-1-cuiyunhui@bytedance.com>
 <20240523111322.19243-3-cuiyunhui@bytedance.com>
 <CAEEQ3wnE+8FXXf76zapqNnC5vruoR9C-y0qjjFw47cHYP57MmQ@mail.gmail.com>
 <CAEEQ3w==wueTSDvEtJe+t7jamH2ERxta4uPLUFVwX2ueRLJ3Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w==wueTSDvEtJe+t7jamH2ERxta4uPLUFVwX2ueRLJ3Bw@mail.gmail.com>

Hi Yunhui,

On Fri, Jun 07, 2024 at 04:44:36PM +0800, yunhui cui wrote:
> Hi Sunilvl,
> 
> 
> On Mon, May 27, 2024 at 8:51 PM yunhui cui <cuiyunhui@bytedance.com> wrote:
> >
> > Hi Palmer,
> >
> > Gentle ping ...
> >
> > On Thu, May 23, 2024 at 7:13 PM Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > >
> > > After adding ACPI support to populate_cache_leaves(), RISC-V can build
> > > cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> > > configuration.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  arch/riscv/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index f961449ca077..a9ebecd72052 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -14,6 +14,7 @@ config RISCV
> > >         def_bool y
> > >         select ACPI_GENERIC_GSI if ACPI
> > >         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > > +       select ACPI_PPTT if ACPI
NIT: I would add this prior to ACPI_REDUCED_HARDWARE_ONLY.

> > >         select ARCH_DMA_DEFAULT_COHERENT
> > >         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> > >         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> > > --
> > > 2.20.1
> > >
> >
> > Thanks,
> > Yunhui
> 
> Could you please review or ack this patchset again? Palmer did not respond.
> 
> Link:
> https://lore.kernel.org/linux-riscv/20240523111322.19243-3-cuiyunhui@bytedance.com/T/
> 
My bad, I was under the impression that I had Acked already. The series
looks good to me except the nit above.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil

