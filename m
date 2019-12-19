Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F20127026
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 23:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLSWAm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 17:00:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45165 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSWAm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2019 17:00:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so9036592otp.12;
        Thu, 19 Dec 2019 14:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBtNLSUS6Ywl14BNvofHDMyiiz+12f6G6YvH8Y2fDv4=;
        b=iQQ80VQnJ5dVL+B7BY42H8gKgNGme4c9CVijYbkO84SHLO8tkMHikdkHFXeIP/dSHe
         jlQD6em8O3N4ipOQtThat1YlDTyCKMBHqssZ3OGrD7x1H0BOqH1hejhnDlgZhFotyMcu
         qCWl1mww57QUKI1IHLSg+k2ffjV8o18vQaOSKyF6Tpc9lDpxtzv8Qhh5ys8eZOW75FnT
         3cakEALWD1DYOMc0J5/UeD0ZBaFYDkegYHy5WQXbq/Ove4Yzo0+NrpwI/fc3Cb2K+bW7
         XP1xmHbwFAXJsGRFmUOQB7FT+s2575Zx+idbovzpbxlx38s3rLBJOHUsIDLHvpatF9bh
         +Uyw==
X-Gm-Message-State: APjAAAWDlkuAfC/L9cQvMpKJcSJmQXV7O1cCwNgIK6qWQ7FQtN8Gp10W
        FCLfywOMVN/cbZ3s6Mf+eRNMu9tzXd8rQPe4LEU=
X-Google-Smtp-Source: APXvYqwiVD+oDHmcpes3nrdTtRvyPemViEdYSagqOmt9aEw9isgiCAphhYN/oWpii69DP7p7Z5ZTxFbwmHOAJM2v4Xk=
X-Received: by 2002:a05:6830:1cd3:: with SMTP id p19mr9090434otg.118.1576792841468;
 Thu, 19 Dec 2019 14:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20191217104856.24987-1-peter.ujfalusi@ti.com>
In-Reply-To: <20191217104856.24987-1-peter.ujfalusi@ti.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Dec 2019 23:00:30 +0100
Message-ID: <CAJZ5v0gFD8AVCoLkeuQ47ab4eqN-9idf=p5jq3Nhc8DbOKBdSw@mail.gmail.com>
Subject: Re: [PATCH] docs: firmware-guide: acpi: Change dma_request_slave_channel
 to dma_request_chan
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 17, 2019 at 11:48 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> dma_request_chan() is the preferred API to request slave channels.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../firmware-guide/acpi/enumeration.rst          | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
> index 0a72b6321f5f..c13fee8b02ba 100644
> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -71,8 +71,8 @@ DMA support
>  DMA controllers enumerated via ACPI should be registered in the system to
>  provide generic access to their resources. For example, a driver that would
>  like to be accessible to slave devices via generic API call
> -dma_request_slave_channel() must register itself at the end of the probe
> -function like this::
> +dma_request_chan() must register itself at the end of the probe function like
> +this::
>
>         err = devm_acpi_dma_controller_register(dev, xlate_func, dw);
>         /* Handle the error if it's not a case of !CONFIG_ACPI */
> @@ -112,15 +112,15 @@ could look like::
>         }
>         #endif
>
> -dma_request_slave_channel() will call xlate_func() for each registered DMA
> -controller. In the xlate function the proper channel must be chosen based on
> +dma_request_chan() will call xlate_func() for each registered DMA controller.
> +In the xlate function the proper channel must be chosen based on
>  information in struct acpi_dma_spec and the properties of the controller
>  provided by struct acpi_dma.
>
> -Clients must call dma_request_slave_channel() with the string parameter that
> -corresponds to a specific FixedDMA resource. By default "tx" means the first
> -entry of the FixedDMA resource array, "rx" means the second entry. The table
> -below shows a layout::
> +Clients must call dma_request_chan() with the string parameter that corresponds
> +to a specific FixedDMA resource. By default "tx" means the first entry of the
> +FixedDMA resource array, "rx" means the second entry. The table below shows a
> +layout::
>
>         Device (I2C0)
>         {
> --
> Peter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Applying with modified subject as 5.6 material, thanks!
