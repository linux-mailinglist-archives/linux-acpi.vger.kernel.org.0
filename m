Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27344ECB92
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 20:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349870AbiC3SQw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 14:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349798AbiC3SQk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 14:16:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4E3BF92;
        Wed, 30 Mar 2022 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648664093; x=1680200093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MLep9sYBXvZ+gRIYKvaB1ABUb0EepoDAlAjy+0Bt0rk=;
  b=Vc39F18VG/m9GuqlGH8PG2eF/cpE7G1xvFaY/vTKVcevGlxI90psSaQ+
   oEI7sj5x0z2gTwRTUl+wPV2/8n3aj3dIqIEOTGUJ0ipLnTwv7FIpqANdM
   W/5NDSHcs7Xxzj+Aa9FjOxImdF5ZxRpheezGbDb9sQfZw1AJnOf1AJrS/
   7K3ntsZcjtBRBSL0C247nUc+Hu1TmDP4go3azg6wMSoaketnyOBpVjRIs
   wZ/mFPQUqbXH4LBcEV7mTcFhbL7QLxQUjs+UCCsWguVPpsrwcSqus7SkY
   y43EI0LGgzGGFq2RrTV0kROzn1xGu38mbhMEmwDloWQkRi9OuinGAHAdm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241764494"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241764494"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:14:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="653992055"
Received: from sbathula-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.170.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:14:50 -0700
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
Subject: [PATCH v3 2/3] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
Date:   Wed, 30 Mar 2022 12:14:33 -0600
Message-Id: <20220330181434.1515791-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330181434.1515791-1-vishal.l.verma@intel.com>
References: <20220330181434.1515791-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7676; i=vishal.l.verma@intel.com; h=from:subject; bh=fAq/3Ox2XtElTMOcXVzCjjM0m1SA4OeFZHrpWQKdz2s=; b=owGbwMvMwCXGf25diOft7jLG02pJDEku87i+/fni7fUmaAmXEnPP2ZOiX+YGNZhGdpzr/7H4QkW7 Ct/ajlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEzE/z8jwy42roZ307fkbc9K6X3Rum 8nZ0r3v2lh8fztn8+9MvO7fI6RYZmWXf/y39f1zNSqvk0TN8w9zrSucL9gn8nm9ydyj6n28wMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/acpi/pci_root.c | 70 ++++++++++++++++++++++++++++++++---------
 3 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5c5bac255d35..bc1f4314d266 100644
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
index 40a74ff3fa02..5d33bc61fe44 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -170,20 +170,45 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
 			ARRAY_SIZE(pci_osc_control_bit));
 }
 
-static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
+static inline bool is_pcie(struct acpi_pci_root *root)
+{
+	return root->bridge_type == ACPI_BRIDGE_TYPE_PCIE;
+}
 
-static acpi_status acpi_pci_run_osc(acpi_handle handle,
+static inline bool is_cxl(struct acpi_pci_root *root)
+{
+	return root->bridge_type == ACPI_BRIDGE_TYPE_CXL;
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
 		*retval = acpi_osc_ctx_get_pci_control(&context);
 		kfree(context.ret.pointer);
@@ -196,7 +221,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 					u32 *control)
 {
 	acpi_status status;
-	u32 result, capbuf[3];
+	u32 result, capbuf[OSC_CXL_CAPABILITY_DWORDS];
 
 	support |= root->osc_support_set;
 
@@ -204,10 +229,18 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
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
@@ -338,7 +371,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
 	u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
 	struct acpi_pci_root *root;
 	acpi_status status;
-	u32 ctrl, capbuf[3];
+	u32 ctrl, capbuf[OSC_CXL_CAPABILITY_DWORDS];
 
 	if (!mask)
 		return AE_BAD_PARAMETER;
@@ -375,7 +408,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
 	capbuf[OSC_QUERY_DWORD] = 0;
 	capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
 	capbuf[OSC_CONTROL_DWORD] = ctrl;
-	status = acpi_pci_run_osc(handle, capbuf, mask);
+	status = acpi_pci_run_osc(root, capbuf, mask);
 	if (ACPI_FAILURE(status))
 		return status;
 
@@ -454,8 +487,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
 	return true;
 }
 
-static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
-				 bool is_pcie)
+static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 {
 	u32 support, control = 0, requested = 0;
 	acpi_status status;
@@ -506,7 +538,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		*no_aspm = 1;
 
 		/* _OSC is optional for PCI host bridges */
-		if ((status == AE_NOT_FOUND) && !is_pcie)
+		if (status == AE_NOT_FOUND && !is_pcie(root))
 			return;
 
 		if (control) {
@@ -529,7 +561,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
 	bool hotadd = system_state == SYSTEM_RUNNING;
-	bool is_pcie;
+	const char *acpi_hid;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -587,8 +619,16 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
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

