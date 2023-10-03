Return-Path: <linux-acpi+bounces-403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A47B7290
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 22:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 004CD281207
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9583D962
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ECF3CD0A
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 19:50:07 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77467AB
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 12:50:05 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7741b18a06aso98277685a.1
        for <linux-acpi@vger.kernel.org>; Tue, 03 Oct 2023 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1696362604; x=1696967404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9OkhUo6mnx7uMIpcoe9v3PNzerEgkLVZ1kjAanFY00=;
        b=L5z291MEp/0QlzL5FPorR8t2lgGPAcyBfSqpEmMzwWs92WqGXCZV32S2g4Tb1ySil6
         HMk619IE+Z1IubB0pirMf2qIKgmuiR9j03847YxmP7LXkGMKyeux+0gAXYOQHiCQ9bDa
         aC6z2+AI+TlqR9yzBH9Sr89+4aZYu5wJEGp9Aj1n/zMW9TEDnzgVV1undogUUh77Zmmh
         3ZUlb+2pzdtm+apeW4xOqG3gRUOvp7ZyxveD4J+ouFtwMdtcbpnug9pX9UPQ3SWSIdaT
         4/siVOrzO1ARvcwoN6hYDt/cnVHhWPHPF0NbVoxWKJC5u61eAJvMwHriaB05TbHGcygJ
         3oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362604; x=1696967404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9OkhUo6mnx7uMIpcoe9v3PNzerEgkLVZ1kjAanFY00=;
        b=ThgZ4W/dTbt50xOz1mrGpEzdti5NFimxdBeMnGBctWvfNbWAul1GL+81Fs/Hzw6Dki
         FYss0uRsk9E0H+lshrLsdrjrnr7sidrLb2/mdqaVesecAeOpLrnpypzByanP8fdd0rFU
         JCDMDZkQc0OfIBnqgm7XKW70/Zu0+SgZuqJRXI60rdI6enG245rGZKdLhIbtwOY3dewG
         TPYBUCi9P9JFTGEnO7SBjuiWbqhysR5FyxxB8EVVSVeHvLEJOT63pnnM6UCe59fsmTcw
         krd81Qq7LN9K5mdP2OkbcVVKkpJnejazbVFaYUPm5XD7huEW8mwLi13y/A1cy0SwpV+e
         ofpA==
X-Gm-Message-State: AOJu0Yx6LgO8The3ABw2K7c/WICn8k3AF+q7/ODV38ez5A8Cr98c2EML
	eEG2rUO9q1L/IkJ8i5xuynbIRA==
X-Google-Smtp-Source: AGHT+IHKlAb603cnYVhyI7LkeQ3EvgkO8pVwRUeUeHR6q3Zma2WC1Hx+7BvLiQhDqysFF1Yi+ovDCg==
X-Received: by 2002:a05:620a:17a3:b0:765:aac3:7667 with SMTP id ay35-20020a05620a17a300b00765aac37667mr618062qkb.0.1696362604333;
        Tue, 03 Oct 2023 12:50:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:6022:6438:e898:6c27? ([2600:1700:2000:b002:6022:6438:e898:6c27])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b007756fe0bb17sm717260qkm.19.2023.10.03.12.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 12:50:03 -0700 (PDT)
Message-ID: <f4ab7464-3dfb-4d10-8bed-76e7084abd3e@sifive.com>
Date: Tue, 3 Oct 2023 14:50:02 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 3/4] RISC-V: cacheflush: Initialize CBO variables
 on ACPI systems
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Jones <ajones@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>,
 Len Brown <lenb@kernel.org>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-4-sunilvl@ventanamicro.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230927170015.295232-4-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-27 12:00 PM, Sunil V L wrote:
> Using new interface to get the CBO block size information in RHCT,
> initialize the variables on ACPI platforms.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/mm/cacheflush.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index f1387272a551..8e59644e473c 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -3,7 +3,9 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/of.h>
> +#include <asm/acpi.h>
>  #include <asm/cacheflush.h>
>  
>  #ifdef CONFIG_SMP
> @@ -124,15 +126,38 @@ void __init riscv_init_cbo_blocksizes(void)
>  	unsigned long cbom_hartid, cboz_hartid;
>  	u32 cbom_block_size = 0, cboz_block_size = 0;
>  	struct device_node *node;
> +	struct acpi_table_header *rhct;
> +	acpi_status status;
> +	unsigned int cpu;
> +
> +	if (!acpi_disabled) {
> +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> +		if (ACPI_FAILURE(status))
> +			return;
> +	}
>  
> -	for_each_of_cpu_node(node) {
> -		/* set block-size for cbom and/or cboz extension if available */
> -		cbo_get_block_size(node, "riscv,cbom-block-size",
> -				   &cbom_block_size, &cbom_hartid);
> -		cbo_get_block_size(node, "riscv,cboz-block-size",
> -				   &cboz_block_size, &cboz_hartid);
> +	for_each_possible_cpu(cpu) {
> +		if (acpi_disabled) {
> +			node = of_cpu_device_node_get(cpu);
> +			if (!node) {
> +				pr_warn("Unable to find cpu node\n");
> +				continue;
> +			}
> +
> +			/* set block-size for cbom and/or cboz extension if available */
> +			cbo_get_block_size(node, "riscv,cbom-block-size",
> +					   &cbom_block_size, &cbom_hartid);
> +			cbo_get_block_size(node, "riscv,cboz-block-size",
> +					   &cboz_block_size, &cboz_hartid);

This leaks a reference to the device node.

> +		} else {
> +			acpi_get_cbo_block_size(rhct, cpu, &cbom_block_size,
> +						&cboz_block_size, NULL);

This function loops through the whole RHCT already. Why do we need to call it
for each CPU? Can't we just call it once, and have it do the same consistency
checks as cbo_get_block_size()?

In that case, the DT path could keep the for_each_of_cpu_node() loop.

Regards,
Samuel

> +		}
>  	}
>  
> +	if (!acpi_disabled && rhct)
> +		acpi_put_table((struct acpi_table_header *)rhct);
> +
>  	if (cbom_block_size)
>  		riscv_cbom_block_size = cbom_block_size;
>  


