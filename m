Return-Path: <linux-acpi+bounces-2799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5F982AEB0
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jan 2024 13:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3681C22DB3
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jan 2024 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C25B15AC5;
	Thu, 11 Jan 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G33nWuG3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372F15AC2
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso1138245066b.0
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2024 04:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704976091; x=1705580891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=met0TS3f1iN0VupGC8yYYJUiPelRlG/OMDMfE7CCcUo=;
        b=G33nWuG3pLKr7rTBDaurck8orl0FgWfYCi43NSlluN/SbUxFOjJ5Veq7LDpckGqJhG
         LrF/lMkBDjpGF8v+shcQPxDatrd/SV25rwN7o0QJjT5p3Ij88MWmgnYb4NVojCviLoyZ
         wC8CDkRoed3U4J9BxavOH9t/av9msxnHf57/KhpR0fsPU1n0BmC75JtNFmufP8d73nvB
         ZNnO8jaUUMcNsOSKRM9BKNEqNO08L3zwhYNuwh0VL5TEUofClHF/OEvcXWp7MfgCZsz+
         Cc4Z7PjFQVkkzPBfyHsRwnpT0aDTtVSh0+nKtXfvei5+xElPl0Fjacmipv0y79Bj1zKF
         8AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976091; x=1705580891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=met0TS3f1iN0VupGC8yYYJUiPelRlG/OMDMfE7CCcUo=;
        b=izqrJzrDRW2xEKWEc3hbrCPIG1K7+7jOSClVj5zXH4PE69CJ3u4B/GGTaiLHAxTSm7
         ozX3EVynuun/cmjOt704Tw8qmQObK2GkPkl3PLoP2Tzy0W02ImWur/ThK+QQA7ZDplqz
         PywDwDyplgz+PbIdaha2QRhWOlghKTP+yqnqtlF+2gta1IKbShWe8NseUxyeAZ6nEWXA
         BV0kz+xQVIOUX7a2ZblbPWYxx324ARq1itgjJd/BmyC2rCJKE5tZ6zPIseujofCCm+me
         JIrSqQBzGKahZFFcFn9b7apExzXPvj/9dle47XGWnwVnZ0hZVIjUlgb7dZzBzeAbwPJe
         xJxg==
X-Gm-Message-State: AOJu0YyD1HM/zOG2EHM1tClrn9eR2/i+KcWzCFl3S0GE/YroyMLsGSYk
	Nh4ND8O7s10JPU1AwLewYKtTPlAGfR3dIw==
X-Google-Smtp-Source: AGHT+IEkg2z959ndk+FzzQaRGZjtyR4oRWJbgbi4WbvdpfH73VMDgLf0V+BD0aiz0hAD1dgeK/Pwbw==
X-Received: by 2002:a17:907:7f29:b0:a29:eefc:ef80 with SMTP id qf41-20020a1709077f2900b00a29eefcef80mr809934ejc.33.1704976091271;
        Thu, 11 Jan 2024 04:28:11 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ox9-20020a170907100900b00a2825a9e1d0sm526002ejb.174.2024.01.11.04.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 04:28:10 -0800 (PST)
Date: Thu, 11 Jan 2024 13:28:09 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: Re: [PATCH -next 1/2] ACPI: Enable ACPI_PROCESSOR for RISC-V
Message-ID: <20240111-e3a13157f1869342e2c8e942@orel>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
 <20240111093058.121838-2-sunilvl@ventanamicro.com>
 <20240111-bb411d2dd39eb859dd049fa0@orel>
 <ZZ_cBlOSW9VCjkOv@bogus>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ_cBlOSW9VCjkOv@bogus>

On Thu, Jan 11, 2024 at 12:16:06PM +0000, Sudeep Holla wrote:
> On Thu, Jan 11, 2024 at 11:00:12AM +0100, Andrew Jones wrote:
> 
> [...]
> 
> > Also, interestingly, it looks like this ancient line
> >
> >  obj-$(CONFIG_ACPI_PROCESSOR)    += processor.o
> >
> > in drivers/acpi/Makefile should be removed,
> 
> No
> 
> > since there's no drivers/acpi/processor.c file.
> 
> Correct, but ..
> 
> > I guess the make process silently filters object files which don't have
> > corresponding source files?
> 
> May be, but I doubt if that is the case here.
> 
> processor.o is just aggregation of all processor_*.o and this will be
> the processor.ko when built as a module.

Oh, I see. I had tried looking for a processor.o after building, to see if
it was something like that, but it still didn't appear. It didn't occur to
me to also try ACPI_PROCESSOR as a module.

I'll go put my head in some sand now.

Thanks,
drew

