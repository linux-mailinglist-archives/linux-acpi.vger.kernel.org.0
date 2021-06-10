Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DAD3A2626
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 10:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFJIFn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 04:05:43 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42761 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhFJIFm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 04:05:42 -0400
Received: by mail-wr1-f46.google.com with SMTP id c5so1134014wrq.9
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6d64EfMmKjBsLXuufmWEUBLj9XWA4YjPbU9Y/1wt2B8=;
        b=ObI/IzUukEYxx+7H8+Qf0c5GsgYSNdbZSErulQp+S5M095cDQ63LAs4nqiCOr4OSe0
         i/FNuhtV6CsQXPFO7XOQ6EM/eQxQDqwiYBae+RKq3EOIgwxnwJUnU7d09ygRpJh0rbiS
         WmfD13dPCc27InjhoUw07zaBwR0qqlRJMZrskGrqVpjWJEuhLHcy7PnYvSBzEkMk7Y4C
         X/nPyuSTqbaIwiPMZbeIP5zs4ELOKDWw4c7/dWuPyF1U172DTBtgjmadVm4nASZWRfbM
         M0tjl+lcuIZQH59VeO5Eb0JfSz8aylyM0XkCrZmSE6BhddflN5ZkTX1nTFcqksk8IJHb
         gIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6d64EfMmKjBsLXuufmWEUBLj9XWA4YjPbU9Y/1wt2B8=;
        b=PavOPCSPo/v+yHHZiS7mWwWMwIO4Dd58FBwwtduNSkMtrcnuVgUkjYwOx7d6UkZFEp
         qUtwBHO2b/IKLz4IunFtNgzbJnMcY5ZYrUjMVQNxBus1Niuc5rcjV+0U2C8YakzAJ+eZ
         NabSRxCfurLaGEXXOoEcv4Rc5dqj2+eqHI4IAYRqfFFWmpZYywsD0HM9rqRc/Axwrdjm
         kBHWAuSeoGU9wEV2gmM2bxoijJteciu5crnunBt2XCiOapbDXutegcfpE4bg7WUOPtmi
         Qxru5xp/JiMdm4z032jUEMslLVav1MJG6V1tCMy8M1PndKEuLze67PPf1bm0c/Z20Ixb
         yE9A==
X-Gm-Message-State: AOAM533DUxhMcPm0QT2DefCVIBw+Ms640OHRvqJtQ12dgewMZ7X4k6pt
        kHOHU8Wb4tNdleRzl+w+wEv53A==
X-Google-Smtp-Source: ABdhPJz3GLvas2zyoO7uIAb3y7v6qAeWCy4E0Q2PobZGKURJL4xC2/JOv5xITetYPC0Kt6UtuqclGw==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr3885872wrx.144.1623312166388;
        Thu, 10 Jun 2021 01:02:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id o3sm2715059wrm.78.2021.06.10.01.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:02:45 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        jean-philippe@linaro.org
Subject: [PATCH v4 0/6] Add support for ACPI VIOT
Date:   Thu, 10 Jun 2021 09:51:27 +0200
Message-Id: <20210610075130.67517-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a driver for the ACPI VIOT table, which provides topology
information for para-virtual IOMMUs. Enable virtio-iommu on
non-devicetree platforms, including x86.

Since v3 [1] I fixed a build bug for !CONFIG_IOMMU_API. Joerg offered to
take this series through the IOMMU tree, which requires Acks for patches
1-3.

You can find a QEMU implementation at [2], with extra support for
testing all VIOT nodes including MMIO-based endpoints and IOMMU.
This series is at [3].

[1] https://lore.kernel.org/linux-iommu/20210602154444.1077006-1-jean-philippe@linaro.org/
[2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
[3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi


Jean-Philippe Brucker (6):
  ACPI: arm64: Move DMA setup operations out of IORT
  ACPI: Move IOMMU setup code out of IORT
  ACPI: Add driver for the VIOT table
  iommu/dma: Pass address limit rather than size to
    iommu_setup_dma_ops()
  iommu/dma: Simplify calls to iommu_setup_dma_ops()
  iommu/virtio: Enable x86 support

 drivers/acpi/Kconfig         |   3 +
 drivers/iommu/Kconfig        |   4 +-
 drivers/acpi/Makefile        |   2 +
 drivers/acpi/arm64/Makefile  |   1 +
 include/acpi/acpi_bus.h      |   3 +
 include/linux/acpi.h         |   3 +
 include/linux/acpi_iort.h    |  14 +-
 include/linux/acpi_viot.h    |  19 ++
 include/linux/dma-iommu.h    |   4 +-
 arch/arm64/mm/dma-mapping.c  |   2 +-
 drivers/acpi/arm64/dma.c     |  50 +++++
 drivers/acpi/arm64/iort.c    | 129 ++-----------
 drivers/acpi/bus.c           |   2 +
 drivers/acpi/scan.c          |  78 +++++++-
 drivers/acpi/viot.c          | 364 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c    |   9 +-
 drivers/iommu/dma-iommu.c    |  17 +-
 drivers/iommu/intel/iommu.c  |  10 +-
 drivers/iommu/virtio-iommu.c |   8 +
 MAINTAINERS                  |   8 +
 20 files changed, 580 insertions(+), 150 deletions(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/arm64/dma.c
 create mode 100644 drivers/acpi/viot.c

-- 
2.31.1

