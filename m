Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A7621A731
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 20:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGISnm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 14:43:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:34079 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgGISnl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Jul 2020 14:43:41 -0400
IronPort-SDR: aES/5/9aDQnQd/Oj/5HqlcjFQ6fP65c+uZwkX+G4qMgUL8qYs5Smu+4achyIfQsmbIJsM9vKPB
 T7kYU2AQxXzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="147166672"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="147166672"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 11:43:10 -0700
IronPort-SDR: aLVUxwbumtA0VDDj/erIBDT5YZPyZBbKLx0K3hbgaaBMz8ZtTcansNhxrgbQWPFtcrHRqcknJa
 //SYQoCFvWqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="280391549"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2020 11:43:07 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 6703A580801;
        Thu,  9 Jul 2020 11:43:07 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        dan.j.williams@intel.com, shyjumon.n@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH V5] drivers/nvme: Add support for ACPI StorageD3Enable property
Date:   Thu,  9 Jul 2020 11:43:33 -0700
Message-Id: <20200709184333.6241-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200702225011.10932-1-david.e.box@linux.intel.com>
References: <20200702225011.10932-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch implements a solution for a BIOS hack used on some currently
shipping Intel systems to change driver power management policy for PCIe
NVMe drives. Some newer Intel platforms, like some Comet Lake systems,
require that PCIe devices use D3 when doing suspend-to-idle in order to
allow the platform to realize maximum power savings. This is particularly
needed to support ATX power supply shutdown on desktop systems. In order to
ensure this happens for root ports with storage devices, Microsoft
apparently created this ACPI _DSD property as a way to influence their
driver policy. To my knowledge this property has not been discussed with
the NVME specification body.

Though the solution is not ideal, it addresses a problem that also affects
Linux since the NVMe driver's default policy of using NVMe APST during
suspend-to-idle prevents the PCI root port from going to D3 and leads to
higher power consumption for these platforms. The power consumption
difference may be negligible on laptop systems, but many watts on desktop
systems when the ATX power supply is blocked from powering down.

The patch creates a new nvme_acpi_storage_d3 function to check for the
StorageD3Enable property during probe and enables D3 as a quirk if set.  It
also provides a 'noacpi' module parameter to allow skipping the quirk if
needed.

Tested on:
PM961 NVMe SED Samsung 512GB
INTEL SSDPEKKF512G8

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
Changes from V4:
 	- Add support for North complex PCI root ports.
	- Use acpi_bus_get_device instead of acpi_bus_get_acpi_device.
	  Also fixes compiler error on V4 reported by lkp@intel.com.
	- Place CONFIG_ACPI around function since acpi_bus_get_device
	  is not stubbed out.

Changes from V3:
 	- Use pcie_find_root_port() instead of pci_find_pcie_root_port(),
 	  changed in 5.8.
 	- Remove "Cc:" emails that ended up at top of V3 commit message.
 	- Fix changelog numbering.
 
Changes from V2:
	- Remove check for "not yet bound" ACPI companion device since
	  this will not be a concern at driver probe time per Rafael.
	- Move storage_d3 function out of PCI core and into NVMe driver
	  since there's nothing the PCI core can do with this code as
	  noted by Bjorn.
 
Changes from V1:
	- Export the pci_acpi_storage_d3 function for use by drivers as
	  needed instead of modifying the pci header.
	- Add missing put on acpi device handle.
	- Add 'noacpi' module parameter to allow undoing this change.
	- Add info message that this is a platform quirk.


 drivers/acpi/property.c |  3 ++
 drivers/nvme/host/pci.c | 64 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e601c4511a8b..c2e2ae774a19 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
 	/* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
 	GUID_INIT(0x6c501103, 0xc189, 0x4296,
 		  0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
+	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
+	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
+		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
 };
 
 /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1d18f0633c7..7c0be363eb22 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#include <linux/acpi.h>
 #include <linux/aer.h>
 #include <linux/async.h>
 #include <linux/blkdev.h>
@@ -94,6 +95,10 @@ static unsigned int poll_queues;
 module_param_cb(poll_queues, &io_queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
+static bool noacpi;
+module_param(noacpi, bool, 0444);
+MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -2759,6 +2764,55 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static bool nvme_acpi_storage_d3(struct pci_dev *dev)
+{
+	const struct fwnode_handle *fwnode;
+	struct acpi_device *adev;
+	struct pci_dev *root;
+	acpi_handle handle;
+	acpi_status status;
+	u8 val;
+
+	/*
+	 * Look for _DSD property specifying that the storage device on
+	 * the port must use D3 to support deep platform power savings during
+	 * suspend-to-idle
+	 */
+	root = pcie_find_root_port(dev);
+	if (!root)
+		return false;
+
+	adev = ACPI_COMPANION(&root->dev);
+	if (!adev)
+		return false;
+
+	/*
+	 * The property is defined in the PXSX device for South complex ports
+	 * and in the PEGP device for North complex ports.
+	 */
+	status = acpi_get_handle(adev->handle, "PXSX", &handle);
+	if (ACPI_FAILURE(status)) {
+		status = acpi_get_handle(adev->handle, "PEGP", &handle);
+		if (ACPI_FAILURE(status))
+			return false;
+	}
+
+	if (acpi_bus_get_device(handle, &adev))
+		return false;
+
+	fwnode = acpi_fwnode_handle(adev);
+
+	return fwnode_property_read_u8(fwnode, "StorageD3Enable", &val) ?
+		false : val == 1;
+}
+#else
+static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
+{
+	return false;
+}
+#endif
+
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
@@ -2808,6 +2862,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
+	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
+		/*
+		 * Some systems use a bios work around to ask for D3 on
+		 * platforms that support kernel managed suspend.
+		 */
+		dev_info(&pdev->dev,
+			 "platform quirk: setting simple suspend\n");
+		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
+	}
+
 	/*
 	 * Double check that our mempool alloc size will cover the biggest
 	 * command we support.
-- 
2.20.1

