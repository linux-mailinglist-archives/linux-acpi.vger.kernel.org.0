Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA5F15C89A
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 17:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBMQwG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 11:52:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41277 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgBMQwG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Feb 2020 11:52:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so7566027wrw.8
        for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2020 08:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfKpna/gHZrKywpyhlfYfrWp7SfpssT14AH9fDnyBhc=;
        b=sq5RPbQMnHdJFKyr0y4rdobfNVfPyioZd4bFmy17jTSnzdOsxyVQCBIzt+dwmj/1hS
         0FEIxdf3kxtor+WLr7kL9Y0vlCfHOur0aEBvo57AoXZfAVKNJX7nVRcpo3gPgBs0J121
         JdAYwRCxxQKun+l1koHxbdXN/njOydBSX0j+Mi2OvJHKT8u6PsEqveyKsSTTNLqATYin
         v3DQfP7nvrGGDS8aYK53MnSe/mxwZRXMScAGeoYNzL/tpe2Xv0I8BGXkzvgDYJ0/HQDv
         JQh2RDF9ivk+TTFAdaGiOzE2CWJp7ONbWUXJKbxdagRIWbTJQpBvhyu2B2bQXibL99eT
         R2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfKpna/gHZrKywpyhlfYfrWp7SfpssT14AH9fDnyBhc=;
        b=guiMlHFxTfn7OmHKxlfGeJ9ihIKdDqMJAg/YNCkjMsJ6FfgTlpqKkYIwrRmfkgcle1
         NEwLZaDYOD/s9ByPWwAOAMmtRxux38pY845q0U7p5G14mJIHviyp6Tlc/qDCakMJ8j9b
         bNq1JQZrPgtJJaIe2Vv7k/QwUdC/efpuy00+uF+nI8TKFO2AbpowNUcX++sjpmmYOCII
         9twLqQMvk7J9p/9+TUucoW5ZSdpVn/O1FoEoP/VU+LYhFxzqtZ50gOD3QxHU1L+rCcmd
         YZhC9Eib4MWDnNDbw/S5S6J1pqGVGzryAPbib4PMmB6Sdkdu5cjzjZbqjVaP7N2Pliqj
         DQdw==
X-Gm-Message-State: APjAAAVWcqNY9MquPtugtnypr6j889o18wkQOp5zpEwDpHYZYWG2m8dM
        Qp2cJ3h1HawLaRsKQxtyFsng6g==
X-Google-Smtp-Source: APXvYqy3NlA5gvY/i2LUQjbrj98NidF1+ZAccFnC7XtPBVcGfForOTuhwxmW4gsDRqMB842f8yYE+Q==
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr21837119wrv.240.1581612723942;
        Thu, 13 Feb 2020 08:52:03 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:52:03 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: [PATCH 00/10] PCI/ATS: Device-tree support and other improvements
Date:   Thu, 13 Feb 2020 17:50:38 +0100
Message-Id: <20200213165049.508908-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Enable ATS on device-tree based systems, and factor the common ATS
enablement checks into pci_enable_ats().

ATS support in PCIe endpoints is discovered through the ATS capability,
but there is no common method for discovering whether the host bridge
supports ATS. Each vendor provides their own ACPI method:
* DMAR (Intel) reports ATS support per domain or per root port.
* IVRS (AMD) reports negative ATS support for a range of devices.
* IORT (ARM) reports ATS support for a root complex.

In my opinion it's important that we only enable ATS if the host bridge
supports it, but I don't think a finer granularity is useful. If the
host bridge ignores the Address Translation field of TLP headers, it
could in theory treat a Translation Request as a Memory Read Request,
and a Translated Request as a normal memory access, which could result
in silent memory corruption.

Patches 1-3 add a device-tree property that declares ATS support in host
controllers. We only add it to the generic host, but the property can
easily be reused by other PCI hosts. Alternatively, the host drivers can
directly set the new ats_supported property of the host bridge
introduced in patch 1.

Patch 4 uses the new ats_supported host bridge property for IORT. Patch
9 removes the old method that set a flag in each endpoint's fwspec.

Patches 5-8 put all checks required for enabling ATS in common, along
with the new host bridge check.

Jean-Philippe Brucker (11):
  dt-bindings: PCI: generic: Add ats-supported property
  PCI: Add ats_supported host bridge flag
  PCI: OF: Check whether the host bridge supports ATS
  ACPI/IORT: Check ATS capability in root complex node
  PCI/ATS: Gather checks into pci_ats_supported()
  iommu/amd: Use pci_ats_supported()
  iommu/arm-smmu-v3: Use pci_ats_supported()
  iommu/vt-d: Use pci_ats_supported()
  ACPI/IORT: Drop ATS fwspec flag
  arm64: dts: fast models: Enable PCIe ATS for Base RevC FVP
  Documentation: Generalize the "pci=noats" boot parameter

 .../admin-guide/kernel-parameters.txt         |  4 +-
 .../bindings/pci/host-generic-pci.yaml        |  6 +++
 arch/arm64/boot/dts/arm/fvp-base-revc.dts     |  1 +
 drivers/acpi/arm64/iort.c                     | 38 +++++++++++++------
 drivers/acpi/pci_root.c                       |  3 ++
 drivers/iommu/amd_iommu.c                     | 12 ++----
 drivers/iommu/arm-smmu-v3.c                   | 18 ++-------
 drivers/iommu/intel-iommu.c                   |  9 ++---
 drivers/pci/ats.c                             | 30 ++++++++++++++-
 drivers/pci/controller/pci-host-common.c      |  1 +
 drivers/pci/of.c                              |  9 +++++
 drivers/pci/probe.c                           |  7 ++++
 include/linux/acpi_iort.h                     |  8 ++++
 include/linux/iommu.h                         |  4 --
 include/linux/of_pci.h                        |  3 ++
 include/linux/pci-ats.h                       |  3 ++
 include/linux/pci.h                           |  1 +
 17 files changed, 110 insertions(+), 47 deletions(-)

-- 
2.25.0

