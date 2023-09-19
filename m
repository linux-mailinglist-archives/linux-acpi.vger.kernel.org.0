Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D007A56E9
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Sep 2023 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjISBRp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjISBRo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 21:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298410D
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 18:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695086210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omPau9d/hvAoI0gDrC/4LG/Ef7KpyIVKvwkkyw1GuWQ=;
        b=J5gpzRCAWIL8p141j7ZUOPpjiO75/3KorwR0MlJlAe918MnW2Ycc+5ExKhSHF0tkccIGHt
        Hh9IN/yh7vR5cSDz+DT5rXsBCXvvXTjo43yQgM7JNMhtJcjLzS2c6pu4tPG2COA1QcDuWU
        Z0/kLZsKxMOEgZG3R11nxZiJTj2T/5o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-IDlIfj0PNUC2tDYz010gbg-1; Mon, 18 Sep 2023 21:16:49 -0400
X-MC-Unique: IDlIfj0PNUC2tDYz010gbg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c395534687so44493995ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 18:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695086208; x=1695691008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omPau9d/hvAoI0gDrC/4LG/Ef7KpyIVKvwkkyw1GuWQ=;
        b=SX3ITsml5+GbHANSJ3OpMdyh5V1hhMs7umITYiPPWnEi4Esy12m9RqcpEwdeGbX4cx
         f2nUBIBi2Zz6OI3Z+lMJOLMe5v+V3KGkDjbB3yB+ZyplxJau4qbKzgYkMywvoUEDT+Ak
         JX4NX0sbYeG2/f0Isa9L64W+FwqNaDvRZVJPQXLxV/NDLA7P5W82QKL4y7zus/vbdrFY
         OZ5OGm6lCNAG/XTuFWXJZxPm1zl/r0g528tphQz3Ku8w0urtdsLfNUBbHTADPiRn9EoR
         y4zQZ+dfg8Xbv0IYfVfiUEcuDp6FThVxsc3zddAhvc81NzjdXqSG18EQMjBu3C6Ry63o
         kaqg==
X-Gm-Message-State: AOJu0YxQHcvQsb0LMsj1TOD4T5zHMx7BVr7P/xwjB41FjVtzpS4g/H4d
        dp7mtxN0tUq2kiHKdewOZbXJVO7leMsGw4FIF7veS/VJKUXZXkImq/serYfnGftsmkvbYE8Y3BO
        HPHIYgHtdf63vsO90ycPqyQ==
X-Received: by 2002:a17:903:32ce:b0:1c5:82bb:223b with SMTP id i14-20020a17090332ce00b001c582bb223bmr3093053plr.60.1695086208303;
        Mon, 18 Sep 2023 18:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE1i0NJ56OK1RSneouzoLKNH0vI25vR0RRcS/LvZ7zADw/YiBXjO0kBQXVFFJFy1l+rs/4UQ==
X-Received: by 2002:a17:903:32ce:b0:1c5:82bb:223b with SMTP id i14-20020a17090332ce00b001c582bb223bmr3093033plr.60.1695086207927;
        Mon, 18 Sep 2023 18:16:47 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902c38100b001bc2831e1a8sm6580180plg.80.2023.09.18.18.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 18:16:47 -0700 (PDT)
Message-ID: <9ef55959-66f3-0dc3-dec8-e2b673f965a4@redhat.com>
Date:   Tue, 19 Sep 2023 11:16:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 26/35] arm64: acpi: Move get_cpu_for_acpi_id() to a
 header
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-27-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-27-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 9/14/23 02:38, James Morse wrote:
> ACPI identifies CPUs by UID. get_cpu_for_acpi_id() maps the ACPI UID
> to the linux CPU number.
> 
> The helper to retrieve this mapping is only available in arm64's numa
> code.
> 
> Move it to live next to get_acpi_id_for_cpu().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/arm64/include/asm/acpi.h | 11 +++++++++++
>   arch/arm64/kernel/acpi_numa.c | 11 -----------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 4d537d56eb84..ce5045038e87 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -100,6 +100,17 @@ static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>   	return	acpi_cpu_get_madt_gicc(cpu)->uid;
>   }
>   
> +static inline int get_cpu_for_acpi_id(u32 uid)
> +{
> +	int cpu;
> +
> +	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> +		if (uid == get_acpi_id_for_cpu(cpu))
> +			return cpu;
> +
> +	return -EINVAL;
> +}
> +
>   static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>   void __init acpi_init_cpus(void);
>   int apei_claim_sea(struct pt_regs *regs);
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index e51535a5f939..0c036a9a3c33 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -34,17 +34,6 @@ int __init acpi_numa_get_nid(unsigned int cpu)
>   	return acpi_early_node_map[cpu];
>   }
>   
> -static inline int get_cpu_for_acpi_id(u32 uid)
> -{
> -	int cpu;
> -
> -	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -		if (uid == get_acpi_id_for_cpu(cpu))
> -			return cpu;
> -
> -	return -EINVAL;
> -}
> -
>   static int __init acpi_parse_gicc_pxm(union acpi_subtable_headers *header,
>   				      const unsigned long end)
>   {

