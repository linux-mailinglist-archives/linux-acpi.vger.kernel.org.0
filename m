Return-Path: <linux-acpi+bounces-4099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 013278714EE
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 05:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A8A1C23293
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 04:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E343040BE7;
	Tue,  5 Mar 2024 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JcmZ6zKI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA83B193
	for <linux-acpi@vger.kernel.org>; Tue,  5 Mar 2024 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613870; cv=none; b=BvY7SNM1rM/jH4z51X2g6x5yGlfkBchre6S+PwDIP3XTcceyRrFadmhPQxvDExCTjRTL+wjqCvMQCgOOtZ1RCZbcMd5VIARK7fQ5CMzQJ11DFEamqN4hqsNKWeYP6/XsnOCdsWRF7YBLn+aPFl4nqbRCrEfnQcteI/ZzJ8w5Av4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613870; c=relaxed/simple;
	bh=9FduPOM1E0DLi1J/5wrgWMsdvAlzYCOwin/4aXtDbPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zuv8c40Ez9qVBNe3qIDehgt8nVWzNusjFrE52An7a7pAJk4G5QksGkdx39+lns86P0XTEgZSlBBiqIJ2HgiLYbeXZ6o607FI6GT1izsfI29oQxco0enGyGBkF00TCR313VJVT1IQIuPDmo2UqV+Ljm/7liKp134Eb+lbBfVZ1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JcmZ6zKI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso4455080a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 04 Mar 2024 20:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709613868; x=1710218668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEmCILRrIWZpalXXrpWDX7rbP4qw8KKDAl0Yn0w+NeM=;
        b=JcmZ6zKIFsPibwIxqhIEhH4mnOo/+yJGvSF3Do6zD3CWlGzi7fFJYM5xlWe4vErl6F
         X8C7aDLmdxxIBr1pqFK78DiaABaR6pAUSTDo0vpeymK9GbzNUgG+rUm6rQG2+BJIRfQH
         NKMuUIukX7iyAe31iggW1HwuT3TQ+Mk7INM5w6l7NL0fHfxOOAiz98Y8R8LrMSYZnqPQ
         YFzQlJ9XXq53NqOixi6D1JLqEKcuXNue5Z4cO+kRniHe8C1Q3PAfNJBrKxYWajqmQF4F
         hHDxdXpE9DnYXOYKmsIpWT4LRRDx4qajI/DUMZQQOBWqUjnwlf4PNhWOf5/AvV2ktLnp
         wWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709613868; x=1710218668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEmCILRrIWZpalXXrpWDX7rbP4qw8KKDAl0Yn0w+NeM=;
        b=pSDQPmsvHyi+zrFj+aUupA2aKBIAV67JrIfwISW1hAUP7tyzJ2zS8OfGrUZ7Fa01aA
         K8jevy4EBrrbaHAoKx/Jaf4mlglqHhffUq/e1o0pttbqp2Fm2Q4fXrNTperGNBV2Be/j
         /Y51hTr4KHZr9xYpAJJERIHgwP12EeOYObfWgLBD2jIDwtXqZYul9Y1tfEyr5WmMV9H0
         +k0R/V2MXFA2neqJVnG422IOuMZI1DBE7YzhRO4BrmLNUkrNfD0y/NgFjANl7W7RTVSC
         JUGVdfCHxrYUbhkoKa9/WgETTT6bMKNN/PaYTH8Ep+E+z2/h5pp4Dhx3ykhkBqMLr6hM
         T35Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkTr/JOak3uiPr3/U+lsEjreDq4LYTmogUPPFdN4jlfmCu8KmD3mfXnGUEff1CZaEv5TpMokGC4EaWlWAYy6kkcFzER2yc3hQqDA==
X-Gm-Message-State: AOJu0YwXfT1dWDMTTV3Fm4AggAQuqo0Sin/IT07D73Z4ZG9shw05QBQh
	r8IVesOHmnSnn0pHw/0yfSeAnXJ6OITH0mjHnyo4o2UXV1jfRdlsy6mKJTXQC3Q=
X-Google-Smtp-Source: AGHT+IGzdE2wBh5JMNN2REb28BcAMWbrN4VvpnatTms7qSnw73XZkAoXt6ydG0CS93YADlTRvZf9Ag==
X-Received: by 2002:a05:6a20:4304:b0:19e:4aa7:e6ab with SMTP id h4-20020a056a20430400b0019e4aa7e6abmr909690pzk.47.1709613867818;
        Mon, 04 Mar 2024 20:44:27 -0800 (PST)
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001dcfaf4db22sm5467653plr.2.2024.03.04.20.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:44:26 -0800 (PST)
Date: Tue, 5 Mar 2024 10:14:14 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 0/4] Add ACPI NUMA support for RISC-V
Message-ID: <ZeajHkn6dTQ3krsL@sunil-laptop>
References: <cover.1706603678.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706603678.git.haibo1.xu@intel.com>

Hi Haibo,
On Wed, Jan 31, 2024 at 10:31:57AM +0800, Haibo Xu wrote:
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
> 
> Patch 1/4 is generated from the acpica PR[2] and should be merged through
> the acpica project. Due to this dependency, other 3 patches can only be
> merged after the corresponding ACPICA patch was pulled into linux.
> 
> Patch 2/4 add the common SRAT RINTC affinity structure handler.
> Patch 3/4 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 4/4 add corresponding ACPI_NUMA config for RISC-V Kconfig. 
> 
> Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
> 
> [1] https://mantis.uefi.org/mantis/view.php?id=2433

Please avoid providing mantis link. It is not useful for people who are
not UEFI members. Better to provide the link to the PDF version of the
ECR approved.

Thanks,
Sunil

