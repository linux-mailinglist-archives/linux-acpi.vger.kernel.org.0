Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197456A9BA7
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 17:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCCQXM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 11:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjCCQXL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 11:23:11 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3373013DDC
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 08:23:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d30so12517497eda.4
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 08:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ryeAsxysbo6DUGxfiuPOI8CvtI+vb6NelPj5oYksPo=;
        b=EzNCK3RZSJsJUeQFEWK8SnOi6P6PWK6BpIgChisWP1NzSH3VJqAhxv3yOHN49QZqxg
         V0BotQn335MAGYgJxAnQgTh9LVMsDSCDQ/xWw3H3ctNOmg8JAYT3/m7yFa9i2bJjF+ra
         ZttoECnbnJngdAr0peRBlCURcv4DOeWZMJr+UQInSQrH5dYL06UB85PPFrccZC8J4Gc5
         GpnECND/KUp0C2V8VxmBWE1aa+V5hB2gD6L4RrqZCHoc7p7UMC3cQOhZQQWzF3fnvlrH
         EbZbRFIvnTrDSVhUBd5gKFA+hE6u/UKpArsqB8YWOidtWPdOHOWOxQg2ufuiPbrJWj+4
         TIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ryeAsxysbo6DUGxfiuPOI8CvtI+vb6NelPj5oYksPo=;
        b=mq3KeDegbV0daMrvJ/7/7wuSXlAVvm/xmlNRw0/aZRS9pWZ1vVWQ20IMQP+FWfbQY7
         b4S2FNZJvEpaH/bQVxmiH8xcjq+jbv9I4LwRCzif7G/i/A3r7FbwQFBKotEtqdJOf5wy
         nbK5L6WJiRUsmkG2nm/SI8HZzt00XbtvzSA7na17o3eE+NQjrF2Ey2wwc447oVZr6TxD
         x9fWCenwBS34OUX5B1wbd36KJAeXUYmT9uO49ZtGsfoqYXNRiy3rK3YVWdKdtcCHPqpv
         SyWFcwQx2d79kh+oGLrQZYuUEHuDcbKtZtdGZOgkB2xtagq4pNcxc0wOOdHyQd1kOzVD
         h5ig==
X-Gm-Message-State: AO0yUKVRLcMieeyWWAwoHOTFwplrLKD2qtCvhjnkiHeB/IUF5SEZezoC
        iAPMDOdQprMNlrOB3+aA8kbDzA==
X-Google-Smtp-Source: AK7set+GMkAPdilJi56mUnW0fX32evecSe24CxSroekBxpjdNIx8xTEeM5pLsOlf4df3VzOOhkydOg==
X-Received: by 2002:aa7:cfc2:0:b0:4bf:f9f4:9b1e with SMTP id r2-20020aa7cfc2000000b004bff9f49b1emr2272745edy.4.1677860588730;
        Fri, 03 Mar 2023 08:23:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id b2-20020a50b402000000b004be64b284b2sm1338509edh.3.2023.03.03.08.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 08:23:08 -0800 (PST)
Date:   Fri, 3 Mar 2023 17:23:07 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 19/20] RISC-V: Enable ACPI in defconfig
Message-ID: <20230303162307.zz5amah65gjme7da@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-20-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-20-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 03, 2023 at 07:06:46PM +0530, Sunil V L wrote:
> Add support to build ACPI subsystem in defconfig.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index d98d6e90b2b8..8822b49ddb59 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -238,3 +238,4 @@ CONFIG_RCU_EQS_DEBUG=y
>  # CONFIG_FTRACE is not set
>  # CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_MEMTEST=y
> +CONFIG_ACPI=y
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
