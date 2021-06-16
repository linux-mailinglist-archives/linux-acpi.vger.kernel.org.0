Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628F3A9A9A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhFPMmO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 08:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232661AbhFPMmO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 08:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623847208;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubsBv6f8Gfa2qgRyhsGa5AFvRPZ+U40JlVZfwTYe0kE=;
        b=h6rWg5NhVeANVTs2qf7xqyq7kb25aOk1maz3eUuAR3gSWXaXLaGUH84G88Yt+1DFyWkGVy
        LU//ktLUv6xR+K1E1KOYXQh83+F5xIUL8H4icf4Ppf7il2S385WEnAV6l1ddRmwwkhg+ZR
        pIY1OchDkfLEsTRlpwn1d05qh+jkBKk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-GjgSbY-EO72kaRyidz3v-w-1; Wed, 16 Jun 2021 08:40:06 -0400
X-MC-Unique: GjgSbY-EO72kaRyidz3v-w-1
Received: by mail-wm1-f69.google.com with SMTP id t11-20020a05600c198bb02901bf95ba8642so1254775wmq.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 05:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=ubsBv6f8Gfa2qgRyhsGa5AFvRPZ+U40JlVZfwTYe0kE=;
        b=o0n3WVia0dhfV0ahhLP9SLJgB0eAreM7JSno4fxtyjEk7RFrs8DnRBXuXptpujv9d/
         fKQmAXKEwEi14qyAuNNUtd8s/XVrsYgNC2K7oLac4qOr1fbh5wz0Q8lVJA/t21dsDvVD
         PEjyQgW0wY6laIj5W0MmDyGvx5fgMiUrG3yIxwAhvtw++AmHYx31M8uKLUge0SQM5e2C
         3XAabH626d7LTakwC02c70/J+vDBJ1bKQRm1TmxQzGrDSUKIKl2TUbHe3n/7wC4GRcnK
         RfX+AvYLs48ZbzeM3V4LjZUCHWacQoCeT1ByghHNqvDT/dhmRNYzYPBcVXuKRbJmJZFB
         mKcg==
X-Gm-Message-State: AOAM531QV2k29TNvoOLWyk8s7KqKTZwwAzzfeocoiHLCv0Gp3pwej5/n
        aRXSMapBG/KcQ/o4EnDMJ79zenFTuFGEV5W9WJs30xwqAAAdtTXjcIEtcs6+O48qJgBsgNOuk/U
        SWwbwOv+uaYoslABTApM8pQ==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5235715wrr.292.1623847205678;
        Wed, 16 Jun 2021 05:40:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5WQBLU4IKG9p3xxW0FVoOol8q9XU19Rj2M+rLCk3pLwV7dw9cSLzoXZeV3mgmVA67Soicyw==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5235693wrr.292.1623847205520;
        Wed, 16 Jun 2021 05:40:05 -0700 (PDT)
Received: from [192.168.43.95] ([37.172.247.238])
        by smtp.gmail.com with ESMTPSA id v15sm4914297wmj.39.2021.06.16.05.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 05:40:04 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v4 0/6] Add support for ACPI VIOT
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, sebastien.boeuf@intel.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
References: <20210610075130.67517-1-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <883de842-d50a-53f9-7589-a6d20e913f2d@redhat.com>
Date:   Wed, 16 Jun 2021 14:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610075130.67517-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 6/10/21 9:51 AM, Jean-Philippe Brucker wrote:
> Add a driver for the ACPI VIOT table, which provides topology
> information for para-virtual IOMMUs. Enable virtio-iommu on
> non-devicetree platforms, including x86.
>
> Since v3 [1] I fixed a build bug for !CONFIG_IOMMU_API. Joerg offered to
> take this series through the IOMMU tree, which requires Acks for patches
> 1-3.
>
> You can find a QEMU implementation at [2], with extra support for
> testing all VIOT nodes including MMIO-based endpoints and IOMMU.
> This series is at [3].
>
> [1] https://lore.kernel.org/linux-iommu/20210602154444.1077006-1-jean-philippe@linaro.org/
> [2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
> [3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi

I tested the series on both aarch64 and x86_64 with qemu. It works for me.
Feel free to add my T-b.

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

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

