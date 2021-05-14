Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6883809AD
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhENMhA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 08:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232712AbhENMhA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 08:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620995748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4A2APivfcyDaCt/06VnummJz8bYOcJRXXs3FFpQO3XU=;
        b=DR8350E5faQ7MzMSnkOahdHjYXiCViQSRTV+8/uWnf5Wroy3AkLlB5epAqp8pt8crF082w
        4j8zDi8Rqg4jbWXoKPsUA2Uw5487GxUUFjXIgBApPTmD8fGITFTK5NrbN1COOvD5PC1vum
        bQ3N+TZxysCOanY19VGYKy7axJVpvLw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-WpwsTkMWMriNplreY_CKKg-1; Fri, 14 May 2021 08:35:34 -0400
X-MC-Unique: WpwsTkMWMriNplreY_CKKg-1
Received: by mail-wr1-f69.google.com with SMTP id 2-20020adf94020000b0290110481f75ddso1415542wrq.21
        for <linux-acpi@vger.kernel.org>; Fri, 14 May 2021 05:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4A2APivfcyDaCt/06VnummJz8bYOcJRXXs3FFpQO3XU=;
        b=aYCSjM1extQbwjFVKYVK7iwIQn3siH50ZFJqWJxc/g2uUWxp/k1LjS0KanBgTqctR7
         3SZYtE0v+mmT1+Xh94KMX+Vx195vGl2ZmKaGgPyBqCbGnLof4yvw3PO0mU9q2Sdsw4z/
         ZModKujabjYsWMPx6E4L3ljwLJoSRAp/Kt5p68dks6ZsFSg6KnM52Y1i5UA+qBrlSvd7
         BbjcOfgTHLogRCUlqnvnAbQt5ZY1oqdrVZ7g9YzRgtKC2vkWYBWdjBMRmkD9DDkCr0d7
         +Uj4fuRNSgSfQRl3BuHJEgc6y46nlx1CDw0zSyAQyXHTjhAl7HFl6Y0+t0ui5bZZp4ie
         /6Lw==
X-Gm-Message-State: AOAM530F5WLIm/DPGr+VMGYQKmO9EjwMjCnGDG+eZ8n6wn6lXGPojbm/
        H+1/xPd6I/1O2W6el7R4YvG1dbwjauRMWUo+hhA75ZBJatZNU56Rysqus4/L5RdT8uYSva9MWFm
        pD5IV7q9k82aiMUcCBHJ6eA==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr49597668wmc.90.1620995733554;
        Fri, 14 May 2021 05:35:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjfU7fJ2sLn26ewhol2WN23VUlfrplBITfOMhtu8CSpXBAXmHZPIuRLwrEYMB8vP4IQNrraA==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr49597643wmc.90.1620995733363;
        Fri, 14 May 2021 05:35:33 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
        by smtp.gmail.com with ESMTPSA id q27sm2855356wrz.79.2021.05.14.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:35:32 -0700 (PDT)
Date:   Fri, 14 May 2021 08:35:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com
Subject: Re: [PATCH v2 0/6] Add support for ACPI VIOT
Message-ID: <20210514083449-mutt-send-email-mst@kernel.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 01:38:31PM +0200, Jean-Philippe Brucker wrote:
> Add a driver for the ACPI VIOT table, which provides topology
> information for para-virtual platforms. Enable virtio-iommu on
> non-devicetree platforms, including x86.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Mostly ACPI stuff so I assume it's best to merge through that tree.

> Since v1 [1]:
> * The VIOT header definitions have been picked for v5.13
> * Share more code with IORT. Patches 1 and 2 extract the common code
>   from IORT.
> * Simplify the VIOT driver. Use the existing fwnode infrastructure
>   instead of adding hooks to the IOMMU driver.
> 
> You can find a QEMU implementation at [2], with extra support for
> testing all VIOT nodes including MMIO-based endpoints and IOMMU. This
> series, based on linux-next, is at [3]
> 
> [1] https://lore.kernel.org/linux-iommu/20210316191652.3401335-1-jean-philippe@linaro.org/
> [2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
> [3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi
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
>  drivers/acpi/scan.c          |  60 +++++-
>  drivers/acpi/viot.c          | 350 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd/iommu.c    |   9 +-
>  drivers/iommu/dma-iommu.c    |  17 +-
>  drivers/iommu/intel/iommu.c  |  10 +-
>  drivers/iommu/virtio-iommu.c |   8 +
>  MAINTAINERS                  |   8 +
>  20 files changed, 548 insertions(+), 150 deletions(-)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/arm64/dma.c
>  create mode 100644 drivers/acpi/viot.c
> 
> -- 
> 2.31.1

