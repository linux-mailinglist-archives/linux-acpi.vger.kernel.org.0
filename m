Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9A3A92B2
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 08:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFPGg4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 02:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhFPGg4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 02:36:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393ABC061574
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 23:34:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z12so1185974edc.1
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 23:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tQ+aFclY7mFrJp03PtWRtGMxzfcha+8ZtdzqiTJIvPY=;
        b=sodWDtxolW8SZ4J/QbhtvXgN8sJJ1NwrEnLg7GNAcl4DP6pyr87NJe+hWWQH+h8kOs
         tDJAUDHm36j6aaV5hGC5Tq0vuUYwMTRnevpzFTvaJ2dNI7W+gqoOfCmg26dC2cfogWXy
         pmWeyw04BWf7kCfFYvHz9ei/2wECnUW2ltF1VbbxccX6NtYbkHj7mbLx4saqs42dHXtm
         qQuiM1JwK63NVlVfNzgA6ziUbKAGQQwtarrvlo3q8bsQ07oGsGI8YoEaKHgDgp7chOvs
         noOKUqGAbLPJub8gCD/oCpjqYFP6qlhUOXHwKk1VNct+Ta3stxyC85QB0J6GPsZhuHx/
         2t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQ+aFclY7mFrJp03PtWRtGMxzfcha+8ZtdzqiTJIvPY=;
        b=Z/nY+GdiBgSsl2F0WAxTmnN/onuUPyV/wH86ARK+tu5NETOpBTgEERhm8dvup6AxJ5
         W0chj9v/yqnqhF63BOnpz6NV7i3NBLxffA3AC5TwH4MUfBRwuFVSJEcPoC3JhS9WYk5+
         9WBmWpBqqD7GM2lbhOPrccHxnLVCmBYpPgKN8C23VyGx6hSCwsZzS2k6XKddnU56Be9K
         npdsL3a2Q6c1cm9jLLu4WPH2V06FkGwPje8Soix5CNdUhAgz0LGJuIMxJNfJG939FUJA
         iGThq5+uSj1r+Fl/roRki2PN9OGbVtAaWtghus/X9E8YFTjdFOdhIxhsWJk32a8lZzI4
         OGug==
X-Gm-Message-State: AOAM530hrvqih2ACfRCnuVHju6sWYa7ocxwOmcDFfqWyOU3tdMniGAAS
        7qs7OJYYOKQAVPmMzp2TtDVtdQ==
X-Google-Smtp-Source: ABdhPJytn6iV+QqlLDcEBGVV9cwmZHvnBd0b+hyOWIjCF87Ob32rWc20CRqdZ0W0K7O0ZWMVsmoufA==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr2254993edd.12.1623825288710;
        Tue, 15 Jun 2021 23:34:48 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id b10sm649538edx.4.2021.06.15.23.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:34:48 -0700 (PDT)
Date:   Wed, 16 Jun 2021 08:34:28 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 0/6] Add support for ACPI VIOT
Message-ID: <YMmbdBuKzkoxEgme@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610075130.67517-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Thu, Jun 10, 2021 at 09:51:27AM +0200, Jean-Philippe Brucker wrote:
> Add a driver for the ACPI VIOT table, which provides topology
> information for para-virtual IOMMUs. Enable virtio-iommu on
> non-devicetree platforms, including x86.
> 
> Since v3 [1] I fixed a build bug for !CONFIG_IOMMU_API. Joerg offered to
> take this series through the IOMMU tree, which requires Acks for patches
> 1-3.

I was wondering if you could take a look at patches 1-3, otherwise we'll
miss the mark for 5.14 since I won't be able to resend next week. The
series adds support for virtio-iommu on QEMU and cloud hypervisor.

Thanks,
Jean

> 
> You can find a QEMU implementation at [2], with extra support for
> testing all VIOT nodes including MMIO-based endpoints and IOMMU.
> This series is at [3].
> 
> [1] https://lore.kernel.org/linux-iommu/20210602154444.1077006-1-jean-philippe@linaro.org/
> [2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
> [3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi
> 
> 
> Jean-Philippe Brucker (6):
>   ACPI: arm64: Move DMA setup operations out of IORT
>   ACPI: Move IOMMU setup code out of IORT
>   ACPI: Add driver for the VIOT table
>   iommu/dma: Pass address limit rather than size to
>     iommu_setup_dma_ops()
>   iommu/dma: Simplify calls to iommu_setup_dma_ops()
>   iommu/virtio: Enable x86 support
> 
>  drivers/acpi/Kconfig         |   3 +
>  drivers/iommu/Kconfig        |   4 +-
>  drivers/acpi/Makefile        |   2 +
>  drivers/acpi/arm64/Makefile  |   1 +
>  include/acpi/acpi_bus.h      |   3 +
>  include/linux/acpi.h         |   3 +
>  include/linux/acpi_iort.h    |  14 +-
>  include/linux/acpi_viot.h    |  19 ++
>  include/linux/dma-iommu.h    |   4 +-
>  arch/arm64/mm/dma-mapping.c  |   2 +-
>  drivers/acpi/arm64/dma.c     |  50 +++++
>  drivers/acpi/arm64/iort.c    | 129 ++-----------
>  drivers/acpi/bus.c           |   2 +
>  drivers/acpi/scan.c          |  78 +++++++-
>  drivers/acpi/viot.c          | 364 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd/iommu.c    |   9 +-
>  drivers/iommu/dma-iommu.c    |  17 +-
>  drivers/iommu/intel/iommu.c  |  10 +-
>  drivers/iommu/virtio-iommu.c |   8 +
>  MAINTAINERS                  |   8 +
>  20 files changed, 580 insertions(+), 150 deletions(-)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/arm64/dma.c
>  create mode 100644 drivers/acpi/viot.c
> 
> -- 
> 2.31.1
> 
