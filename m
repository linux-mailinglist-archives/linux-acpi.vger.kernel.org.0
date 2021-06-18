Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5583ACF1C
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhFRPfK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhFRPev (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 11:34:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98B5C061148
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 08:30:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l1so16559369ejb.6
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVK2Vu+gdkSV5LfHLO/okFsTWTEsOSEgfh/fTAc+ysQ=;
        b=Uv8r73Tua8U4KIGVT0tadYn9JokQ3OI3UF40iCRRH8Qvy+JxNw6WWAESXCcrpkMZD5
         J9OqykH5gEpxXAEhSSHTNdSIYjDCvQfC/QG8Qn8WOqpOk/qeQwqcYl60Y0zNoDJ5dK9j
         vFVf3RcWUverAnEDhV8qhCSXORG1mEGHmaozp15j3vnM+1mkdqmBUJYcyKYaXKZ8/wX6
         DKVu6y5PKk/i85GATFRvHw3B3h6wkjYcKi++Q057tw7ivkm+LVe+yIYv2dbD8kDGryB8
         pCYO+t5K98NRFj1alr60VtctA8wlN3ilmyWo1HfKQowP1OpJjD8zQHLInL7HqZXFq5Dz
         zsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVK2Vu+gdkSV5LfHLO/okFsTWTEsOSEgfh/fTAc+ysQ=;
        b=e4uiv0gHRWS4waUkzDshuuRg+4jHRjId59kK4Ep0aulv6br0F++MFk9kmT/RJCOhKg
         pbNT36HvPS+VJ7fQgEUre1nmbMrPbuzvwHDz6RDAmBSCiKDIYMxszRa8WATm9scSVXC+
         O7/kzxXteGGD4PKXHJtjtwgjeUIACjpRjbd2yCLvreEU80F0CI3Ndan/4kvs60CZk155
         GUgACAAw4SHVN9CdXws0dT6IwrwRtYjGg/wIpAsUoQtCMhUnubeGNPJJIA1R3I5PgyRR
         E6aJ0zsO6ni5h+mZL3uQP6uA2x2d7e612YLW2nDwlE8/kU69lIhtFiOCKS7YxqWaCNEc
         MscA==
X-Gm-Message-State: AOAM530O6t1+taBw01bNb+XouqUlzG/eTBn3ldtWnbl8OubuhbFbteoz
        j8QkEQTrPy652JxogYuSZDNqv2PLjkVOUw==
X-Google-Smtp-Source: ABdhPJwqDmkoCnPG0QnncSmTulnYyA+q0tsJhnaPN0fg6rei1NJ1LtMquAgOeQDHr4MnGh/8I10l5Q==
X-Received: by 2002:a17:906:fcaa:: with SMTP id qw10mr11511312ejb.233.1624030218335;
        Fri, 18 Jun 2021 08:30:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id bn7sm1197613ejb.111.2021.06.18.08.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 08:30:17 -0700 (PDT)
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
Subject: [PATCH v5 0/5] Add support for ACPI VIOT
Date:   Fri, 18 Jun 2021 17:20:55 +0200
Message-Id: <20210618152059.1194210-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a driver for the ACPI VIOT table, which provides topology
information for para-virtual IOMMUs. Enable virtio-iommu on
non-devicetree platforms, including x86.

Since v4 [1]:
* Fixes (comments, wrong argument, unused variable)
* Removed patch 5 that wrongly moved set_dma_ops(dev, NULL) into dma-iommu.
  The simplification of limit parameters for x86 callers is now in patch 4.
* Release ACPI table after parsing
* Added review and tested tags, thanks for all the feedback!

You can find a QEMU implementation at [2], with extra support for
testing all VIOT nodes including MMIO-based endpoints and IOMMU.
This series is at [3].

[1] https://lore.kernel.org/linux-iommu/20210610075130.67517-1-jean-philippe@linaro.org/
[2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
[3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi

Jean-Philippe Brucker (5):
  ACPI: arm64: Move DMA setup operations out of IORT
  ACPI: Move IOMMU setup code out of IORT
  ACPI: Add driver for the VIOT table
  iommu/dma: Pass address limit rather than size to
    iommu_setup_dma_ops()
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
 drivers/acpi/arm64/iort.c    | 128 ++----------
 drivers/acpi/bus.c           |   2 +
 drivers/acpi/scan.c          |  78 +++++++-
 drivers/acpi/viot.c          | 366 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c    |   2 +-
 drivers/iommu/dma-iommu.c    |  13 +-
 drivers/iommu/intel/iommu.c  |   5 +-
 drivers/iommu/virtio-iommu.c |  11 ++
 MAINTAINERS                  |   8 +
 20 files changed, 581 insertions(+), 137 deletions(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/arm64/dma.c
 create mode 100644 drivers/acpi/viot.c

-- 
2.32.0

