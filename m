Return-Path: <linux-acpi+bounces-6696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D391D7B3
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 07:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E85B1C22205
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9211A28D;
	Mon,  1 Jul 2024 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CpEu1hZC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C638397
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jul 2024 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813143; cv=none; b=BKT4gdYSV8z1JreQ97BgxsLrpZf9Bb3c6ZvV6359BTfecIbQE8T+BDVsZGA5BnbFFaJQEEP+1Mq3IFG21OFEznIu3R7v/p/q3pMPerq6d6YUgWvVS76o++IyDeB3whdy7SBWR+tGpO7aWYonut7jIZIzTgD/Ar7+yUSfcuYzfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813143; c=relaxed/simple;
	bh=vZGko0eoNLnj84zRoOPdlydINGSPQ6fYtJo/KDahuY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNm4wdFwcAYdk6a/BLPCqtWcex4cnlm+3xWVH+ADjFcY9PL1OnoRRdO60yLKvfXAYTDBryCqxmdEwlxdA6J5Th2so0dsXqJnwDOCX56Q9xQlD+VJaPBOeMw3gTWlPX1mYxywkaxwV5ynIooLGAePFI85/4T0dCN8Wzp+6FR/Nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CpEu1hZC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-702052976f7so1105189a34.1
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jun 2024 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1719813141; x=1720417941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKMU8DKIWEClgPDBnmDjtT7Ao2B1dNYMjzwF2iFrrjI=;
        b=CpEu1hZCoRVZqXhtpRCFV7/VZ4tUIUEaOQTxBIG4rA9LQvmcuZn+UZBbHFdE13kyZi
         4XCjy6vPsX9WCOA0m5PbhVqIEJDMoNnmHGcZfVQCvTRbdAJgS70RmEPSomNcy5D+pugp
         wjQdPHLQXyg4cxrxz0gnFsWDYJKw7nIi6qt+UBwUIphXz9blveDHDUM+jPQnlB7s+1EP
         mzHFsoDt3Ulf/ru4hdUtcFuDD+yukWX7ccTwfUnoqRX6BBHWniQGV6rAXmbVPshlpCMK
         1KNT8NFAYsbe/7OP5JySlZyPLAr/fLzu3b4wal6zXkbfkulDNBj0HLSJfJS8KhiouGSm
         Kjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719813141; x=1720417941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKMU8DKIWEClgPDBnmDjtT7Ao2B1dNYMjzwF2iFrrjI=;
        b=qJmlKxpSKId16X+WJ0wv3GDzhjl4iTGJm4QoT9un3CT1ls7aWSpXe1CSnbna1w7XgZ
         SN/eljUs8HeRw0g5i/yIfJHiSUALJJcl4sgvBs60FXb5xyBhL2QiSUuytST6q2WQHce5
         7S8O44pEk/7OPIJhaHPhpodAQ9qybyT8gFO7Nt+nySITpokhAIOHlUtoNAypOUC4osH1
         957ZvhlK+1lCVLbBPL3APEBUHDXG05mAE7Dhs6nKUbJTg/6rhg8yBDowMx/Bd/3xj9ng
         DtgdWhOkAICI+NJ0SzXaUUKEF5eNaEmFpxLUf3nUqUu/+lvOpaLGxhVlS+N69RExQB1M
         8ZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6VcbUXTRV5yC05VovSNpCWJY64XjMd66/ykvre8YuVgdZS8PuPWde9op5BidzR4izd5fpEpIGyLILO/1XC1C5qC9v3orh7Tq0fA==
X-Gm-Message-State: AOJu0Yz2d0cCvepNoNqb1xVOjq7jUZDmCat8g/iStBPiyUwSyJN8qkJg
	W8ep42wmNHy9PIdDV4xze+gCB1Tu4b0eVryrp29Fa1NyoXULkVvCbGNzRuF365o=
X-Google-Smtp-Source: AGHT+IGm7YJAgZMyphMx4GQMzsUKLII+YHeZwD23+Ey+akRFhATjAn/ybArgYnMmQp/igw9JEjVJmw==
X-Received: by 2002:a05:6830:903:b0:702:1d8:4d08 with SMTP id 46e09a7af769-702076a4d47mr8000813a34.35.1719813141012;
        Sun, 30 Jun 2024 22:52:21 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7a9b2d9sm1167621a34.6.2024.06.30.22.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 22:52:20 -0700 (PDT)
Date: Mon, 1 Jul 2024 11:22:03 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: arnd@arndb.de, xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Charlie Jenkins <charlie@rivosinc.com>, Baoquan He <bhe@redhat.com>,
	Evan Green <evan@rivosinc.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jisheng Zhang <jszhang@kernel.org>,
	James Morse <james.morse@arm.com>, Andy Chiu <andy.chiu@sifive.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Robert Richter <rrichter@amd.com>, Yuntao Wang <ytcoode@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add ACPI NUMA support for RISC-V
Message-ID: <ZoJEA85utEK6u36t@sunil-laptop>
References: <cover.1718268003.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718268003.git.haibo1.xu@intel.com>

On Thu, Jun 13, 2024 at 04:54:32PM +0800, Haibo Xu wrote:
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
> 
> Patch 1/4 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 2/4 add the common SRAT RINTC affinity structure handler.
> Patch 3/4 change the ACPI_NUMA to a hidden option since it would be selected
> by default on all supported platform.
> Patch 4/4 replace pr_info with pr_debug in arch_acpi_numa_init() to avoid
> potential boot noise on ACPI platforms that are not NUMA.
> 
> Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
> 
> [1] https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view?usp=sharing

Hi Palmer,

Can this series be taken for -next?

Thanks,
Sunil

