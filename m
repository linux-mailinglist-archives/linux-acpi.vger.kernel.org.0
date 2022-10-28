Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B086F6117AB
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Oct 2022 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ1QkO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 28 Oct 2022 12:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1QkO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Oct 2022 12:40:14 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D493B9BB
        for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2022 09:40:10 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id c8so4404366qvn.10
        for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2022 09:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWyWJq5/7vQ3rbCNnl2bgCnz7aWaC09X0dPDioLgN2w=;
        b=UZl57igCpPdW6s3yqTNzCc3ZSp9aLIfuoLaSJjjp8ZmrXSn7Ye8JZyY+GHo0mq6aKi
         ielm7qSJzexjrm6OjXgnOyztNDBRxAlOK7z0XfHSBiB74U2jZzjuarVMdbbrOfMt1zQu
         s1n0sDXhyoPLcly9Qi+NyiAm/B8m5NF0CizaCAqVHA/vyIC6zQ5ciN3Kw1IVEwwcJkJj
         CXp8i4sOIEXHd9l3wuvRlE6rgHXRi6/GfdLO+3792sciuByC7mtchkBnpfEdusNCep2S
         yL/G7oeyyCdwPS9fDI9R2suA7OYlYHbfGxr4Pw48c3DyRaboqtXPjP3UYtnGQxvVc/gk
         LZ7Q==
X-Gm-Message-State: ACrzQf1orNZyAqSGRLqtBntUVtxwQiR3W6lM2REWn5yif1FhSrFcoQH9
        QgAEEwyZDMu/hfdK281wC8mQnVpWG2b/MKneLPo=
X-Google-Smtp-Source: AMsMyM7gWxQnpoESv/SViIEvSagoYDevVbiFFwuGgzQSdOUNNT0jCrDxAte+LxfxA349EBZ2yy/j5xuYBGtk3mXH0ww=
X-Received: by 2002:a0c:a90d:0:b0:4b3:f322:1280 with SMTP id
 y13-20020a0ca90d000000b004b3f3221280mr370777qva.83.1666975209760; Fri, 28 Oct
 2022 09:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221013064459.121933-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20221013064459.121933-1-u.kleine-koenig@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 18:39:58 +0200
Message-ID: <CAJZ5v0iB12c6S=SF7OWYgXDj9=2-rHtjzBHEsMfH+vd7gpiQtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: APEI: Drop unsetting driver data on remove
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 13, 2022 at 8:53 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Since commit 0998d0631001 ("device-core: Ensure drvdata = NULL when no
> driver is bound") the driver core cares for cleaning driver data, so
> don't do it in the driver, too.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/acpi/apei/ghes.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d91ad378c00d..307fbb97a116 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1444,8 +1444,6 @@ static int ghes_remove(struct platform_device *ghes_dev)
>
>         kfree(ghes);
>
> -       platform_set_drvdata(ghes_dev, NULL);
> -
>         return 0;
>  }
>
>
> base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
> --

Applied as 6.2 material, thanks!
