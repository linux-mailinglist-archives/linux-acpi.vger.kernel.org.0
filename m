Return-Path: <linux-acpi+bounces-15746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF3B286D4
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 22:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752511894EB0
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 20:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B042566D2;
	Fri, 15 Aug 2025 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DKId6Znk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6232853EB
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288126; cv=none; b=OQ2qhL5I6UupIsz4rx0/K2VfkRnJ/6KIH0WQkh0JMgHR5LTs3tdNp46g3CkrLwDbzvL/lObg7YK7or9K3kqi8P1Ng1hKBgXhqL159YYcwLqEP3RznB89VfrcBqxXJmcEIDnU+BwHc4k1wVbGK3coaOmJaBqMJN4IGD9tAfh7/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288126; c=relaxed/simple;
	bh=VQzmMcgy25baAW7bo3luXKb7dIqwNw4IKclK8IMOAxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK7/RC1zhZm0q5/T9VKbfd1au1M35ZG5Qji18yj4ssqRloga988oLWTnSkhxBj/AD7l1IS4YoyrbwD1hSy1+G+J8RG8THYGY02FZ+Vdve2DvleetYuSvKUNP0c63euDKhawxI0NikucUo6u+20Hvjs1msEKJNOG213MOYEv7Y4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DKId6Znk; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74381df8cf1so668599a34.0
        for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755288124; x=1755892924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcuxVVhwBqk6/ThFcilXJFO7I/Y8OkGOhPu8yVAUZTE=;
        b=DKId6Znk8SQx9oud4z5pt7S4oxkteNCe2e7RuSWDBubOUCg+YdxLv3wVvE2sDXv1Lm
         NitRpnDMlZomC0dY2MU3jOsWOrOJTrxUoQMf7Q2korpxnaZ327RcVAxvqlgPWyz9nzLV
         rjR6ZUNb8aXZKshMSQPGOWUJ2xa/0E2YSsQSg2wjPr/iTb+zCGSFGt8lro+AL2Fz47OT
         dACJmRm/fEp2R/UosRcOG7gu9sFBkFfaSyX0YR73oeqjFRN42CGIZin6DtrzSz+AwTen
         CfP0L17iNwddNSyhbUSppFgJs0yaehEOMj9sfh6/oAM9jexKNbxGVrto9FO/VoYk9WV1
         083A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755288124; x=1755892924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcuxVVhwBqk6/ThFcilXJFO7I/Y8OkGOhPu8yVAUZTE=;
        b=n+M+JpiFLrWQYTkjSayImk8M2FYF/CNumwD9qRaJgXwPPWmVJ9MmVKVri/rO6NVSmG
         VYjVCTDLFp0+IIsky06EDpBnnTLE2sNtYNL7/KVdwt2rVOWVghHXGFPCppzv9owA/b3w
         iV8+b8k+twIbaJQtLsmPgMg+IUP+SK+uOxYKXCkDF3I53jymYsu1hOTB5stAFcg/1KMl
         Ezuab4/mqsOsgoUfad711bkdiNfqBvlaGWxlI5IcAS+sc25Dvu6LQO5EApNIoPP5TcN2
         +ZMGJhJyFlUt4d3pX2BFwoYPPBdpyCwpq4TuMORHThnDka1UuvHHbSvgIRsuRWMT0YAa
         OLBw==
X-Forwarded-Encrypted: i=1; AJvYcCWxKbLf9tBdyfi1H2ZqYZf4VPPjf7SNWyhqF6QSyWZjtCDBhuJfHIC8zZpX/HIatX3Q1nC0NVg9yboh@vger.kernel.org
X-Gm-Message-State: AOJu0YyuP6nc7l9TYfK7aoXSnjvxEiFKvv7ct4ciJBu6nokVOkyAbEY1
	JuozH71HwkUUkfTpDmxJC9YGjjhBKAiNQqdLzd+KJNbw9sG1RwAfvRzjrXQWh6QE798=
X-Gm-Gg: ASbGncvSxrTCUQU8LtlgsLaAm/syiza9G/m8K/7SbE2eiabdVPZbr3er1K0jmyDoPJU
	m1cYt19tcwXDk1dhCzFjulbQRt1P+FWx8XS8r16Vc+CcZZJlqN+HVk2efVUuC63FntoLRdtLvmm
	NUw/fL/wpDTxhVH+2NZ7Kr1Yx2fh9OujpBPdHUKlvsFF7sPDLhvTwONzSZmhokJ6P5pRYuxauZH
	iLyxhZ9W3TPyHXTZQLHnVu8vPqCCcPiGqsqA+FhWHyWLau2dHrZ6WdDLQdHJvIw58mKpNzt5GcX
	Lbe26WpFodllKGs1qrNRAceZ4ebG02ZCCxLEwuqBrLwe3wHo/TMa9kUgNXZ/Kc6pmVcGvTI0nMO
	4U222GB66Qvb2KNzplTgAQALD
X-Google-Smtp-Source: AGHT+IH6UijrJj9CokQ7LeOZUer1dBOG0/ag/iMKh5MHL6K68xaBLTbERAAjBI3+UFgVXTVGT2cXIw==
X-Received: by 2002:a05:6808:3a0e:b0:435:8501:2b96 with SMTP id 5614622812f47-435ec540455mr1913900b6e.21.1755288123755;
        Fri, 15 Aug 2025 13:02:03 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c949f85b6sm589160173.67.2025.08.15.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 13:02:03 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:02:02 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
Message-ID: <20250815-e69bdc695cf78e6ce07e580c@orel>
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

My preference would be for an interface with the return/err parameters the
other way around, i.e.

int csr_read_num(unsigned long csr_num, unsigned long *val);
int csr_write_num(unsigned long csr_num, unsigned long val);

and then ensure all callers always check that the return value is zero
before proceeding to use val or assume val was written.

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
>  }
>  
>  u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
> -- 
> 2.43.0
>

Other than the suggestion to flip the interface,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

