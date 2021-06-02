Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58601398F67
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhFBP55 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 11:57:57 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:33708 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhFBP5u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 11:57:50 -0400
Received: by mail-ej1-f51.google.com with SMTP id g20so4684175ejt.0
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jun 2021 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hFWxCNmxdTSACAJCND+vZHUnFP/1fNZmOF1MWz4k5Tg=;
        b=yXNfKmP96TrMTc1Fw58DyLmvQouywbWAkFG+mPKml1w5NkKvkB7tlwVKXhtrYfhYuL
         9w34t/rrtl0+be93A97vYBsCY+/VKUxLlj4f3uPZUzrahRZiJrQIFpvIqdt6u8wJ1GSi
         t/c92oJh6YRWVXittEyYvx9/q5OnGstliwJ8LNicLtSeDy1YLd+Z9/XcynHpAFoew2Mb
         owOfd9AemYyanQavr+FDi0IpfYOVLzeUGY90Nf1+98UMK/MWSCptJb2bYGfH/ZG418E4
         hLqvoydYYo2MpGbBUYT4aKmM+gWXjTc4jpVg3fpg6VoYNqGAl7rMNDIhqlEed6Hdc2k4
         CcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hFWxCNmxdTSACAJCND+vZHUnFP/1fNZmOF1MWz4k5Tg=;
        b=jjJHGHda3Z0cQpkWw2kx3s8HthW2dKXdwJm17c4Fx1pakgOyhBsBPmpUjXYyTsgKjb
         hrFFI13oMCWT3XrdwA6HW+vmQ1+bbFkuHsrqLI+VwF32ooaYGWwagh2a4UdawhAz89U4
         r/e0PWpDoba682ZONJno2J3eALaidm9mcJukfwkR/WsBUK8hSlNxIdw0sthZEh6QaaYr
         HLm+P2ElihokHetuo4utPuciYqj+z6yVOYE7hSxbz4sG8iRkXaREid2lLcG+8Il3a1nK
         1Rexav6SdHtqMLCK3vYmWB1FpIdXbZ4JUnxHG9P4rAHUSsc+Wrlj9VqD/ZFeUxjAl1/Y
         K+4w==
X-Gm-Message-State: AOAM533mrNAQnjNojwnWn/zm9b68WqK5zaJIjAP3FX6paVp/jVrAC9Ra
        hyDD+h4TRHP9ie7c6bxiDjjhIg==
X-Google-Smtp-Source: ABdhPJyC6GnC05iD/ICy8SYDfXi0Ni8SzID9FIdZOYY8DSW/Pt+sIC1nio2rktwF7w8ITr6XN/uu6Q==
X-Received: by 2002:a17:906:f184:: with SMTP id gs4mr2311464ejb.420.1622649306228;
        Wed, 02 Jun 2021 08:55:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id d24sm174249edr.95.2021.06.02.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:55:05 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Add support for ACPI VIOT
Date:   Wed,  2 Jun 2021 17:44:40 +0200
Message-Id: <20210602154444.1077006-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a driver for the ACPI VIOT table, which provides topology
information for para-virtual IOMMUs. Enable virtio-iommu on
non-devicetree platforms, including x86.

Since v2 [1] I tried to improve commit messages and comments. More
feedback and review are always welcome. Joerg offered to take this
series through the IOMMU tree, which requires acks for patches 1-3.

You can find a QEMU implementation at [2], with extra support for
testing all VIOT nodes including MMIO-based endpoints and IOMMU.
This series is at [3].

[1] https://lore.kernel.org/linux-iommu/20210423113836.3974972-1-jean-philippe@linaro.org/
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
 drivers/acpi/scan.c          |  60 +++++-
 drivers/acpi/viot.c          | 364 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c    |   9 +-
 drivers/iommu/dma-iommu.c    |  17 +-
 drivers/iommu/intel/iommu.c  |  10 +-
 drivers/iommu/virtio-iommu.c |   8 +
 MAINTAINERS                  |   8 +
 20 files changed, 562 insertions(+), 150 deletions(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/arm64/dma.c
 create mode 100644 drivers/acpi/viot.c

-- 
2.31.1

