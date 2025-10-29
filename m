Return-Path: <linux-acpi+bounces-18354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8ADC1CEBB
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 20:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98D2B4E347C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE25359717;
	Wed, 29 Oct 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II0Wbb4g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BD4358D37;
	Wed, 29 Oct 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764704; cv=none; b=ZCjibRZ4y4fn80z2gFOLZg9i3AH7Yj21SMevw6CrPwQHIguRbvn7tQnYMkvLHkeEohm/SrYGPHbb74sgOtNIO8N0SsMf4KrsuKft3Khfh+O0OzB+bpecudNw799H/PtXvf/8g5/75EgJ2ItgOfYkxPPBq/ZtD3zxNGO+n5iTOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764704; c=relaxed/simple;
	bh=8twDFXhB5PP9hk8ajFP0G5YZKCa0gWuPFjkkttFuV5s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C+ZhIimhV+njNcmhTiUbhJNtkIFqt+LeRwUs4EJJiFuRVM+AcJ3vu4f625bNVKZoJ+Z9cucxpzMWbbmfI2IEAt6PPYsQ5vKm7X5UQt+zZ6XeB2OMN9k0T78Dvom6gRIq9UPE7P8tFqO5h7FDgCcsb0nKR2KeNpMTA1Ha9YiMwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II0Wbb4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FC9C4CEF7;
	Wed, 29 Oct 2025 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761764704;
	bh=8twDFXhB5PP9hk8ajFP0G5YZKCa0gWuPFjkkttFuV5s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=II0Wbb4gSCSAiOkxHMtgix3grklvFNYuoyHHYNXV0oJ6ICwBBC9vDT7wx9szxQXJ4
	 gYTDSpAewcDZHJgrVCBMxeKTWPpBGnIaGK50Sy5SZinYX1AnQe7bAkOKeJHW8LNYkk
	 DPqMyWprBXjsvscPyEMSkzd7epOVthAkE2E5Ny7H1dzBPx2ceU4SXXnj0ySkXwRCay
	 6DNqIILZok3O0nELPLNZR5j91d6jawcRGATKPIDohjQ5Trs/MijN/+83nP40GecTCB
	 qL4C3QaNBCHbG4t+hxu5/4Y35k7n2ORQon5W03p7bxcer+T2eopkXNG771YMHZ29E7
	 fiY0acVUDj0qw==
Date: Wed, 29 Oct 2025 13:04:59 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
cc: Sunil V L <sunilvl@ventanamicro.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, 
    Len Brown <lenb@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
    Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
    Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
    Nutty Liu <nutty.liu@hotmail.com>
Subject: Re: [PATCH v3 1/1] RISC-V: Add common csr_read_num() and csr_write_num()
 functions
In-Reply-To: <20251014132106.181155-2-apatel@ventanamicro.com>
Message-ID: <012aaa39-a37b-e682-0e34-9b7d7cd87f75@kernel.org>
References: <20251014132106.181155-1-apatel@ventanamicro.com> <20251014132106.181155-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Anup,

On Tue, 14 Oct 2025, Anup Patel wrote:

> In RISC-V, there is no CSR read/write instruction which takes CSR
> number via register so add common csr_read_num() and csr_write_num()
> functions which allow accessing certain CSRs by passing CSR number
> as parameter. These common functions will be first used by the
> ACPI CPPC driver and RISC-V PMU driver.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

This patch also (silently) removes the CSR number filtering, e.g.

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

... the above code, and:

>  /*
>   * Read the CSR of a corresponding counter.
>   */
>  unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
>  {
> -	if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
> -	   (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
> -		pr_err("Invalid performance counter csr %lx\n", csr);
> -		return -EINVAL;

... the above code.

I'm thinking that we probably want to keep the CSR number filtering code 
in; at least, I can't think of a good reason to remove it.  Care to add it 
back in?


- Paul

