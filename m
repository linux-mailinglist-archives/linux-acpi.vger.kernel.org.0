Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB7BF4F7B
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfKHP0u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Nov 2019 10:26:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33455 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfKHP0u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Nov 2019 10:26:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so6858652wmb.0
        for <linux-acpi@vger.kernel.org>; Fri, 08 Nov 2019 07:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqa9TgNuEsO9HgZ/3pPJzfYS+V6XOeuR6AE+FRXhkjM=;
        b=Te5zDPiAYaK+KHbGAhgJd/VtE3mWigtsRKL7u1BcvwjwPNdPzg/7LxGWEzUdiw6dXG
         0n6LHlJwVqICWYVTAhKneYz1reVCfd5RDnICCLQUjQaVLq0fopoe2B9zFX9Ya9Is5JWr
         wlO/JqSUM9fgS4LmumnqeJQZ9HXrZv/qqI7rdOe48CKMysLzgB0XmL/tomAoqxsdKvO7
         294fV4mnYHPT5mXX3H5UjD0MqW0T35qmi5Mk5O6tScBxr6gHUOVU56nROPVnWXMYGGMZ
         v/8DuymoH2MBxeRSLytNh+PgngaRyrV8rzCbIHcUl2oXrSKCBEQZQqQUJnj8c0Ye8CMF
         ydDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqa9TgNuEsO9HgZ/3pPJzfYS+V6XOeuR6AE+FRXhkjM=;
        b=qAsitTr/vlonTvnsX+zfcgIumeLU2Tf8ue+iTPRYiXCEZLmDSnkszv6qwGoHAA3cC1
         uKekg6aPNsPtF505A4C5a+1urJDs4CACcvNqcabr3p9JstiO1a1Es4X5aQn58Gl/1qJD
         e6d3lsgSoUgqOFMxsf5m734Rn2q96uDhf6VDTUbcA00xj5Un368ciXTyAOnRrjWZFzQJ
         yO/MFKTkCYu72ir27ViBc/3UIt3eElkYBcZn/qj0cw3DRrLFZxzyiCySYcZK/jDP7s0h
         fMDrCn5x5S9+AjC4A+ioGN1UMckR8EK06X6MEhSoS7kPkhvBUlmRDj+kAdPMTC7ABmGw
         F7sQ==
X-Gm-Message-State: APjAAAX8vpKCVqP307cA5Mt8GlT0PsA8PdEGBCQn6eSDLGhWRdzKwd6d
        LaN7evsrbJUT8Jwu1dM0hMiqeA==
X-Google-Smtp-Source: APXvYqw8YKsdDQmEUDYrUgys0DnX/Dt+RkuFFT8rnX5yYW4C7boT37O9C9+aE+9pW0CQramrRe+NTA==
X-Received: by 2002:a1c:4456:: with SMTP id r83mr8427282wma.2.1573226807102;
        Fri, 08 Nov 2019 07:26:47 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id w18sm6579232wrp.31.2019.11.08.07.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:26:46 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com, jonathan.cameron@huawei.com
Subject: [PATCH v2 0/8] iommu: Add PASID support to Arm SMMUv3
Date:   Fri,  8 Nov 2019 16:25:00 +0100
Message-Id: <20191108152508.4039168-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is version 2 of the series I sent a while ago [1], adding PASID
support to the Arm SMMUv3 driver.

Changes since v1:
* Dropped the patch adding auxiliary domain support. It's an easy way to
  test PASID, by populating PASID contexts using iommu_map/unmap(), but
  I don't know if it will ever have real users. 

  Since v1 I changed my testing gear, and am using the zip accelerator
  [2] instead of a software model. It only uses SVA and testing
  auxiliary domains would require additional changes that would never go
  upstream. SVA requires another 20 patches (including I/O page faults)
  that I will send later, but at least I know that this will get used.

* ioasid patch has been carried by Jacob and should be merged for v5.5 [3]

* Split patch "Add support for Substream IDs" into patches 4 and 5.

* Added IORT support (patch 3) and addressed other comments.

[1] https://lore.kernel.org/linux-iommu/20190610184714.6786-1-jean-philippe.brucker@arm.com/
[2] https://lore.kernel.org/linux-iommu/1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org/
[3] https://lore.kernel.org/linux-iommu/1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com/ 

Jean-Philippe Brucker (8):
  dt-bindings: document PASID property for IOMMU masters
  iommu/arm-smmu-v3: Support platform SSID
  ACPI/IORT: Support PASID for platform devices
  iommu/arm-smmu-v3: Prepare for SSID support
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Improve add_device() error handling
  iommu/arm-smmu-v3: Add support for PCI PASID

 .../devicetree/bindings/iommu/iommu.txt       |   6 +
 drivers/acpi/arm64/iort.c                     |  18 +
 drivers/iommu/arm-smmu-v3.c                   | 442 +++++++++++++++---
 drivers/iommu/of_iommu.c                      |   6 +-
 include/linux/iommu.h                         |   2 +
 5 files changed, 419 insertions(+), 55 deletions(-)

-- 
2.23.0

