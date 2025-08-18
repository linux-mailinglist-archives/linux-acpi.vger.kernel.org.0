Return-Path: <linux-acpi+bounces-15758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6AFB297AD
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF1A3BBD1A
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A409253358;
	Mon, 18 Aug 2025 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QhthNkzR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1182215798
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490200; cv=none; b=eNr0pwoCAQ7NjBYyZA+2/XAgDmUy9WRsRkshNPrjn7IsRnq7F7xHhgL93mQ6xACwT1OfF4WsAlFBKFDRaamDydE4hN7fLFlYAEkJjCPj1g1pIJkHcxvTFqTvYYxmKxDVaagbynIxincM6EkNESt2Jpga1fJwMFCs1SHtSrmATd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490200; c=relaxed/simple;
	bh=KDAUZIOQ9mn09XpD8lWNv8EwZqCbtqu3Vn6LHsRD3Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqvxl62Nk16T3J9qZrGTWbofB9FWD4xyWESpRkBqiYKqFi/y484UJpwhFfw+gpcL+3wX8nSVGxKKs50SAM0bC3vI+yr88EFdq5dMsRUwTi2raLvRzhfVstLbCeHy36gZyV9R6IHle2BGE4vRPCxB1hXtZxfqTtwcK/yESTQ8mJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QhthNkzR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445826fd9dso40679105ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490198; x=1756094998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cic6m/dj0aD9eVh/PT4j71J5W/VVI1QVdV93xvllQvk=;
        b=QhthNkzRNqPcHBQORei6GgD3r4t6Ptfh86pn+854SXyuPUOlXpygxolIXoEEhMrazC
         F10+tyzMdDmN8B6pVDxWwzK8q/UxEOBtJZ2o1ieJWzSoTko8E6BSVGg/jVHgM7BvzvNu
         Rfq/LZX/7/P/P3AqgJF9O+Qjyt/clcNC+vDYndTbZSS7bAZAcyXFx6alvBq/R72ywuj3
         Yt0diSafI4KPfRf19UYUawR97tfsBBCr7pEcg1ngvdNu/TFzQqcZaOpLmv6RFCOjJ9iP
         fuQi3goc778bJaeWs0ZKbAZE/8B4BKS3hZug2Wp5s+eeYKZwAChs5yzFcehGCEnS5cHF
         m5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490198; x=1756094998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cic6m/dj0aD9eVh/PT4j71J5W/VVI1QVdV93xvllQvk=;
        b=h6eMzR3YgNGfEffp+QwsWnvoUW4z7pQqhJNwWygGULbwcDkM0DCOsAXqpinQ7gn/tX
         hQdYjtFgLrbxBSKVQ6W8Isklwbm6GSXFlSSSZghcDlauASWEuK59iFKWahm9FvQKTR9Y
         QqWB3AtLTqxL7mDESRmE5i+mBB/XbTBAU4G+mBryQDLQIe6nnRYefSRXfYCZfFfXFRq+
         MskEZvU+oTkcpxybLwXr6WIn7bjKIAJwS17npH8WvOa6r9BB7dXuvXZHWpPEj6Mb8OJG
         +5CMbuHD7euFqz0/g+uowZJoiy2afbWE3uQiKzFonl52TExy9C7pKXmkaDV7LilwcM5r
         yOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTJyxvm6ZhdyE0PGz8n4tirmto9Jt1rbZnas4bLiXwhoT7j59l2J34xf2w+ffvwP7U0xvkSg2WLH5a@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1R+iVW1sp15U64yfGXDE6B7SOCJcc68oif/PIjm2MNI2bnZ/c
	yiL0DvpW9JFIRIf5RzwFb9NeaAEp5rQXHnpdzS+T2uTKTfoqajOdutOaK+UpV5dKWEo=
X-Gm-Gg: ASbGncv5VP5NoS/4wK2bwtXhoYaYKL9b7Jmt9PtZXSYqUC7aFRQYXl9RkFMSkoP/c/E
	gFq7O+OvQ/qDaFXh00dRMqQqZFi4iBao3C96KLa8LYSEDmRfmdG2+vX6+h5iNNdkJwpFJL6BDqG
	gWOJl4FlaFdO2YOD5wTX7tHNAAYEEnR/ggf2WPNcUweDPy6OTfQs/bAo3B7Aeywrn4nwCIJMNpr
	trT3kCo5RkclysWny60QznmC/Bh1cRKfw+XJkFRA4NgXINEWXtIgtecI7p00jhdsuLAp8V1XcJB
	kkf6O8j+dSBBqEmQ9djwTdCLlUVvoWKLTCihnukU9lNsRs+S04+y6swPUkVoCni23GR6t2o35aE
	U3hAkpqq8ThIY/Ck589N0hwMOR8dCAELcasuCoQ==
X-Google-Smtp-Source: AGHT+IECZ/fHWu0eLpHlyIlOaOKTW7TB5KbiIYIV2gyGFhcdQyqL1sbiVLLuzteuinhCHVBZ4RQLFQ==
X-Received: by 2002:a17:903:4b4c:b0:23f:f3e1:7363 with SMTP id d9443c01a7336-2446d73e7c9mr128300415ad.23.1755490197940;
        Sun, 17 Aug 2025 21:09:57 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d578aa4sm66701445ad.153.2025.08.17.21.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:09:57 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:39:48 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
Message-ID: <aKKnjDt5bSTFtFQX@sunil-laptop>
References: <20250815161406.76370-1-apatel@ventanamicro.com>
 <20250815161406.76370-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815161406.76370-3-apatel@ventanamicro.com>

On Fri, Aug 15, 2025 at 09:44:06PM +0530, Anup Patel wrote:
> In RISC-V, there is no CSR read/write instruction which takes CSR
> number via register so add common csr_read_num() and csr_write_num()
> functions which allow accessing certain CSRs by passing CSR number
> as parameter. These common functions will be first used by the
> ACPI CPPC driver and RISC-V PMU driver.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/csr.h |   3 +
>  arch/riscv/kernel/Makefile   |   1 +
>  arch/riscv/kernel/csr.c      | 177 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/riscv/cppc.c    |  17 ++--
>  drivers/perf/riscv_pmu.c     |  43 +--------
>  5 files changed, 189 insertions(+), 52 deletions(-)
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
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_CSR_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index c7b542573407..0a75e20bde18 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -50,6 +50,7 @@ obj-y	+= soc.o
>  obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
>  obj-y	+= cpu.o
>  obj-y	+= cpufeature.o
> +obj-y	+= csr.o
>  obj-y	+= entry.o
>  obj-y	+= irq.o
>  obj-y	+= process.o
> diff --git a/arch/riscv/kernel/csr.c b/arch/riscv/kernel/csr.c
> new file mode 100644
> index 000000000000..f7de45bb597c
> --- /dev/null
> +++ b/arch/riscv/kernel/csr.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Ventana Micro Systems Inc.
> + */
> +
> +#define pr_fmt(fmt) "riscv: " fmt
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/printk.h>
> +#include <linux/types.h>
> +#include <asm/csr.h>
> +
> +#define CSR_CUSTOM0_U_RW_BASE		0x800
> +#define CSR_CUSTOM0_U_RW_COUNT		0x100
> +
> +#define CSR_CUSTOM1_U_RO_BASE		0xCC0
> +#define CSR_CUSTOM1_U_RO_COUNT		0x040
> +
> +#define CSR_CUSTOM2_S_RW_BASE		0x5C0
> +#define CSR_CUSTOM2_S_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM3_S_RW_BASE		0x9C0
> +#define CSR_CUSTOM3_S_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM4_S_RO_BASE		0xDC0
> +#define CSR_CUSTOM4_S_RO_COUNT		0x040
> +
> +#define CSR_CUSTOM5_HS_RW_BASE		0x6C0
> +#define CSR_CUSTOM5_HS_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM6_HS_RW_BASE		0xAC0
> +#define CSR_CUSTOM6_HS_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM7_HS_RO_BASE		0xEC0
> +#define CSR_CUSTOM7_HS_RO_COUNT		0x040
> +
> +#define CSR_CUSTOM8_M_RW_BASE		0x7C0
> +#define CSR_CUSTOM8_M_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM9_M_RW_BASE		0xBC0
> +#define CSR_CUSTOM9_M_RW_COUNT		0x040
> +
> +#define CSR_CUSTOM10_M_RO_BASE		0xFC0
> +#define CSR_CUSTOM10_M_RO_COUNT		0x040
> +
> +unsigned long csr_read_num(unsigned long csr_num, int *out_err)
> +{
> +#define switchcase_csr_read(__csr_num)				\
> +	case (__csr_num):					\
> +		return csr_read(__csr_num)
> +#define switchcase_csr_read_2(__csr_num)			\
> +	switchcase_csr_read(__csr_num + 0);			\
> +	switchcase_csr_read(__csr_num + 1)
> +#define switchcase_csr_read_4(__csr_num)			\
> +	switchcase_csr_read_2(__csr_num + 0);			\
> +	switchcase_csr_read_2(__csr_num + 2)
> +#define switchcase_csr_read_8(__csr_num)			\
> +	switchcase_csr_read_4(__csr_num + 0);			\
> +	switchcase_csr_read_4(__csr_num + 4)
> +#define switchcase_csr_read_16(__csr_num)			\
> +	switchcase_csr_read_8(__csr_num + 0);			\
> +	switchcase_csr_read_8(__csr_num + 8)
> +#define switchcase_csr_read_32(__csr_num)			\
> +	switchcase_csr_read_16(__csr_num + 0);			\
> +	switchcase_csr_read_16(__csr_num + 16)
> +#define switchcase_csr_read_64(__csr_num)			\
> +	switchcase_csr_read_32(__csr_num + 0);			\
> +	switchcase_csr_read_32(__csr_num + 32)
> +#define switchcase_csr_read_128(__csr_num)			\
> +	switchcase_csr_read_64(__csr_num + 0);			\
> +	switchcase_csr_read_64(__csr_num + 64)
> +#define switchcase_csr_read_256(__csr_num)			\
> +	switchcase_csr_read_128(__csr_num + 0);			\
> +	switchcase_csr_read_128(__csr_num + 128)
> +
> +	if (out_err)
> +		*out_err = 0;
> +
> +	switch (csr_num) {
> +	switchcase_csr_read_32(CSR_CYCLE);
> +	switchcase_csr_read_32(CSR_CYCLEH);
> +	switchcase_csr_read_256(CSR_CUSTOM0_U_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM1_U_RO_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM2_S_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM3_S_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM4_S_RO_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM5_HS_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM6_HS_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM7_HS_RO_BASE);
> +#ifdef CONFIG_RISCV_M_MODE
> +	switchcase_csr_read_64(CSR_CUSTOM8_M_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM9_M_RW_BASE);
> +	switchcase_csr_read_64(CSR_CUSTOM10_M_RO_BASE);
> +#endif
> +	default:
> +		if (out_err)
> +			*out_err = -EINVAL;
> +		else
> +			pr_err("%s: csr 0x%lx not supported\n", __func__, csr_num);
> +		break;
> +	}
> +
> +	return 0;
> +#undef switchcase_csr_read_256
> +#undef switchcase_csr_read_128
> +#undef switchcase_csr_read_64
> +#undef switchcase_csr_read_32
> +#undef switchcase_csr_read_16
> +#undef switchcase_csr_read_8
> +#undef switchcase_csr_read_4
> +#undef switchcase_csr_read_2
> +#undef switchcase_csr_read
> +}
> +EXPORT_SYMBOL_GPL(csr_read_num);
> +
> +void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err)
> +{
> +#define switchcase_csr_write(__csr_num, __val)			\
> +	case (__csr_num):					\
> +		csr_write(__csr_num, __val);			\
> +		break
> +#define switchcase_csr_write_2(__csr_num, __val)		\
> +	switchcase_csr_write(__csr_num + 0, __val);		\
> +	switchcase_csr_write(__csr_num + 1, __val)
> +#define switchcase_csr_write_4(__csr_num, __val)		\
> +	switchcase_csr_write_2(__csr_num + 0, __val);		\
> +	switchcase_csr_write_2(__csr_num + 2, __val)
> +#define switchcase_csr_write_8(__csr_num, __val)		\
> +	switchcase_csr_write_4(__csr_num + 0, __val);		\
> +	switchcase_csr_write_4(__csr_num + 4, __val)
> +#define switchcase_csr_write_16(__csr_num, __val)		\
> +	switchcase_csr_write_8(__csr_num + 0, __val);		\
> +	switchcase_csr_write_8(__csr_num + 8, __val)
> +#define switchcase_csr_write_32(__csr_num, __val)		\
> +	switchcase_csr_write_16(__csr_num + 0, __val);		\
> +	switchcase_csr_write_16(__csr_num + 16, __val)
> +#define switchcase_csr_write_64(__csr_num, __val)		\
> +	switchcase_csr_write_32(__csr_num + 0, __val);		\
> +	switchcase_csr_write_32(__csr_num + 32, __val)
> +#define switchcase_csr_write_128(__csr_num, __val)		\
> +	switchcase_csr_write_64(__csr_num + 0, __val);		\
> +	switchcase_csr_write_64(__csr_num + 64, __val)
> +#define switchcase_csr_write_256(__csr_num, __val)		\
> +	switchcase_csr_write_128(__csr_num + 0, __val);		\
> +	switchcase_csr_write_128(__csr_num + 128, __val)
> +
> +	if (out_err)
> +		*out_err = 0;
> +
> +	switch (csr_num) {
> +	switchcase_csr_write_256(CSR_CUSTOM0_U_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM2_S_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM3_S_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM5_HS_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM6_HS_RW_BASE, val);
> +#ifdef CONFIG_RISCV_M_MODE
> +	switchcase_csr_write_64(CSR_CUSTOM8_M_RW_BASE, val);
> +	switchcase_csr_write_64(CSR_CUSTOM9_M_RW_BASE, val);
> +#endif
> +	default:
> +		if (out_err)
> +			*out_err = -EINVAL;
> +		else
> +			pr_err("%s: csr 0x%lx not supported\n", __func__, csr_num);
> +		break;
> +	}
> +#undef switchcase_csr_write_256
> +#undef switchcase_csr_write_128
> +#undef switchcase_csr_write_64
> +#undef switchcase_csr_write_32
> +#undef switchcase_csr_write_16
> +#undef switchcase_csr_write_8
> +#undef switchcase_csr_write_4
> +#undef switchcase_csr_write_2
> +#undef switchcase_csr_write
> +}
> +EXPORT_SYMBOL_GPL(csr_write_num);
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
>  
>  /*
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 7644147d50b4..aa053254448d 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -16,6 +16,7 @@
>  #include <linux/smp.h>
>  #include <linux/sched_clock.h>
>  
> +#include <asm/csr.h>
>  #include <asm/sbi.h>
>  
>  static bool riscv_perf_user_access(struct perf_event *event)
> @@ -88,46 +89,6 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time_short = 1;
>  }
>  
> -static unsigned long csr_read_num(int csr_num)
> -{
> -#define switchcase_csr_read(__csr_num, __val)		{\
> -	case __csr_num:					\
> -		__val = csr_read(__csr_num);		\
> -		break; }
> -#define switchcase_csr_read_2(__csr_num, __val)		{\
> -	switchcase_csr_read(__csr_num + 0, __val)	 \
> -	switchcase_csr_read(__csr_num + 1, __val)}
> -#define switchcase_csr_read_4(__csr_num, __val)		{\
> -	switchcase_csr_read_2(__csr_num + 0, __val)	 \
> -	switchcase_csr_read_2(__csr_num + 2, __val)}
> -#define switchcase_csr_read_8(__csr_num, __val)		{\
> -	switchcase_csr_read_4(__csr_num + 0, __val)	 \
> -	switchcase_csr_read_4(__csr_num + 4, __val)}
> -#define switchcase_csr_read_16(__csr_num, __val)	{\
> -	switchcase_csr_read_8(__csr_num + 0, __val)	 \
> -	switchcase_csr_read_8(__csr_num + 8, __val)}
> -#define switchcase_csr_read_32(__csr_num, __val)	{\
> -	switchcase_csr_read_16(__csr_num + 0, __val)	 \
> -	switchcase_csr_read_16(__csr_num + 16, __val)}
> -
> -	unsigned long ret = 0;
> -
> -	switch (csr_num) {
> -	switchcase_csr_read_32(CSR_CYCLE, ret)
> -	switchcase_csr_read_32(CSR_CYCLEH, ret)
> -	default :
> -		break;
> -	}
> -
> -	return ret;
> -#undef switchcase_csr_read_32
> -#undef switchcase_csr_read_16
> -#undef switchcase_csr_read_8
> -#undef switchcase_csr_read_4
> -#undef switchcase_csr_read_2
> -#undef switchcase_csr_read
> -}
> -
>  /*
>   * Read the CSR of a corresponding counter.
>   */
> @@ -139,7 +100,7 @@ unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
>  		return -EINVAL;
>  	}
>  
> -	return csr_read_num(csr);
> +	return csr_read_num(csr, NULL);
>
I think it is better to pass valid error pointer here.

>  }
>  
>  u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
> -- 
> 2.43.0
> 

Otherwise, LGTM.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

