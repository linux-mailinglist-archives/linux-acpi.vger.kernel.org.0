Return-Path: <linux-acpi+bounces-15850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E68B2D4D1
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557B717F59C
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0412F2D6E72;
	Wed, 20 Aug 2025 07:26:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C502D660A;
	Wed, 20 Aug 2025 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674778; cv=none; b=eXNHXwQrezRWrgpoA0FSHdr3AuMN5vtkuFQZjWKlhIooQwjh2p6m+v5eSrRe9ZebMPOj6nENWOA/pZd38L8aQ7bim6voDM0BVfrbs/j6MLLgnO190JSrnWzhlcT/FWJ+RqeSAH3mm4VEaIno0CYgrfPE8tsMq1p/vdaMc+OESk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674778; c=relaxed/simple;
	bh=zPnGrSb0K3cnzhxgzKjh/vnK+d19vA/C2BdsVgWufQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtL767kCwtL9yPP5P9JdSpGk++JbwUqNFMPQdTcEHWFFtAG65A5oQzgT2GrRBafhr7edbTLhIJihRmKPcuBHOHbou1P1iNpV3WoIFjBnbVpc9IsCS6Nk6zcnI0m15QpVrdIckjN4goarm0tNrUfEhMANRJ3HpBrO9la4JaNs/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id DF522580CC5;
	Wed, 20 Aug 2025 07:12:54 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E781442EB;
	Wed, 20 Aug 2025 07:12:44 +0000 (UTC)
Message-ID: <b18c4283-388a-4b4a-91cb-ae686d7efc11@ghiti.fr>
Date: Wed, 20 Aug 2025 09:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
To: Anup Patel <apatel@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Len Brown <lenb@kernel.org>,
 Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Troy Mitchell <troy.mitchell@linux.dev>
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-2-apatel@ventanamicro.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250818143600.894385-2-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvdgrtdegmegtvggttdemuddvudgumehfvdefvdemjegufhekmegsfhegsgemgeeliegvmeduugegsgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtgeemtggvtgdtmeduvdduugemfhdvfedvmeejughfkeemsghfgegsmeegleeivgemudgugegspdhhvghloheplgfkrfggieemvdgrtdegmegtvggttdemuddvudgumehfvdefvdemjegufhekmegsfhegsgemgeeliegvmeduugegsggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheprghprghtvghlsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehsuhhnihhlvhhlsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrthhishhhrdhprghtrhgrsehlihhnuhigrdguvghvpdhrtghpthhtoheprghjohhnvghssehvvghnthgrnhgrmhhitghrohdrtghomh

Hi Anup,

On 8/18/25 16:35, Anup Patel wrote:
> The cppc_ffh_csr_read() and cppc_ffh_csr_write() returns Linux error
> code in "data->ret.error" so cpc_read_ffh() and cpc_write_ffh() must
> not use sbi_err_map_linux_errno() for FFH_CPPC_CSR.
>
> Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
> ---
>   drivers/acpi/riscv/cppc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 440cf9fb91aa..42c1a9052470 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -119,7 +119,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>   
>   		*val = data.ret.value;
>   
> -		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
> +		return data.ret.error;
>   	}
>   
>   	return -EINVAL;
> @@ -148,7 +148,7 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
>   
>   		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
>   
> -		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
> +		return data.ret.error;
>   	}
>   
>   	return -EINVAL;


I picked this up for fixes, cc stable and I'll send this patch for some 
6.17-rcX.

Thanks,

Alex


