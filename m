Return-Path: <linux-acpi+bounces-15821-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CDBB2B77D
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 05:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4F64E1C5E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 03:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDC42D3EEE;
	Tue, 19 Aug 2025 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lIocyK96"
X-Original-To: linux-acpi@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C24A35;
	Tue, 19 Aug 2025 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574005; cv=none; b=HeT0GN2fnM/+QdCdyDSDCTtgoe3X+e6AgsJICTSFMTg7KLQGkAeht8UiAwoY25stw8gPuIgD3QIMuxzwjg+XxF1JnFrwToRZ+PR/D1U0V5Tkl67+UeChzdA8Jq8+IjrWzWIwJdy+02+VF0yubo1EssI2VQOuRTxg6xyHHonpzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574005; c=relaxed/simple;
	bh=v2fOmGvCEa1uf4z/p4esCXg2wiXJmeWbshwawmhZPck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3cGpzrmgI8LsF6TJiBSYoGbvt3iuBf8PFiZ3bzrSI3ppXabx2cZL/5FbvSmQuJuF8LPJZMmSuxnJu2aXnjVqiOrcB4T8CTOLQ3/HnBiR+1pS/CFfQleC3iolvOZO+OYuu0pevbtm3i6PppGOTVt+iON9InaaU5ZC6rLQKs6hfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lIocyK96; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1BC3F22D7F;
	Tue, 19 Aug 2025 05:26:40 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6mf-pBRRXyKk; Tue, 19 Aug 2025 05:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755573999; bh=v2fOmGvCEa1uf4z/p4esCXg2wiXJmeWbshwawmhZPck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lIocyK96JzLEoWkrV/InqiZnpuh5giFNVn7nTAr4tSxuJTGEOC7rFrJr9L4axHtEN
	 f4+O36eWEssxmtQCGx6ey9rkLp9UTPIRu76Rlr25CobclxH0YkZLuJhd05iC/ae24o
	 Y7Uf4iu104epCpo/in1Ff7Ih3VPWj6kMJqSqwv8qXtm2rpMn/ExADKsClvRBUUbslN
	 28HPJYDduR8hNPecYhtNDv5tpExyjmu4YLliYLLpeRvgxwByWf+Edtkt0aRFW58Efd
	 8suHStYpx+zphVDOflDvS+HYKlStJ/Il3+fNPjB+1J7kY3kjLLFaK5HPaqoyxpscxC
	 BrIm4QZw5cBxA==
Date: Tue, 19 Aug 2025 03:26:18 +0000
From: Yao Zi <ziyao@disroot.org>
To: Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
Message-ID: <aKPu2g1MOZBBzQbV@pie>
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
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 6fed42e37705..1540626b3540 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -575,6 +575,9 @@
>  			      : "memory");			\
>  })
>  
> +extern unsigned long csr_read_num(unsigned long csr_num, int *out_err);
> +extern void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);

I think it's more consistent to directly return the error code, and for
csr_read_num, we could pass out the read value by a pointer. e.g.

	int csr_read_num(unsigned long csr_num, unsigned long *val);
	int csr_write_num(unsigned long csr_num, unsigned long val);

This allows the caller to eliminate a variable for temporarily storing
the error code if they use it just after the invokation, and fits the
common convention of Linux better.

> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_CSR_H */

...

> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 42c1a9052470..fe491937ed25 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -65,24 +65,19 @@ static void sbi_cppc_write(void *write_data)
>  static void cppc_ffh_csr_read(void *read_data)
>  {
>  	struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
> +	int err;
>  
> -	switch (data->reg) {
> -	/* Support only TIME CSR for now */
> -	case CSR_TIME:
> -		data->ret.value = csr_read(CSR_TIME);
> -		data->ret.error = 0;
> -		break;
> -	default:
> -		data->ret.error = -EINVAL;
> -		break;
> -	}
> +	data->ret.value = csr_read_num(data->reg, &err);
> +	data->ret.error = err;
>  }
>  
>  static void cppc_ffh_csr_write(void *write_data)
>  {
>  	struct sbi_cppc_data *data = (struct sbi_cppc_data *)write_data;
> +	int err;
>  
> -	data->ret.error = -EINVAL;
> +	csr_write_num(data->reg, data->val, &err);
> +	data->ret.error = err;
>  }

This could be simplified as

	data->ret.error = csr_write_num(data->reg, data->val);

and variable err could be dropped.

Best regards,
Yao Zi

