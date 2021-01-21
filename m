Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDF2FEA53
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 13:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbhAUMkk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 07:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731230AbhAUMkM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 07:40:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5FEC0613C1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c12so1585474wrc.7
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 04:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3l0OetoC6tw2Q4vXg0OJU58lOnJngSuhcgcpV0j+8A=;
        b=eWz40E4PQwAOppqBXOwKvt7Q0dVqHUMh5fqoJvuQDA3+kHfzRAM63s2hCG8pfXf/KX
         t1YLSGF55pBNR2O9qMkU8XNhlJEEPEFxSPI+KSsuahcO6/fMwqXvmQIo6j1dfavCmDdj
         2B4/qfVkLa0wBIQM3C7X6KgbYGm6oqE9MOBt17J/hCH9OvzxW2nN3/Fafr9nNHhw1pKd
         KvmOhkIHRvFkOP99nRyu5JXBGxSs8J9RFK95nw/VPMXO4yliQAc11MxeVpIy76ZiUVm2
         hY98zO+6QyqZygvqDXOilArvpDWBw4lbh2dFhPuehwvVGwJAKaiui4K6V79Pg/DqOpRc
         a7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3l0OetoC6tw2Q4vXg0OJU58lOnJngSuhcgcpV0j+8A=;
        b=Lv2A5DsjFVo2h4mxH0GVapLNhQHQXMRk9UMXXAh84YcOKrS/XWvEyDH1VydWdYAIvx
         9/x0BqgfWPrltsH/MagHTcImjl9jtqaK+1LvIxM70TbUWifVzY3uEsz8fovvEY7SXXbo
         Wu9e1qUnrWFPSVSFLYAk4O9JIc7EzwPznqF0gAIMxyKRxSRlTpyl/k0Eqvtsh/z0ZNbK
         39H6CUmH9TOHXMEYIrUCf1XHByFJMm8t4YPkyimFCTzENWlFZePD4yL6oI7GtuXObtoz
         IKNIHukcPr7wx6XWwFo4Vh2T+aYG7nnquaUu4iZ3HN5FHfpHtsYBNDtSOOrJxA1xGSc8
         dV1g==
X-Gm-Message-State: AOAM531ug8QvICYgg2uY6/mGNEDMZvbloz+9ehbAJEj4enpnrBlcV07A
        ChwXoxXxJFTTsUICasoZNwomNg==
X-Google-Smtp-Source: ABdhPJxQ+YnQY5ijaIW9U3we9pi/dCo07br3O0qdhedw1UO5Y/HhGzv9KZbJGYIhp9HYeRyQJgQvQQ==
X-Received: by 2002:adf:d20b:: with SMTP id j11mr13720018wrh.318.1611232771208;
        Thu, 21 Jan 2021 04:39:31 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 04:39:30 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v10 00/10] iommu: I/O page faults for SMMUv3
Date:   Thu, 21 Jan 2021 13:36:14 +0100
Message-Id: <20210121123623.2060416-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add stall support to the SMMUv3, along with a common I/O Page Fault
handler.

Changes since v9 [1]:
* Style changes suggested by Jonathan
* Fixes to patch 10 pointed out by Robin
* In patch 10, don't register the mm fault handler when enabling
  IOMMU_DEV_FEAT_IOPF, because that feature only indicates that a device
  driver wants to use PRI or stall. After enabling it, drivers may
  register their own IOPF handler (see discussion on v9 patch 03).
  Instead register the mm handler when enabling IOMMU_DEV_FEAT_SVA.

[1] https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (10):
  iommu: Fix comment for struct iommu_fwspec
  iommu/arm-smmu-v3: Use device properties for pasid-num-bits
  iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
  iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
  uacce: Enable IOMMU_DEV_FEAT_IOPF
  iommu: Add a page fault handler
  iommu/arm-smmu-v3: Maintain a SID->device structure
  dt-bindings: document stall property for IOMMU masters
  ACPI/IORT: Enable stall support for platform devices
  iommu/arm-smmu-v3: Add stall support for platform devices

 drivers/iommu/Makefile                        |   1 +
 .../devicetree/bindings/iommu/iommu.txt       |  18 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  56 ++-
 drivers/iommu/iommu-sva-lib.h                 |  53 ++
 include/linux/iommu.h                         |  26 +-
 drivers/acpi/arm64/iort.c                     |  15 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 347 +++++++++++--
 drivers/iommu/intel/iommu.c                   |  11 +-
 drivers/iommu/io-pgfault.c                    | 461 ++++++++++++++++++
 drivers/iommu/of_iommu.c                      |   5 -
 drivers/misc/uacce/uacce.c                    |  39 +-
 12 files changed, 1018 insertions(+), 73 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.30.0

