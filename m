Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F009769D48F
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Feb 2023 21:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjBTUQC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Feb 2023 15:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjBTUQB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2023 15:16:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037D120075
        for <linux-acpi@vger.kernel.org>; Mon, 20 Feb 2023 12:15:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x10so8182680edd.13
        for <linux-acpi@vger.kernel.org>; Mon, 20 Feb 2023 12:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=64v0b9wMigK7c/r93Ya8QO/swfrpWXwK/PsuhD+FDn4=;
        b=NVZM89GiYAZYzEwCI4nIfa8QbXd+DNnr2PG59kkv6v1nsMejn/bDCCYjMo6XF3RGfg
         IcrczEMXSrTvOKYP6gT2/3Xpw5/uGaTn9y5nKuurvkykWxI6fCm3oThETyeoSky95Wtx
         ODu4fO/CavtyXmTanOeIAo5M4Cf0kJl5jwFNIet2iY84+bXmz+YoA0egvxWS970f0buA
         FI/X370SWTcZEf9xB1QwlbrgbPSXpVedDsg5drq71CgkgjED2ocJ/ODruLGOuJswl0W/
         uuv05daLFhjZS2lx2/LkaoMYAnbYtiVmcHN+DrQnm7mrSHx/C9ITHMCVFG3w2Pl1xebX
         rqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64v0b9wMigK7c/r93Ya8QO/swfrpWXwK/PsuhD+FDn4=;
        b=3xDevKbKI52UOfz0Uj2Ghzse8gzQPKFOuwzcPq09d4OeKVIR8yeHDmnBkOmRjI0vRF
         vl//j7kGXLeZiw19IzSbsV76wktcFAk810jQQd/AsijzVZCOlw0H7MHHg8fKAVImmZzL
         yfzlXkgGv8DCdROmWZmE1drja77wMiieJMUGl+eCsayAk/9KoeDR1AwroPXLKFtjTdvs
         Sq+eDi2LoGZmUJe2ukp9FmJIG2ur3TNvUsskR7CzcitwRmvllAbyKHIUiBl1ZVjhuMvX
         gb8Y7EqyxuK/Mkr1SpvlWWYvuj94Hy+YgQRfsVBnNPsMfzLk+gUgbRAyjNV9viCw6/g+
         P6wg==
X-Gm-Message-State: AO0yUKUXt1DHMOKlkEzdnyeGdh6Kv5c3V9P1mg1c2fCQRs/ZNRtmgPQ8
        A8KHbr6Cx++95cYM0nRltQSOqA==
X-Google-Smtp-Source: AK7set8EYvyS0KUGBYqhaUXbJMzPLDxhdTgj3Aa5X3d/dKS8NQ3loGJmrI55BK77rB9i9PNp/3+5vw==
X-Received: by 2002:a17:906:3e43:b0:88a:2e57:9813 with SMTP id t3-20020a1709063e4300b0088a2e579813mr10027851eji.33.1676924157519;
        Mon, 20 Feb 2023 12:15:57 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id gj18-20020a170906e11200b008d47cd2edfbsm1608023ejb.60.2023.02.20.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:15:57 -0800 (PST)
Date:   Mon, 20 Feb 2023 21:15:56 +0100
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
Subject: Re: [PATCH V2 21/21] Documentation/kernel-parameters.txt: Add RISC-V
 for ACPI parameter
Message-ID: <20230220201556.i3dihi3oj2lwckno@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-22-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-22-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:43PM +0530, Sunil V L wrote:
> With ACPI support added for RISC-V, this kernel parameter is also
> supported on RISC-V. Hence, update the documentation.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..b3a5a5844daa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1,17 +1,17 @@
> -	acpi=		[HW,ACPI,X86,ARM64]
> +	acpi=		[HW,ACPI,X86,ARM64,RISC-V]
>  			Advanced Configuration and Power Interface
>  			Format: { force | on | off | strict | noirq | rsdt |
>  				  copy_dsdt }
>  			force -- enable ACPI if default was off
> -			on -- enable ACPI but allow fallback to DT [arm64]
> +			on -- enable ACPI but allow fallback to DT [arm64,riscv]
>  			off -- disable ACPI if default was on
>  			noirq -- do not use ACPI for IRQ routing
>  			strict -- Be less tolerant of platforms that are not
>  				strictly ACPI specification compliant.
>  			rsdt -- prefer RSDT over (default) XSDT
>  			copy_dsdt -- copy DSDT to memory
> -			For ARM64, ONLY "acpi=off", "acpi=on" or "acpi=force"
> -			are available
> +			For ARM64 and RISC-V, ONLY "acpi=off", "acpi=on" or
> +			"acpi=force" are available
>  
>  			See also Documentation/power/runtime_pm.rst, pci=noacpi
>  
> -- 
> 2.34.1
>

I'd squash this into patch 18, "RISC-V: Add ACPI initialization in
setup_arch()"

Thanks,
drew
