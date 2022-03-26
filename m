Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619914E7E1D
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Mar 2022 01:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiCZA0U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Mar 2022 20:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCZA0R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2022 20:26:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E8D35248;
        Fri, 25 Mar 2022 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254282; x=1679790282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Vaao8UPajyvbZwIqwuigMcc3TK8sVUH5316v42oZho=;
  b=jFUgszWOc4qwtKHLHSdd0DVWZEJRv8Eof80y0b5bfthOZ02lyGwiaPXR
   3aQjfMm6nx2lJn5OTspUsbJ8qZ0Da7DQoLB4Ea4nRhMcM3CaYeu/2ZBjf
   JOZ8qORfy/RbLP0De65eoOFDkQ6Ah58ZjegDM2nYXqnwV4lMLhKelG16o
   HsZdxmFQ7DzaorWCsW69jg8d1liYbOUQMyo+sPCexmVYL8ylddMwd6k65
   k1dsR578wQbcr0KI1tr4vFdASe2Zxkh5hjX+aCPFCFL/G2eu32YmMODBh
   g9G0H3yldMuQGf2TYDwqdEzYy/KG8/QIAV23x/cK28aDC2Ma96murXBLs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="283621482"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="283621482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:24:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="617281317"
Received: from jamanorb-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.81.45])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:24:41 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 1/2] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
Date:   Fri, 25 Mar 2022 18:24:29 -0600
Message-Id: <20220326002430.797244-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326002430.797244-1-vishal.l.verma@intel.com>
References: <20220326002430.797244-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7721; i=vishal.l.verma@intel.com; h=from:subject; bh=xk0CrkMTu7VZvxVhNgyAOLWPZHELHfYAHR2GAqK2joM=; b=owGbwMvMwCXGf25diOft7jLG02pJDEl2sXaFj6TST0mJleaz7/lyPuuIi1W253lBle1dAR0+RZ73 J2zrKGVhEONikBVTZPm75yPjMbnt+TyBCY4wc1iZQIYwcHEKwETcdBn+O79T8Sw7+qT/k8TEbcZf73 VVaj8u5zleyVF9aWp5yPMdcxkZjnuXi/pJCH7d4v4wuW7/4VafmqrZt9q3bpL5+GXpNGM9LgA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

OB In preparation for negotiating OS control of CXL _OSC features, do the
minimal enabling to use CXL _OSC to handle the base PCIe feature
negotiation. Recall that CXL _OSC is a super-set of PCIe _OSC and the
CXL 2.0 specification mandates: "If a CXL Host Bridge device exposes CXL
_OSC, CXL aware OSPM shall evaluate CXL _OSC and not evaluate PCIe
_OSC."

Rather than pass a boolean flag alongside @root to all the helper
functions that need to consider PCIe specifics, add is_pcie() and
is_cxl() helper functions to check the flavor of @root. This also
allows for dynamic fallback to PCIe _OSC in cases where an attempt to
use CXL _OXC fails. This can happen on CXL 1.1 platforms that publish
ACPI0016 devices to indicate CXL host bridges, but do not publish the
optional CXL _OSC method. CXL _OSC is mandatory for CXL 2.0 hosts.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 include/linux/acpi.h    |  4 +++
 include/acpi/acpi_bus.h |  6 ++++
 drivers/acpi/pci_root.c | 74 ++++++++++++++++++++++++++++++++---------
 3 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6274758648e3..f41e8b00a839 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -550,6 +550,10 @@ struct acpi_osc_context {
 
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 
+/* Number of _OSC capability DWORDS depends on bridge type */
+#define OSC_PCI_CAPABILITY_DWORDS		3
+#define OSC_CXL_CAPABILITY_DWORDS		5
+
 /* Indexes into _OSC Capabilities Buffer (DWORDs 2 & 3 are device-specific) */
 #define OSC_QUERY_DWORD				0	/* DWORD 1 */
 #define OSC_SUPPORT_DWORD			1	/* DWORD 2 */
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ca88c4706f2b..9413d2389711 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -581,10 +581,16 @@ int unregister_acpi_bus_type(struct acpi_bus_type *);
 int acpi_bind_one(struct device *dev, struct acpi_device *adev);
 int acpi_unbind_one(struct device *dev);
 
+enum acpi_bridge_type {
+	ACPI_BRIDGE_TYPE_PCIE = 1,
+	ACPI_BRIDGE_TYPE_CXL,
+};
+
 struct acpi_pci_root {
 	struct acpi_device * device;
 	struct pci_bus *bus;
 	u16 segment;
+	int bridge_type;
 	struct resource secondary;	/* downstream bus range */
 
 	u32 osc_support_set;	/* _OSC state of support bits */
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b76db99cced3..170fe8c6fa5e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -170,20 +170,49 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
 			ARRAY_SIZE(pci_osc_control_bit));
 }
 
-static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
+static bool is_pcie(struct acpi_pci_root *root)
+{
+	if (root->bridge_type == ACPI_BRIDGE_TYPE_PCIE)
+		return true;
+	return false;
+}
 
-static acpi_status acpi_pci_run_osc(acpi_handle handle,
+static bool is_cxl(struct acpi_pci_root *root)
+{
+	if (root->bridge_type == ACPI_BRIDGE_TYPE_CXL)
+		return true;
+	return false;
+}
+
+static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
+static u8 cxl_osc_uuid_str[] = "68F2D50B-C469-4d8A-BD3D-941A103FD3FC";
+
+static char *to_uuid(struct acpi_pci_root *root)
+{
+	if (is_cxl(root))
+		return cxl_osc_uuid_str;
+	return pci_osc_uuid_str;
+}
+
+static int cap_length(struct acpi_pci_root *root)
+{
+	if (is_cxl(root))
+		return sizeof(u32) * OSC_CXL_CAPABILITY_DWORDS;
+	return sizeof(u32) * OSC_PCI_CAPABILITY_DWORDS;
+}
+
+static acpi_status acpi_pci_run_osc(struct acpi_pci_root *root,
 				    const u32 *capbuf, u32 *retval)
 {
 	struct acpi_osc_context context = {
-		.uuid_str = pci_osc_uuid_str,
+		.uuid_str = to_uuid(root),
 		.rev = 1,
-		.cap.length = 12,
+		.cap.length = cap_length(root),
 		.cap.pointer = (void *)capbuf,
 	};
 	acpi_status status;
 
-	status = acpi_run_osc(handle, &context);
+	status = acpi_run_osc(root->device->handle, &context);
 	if (ACPI_SUCCESS(status)) {
 		*retval = *((u32 *)(context.ret.pointer + 8));
 		kfree(context.ret.pointer);
@@ -196,7 +225,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 					u32 *control)
 {
 	acpi_status status;
-	u32 result, capbuf[3];
+	u32 result, capbuf[OSC_CXL_CAPABILITY_DWORDS];
 
 	support |= root->osc_support_set;
 
@@ -204,10 +233,18 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 	capbuf[OSC_SUPPORT_DWORD] = support;
 	capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
 
-	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
+retry:
+	status = acpi_pci_run_osc(root, capbuf, &result);
 	if (ACPI_SUCCESS(status)) {
 		root->osc_support_set = support;
 		*control = result;
+	} else if (is_cxl(root)) {
+		/*
+		 * CXL _OSC is optional on CXL 1.1 hosts. Fall back to PCIe _OSC
+		 * upon any failure using CXL _OSC.
+		 */
+		root->bridge_type = ACPI_BRIDGE_TYPE_PCIE;
+		goto retry;
 	}
 	return status;
 }
@@ -338,7 +375,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
 	u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
 	struct acpi_pci_root *root;
 	acpi_status status;
-	u32 ctrl, capbuf[3];
+	u32 ctrl, capbuf[OSC_CXL_CAPABILITY_DWORDS];
 
 	if (!mask)
 		return AE_BAD_PARAMETER;
@@ -375,7 +412,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
 	capbuf[OSC_QUERY_DWORD] = 0;
 	capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
 	capbuf[OSC_CONTROL_DWORD] = ctrl;
-	status = acpi_pci_run_osc(handle, capbuf, mask);
+	status = acpi_pci_run_osc(root, capbuf, mask);
 	if (ACPI_FAILURE(status))
 		return status;
 
@@ -454,8 +491,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
 	return true;
 }
 
-static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
-				 bool is_pcie)
+static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 {
 	u32 support, control = 0, requested = 0;
 	acpi_status status;
@@ -506,7 +542,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		*no_aspm = 1;
 
 		/* _OSC is optional for PCI host bridges */
-		if ((status == AE_NOT_FOUND) && !is_pcie)
+		if (status == AE_NOT_FOUND && !is_pcie(root))
 			return;
 
 		if (control) {
@@ -529,7 +565,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
 	bool hotadd = system_state == SYSTEM_RUNNING;
-	bool is_pcie;
+	const char *acpi_hid;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -587,8 +623,16 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
 	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
 
-	is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
-	negotiate_os_control(root, &no_aspm, is_pcie);
+	acpi_hid = acpi_device_hid(root->device);
+	if (strcmp(acpi_hid, "PNP0A08") == 0)
+		root->bridge_type = ACPI_BRIDGE_TYPE_PCIE;
+	else if (strcmp(acpi_hid, "ACPI0016") == 0)
+		root->bridge_type = ACPI_BRIDGE_TYPE_CXL;
+	else
+		dev_warn(&device->dev, "unknown bridge type with hid: %s\n",
+			 acpi_hid);
+
+	negotiate_os_control(root, &no_aspm);
 
 	/*
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
-- 
2.35.1

