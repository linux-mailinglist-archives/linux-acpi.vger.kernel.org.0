Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91C62B05C6
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 14:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgKLNDQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 08:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgKLNDP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 08:03:15 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C46C0613D4
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 05:03:15 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so5872299wrc.11
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 05:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoAG1pru+t0E0RGbZFAgVVNe78IlOrfO4ZdEb2/m39k=;
        b=UphNYMQS/LN28Yxb1McSQM05xn0X1V0x7rJ0PnNKfQvzO7zSoSBhZ9CLBwJKzAgh16
         17BMyTB6gytjqNUMMUrH82FFJY2PEIruw0bKT5P4mlmuWOAislyFW6xOumTDMAcADDJ/
         3I+1KO/GAtkaunGBQ3cAe+TPQ8lRQuZK1Uk3iHPKADw+iRsHWUINdXk0j0p0aLmHWSQD
         Lar/biWGCcmxYMOxn5/aO0uFOlgWdelEDWUgUAG103fCjfzlpWK4j4svUJKEmpdBgdzE
         qnbdv6qFgKnizUAGgssYpzF9v1UwcuGMLi2IRXc/YY0k9b1cqi77VreSmTVMP/3andg7
         tthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoAG1pru+t0E0RGbZFAgVVNe78IlOrfO4ZdEb2/m39k=;
        b=IT9UI4NyVZl3TLhcJA7SiwjcYMbZ5JEe6MsujHvTtaDI5GLoVA9alsfavOIG6bLNim
         IxzYCLcQLkUy/TC/o01aQJtjgK2ZAUlm9SHYGjqTo4cmA5+7M41WqeC5vdBwHMdKDbNl
         c4JlikWUzYiDP4brcLag/Nfsjb2p/O7UIJMnC6R6FMcUa64mAjB9an/po9Izkh9xu6Au
         6hgcinjceZAvBkpRB7efHAfsKqbkg4EybStS+kXOUr1k2w4kHyjPrh7dlAaZ6/L/aA1m
         PsyWInX8l02UMf8xl8vfa7BBEHIk/vJL4MTjSEnxSCOjEi0dDXRyUain9d+CoNg049cg
         7D7A==
X-Gm-Message-State: AOAM533QrTz8/bc93Akvkr7fZ8aTi9xSgWjNxQWUkTBQR98qpb/JtjsI
        U1CTPHh7lYPmM23E/DEoKM5Riw==
X-Google-Smtp-Source: ABdhPJxMBUohVh2fAAvMFdY17a6lP3nz140iaaxKiNjcDkvE3A2fsz0yM/aFafAdvuPkFa1NZKXESQ==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4434152wrn.212.1605186194089;
        Thu, 12 Nov 2020 05:03:14 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:13 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v8 0/9] iommu: I/O page faults for SMMUv3
Date:   Thu, 12 Nov 2020 13:55:12 +0100
Message-Id: <20201112125519.3987595-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for stall and PRI to the SMMUv3 driver, along with a common
I/O Page Fault handler.

These patches were last sent as part of v7 of the larger SVA series [1].
Main changes since v7:
* Dropped CONFIG_IOMMU_PAGE_FAULT, reuse CONFIG_IOMMU_SVA_LIB instead.
* Extracted devicetree support into patch 4.
* Added patch 5 for ACPI support.
* Dropped event queue flush on unbind(). Since device drivers must
  complete DMA transactions before calling unbind(), there cannot be any
  pending stalled event.
* A few small fixes.

The series depends on "iommu/sva: Add PASID helpers" [2], since it
provides the function to search an mm_struct by PASID.

Has anyone been testing the PRI patches on hardware? I still only have a
software model to test them, so as much as I'd like to cross this off my
list, we could leave out patches 7-9 for now.

[1] https://lore.kernel.org/linux-iommu/20200519175502.2504091-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/20201106155048.997886-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (9):
  iommu: Add a page fault handler
  iommu/arm-smmu-v3: Maintain a SID->device structure
  dt-bindings: document stall property for IOMMU masters
  of/iommu: Support dma-can-stall property
  ACPI/IORT: Enable stall support for platform devices
  iommu/arm-smmu-v3: Add stall support for platform devices
  PCI/ATS: Add PRI stubs
  PCI/ATS: Export PRI functions
  iommu/arm-smmu-v3: Add support for PRI

 drivers/iommu/Makefile                        |   1 +
 .../devicetree/bindings/iommu/iommu.txt       |  18 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  69 +-
 drivers/iommu/iommu-sva-lib.h                 |  53 ++
 include/linux/iommu.h                         |   4 +
 include/linux/pci-ats.h                       |   7 +
 drivers/acpi/arm64/iort.c                     |   1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  52 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 605 +++++++++++++++---
 drivers/iommu/io-pgfault.c                    | 462 +++++++++++++
 drivers/iommu/of_iommu.c                      |   5 +-
 drivers/pci/ats.c                             |   4 +
 12 files changed, 1191 insertions(+), 90 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c

-- 
2.29.1

