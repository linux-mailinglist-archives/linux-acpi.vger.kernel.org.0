Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDAB640CB3
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Dec 2022 18:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiLBR55 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Dec 2022 12:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiLBR5y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Dec 2022 12:57:54 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B094B1AD93
        for <linux-acpi@vger.kernel.org>; Fri,  2 Dec 2022 09:57:50 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r18so4954071pgr.12
        for <linux-acpi@vger.kernel.org>; Fri, 02 Dec 2022 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpV6FtlGJmbPG4Gl6DlIwigphMAcM3UTUgrO4+lemWs=;
        b=AkdsJdvyIzbTuxBG/JKnklHpRXvVoLQA+8QI40Wz8FNvV41nXCSqsOQRPDxX0N6mEy
         cJaZXq8mcQuxRYKeGkHP9JyRcNbOSAtl0KGE1cYX+PntDHTqVls2XiM3BUxBXugnEgPg
         DvaeP/WTKdcCR/FStVwt2fHfvEW68ZeigiLiaw/i6bJA08q4Px7GR93qwKjVSzpz5RS3
         HJh2cHG24Lm+5FYDTZGw9tb5zsKbY0KtZk+ryW+JL3iJPo406PUQi1NHt/59+1wHFdIE
         vsht164Xjq3jDzr/OqP3UtRBAdGb//TTH8L2h/ew4aaJR7YNleU7PvgmnnB6ETBPnARP
         rdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpV6FtlGJmbPG4Gl6DlIwigphMAcM3UTUgrO4+lemWs=;
        b=TkxF02Zfugeq+kcfXqKA7svcapCKprzbZfK8zH4vSUpNAAEiy4OSXJkmwmaXeuKazk
         vrAoHEAADejgOsJMudKJdRNVqsS133fjZY6t+e79Y+GLVtKmz6n3+ws6UtsMiZQuTnZq
         noM3r4kWRziGGimx7WwsWqzMbQWYpvCWYOkdLwydgp5BJtq6k1lmJb8Kf4X5L3yYXV6m
         LMYr0RBKAAmWvYkZ5ZpO1jzg7hSFniNQTx3+veljYWS93D0UW1X6Tv2P2a7Bj7nDVBTU
         iK1B2EJuFMThw7KLcYAX8ApxQoM2fEg64g7ee2DrEf5gN37Uf//97165uHCJsnguml2H
         70IQ==
X-Gm-Message-State: ANoB5pm8I7XdrFoYpu00QWx4nQ5hXBY17Lo9unuJ0sCoGXFZzjR81ED+
        0Wmmp+N9o5sITkXsqHu4iPcZbg==
X-Google-Smtp-Source: AA0mqf6tDVB0CBWC9FT//8hYKJadLUBKQvQlKGnAljbWEkPH2FhmEmO8yFibfCHNjYT0HqGFeeM8yA==
X-Received: by 2002:a62:3882:0:b0:56b:9ce2:891f with SMTP id f124-20020a623882000000b0056b9ce2891fmr58857615pfa.43.1670003869850;
        Fri, 02 Dec 2022 09:57:49 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b00189812a5397sm5802867plb.180.2022.12.02.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:57:49 -0800 (PST)
Date:   Fri, 02 Dec 2022 09:57:49 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 09:57:35 PST (-0800)
Subject:     Re: [PATCH v2 1/5] cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
In-Reply-To: <20221121171217.3581004-2-pierre.gondois@arm.com>
CC:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Rob.Herring@arm.com, pierre.gondois@arm.com,
        Conor Dooley <conor.dooley@microchip.com>,
        sudeep.holla@arm.com, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, rafael@kernel.org, lenb@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, jeremy.linton@arm.com,
        gshan@redhat.com, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     pierre.gondois@arm.com
Message-ID: <mhng-386efd8d-215e-4e3a-bbaa-ea03c843ab96@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 21 Nov 2022 09:12:09 PST (-0800), pierre.gondois@arm.com wrote:
> RISC-V's implementation of init_of_cache_level() is following
> the Devicetree Specification v0.3 regarding caches, cf.:
> - s3.7.3 'Internal (L1) Cache Properties'
> - s3.8 'Multi-level and Shared Cache Nodes'
>
> Allow reusing the implementation by moving it.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/riscv/kernel/cacheinfo.c | 39 +------------------------------
>  drivers/base/cacheinfo.c      | 44 +++++++++++++++++++++++++++++++++++
>  include/linux/cacheinfo.h     |  1 +
>  3 files changed, 46 insertions(+), 38 deletions(-)
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 90deabfe63ea..440a3df5944c 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -115,44 +115,7 @@ static void fill_cacheinfo(struct cacheinfo **this_leaf,
>
>  int init_cache_level(unsigned int cpu)
>  {
> -	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> -	struct device_node *np = of_cpu_device_node_get(cpu);
> -	struct device_node *prev = NULL;
> -	int levels = 0, leaves = 0, level;
> -
> -	if (of_property_read_bool(np, "cache-size"))
> -		++leaves;
> -	if (of_property_read_bool(np, "i-cache-size"))
> -		++leaves;
> -	if (of_property_read_bool(np, "d-cache-size"))
> -		++leaves;
> -	if (leaves > 0)
> -		levels = 1;
> -
> -	prev = np;
> -	while ((np = of_find_next_cache_node(np))) {
> -		of_node_put(prev);
> -		prev = np;
> -		if (!of_device_is_compatible(np, "cache"))
> -			break;
> -		if (of_property_read_u32(np, "cache-level", &level))
> -			break;
> -		if (level <= levels)
> -			break;
> -		if (of_property_read_bool(np, "cache-size"))
> -			++leaves;
> -		if (of_property_read_bool(np, "i-cache-size"))
> -			++leaves;
> -		if (of_property_read_bool(np, "d-cache-size"))
> -			++leaves;
> -		levels = level;
> -	}
> -
> -	of_node_put(np);
> -	this_cpu_ci->num_levels = levels;
> -	this_cpu_ci->num_leaves = leaves;
> -
> -	return 0;
> +	return init_of_cache_level(cpu);
>  }
>
>  int populate_cache_leaves(unsigned int cpu)
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 4b5cd08c5a65..a4308b48dd3e 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -224,8 +224,52 @@ static int cache_setup_of_node(unsigned int cpu)
>
>  	return 0;
>  }
> +
> +int init_of_cache_level(unsigned int cpu)
> +{
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	struct device_node *np = of_cpu_device_node_get(cpu);
> +	struct device_node *prev = NULL;
> +	int levels = 0, leaves = 0, level;
> +
> +	if (of_property_read_bool(np, "cache-size"))
> +		++leaves;
> +	if (of_property_read_bool(np, "i-cache-size"))
> +		++leaves;
> +	if (of_property_read_bool(np, "d-cache-size"))
> +		++leaves;
> +	if (leaves > 0)
> +		levels = 1;
> +
> +	prev = np;
> +	while ((np = of_find_next_cache_node(np))) {
> +		of_node_put(prev);
> +		prev = np;
> +		if (!of_device_is_compatible(np, "cache"))
> +			break;
> +		if (of_property_read_u32(np, "cache-level", &level))
> +			break;
> +		if (level <= levels)
> +			break;
> +		if (of_property_read_bool(np, "cache-size"))
> +			++leaves;
> +		if (of_property_read_bool(np, "i-cache-size"))
> +			++leaves;
> +		if (of_property_read_bool(np, "d-cache-size"))
> +			++leaves;
> +		levels = level;
> +	}
> +
> +	of_node_put(np);
> +	this_cpu_ci->num_levels = levels;
> +	this_cpu_ci->num_leaves = leaves;
> +
> +	return 0;
> +}
> +
>  #else
>  static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
> +int init_of_cache_level(unsigned int cpu) { return 0; }
>  #endif
>
>  int __weak cache_setup_acpi(unsigned int cpu)
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 00b7a6ae8617..ff0328f3fbb0 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -80,6 +80,7 @@ struct cpu_cacheinfo {
>
>  struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
>  int init_cache_level(unsigned int cpu);
> +int init_of_cache_level(unsigned int cpu);
>  int populate_cache_leaves(unsigned int cpu);
>  int cache_setup_acpi(unsigned int cpu);
>  bool last_level_cache_is_valid(unsigned int cpu);

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
