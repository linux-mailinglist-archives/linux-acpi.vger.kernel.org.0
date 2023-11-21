Return-Path: <linux-acpi+bounces-1723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736EF7F3941
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 23:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F50B20A8E
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320535A103
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHFXBErd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF09C100;
	Tue, 21 Nov 2023 13:49:57 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb55001124so170554b3a.0;
        Tue, 21 Nov 2023 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700603397; x=1701208197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Gtgz9FsdyKFDL5tR7CMd1m/DpQtkGweBHqoxGbzpzs=;
        b=bHFXBErdI6rUujSrnFKKd+E+xs7e7aaBJKybZpJJ2PYYPkH4CjIXabg+bCu316GKjL
         V2+S9a1kriQCekSdZjn5ikDIdl02JCFSPgiMxOPIFoXxSqkLItpKC93aPjECc330tWqv
         UcHO3mxwa9vGdXKL5ijmFQuaPkkv1qxDRgNBuCzC4buEG1x9+CzRPwFHbRFimpzbhcxV
         iJcJdOv3boJRFQcX2TT4ZlZKFoGaD6ll+H0elIKDXdZ8w4eDzyW24J4/vyMpElPFwNqZ
         lKTtmJJTmXVUGHmFQLsHwJFi0gvinLCkeV+wSL+Kh2Of9SiUrLszLNcVSpClXv93WxIr
         ISNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700603397; x=1701208197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gtgz9FsdyKFDL5tR7CMd1m/DpQtkGweBHqoxGbzpzs=;
        b=t9mvU6sbkpMPgxIwXMgX9mdpGX5qOa8lpmHPJ3hSRNf6WNi7jI2KU6fb7bmDyqK1wz
         Tc3zzHG9bR/EvqgBz+z08+m+7ysjjvv52icBLWOC6eYirUmQn9fXrnnEuV1vX5Ot9IiO
         rqAoMrWUBWP7LWcFUjknS6aKyz33I2FRefMW4ZSEu4TIUFXfcOWhvt6tnd+5swCPdmx8
         zPDdiri8WuJ2BSZL+MnHmuacy0vefUVIe/1mdx/ipy42teMVDzjHk07a/OMCCHSqDRG/
         eWzNvOX6kAIv/Qp1MoxeK+PJIZFFE60dfVH8asVHlsVNWvseDMTPZ5lE3BlNJzqA8QRD
         NWbQ==
X-Gm-Message-State: AOJu0Yw+Q6GYyxn5nDh1IpgsCnIQbXA3eaXeRsXuWF2fDNl2jaPzyA+9
	AzJxMrz/L++tbTwvHy2A7+o=
X-Google-Smtp-Source: AGHT+IGvhU9AXpv6DkrhrnepHN3HLJircjSluq81o11W8qfsOoNA0iOUwKAD0D6E1evrcgiZsgbd7Q==
X-Received: by 2002:a05:6a21:a59b:b0:187:962d:746b with SMTP id gd27-20020a056a21a59b00b00187962d746bmr1015699pzc.9.1700603397092;
        Tue, 21 Nov 2023 13:49:57 -0800 (PST)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com. [198.54.134.172])
        by smtp.gmail.com with ESMTPSA id 9-20020a630b09000000b005b92d3cb4c2sm8385412pgl.58.2023.11.21.13.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 13:49:56 -0800 (PST)
Message-ID: <7e4038d8-ef60-f943-a7ba-db59ce9a2aa7@gmail.com>
Date: Tue, 21 Nov 2023 13:49:54 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linus.walleij@linaro.org,
 rafael@kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org,
 robert.moore@intel.com, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, guohanjun@huawei.com, arnd@arndb.de,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <170058229266.2356592.11579977558324549374.stgit@djiang5-mobl3>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <170058229266.2356592.11579977558324549374.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/23 07:58, Dave Jiang wrote:
> Linus reported that:
> After commit a103f46633fd the kernel stopped compiling for
> several ARM32 platforms that I am building with a bare metal
> compiler. Bare metal compilers (arm-none-eabi-) don't
> define __linux__.
> 
> This is because the header <acpi/platform/acenv.h> is now
> in the include path for <linux/irq.h>:
> 
>    CC      arch/arm/kernel/irq.o
>    CC      kernel/sysctl.o
>    CC      crypto/api.o
> In file included from ../include/acpi/acpi.h:22,
>                   from ../include/linux/fw_table.h:29,
>                   from ../include/linux/acpi.h:18,
>                   from ../include/linux/irqchip.h:14,
>                   from ../arch/arm/kernel/irq.c:25:
> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
>    218 | #error Unknown target environment
>        |  ^~~~~
> 
> The issue is caused by the introducing of splitting out the ACPI code to
> support the new generic fw_table code.
> 
> Rafael suggested moving the fw_table.h include in linux/acpi.h to below
> the asm/acpi.h. The move also helped with eliminating the inclusion of
> acpi/acpi.h in fw_table.h. The unfortunate circular inclusion of
> linux/acpi.h is needed for fw_table.h due fw_table code needing the
> defined acpi structs in order to build.
> 
> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   include/linux/acpi.h     |   23 ++++++++++++-----------
>   include/linux/fw_table.h |    1 -
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 54189e0e5f41..2789beb26138 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -15,7 +15,6 @@
>   #include <linux/mod_devicetable.h>
>   #include <linux/property.h>
>   #include <linux/uuid.h>
> -#include <linux/fw_table.h>
>   
>   struct irq_domain;
>   struct irq_domain_ops;
> @@ -25,16 +24,6 @@ struct irq_domain_ops;
>   #endif
>   #include <acpi/acpi.h>
>   
> -#ifdef CONFIG_ACPI_TABLE_LIB
> -#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
> -#define __init_or_acpilib
> -#define __initdata_or_acpilib
> -#else
> -#define EXPORT_SYMBOL_ACPI_LIB(x)
> -#define __init_or_acpilib __init
> -#define __initdata_or_acpilib __initdata
> -#endif
> -
>   #ifdef	CONFIG_ACPI
>   
>   #include <linux/list.h>
> @@ -48,6 +37,18 @@ struct irq_domain_ops;
>   #include <acpi/acpi_io.h>
>   #include <asm/acpi.h>
>   
> +#include <linux/fw_table.h>
> +
> +#ifdef CONFIG_ACPI_TABLE_LIB
> +#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
> +#define __init_or_acpilib
> +#define __initdata_or_acpilib
> +#else
> +#define EXPORT_SYMBOL_ACPI_LIB(x)
> +#define __init_or_acpilib __init
> +#define __initdata_or_acpilib __initdata
> +#endif
> +
>   static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
>   {
>   	return adev ? adev->handle : NULL;
> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
> index ff8fa58d5818..a722300c215b 100644
> --- a/include/linux/fw_table.h
> +++ b/include/linux/fw_table.h
> @@ -26,7 +26,6 @@ struct acpi_subtable_proc {
>   };
>   
>   #include <linux/acpi.h>
> -#include <acpi/acpi.h>

Hi Dave,

Seems to me that the #include <linux/acpi.h> should go too, to break the 
circular including cycle. If it remains, I fear that there could be 
subtle problems in the future depending on which header is included 
first in a compilation unit. It sounds now like the only correct way to 
get fw_table.h included is transitively via linux/acpi.h (of note: 
lib/fw_table.c will have to be updated; it's the only file that 
currently breaks this rule) so that removal will just help enforce this. 
Plus, includes in the middle of non-preprocessor declarations are a 
(sometimes necessary, definitely not here) code smell, in my view.

If this include must remain for some reason, perhaps a comment should be 
added to call attention to the circular situation and provide justification?

Cheers,
Sam

>   
>   union acpi_subtable_headers {
>   	struct acpi_subtable_header common;
> 
> 
> 
> 

