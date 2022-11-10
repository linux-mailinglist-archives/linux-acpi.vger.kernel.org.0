Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B220624A99
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Nov 2022 20:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiKJTXi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Nov 2022 14:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKJTXh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2022 14:23:37 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEDBB859
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 11:23:35 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id g10so1762272qkl.6
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 11:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XSqyH4okSw608+E1B3obXlqksN66twvjfOfCM/IBR8=;
        b=wQf7RGWU+6QF8R6wCAL/gAYvRe6ZyJAFRXa8+S5DCZ6i+P6kSW0nAxr/H9VwfjB4at
         77DjjqOwJdFQejicYA3/YTeuWEHo6FoogmA1+OWHdCXk8hAlU1WZVGG7ZtQ5+nJIjJh7
         bZUeERStj/gMkds/hlDEgz7ijarIfi0h8Vj+tvfi6Dz3LgpznsN6PdVs2HjCGqIDau/n
         n8uqINl6Vqd8m41yymmT3qGSdkaRHX0+ELLpA1XxgHhvxCpdMHy3Va7+V8N/ohgMoBZQ
         Cnyh6RstAAzQv0t/tTzLcF5uXpyLNERzun+BvH3KptiZTuKVyazvk83DKTcdGGuEj90j
         iluQ==
X-Gm-Message-State: ACrzQf2Ua8VpY3uflrUiez0uAN6mO6LrNmj1fXxU6kvlGpNXUoAbguQ4
        e7sje7E1fGAEyk2jzVTuPYGUnlmBYnBfuLPVDEhxxf3A
X-Google-Smtp-Source: AMsMyM5hBEHEuEx1laJbWwT3sqdfCFw9igv3rJiit0LFbUM54pIQcq/5oCYg5o0D5T/DcJi1TZjlDsdrpKSPduUnu1s=
X-Received: by 2002:ae9:eb4a:0:b0:6fa:df0:f326 with SMTP id
 b71-20020ae9eb4a000000b006fa0df0f326mr1670814qkg.23.1668108214154; Thu, 10
 Nov 2022 11:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20221108014623.71622-1-wangxiongfeng2@huawei.com>
In-Reply-To: <20221108014623.71622-1-wangxiongfeng2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 20:23:23 +0100
Message-ID: <CAJZ5v0hbMZJRstwshZfDuGv3cBZC9tzQTmkJBFToNv8PdwH8Pw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: irq: Fix some kernel-doc issues
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rafael@kernel.org, lenb@kernel.org, maz@kernel.org,
        lvjianmin@loongson.cn, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 8, 2022 at 2:27 AM Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>
> The following commit change the second parameter of acpi_set_irq_model()
> but forgot to update the function description. Let's fix it.
>
>   commit 7327b16f5f56 ("APCI: irq: Add support for multiple GSI domains")
>
> Also add description of parameter 'gsi' for
> acpi_get_irq_source_fwhandle() to avoid the following build W=1 warning.
>
>   drivers/acpi/irq.c:108: warning: Function parameter or member 'gsi' not described in 'acpi_get_irq_source_fwhandle'
>
> Fixes: 7327b16f5f56 ("APCI: irq: Add support for multiple GSI domains")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Applied as 6.2 material, thanks!

> ---
>  drivers/acpi/irq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 1cc4647f78b8..c2c786eb95ab 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -94,6 +94,7 @@ EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>  /**
>   * acpi_get_irq_source_fwhandle() - Retrieve fwhandle from IRQ resource source.
>   * @source: acpi_resource_source to use for the lookup.
> + * @gsi: GSI IRQ number
>   *
>   * Description:
>   * Retrieve the fwhandle of the device referenced by the given IRQ resource
> @@ -297,8 +298,8 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
>  /**
>   * acpi_set_irq_model - Setup the GSI irqdomain information
>   * @model: the value assigned to acpi_irq_model
> - * @fwnode: the irq_domain identifier for mapping and looking up
> - *          GSI interrupts
> + * @fn: a dispatcher function that will return the domain fwnode
> + *     for a given GSI
>   */
>  void __init acpi_set_irq_model(enum acpi_irq_model_id model,
>                                struct fwnode_handle *(*fn)(u32))
> --
> 2.20.1
>
