Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161A3200397
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jun 2020 10:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgFSIVL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Jun 2020 04:21:11 -0400
Received: from foss.arm.com ([217.140.110.172]:46846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731241AbgFSIUd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Jun 2020 04:20:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E408E2B;
        Fri, 19 Jun 2020 01:20:27 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6990E3F71F;
        Fri, 19 Jun 2020 01:20:25 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 00/12] ACPI/OF: Upgrade MSI/IOMMU ID mapping APIs
Date:   Fri, 19 Jun 2020 09:20:01 +0100
Message-Id: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series is a v2 of a previous posting:

v1 -> v2

- Removed _rid() wrappers
- Fixed !CONFIG_ACPI compilation issue
- Converted of_pci_iommu_init() to use of_iommu_configure_dev_id()

v1: https://lore.kernel.org/linux-arm-kernel/20200521130008.8266-1-lorenzo.pieralisi@arm.com/

Original cover letter
---------------------

Firmware bindings provided in the ACPI IORT table[1] and device tree
bindings define rules to carry out input/output ID mappings - ie
retrieving an IOMMU/MSI controller input ID for a device with a given
ID.

At the moment these firmware bindings are used exclusively for PCI
devices and their requester ID to IOMMU/MSI id mapping but there is
nothing PCI specific in the ACPI and devicetree bindings that prevent
the firmware and kernel from using the firmware bindings to traslate
device IDs for any bus that requires its devices to carry out
input/output id translations.

The Freescale FSL bus is an example whereby the input/output ID
translation kernel code put in place for PCI can be reused for devices
attached to the bus that are not PCI devices.

This series updates the kernel code to make the MSI/IOMMU input/output
ID translation PCI agnostic and apply the resulting changes to the
device ID space provided by the Freescale FSL bus.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf

Cc: Rob Herring <robh+dt@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Joerg Roedel <joro@8bytes.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>

Diana Craciun (2):
  of/irq: make of_msi_map_get_device_domain() bus agnostic
  bus/fsl-mc: Refactor the MSI domain creation in the DPRC driver

Laurentiu Tudor (1):
  dt-bindings: arm: fsl: Add msi-map device-tree binding for fsl-mc bus

Lorenzo Pieralisi (8):
  ACPI/IORT: Make iort_match_node_callback walk the ACPI namespace for
    NC
  ACPI/IORT: Make iort_get_device_domain IRQ domain agnostic
  ACPI/IORT: Make iort_msi_map_rid() PCI agnostic
  ACPI/IORT: Remove useless PCI bus walk
  ACPI/IORT: Add an input ID to acpi_dma_configure()
  of/iommu: Make of_map_rid() PCI agnostic
  of/device: Add input id to of_dma_configure()
  of/irq: Make of_msi_map_rid() PCI bus agnostic

Makarand Pawagi (1):
  bus: fsl-mc: Add ACPI support for fsl-mc

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt |  50 +++++++-
 drivers/acpi/arm64/iort.c                     | 108 ++++++++++++------
 drivers/acpi/scan.c                           |   8 +-
 drivers/bus/fsl-mc/dprc-driver.c              |  31 ++---
 drivers/bus/fsl-mc/fsl-mc-bus.c               |  79 +++++++++----
 drivers/bus/fsl-mc/fsl-mc-msi.c               |  36 ++++--
 drivers/bus/fsl-mc/fsl-mc-private.h           |   6 +-
 drivers/iommu/of_iommu.c                      |  81 +++++++------
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   | 105 ++++++++++++++---
 drivers/of/base.c                             |  42 +++----
 drivers/of/device.c                           |   8 +-
 drivers/of/irq.c                              |  34 +++---
 drivers/pci/msi.c                             |   9 +-
 include/acpi/acpi_bus.h                       |   9 +-
 include/linux/acpi.h                          |   7 ++
 include/linux/acpi_iort.h                     |  20 ++--
 include/linux/of.h                            |   4 +-
 include/linux/of_device.h                     |  16 ++-
 include/linux/of_iommu.h                      |   6 +-
 include/linux/of_irq.h                        |  13 ++-
 20 files changed, 451 insertions(+), 221 deletions(-)

-- 
2.26.1

