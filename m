Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A6969D11F
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Feb 2023 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjBTQKQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Feb 2023 11:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBTQKP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2023 11:10:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC615B464
        for <linux-acpi@vger.kernel.org>; Mon, 20 Feb 2023 08:10:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id da10so7847198edb.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Feb 2023 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bkra1bclUQEMnLygi/D5rdgvW1P/Dj1p2TQWCn86qk=;
        b=AcgypjlCdest8+7YJscE8GB6VRXm+WHGohhqWuSB6enI/kmspiuOQpc/fkoSFFqhHu
         z17SjKRjP23SsRwSwQWcoSa2aaEujfaJR3DXIVPA+N9troLPChPc1XAQ3uY5CDUiCh9E
         vsQM+m6qnX4PhAJhlFJU6qXzZUxAi2dXbfMIzrGgNRVAUza3i3dEc3z/4iYTdbFW3FhP
         4tZrPz9cc9DNflzEpFXDsmgwvzosv+PJFd7dnKPn+HSn61Gj054+WuwdEdivo1X0PL6M
         KH61T3VeLjqCbBG4aGet6zUr7P73vd/CoGb9IHArx3l4iA62rNqxmn6dIfHBdCwYNltf
         LwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bkra1bclUQEMnLygi/D5rdgvW1P/Dj1p2TQWCn86qk=;
        b=LU56dY/obIJmU0P0lIAbVBr1JT8HonbN0qp4zZTkVeEe+rGtHVfAYRoOMmK2L13LDM
         3fvuF7JAFqbkjK8jxMr6WNXQdddOpWefsZRZ75vTDCxxfOH2GoqUWbn4gSIqR8N2Cxg9
         JmT3Wyii9zcdpJe24Qh5gLgEqL29yBphoKE1Lr1++lw6gAbT+YpyR4mCA7niQ9L9EvFH
         dedIMpysC9iRUWYAZanUHb1H/6x8dxqimPXrxOvaqrdqCra4FLkSxXX8wm+fhLf2aBlU
         k8jTGefsoHtN//dvdCKoHo3BMiVQdBY+SrgXabhahY2rlMixZfzvlYTFyjdzZEQfkVWV
         Ik9g==
X-Gm-Message-State: AO0yUKU9rrAwhJHGoWM68RlOwyokTSPZPLpwNNkXr0iCr0bNe2Ydt7bg
        akqWqsBVUsOsTzRSvFvXwic6SA==
X-Google-Smtp-Source: AK7set9DAM+Yv85Xv+o3eR5u0fQmR/veAV7cMbx0l9lSvAscXu2LqHC0oRT1HfopFUaJA8UuOqBBQw==
X-Received: by 2002:a17:906:374d:b0:886:ec6e:4c1 with SMTP id e13-20020a170906374d00b00886ec6e04c1mr9715076ejc.59.1676909412221;
        Mon, 20 Feb 2023 08:10:12 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id hz13-20020a1709072ced00b008b30e2a450csm4648847ejc.144.2023.02.20.08.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:10:11 -0800 (PST)
Date:   Mon, 20 Feb 2023 17:10:11 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V2 07/21] ACPI: processor_core: RISC-V: Enable mapping
 processor to the hartid
Message-ID: <20230220161011.d3ad4dhuv5ocsa7s@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-8-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-8-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:29PM +0530, Sunil V L wrote:
> processor_core needs arch-specific functions to map the ACPI ID
> to the physical ID. In RISC-V platforms, hartid is the physical id
> and RINTC structure in MADT provides this mapping. Add arch-specific
> function to get this mapping from RINTC.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/include/asm/acpi.h |  3 +++
>  drivers/acpi/processor_core.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 7f9dce3c39d0..4a3622b38159 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -15,6 +15,9 @@
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
>  
> +typedef u64 phys_cpuid_t;
> +#define PHYS_CPUID_INVALID INVALID_HARTID
> +
>  /* ACPI table mapping after acpi_permanent_mmap is set */
>  void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
>  #define acpi_os_ioremap acpi_os_ioremap
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 2ac48cda5b20..d6606a9f2da6 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -106,6 +106,32 @@ static int map_gicc_mpidr(struct acpi_subtable_header *entry,
>  	return -EINVAL;
>  }
>  
> +/*
> + * Retrieve the RISC-V hartid for the processor
> + */
> +static int map_rintc_hartid(struct acpi_subtable_header *entry,
> +			    int device_declaration, u32 acpi_id,
> +			    phys_cpuid_t *hartid)
> +{
> +	struct acpi_madt_rintc *rintc =
> +	    container_of(entry, struct acpi_madt_rintc, header);
> +
> +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> +		return -ENODEV;
> +
> +	/* device_declaration means Device object in DSDT, in the
> +	 * RISC-V, logical processors are required to
> +	 * have a Processor Device object in the DSDT, so we should
> +	 * check device_declaration here
> +	 */
> +	if (device_declaration && rintc->uid == acpi_id) {
> +		*hartid = rintc->hart_id;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
>  				   int type, u32 acpi_id)
>  {
> @@ -136,6 +162,9 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
>  		} else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
>  			if (!map_gicc_mpidr(header, type, acpi_id, &phys_id))
>  				break;
> +		} else if (header->type == ACPI_MADT_TYPE_RINTC) {
> +			if (!map_rintc_hartid(header, type, acpi_id, &phys_id))
> +				break;
>  		}
>  		entry += header->length;
>  	}
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
