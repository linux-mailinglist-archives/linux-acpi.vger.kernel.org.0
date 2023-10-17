Return-Path: <linux-acpi+bounces-690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D57CC0E0
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 12:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8D5B20F97
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6AD4120C
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="R3ZF9f1H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5A3B79A
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 08:41:08 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C1DB0
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 01:41:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso43428451fa.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697532064; x=1698136864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vB/kfuKzCfr9/00WQN4N9vxRELf8bEUkzHFo66uF28g=;
        b=R3ZF9f1HNyy7HOzN+cTg0IAThBU+IHV8MuZTrM97HH1IrK2VM3FN/mic4pWarQQfO7
         dE6WTJ83n1aDTU/nZ5HnCUORtJ2yAFGiYHTbMthWP4xACRdLolETRTLPwwwtVLRP4OEY
         5x3f9uomRT+eRZOZZKGuPhwXLKnyZbl0pX1xFRjhpA58x++HJ2bAolWERx6bJILdT6n6
         pe/IY+sZyd7TDP+ibYrt3iCEiGHumINC2Bv9nlgrmdifB/Rrf4/JAEjxmh3HoEx316n1
         h/ZvQevyCkhc10wsdJWXWGYeJmm3qw+DPXJ/YbTbCxFrH1Kr2dzVUAg3OAA3WS1VASZi
         aKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532064; x=1698136864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB/kfuKzCfr9/00WQN4N9vxRELf8bEUkzHFo66uF28g=;
        b=Ugg9QuQkb4mP/CMwkc/6DPH+efGUEoyIZlGwj0b7Psep870fvxbISp+DVsL00JGKBf
         gxRqyQ6ePUcZZ6BD5VkeKnZJ31ZW+uYUzwSFXVEjkhwLmGtAkZ7pvxhyy+3QnmFAxZwU
         lIZRTrICEcGVMietKkTTQ4VUyJQdFv36JetfJE+x4pbIuZHCL3n+nMrZ0vcao2dxHwaS
         X3MCDZAhMxZjxehWZXT9yyXC9RWs/pGtvaK5hwp1NmDpJ0sV5jl9bbKJztfIS99gaKvB
         vjZbkvbSo1Gc1tABdVqwGlkBXQbR50Fhuwhc/tXlTCtF84lFiACZoTwH36ZTTu8orMyh
         DSVQ==
X-Gm-Message-State: AOJu0YzOaXRW2u0jfiCrcefO51YpC5b/9XZs373wDTcaGwX6GA/sxhHJ
	En6EJGMdonNVZiXGnePUWuFrxQ==
X-Google-Smtp-Source: AGHT+IGhiqrfDB4ZTR0M/BpXYyS+AZ/LIFG8yzd1vQg3LLGnmte00ytOqfmObo/yWeIIK6ortCSl8Q==
X-Received: by 2002:a2e:9214:0:b0:2c2:8f22:d9c2 with SMTP id k20-20020a2e9214000000b002c28f22d9c2mr1361491ljg.22.1697532064466;
        Tue, 17 Oct 2023 01:41:04 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d51c2000000b0032da4f70756sm1164746wrv.5.2023.10.17.01.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:41:03 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:41:02 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Anup Patel <apatel@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 3/3] RISC-V: cacheflush: Initialize CBO
 variables on ACPI systems
Message-ID: <20231017-e198b2c70475b6f09754d175@orel>
References: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
 <20231016164958.1191529-4-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016164958.1191529-4-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 10:19:58PM +0530, Sunil V L wrote:
> Initialize the CBO variables on ACPI based systems using information in
> RHCT.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/mm/cacheflush.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index f1387272a551..55a34f2020a8 100644
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
> @@ -124,13 +126,24 @@ void __init riscv_init_cbo_blocksizes(void)
>  	unsigned long cbom_hartid, cboz_hartid;
>  	u32 cbom_block_size = 0, cboz_block_size = 0;
>  	struct device_node *node;
> +	struct acpi_table_header *rhct;
> +	acpi_status status;
> +
> +	if (acpi_disabled) {
> +		for_each_of_cpu_node(node) {
> +			/* set block-size for cbom and/or cboz extension if available */
> +			cbo_get_block_size(node, "riscv,cbom-block-size",
> +					   &cbom_block_size, &cbom_hartid);
> +			cbo_get_block_size(node, "riscv,cboz-block-size",
> +					   &cboz_block_size, &cboz_hartid);
> +		}
> +	} else {
> +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> +		if (ACPI_FAILURE(status))
> +			return;
>  
> -	for_each_of_cpu_node(node) {
> -		/* set block-size for cbom and/or cboz extension if available */
> -		cbo_get_block_size(node, "riscv,cbom-block-size",
> -				   &cbom_block_size, &cbom_hartid);
> -		cbo_get_block_size(node, "riscv,cboz-block-size",
> -				   &cboz_block_size, &cboz_hartid);
> +		acpi_get_cbo_block_size(rhct, &cbom_block_size, &cboz_block_size, NULL);
> +		acpi_put_table((struct acpi_table_header *)rhct);
>  	}
>  
>  	if (cbom_block_size)
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

