Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8632AC32C
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 19:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgKISGz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 13:06:55 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34266 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbgKISGy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 13:06:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id j14so9851541ots.1;
        Mon, 09 Nov 2020 10:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WoeS2aqiMEB/BoBFNlj+ravv88y6Faul4llZknDJbU=;
        b=iHcWWynpXf5wNVL1pArPKBjF2E9bZ8NEua6cJehK69WrRS+aOgpTNy+ZY/qS3Gmj7g
         pWqZ2kEQ3nwNXtzNH9TjhXMvITNyWdc36YD+tDaCnm9FHvt8K/88Jbh2bxWu6hQNyMc4
         AFSv9WJSzekuRKQuBRmr93q9/zK6eywMzccIto4nnCDTc0pPd7tcVtyh0Q0g07ppEaP/
         +26WIrMR4jDRzDmtF9Qvp/PfYfNH04JJY1TwmdzsJ8CyNwABFd4woyRtaLoWuWhmh8J9
         aGLHPb5k8It+cO7hQI3A/odKdYRcQ4N4ombswK0zFddXL4sS/R/vq9cCSm5Ym+LOT1IO
         SJRA==
X-Gm-Message-State: AOAM530lwOAbtnD08WC6zKB3oqhP7V8cdLKs7LRRajmoXLcgfbKbjKhH
        fOEGyWSMk+VJzrw/z+S3RGB5SsCZvNjGBlXJhhY=
X-Google-Smtp-Source: ABdhPJwME8Wzg160+7f3BVBWjxT5Zt+aCxKTVvh0kpHYog13JYC3qBZ2gECPqEvFeXXeHOEaBbRIgH4nP7gCdIeBFnI=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr11795120ota.260.1604945214241;
 Mon, 09 Nov 2020 10:06:54 -0800 (PST)
MIME-Version: 1.0
References: <1604315971-89149-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1604315971-89149-1-git-send-email-john.garry@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Nov 2020 19:06:43 +0100
Message-ID: <CAJZ5v0jr9mFzKc9hNsy0_kaZn1Er4UwEk4qzhWjj5CaagyZiMg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Fix acpi_dma_configure_id() kerneldoc name
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 2, 2020 at 12:23 PM John Garry <john.garry@huawei.com> wrote:
>
> For some reason building with W=1 doesn't pick up on this, but the
> kerneldoc name for acpi_dma_configure_id() is not right, so fix it up.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a896e5e87c93..bc6a79e33220 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1453,7 +1453,7 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>  }
>
>  /**
> - * acpi_dma_configure - Set-up DMA configuration for the device.
> + * acpi_dma_configure_id - Set-up DMA configuration for the device.
>   * @dev: The pointer to the device
>   * @attr: device dma attributes
>   * @input_id: input device id const value pointer
> --

Applied as 5.10-rc material, thanks!
