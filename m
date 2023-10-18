Return-Path: <linux-acpi+bounces-735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245567CE033
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32CC281125
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B61037C8E
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="e85e5oM0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2998171BA
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 13:05:34 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1339D119
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 06:05:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405497850dbso64133745e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697634331; x=1698239131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GBX62DseBvfVHXeEbOvo2juJ8HpiHCck4wGzzm+Z4mE=;
        b=e85e5oM0J5S12f++M+YJMvVFZ46ykUlYQJVF91TqktqA3WwuiYsGpP9PniiILoQNj9
         68s4s1gfgmNL/iQDmemltXQvgzY7qi3EQ/AE9f1dPwNXvUPSIm6hoEaSJQi/6RGDOvlS
         Clq4gCmV1Ma/cTYJmGGSPJc0YFaqNhfIzIV4ltDZRvF/SbGyYphSGmfScYfaDHcSxjPr
         1C57TaVqSaCDhl1Tr3ffdP9vKZ/9HTH0Z1fJ9wp/SQ7FNlAPyfBfCtPHsiO8ahIXp2i0
         PxUDkR0G+teziqeMvpzEcSTM7uWkFyz8TyGUflQsbyIao+tINphp8dKPRkoCk0H4WZnt
         8zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634331; x=1698239131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBX62DseBvfVHXeEbOvo2juJ8HpiHCck4wGzzm+Z4mE=;
        b=PbXM8ykCtwKCsUQ0tEgDzTH2Xm2kFiCK1JjdWUzqM2HQnYB4D5SMko327+ZphgmVXk
         gsbgb6qGA1v3t6eOzj0gZnyQyiittRh1jdZEz1PLpcY5sf0Ihx7qAWmM7acRk3G6iSS7
         mk/Nx3I0zTQy3sN2G/R8gG0mF8sBOl0OStW6dQH/V9QCpKAHpPeXlqbtmWhxiItmKrCy
         Xjv7BsWayPmE3XyrH0m7Iu29ghIF246/mt4exBwI6oI0N2MCOAa07uVwKWvnGg/A9fhY
         n88obf46wsVZlsrnfjVSbLlYXQLiGp8Ho1XqHH1MWKgay6vOgj7wsrDxxJUpJe9CcoTH
         rRhA==
X-Gm-Message-State: AOJu0YxsdiTs5XgJiYQqoiHKFAbHWYy03zEGGSQh1e4HNNXT1q2Rk0Lq
	tf2/iyjpb9wrBQIueRyLqvIPJg==
X-Google-Smtp-Source: AGHT+IF8gZ4+4pSrBgYaHk7XtB6rAHNxDkDq0yccZv1U0hcVx5il84WsHJ3BL8WIR1OEPUv2qiE9jg==
X-Received: by 2002:a05:600c:294c:b0:405:499a:7fc1 with SMTP id n12-20020a05600c294c00b00405499a7fc1mr3869445wmd.40.1697634331212;
        Wed, 18 Oct 2023 06:05:31 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c15d200b004063d8b43e7sm1621073wmf.48.2023.10.18.06.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:05:30 -0700 (PDT)
Date: Wed, 18 Oct 2023 15:05:29 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v4 -next 2/4] RISC-V: ACPI: Update the return value of
 acpi_get_rhct()
Message-ID: <20231018-ea3dd893b735ce7ddb953ff5@orel>
References: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
 <20231018124007.1306159-3-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018124007.1306159-3-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 06:10:05PM +0530, Sunil V L wrote:
> acpi_get_rhct() currently returns pointer to acpi_table_header
> structure. But since this is specific to RHCT, return pointer to
> acpi_table_rhct structure itself.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/riscv/rhct.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
> index b280b3e9c7d9..489b0e93b1e5 100644
> --- a/drivers/acpi/riscv/rhct.c
> +++ b/drivers/acpi/riscv/rhct.c
> @@ -9,7 +9,7 @@
>  
>  #include <linux/acpi.h>
>  
> -static struct acpi_table_header *acpi_get_rhct(void)
> +static struct acpi_table_rhct *acpi_get_rhct(void)
>  {
>  	static struct acpi_table_header *rhct;
>  	acpi_status status;
> @@ -26,7 +26,7 @@ static struct acpi_table_header *acpi_get_rhct(void)
>  		}
>  	}
>  
> -	return rhct;
> +	return (struct acpi_table_rhct *)rhct;
>  }
>  
>  /*
> @@ -48,7 +48,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
>  	BUG_ON(acpi_disabled);
>  
>  	if (!table) {
> -		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
> +		rhct = acpi_get_rhct();
>  		if (!rhct)
>  			return -ENOENT;
>  	} else {
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

