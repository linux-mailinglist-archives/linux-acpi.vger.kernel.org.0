Return-Path: <linux-acpi+bounces-15804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A5B2ABC8
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CC77B1BDA
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31002356C7;
	Mon, 18 Aug 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RQpqI/V9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCC235063
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528966; cv=none; b=bK6oXBRFvYSsrZP8A4dAPzaI2XenGEkfigSH8RVA2lKZncQWdMkSShS166h8rj6+EGLSmlaUpwn6fTbeh0S/rqiwqO2CGDFEBYvWZ/ToWcBBoMmc6TPhnjL+hCe9hm4UJzXvsVX24scAMSWX27mHVfKKlG3Z3ucA+KevXYDqYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528966; c=relaxed/simple;
	bh=OoK8EZCVh6shAzfoSOyrqIIYjO/z1iYKrSUGlMsjZxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITyyyNeY1xxkrvr2SWIfLdxg3lHecmmBs8t2Jb5QfqBwIam2E1L8JKgmCm/itn5xwAITtgFiLphDM3TEX2VvGXY1oLAwQ3G4/5GDjX3w/s+jpBNT+tWJuIL/27H6D5wrVS7eAqRZsSJ0gzN4F0SnusXidcO5txlZDVGpWX70T8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RQpqI/V9; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e57376f661so16450695ab.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755528964; x=1756133764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9CfNSTuc/uF1qHY5WFP24kXO82FfA15GfsdN/C+IOc=;
        b=RQpqI/V9TnMHG7v2MomdAoIKrZCNnmu6gMri5+Rcw8M9G0T+ExOaXaq9VeLAjyCssR
         lvwXNxJhJsIQoP9tCn1EMesTxtDQEeqZyhNRqH1sPzgOEkG4HvDwe50yipll/p67KqhF
         VDvB5z9GomrDNTVcMzfQWIOaE9ojAQo/AlqTff0NuOqyzYNQC3EEPikGAizq/FbXPjxS
         aWVF/fFqga9QcTq/eXaU692caGFN3xDKmSuDWXKq+6iDlDy4C6wrnnuaQzYjpdneGa3W
         I8AB3p4aj4VAqVDxFWaPp738jTumOaoo05nk8DaLhDmmsEeL2GIu6vyWCYZLxUuAyY1/
         U3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755528964; x=1756133764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9CfNSTuc/uF1qHY5WFP24kXO82FfA15GfsdN/C+IOc=;
        b=u1WKZI88t9BI+E9izCapHGOm5p/BfY+XyQrOASyuvjAu2ixO8E7m776xYTe7QxKcZW
         hqYbHmmmST1MAx9RRxKqxYYYMl8bR1BIZDKKRuNTzhjCIkHJpJdePN7B2Tn0sLuNLxJB
         w3z1gDEBCxuICjtlHKEjdlig88k2kHLKZV15GgPOiG238AcdWhg3tNmHpEsJgWxehbct
         ooItfuKuqz7J/f2RAgUWQztYCkQSjGFBm5YaYBATL/JpmnGefFPyrvzPJ38ZZXkfS/SL
         Cyt9Q7T0J9fVDrsNeJ0w93B8dD0R56AltsuelQngqf4lQAmT9AiTP87LjQr0nGhXbfeP
         SSVg==
X-Forwarded-Encrypted: i=1; AJvYcCWM2hjzfTuxtVvfnZeo2UOsXzzYmyw7lzBVEQhn9FU51DOC538u7e1IOIAzkB7wMnKu68L8XigXMLUn@vger.kernel.org
X-Gm-Message-State: AOJu0YxMAGoieKuduiPGv9zpsKviaf5Pn7CQIJJ3/KxBrPCqxx8Qb6Xb
	f6J5lsZLWcNLqQbMhNi7vatLuWbHF4+Jlt1NetTNv3JuyMCV2M/ta9FqdmH8CU+MKW0=
X-Gm-Gg: ASbGncsY7xCoNGNfoxkR5uVOZQPwuGLaVbkBN7HCQbD9qBUtBMB/UW60NwrfzG7eDEB
	yHDJnB9uordc1nABmkdmBkatcLPk9y1eH8YRfFacl20iv39+ACQ8vJQOKdSuuILIfMApjG0aYHi
	XVLU3gvzyvNgqh7uwXJNWbaj6SAXde/9mNuzNgmqQZMJM2uR8Yfx5xI46trxGz/qK1ZOq3MEMSO
	eQ6wOc/FsAYCpbd6y5P3r9yYZok+U57+CtXLuqlxYzMEwELCIwFrbqbMicu8WNN/vRh2uSLmdrg
	VW/RkHv2poaHKfbiL9xO6JM8JKCLn60fekEANdDSxs24TW6fTWlzEOQzUYwYJF7RRTOnaToKUID
	T9NsS4ZcI13Z4FkL2BKMNicW6GgoNALdb3CQ=
X-Google-Smtp-Source: AGHT+IHKhwEj30JkX2wIaBs2G2ErrpG6q1NBNVHTVwHY/0ZVQYUutUV3YGS8fX1au2IKlXNP3c+x+w==
X-Received: by 2002:a05:6e02:18c6:b0:3e5:3d13:5d80 with SMTP id e9e14a558f8ab-3e57e86aa7amr243594735ab.6.1755528964324;
        Mon, 18 Aug 2025 07:56:04 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c9477ef56sm2565433173.5.2025.08.18.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:56:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:56:03 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
Message-ID: <20250818-ba7d5f923321feb836a408db@orel>
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818143600.894385-3-apatel@ventanamicro.com>

On Mon, Aug 18, 2025 at 08:06:00PM +0530, Anup Patel wrote:
> In RISC-V, there is no CSR read/write instruction which takes CSR
> number via register so add common csr_read_num() and csr_write_num()
> functions which allow accessing certain CSRs by passing CSR number
> as parameter. These common functions will be first used by the
> ACPI CPPC driver and RISC-V PMU driver.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/csr.h |   3 +
>  arch/riscv/kernel/Makefile   |   1 +
>  arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/riscv/cppc.c    |  17 ++--
>  drivers/perf/riscv_pmu.c     |  54 ++----------
>  5 files changed, 184 insertions(+), 56 deletions(-)
>  create mode 100644 arch/riscv/kernel/csr.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

