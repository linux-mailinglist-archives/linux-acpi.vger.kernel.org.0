Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C14F340CF0
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCRS2j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 14:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhCRS2J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Mar 2021 14:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616092089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tnHnMyJqosN4g4HqZoYksr2OdNUO3XXErmR0Dj0ujns=;
        b=OdDrUtOAV+9YYzdDbaB+r1l7UC57E8R27wPY8zv3fNuCKBBvbE3HVA9f9+udATHYH0JHuj
        1dAuKB3vG3WXCKcCtT0G8Ao3Ikcq4dnb6CEMN87rObkdqoy2K+VH6+jwO0xA7HmI3ymNyc
        hELCLsy3uaVmE2f3g3ArNm4fpo5vWqw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-fgaguGZ2PPq0x1RyW3o0mw-1; Thu, 18 Mar 2021 14:28:07 -0400
X-MC-Unique: fgaguGZ2PPq0x1RyW3o0mw-1
Received: by mail-wr1-f70.google.com with SMTP id p12so17916000wrn.18
        for <linux-acpi@vger.kernel.org>; Thu, 18 Mar 2021 11:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tnHnMyJqosN4g4HqZoYksr2OdNUO3XXErmR0Dj0ujns=;
        b=Y5F4I+hI6qVv8yTvdoXgJ2N+oO4Ome/ggNsrHJ47zyZzyNrneojOCHUtQD/Rp19Yyv
         pgc569OMorECFPshyg8n89Tt8rlpzdzPGVJCeIaQUNHmngPklnM3lrAUBV+cGql8L+j0
         F9CH1kv06QLUVqBD8J71ignIsNJbE5zNxMu9dg9wzRlx2iRijiq8xY0wLgBcPE8/zuKt
         aNAmmvY1SJEXVokQaxakXGCWLVSYNfRN2FZvPIUxabn0k6wBGgF2TWG0liwAEHT6u18k
         CyrbJvNG6pIsxPq/qnAwuu1FMRTMa1BcXYGwHgX0BTck1LlIp7w2mXRmr29nJzLt2aUo
         sNpA==
X-Gm-Message-State: AOAM532bo6nyMy0GY4ymMukXoul4z3xkmTxHeitdfT2cygF9ji7T9iRt
        4Z4Gq8x8TkagX3IsDJuZZAaJotU8FFyJuMThOtFlsmg1vBky6oURyQ7pwIVn5+veBUz7hLZvVW1
        N1sJ/uSiJWnQjqU1vFRzc8Q==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr445893wmh.29.1616092086136;
        Thu, 18 Mar 2021 11:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAhfnko6xreV0Aev/lGLY50U+s9V+kNR5evCF+1y99zRAKKI8v26JTFwGZ8CX5kgIkHS1h+g==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr445882wmh.29.1616092086000;
        Thu, 18 Mar 2021 11:28:06 -0700 (PDT)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id z7sm4007814wrt.70.2021.03.18.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 11:28:05 -0700 (PDT)
Date:   Thu, 18 Mar 2021 14:28:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20210318142709-mutt-send-email-mst@kernel.org>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-4-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316191652.3401335-4-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 16, 2021 at 08:16:54PM +0100, Jean-Philippe Brucker wrote:
> With the VIOT support in place, x86 platforms can now use the
> virtio-iommu.
> 
> The arm64 Kconfig selects IOMMU_DMA, while x86 IOMMU drivers select it
> themselves.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/iommu/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 2819b5c8ec30..ccca83ef2f06 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -400,8 +400,9 @@ config HYPERV_IOMMU
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
>  	depends on VIRTIO
> -	depends on ARM64
> +	depends on (ARM64 || X86)
>  	select IOMMU_API
> +	select IOMMU_DMA if X86

Would it hurt to just select unconditionally? Seems a bit cleaner
...

>  	select INTERVAL_TREE
>  	select ACPI_VIOT if ACPI
>  	help
> -- 
> 2.30.2

