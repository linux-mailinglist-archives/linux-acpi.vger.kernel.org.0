Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71B369188
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhDWL5d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 07:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhDWL5d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 07:57:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED39C061574
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:56:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p6so41451080wrn.9
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OCtTdC5nBJa7AZmDlmzklJ0KIvQRoRufXj59YXg9RM=;
        b=xxpjzNJRvJDMbMoE0tNn6IDo2ICmCTLmNrSFUy+DyLjclCsJ50hEk67FvEk9pf255W
         46kYA9cB+trAycZz8VQ52YcEBz1JuKw9L0As/Us439uqUy+lhb6ugdX6gQzVrEEbqKSB
         3/3F/MUMk1RFaiCzi3joPgc4cdcoDV2Kv/cP13xT/VN+2nd7GJJf6VZQ77lMknn5Jvx/
         nAqYXlV8EnOuwrN3BrGgd2/btDTxVd1OLXGJXVl40lIBiowFxSC9ZrWQgYTlzjOr8rvy
         OmsM0uV5OJoaOuWp4izzgx4yX9URzryVAyAwd4UduiR+q/cZJzQKGz4Xwrw6KzMG/14I
         NXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OCtTdC5nBJa7AZmDlmzklJ0KIvQRoRufXj59YXg9RM=;
        b=ecmQigZBCUKhvb15vVxO3Am8Je+cDREMrq2fe0BlMmiOAKd9Eo6vN1eZOuwve7QsXQ
         8RHfJVrhmWf8UEHaqxIHxjJlmM99WqiqESvtZ8iQQeTtlODwU4PgFx63zMfG/kGgJ94x
         Uw81LNrKke/R7AOzz69909Ymb8gc11fZlcIbXi/xaoznY+NINUqUncfiutp4dRoDn9WT
         CLQpRI+5FtvDPleroot/Z8qH1xm0g1EAlB9bwfEBCkNxJXdH32vl1mTBWcDNZWa+wCwO
         TQbydC1dxdVvl31XsE7blgAkkvGwhc6dGVBjvTgfQCk/i7I+aYdBKlpc2XL+srC88+Jk
         AnIg==
X-Gm-Message-State: AOAM532m42kgm75jAGp+jWFHCG/0emWhW4q+DLK094OZonYBxzVPaO4j
        31ScvHa+XymVkn0LEGGoBmTbEw==
X-Google-Smtp-Source: ABdhPJyPpRSQxeHrMpv6L9ZEKawoGl7i7qyluCOrnXzXwS5te0ECEeIqx0XP2UAqECduDHkazD4q7A==
X-Received: by 2002:adf:f88f:: with SMTP id u15mr4264902wrp.368.1619179013954;
        Fri, 23 Apr 2021 04:56:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:56:53 -0700 (PDT)
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
Subject: [PATCH v2 0/6] Add support for ACPI VIOT
Date:   Fri, 23 Apr 2021 13:38:31 +0200
Message-Id: <20210423113836.3974972-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a driver for the ACPI VIOT table, which provides topology
information for para-virtual platforms. Enable virtio-iommu on
non-devicetree platforms, including x86.

Since v1 [1]:
* The VIOT header definitions have been picked for v5.13
* Share more code with IORT. Patches 1 and 2 extract the common code
  from IORT.
* Simplify the VIOT driver. Use the existing fwnode infrastructure
  instead of adding hooks to the IOMMU driver.

You can find a QEMU implementation at [2], with extra support for
testing all VIOT nodes including MMIO-based endpoints and IOMMU. This
series, based on linux-next, is at [3]

[1] https://lore.kernel.org/linux-iommu/20210316191652.3401335-1-jean-philippe@linaro.org/
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
 drivers/acpi/viot.c          | 350 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c    |   9 +-
 drivers/iommu/dma-iommu.c    |  17 +-
 drivers/iommu/intel/iommu.c  |  10 +-
 drivers/iommu/virtio-iommu.c |   8 +
 MAINTAINERS                  |   8 +
 20 files changed, 548 insertions(+), 150 deletions(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/arm64/dma.c
 create mode 100644 drivers/acpi/viot.c

-- 
2.31.1

