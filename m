Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5B4E7E1B
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Mar 2022 01:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiCZA0U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Mar 2022 20:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiCZA0S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2022 20:26:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A53EF01;
        Fri, 25 Mar 2022 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254282; x=1679790282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tn9X631crMsvgft1YMFk/0/fsjhnitaE4RR+fVcK5bg=;
  b=R3RlzUjKuUGaF3Eng5IDN7W/zAmUGjijDOLWcotgSjqJywJ4qNTSOikR
   iZdsW+IQ+eGede/5BDeJBVNj2VrX6duLKBTL7cLuszLPqgKiMxcrEfulY
   wa93J1r1aQ74gtSQ0YHv0lp24h4Z3M0Bct1QU+9J3IhqgWDoBpqDAXyfM
   eT6VtphXKR+54PJCVGx/SpGgb5xbQZYfBUE0tXrhh0RZzxto7PLIDK+Np
   dWsmiA7C9uZOv9/cRYsTvo1/rHfCoj1MKKH2+zIo6A5MZc/cB0nDPkwWd
   fTRPSOTUrbhPfEty8BarR38w8NEMnpw3P4CXeqa1iwcI3dpk5j5pSpE6k
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="283621484"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="283621484"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:24:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="617281321"
Received: from jamanorb-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.81.45])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:24:42 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] acpi/pci_root: negotiate CXL _OSC
Date:   Fri, 25 Mar 2022 18:24:30 -0600
Message-Id: <20220326002430.797244-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326002430.797244-1-vishal.l.verma@intel.com>
References: <20220326002430.797244-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13964; h=from:subject; bh=Tn9X631crMsvgft1YMFk/0/fsjhnitaE4RR+fVcK5bg=; b=owGbwMvMwCXGf25diOft7jLG02pJDEl2sXb/RO6dnn48nImztDxjd9hEz3pjxosyB9+1/VjDOvNt xzTJjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEwk3pSR4bF1iL4Awwwexs/8SjtiNC Uc+oqym5eqHaict/D1jPbDxxgZfl+9WsW1yclTNefE+Q0l0V7hP1eb7giasaaX+98DG7NZHAA=
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

Add full support for negotiating _OSC as defined in the CXL 2.0 spec, as
applicable to CXL-enabled platforms. Advertise support for the CXL
features we support - 'CXL 2.0 port/device register access', 'Protocol
Error Reporting', and 'CL Native Hot Plug'. Request control for 'CXL
Memory Error Reporting'. The requests are dependent on CONFIG_* based
pre-requisites, and prior PCI enabling, similar to how the standard PCI
_OSC bits are determined.

The CXL specification does not define any additional constraints on
the hotplug flow beyond PCIe native hotplug, so a kernel that supports
native PCIe hotplug, supports CXL hotplug. For error handling protocol
and link errors just use PCIe AER. There is nascent support for
amending AER events with CXL specific status [1], but there's
otherwise no additional OS responsibility for CXL errors beyond PCIe
AER. CXL Memory Errors behave the same as typical memory errors so
CONFIG_MEMORY_FAILURE is sufficient to indicate support to platform
firmware.

[1]: https://lore.kernel.org/linux-cxl/164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com/

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 include/linux/acpi.h    |  16 +++-
 include/acpi/acpi_bus.h |   6 +-
 drivers/acpi/pci_root.c | 159 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 159 insertions(+), 22 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f41e8b00a839..fa7e18ff8fb2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -554,10 +554,15 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_PCI_CAPABILITY_DWORDS		3
 #define OSC_CXL_CAPABILITY_DWORDS		5
 
-/* Indexes into _OSC Capabilities Buffer (DWORDs 2 & 3 are device-specific) */
+/*
+ * Indexes into _OSC Capabilities Buffer
+ * DWORDs 2 & 3 are device-specific, and 4 & 5 are specific to CXL platforms
+ */
 #define OSC_QUERY_DWORD				0	/* DWORD 1 */
 #define OSC_SUPPORT_DWORD			1	/* DWORD 2 */
 #define OSC_CONTROL_DWORD			2	/* DWORD 3 */
+#define OSC_CXL_SUPPORT_DWORD			3	/* DWORD 4 */
+#define OSC_CXL_CONTROL_DWORD			4	/* DWORD 5 */
 
 /* _OSC Capabilities DWORD 1: Query/Control and Error Returns (generic) */
 #define OSC_QUERY_ENABLE			0x00000001  /* input */
@@ -611,6 +616,15 @@ extern u32 osc_sb_native_usb4_control;
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
 #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
 
+/* CXL _OSC: Capabilities DWORD 4: Support Field */
+#define OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT	0x00000001
+#define OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT	0x00000002
+#define OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT	0x00000004
+#define OSC_CXL_NATIVE_HP_SUPPORT		0x00000008
+
+/* CXL _OSC: Capabilities DWORD 5: Control Field */
+#define OSC_CXL_ERROR_REPORTING_CONTROL		0x00000001
+
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
 #define ACPI_GSB_ACCESS_ATTRIB_BYTE		0x00000006
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 9413d2389711..0fdd913c1fd7 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -593,8 +593,10 @@ struct acpi_pci_root {
 	int bridge_type;
 	struct resource secondary;	/* downstream bus range */
 
-	u32 osc_support_set;	/* _OSC state of support bits */
-	u32 osc_control_set;	/* _OSC state of control bits */
+	u32 osc_support_set;		/* _OSC state of support bits */
+	u32 osc_control_set;		/* _OSC state of control bits */
+	u32 cxl_osc_support_set;	/* _OSC state of CXL support bits */
+	u32 cxl_osc_control_set;	/* _OSC state of CXL control bits */
 	phys_addr_t mcfg_addr;
 };
 
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 170fe8c6fa5e..3bf79e44a8d3 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -142,6 +142,17 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
 };
 
+static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
+	{ OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT, "CXL11PortRegAccess" },
+	{ OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT, "CXL20PortDevRegAccess" },
+	{ OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT, "CXLProtocolErrorReporting" },
+	{ OSC_CXL_NATIVE_HP_SUPPORT, "CXLNativeHotPlug" },
+};
+
+static struct pci_osc_bit_struct cxl_osc_control_bit[] = {
+	{ OSC_CXL_ERROR_REPORTING_CONTROL, "CXLMemErrorReporting" },
+};
+
 static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
 			    struct pci_osc_bit_struct *table, int size)
 {
@@ -170,6 +181,18 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
 			ARRAY_SIZE(pci_osc_control_bit));
 }
 
+static void decode_cxl_osc_support(struct acpi_pci_root *root, char *msg, u32 word)
+{
+	decode_osc_bits(root, msg, word, cxl_osc_support_bit,
+			ARRAY_SIZE(cxl_osc_support_bit));
+}
+
+static void decode_cxl_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
+{
+	decode_osc_bits(root, msg, word, cxl_osc_control_bit,
+			ARRAY_SIZE(cxl_osc_control_bit));
+}
+
 static bool is_pcie(struct acpi_pci_root *root)
 {
 	if (root->bridge_type == ACPI_BRIDGE_TYPE_PCIE)
@@ -201,8 +224,23 @@ static int cap_length(struct acpi_pci_root *root)
 	return sizeof(u32) * OSC_PCI_CAPABILITY_DWORDS;
 }
 
+static u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
+{
+	u32 *ret = context->ret.pointer;
+
+	return ret[OSC_CONTROL_DWORD];
+}
+
+static u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
+{
+	u32 *ret = context->ret.pointer;
+
+	return ret[OSC_CXL_CONTROL_DWORD];
+}
+
 static acpi_status acpi_pci_run_osc(struct acpi_pci_root *root,
-				    const u32 *capbuf, u32 *retval)
+				    const u32 *capbuf, u32 *pci_control,
+				    u32 *cxl_control)
 {
 	struct acpi_osc_context context = {
 		.uuid_str = to_uuid(root),
@@ -214,18 +252,20 @@ static acpi_status acpi_pci_run_osc(struct acpi_pci_root *root,
 
 	status = acpi_run_osc(root->device->handle, &context);
 	if (ACPI_SUCCESS(status)) {
-		*retval = *((u32 *)(context.ret.pointer + 8));
+		*pci_control = acpi_osc_ctx_get_pci_control(&context);
+		if (is_cxl(root))
+			*cxl_control = acpi_osc_ctx_get_cxl_control(&context);
 		kfree(context.ret.pointer);
 	}
 	return status;
 }
 
-static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
-					u32 support,
-					u32 *control)
+static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 support,
+				      u32 *control, u32 cxl_support,
+				      u32 *cxl_control)
 {
 	acpi_status status;
-	u32 result, capbuf[OSC_CXL_CAPABILITY_DWORDS];
+	u32 pci_result, cxl_result, capbuf[OSC_CXL_CAPABILITY_DWORDS];
 
 	support |= root->osc_support_set;
 
@@ -233,11 +273,21 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 	capbuf[OSC_SUPPORT_DWORD] = support;
 	capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
 
+	if (is_cxl(root)) {
+		cxl_support |= root->cxl_osc_support_set;
+		capbuf[OSC_CXL_SUPPORT_DWORD] = cxl_support;
+		capbuf[OSC_CXL_CONTROL_DWORD] = *cxl_control | root->cxl_osc_control_set;
+	}
+
 retry:
-	status = acpi_pci_run_osc(root, capbuf, &result);
+	status = acpi_pci_run_osc(root, capbuf, &pci_result, &cxl_result);
 	if (ACPI_SUCCESS(status)) {
 		root->osc_support_set = support;
-		*control = result;
+		*control = pci_result;
+		if (is_cxl(root)) {
+			root->cxl_osc_support_set = cxl_support;
+			*cxl_control = cxl_result;
+		}
 	} else if (is_cxl(root)) {
 		/*
 		 * CXL _OSC is optional on CXL 1.1 hosts. Fall back to PCIe _OSC
@@ -360,6 +410,8 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
  * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
  * @mask: Mask of _OSC bits to request control of, place to store control mask.
  * @support: _OSC supported capability.
+ * @cxl_mask: Mask of CXL _OSC control bits, place to store control mask.
+ * @cxl_support: CXL _OSC supported capability.
  *
  * Run _OSC query for @mask and if that is successful, compare the returned
  * mask of control bits with @req.  If all of the @req bits are set in the
@@ -370,12 +422,14 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
  * _OSC bits the BIOS has granted control of, but its contents are meaningless
  * on failure.
  **/
-static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 support)
+static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask,
+					    u32 support, u32 *cxl_mask,
+					    u32 cxl_support)
 {
 	u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
 	struct acpi_pci_root *root;
 	acpi_status status;
-	u32 ctrl, capbuf[OSC_CXL_CAPABILITY_DWORDS];
+	u32 ctrl, cxl_ctrl = 0, capbuf[OSC_CXL_CAPABILITY_DWORDS];
 
 	if (!mask)
 		return AE_BAD_PARAMETER;
@@ -387,20 +441,42 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
 	ctrl   = *mask;
 	*mask |= root->osc_control_set;
 
+	if (is_cxl(root)) {
+		cxl_ctrl = *cxl_mask;
+		*cxl_mask |= root->cxl_osc_control_set;
+	}
+
 	/* Need to check the available controls bits before requesting them. */
 	do {
-		status = acpi_pci_query_osc(root, support, mask);
+		u32 pci_missing = 0, cxl_missing = 0;
+
+		status = acpi_pci_query_osc(root, support, mask, cxl_support,
+					    cxl_mask);
 		if (ACPI_FAILURE(status))
 			return status;
-		if (ctrl == *mask)
-			break;
-		decode_osc_control(root, "platform does not support",
-				   ctrl & ~(*mask));
+		if (is_cxl(root)) {
+			if (ctrl == *mask && cxl_ctrl == *cxl_mask)
+				break;
+			pci_missing = ctrl & ~(*mask);
+			cxl_missing = cxl_ctrl & ~(*cxl_mask);
+		} else {
+			if (ctrl == *mask)
+				break;
+			pci_missing = ctrl & ~(*mask);
+		}
+		if (pci_missing)
+			decode_osc_control(root, "platform does not support",
+					   pci_missing);
+		if (cxl_missing)
+			decode_cxl_osc_control(root, "CXL platform does not support",
+					   cxl_missing);
 		ctrl = *mask;
-	} while (*mask);
+		cxl_ctrl = *cxl_mask;
+	} while (*mask || *cxl_mask);
 
 	/* No need to request _OSC if the control was already granted. */
-	if ((root->osc_control_set & ctrl) == ctrl)
+	if ((root->osc_control_set & ctrl) == ctrl &&
+	    (root->cxl_osc_control_set & cxl_ctrl) == cxl_ctrl)
 		return AE_OK;
 
 	if ((ctrl & req) != req) {
@@ -412,11 +488,17 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
 	capbuf[OSC_QUERY_DWORD] = 0;
 	capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
 	capbuf[OSC_CONTROL_DWORD] = ctrl;
-	status = acpi_pci_run_osc(root, capbuf, mask);
+	if (is_cxl(root)) {
+		capbuf[OSC_CXL_SUPPORT_DWORD] = root->cxl_osc_support_set;
+		capbuf[OSC_CXL_CONTROL_DWORD] = cxl_ctrl;
+	}
+
+	status = acpi_pci_run_osc(root, capbuf, mask, cxl_mask);
 	if (ACPI_FAILURE(status))
 		return status;
 
 	root->osc_control_set = *mask;
+	root->cxl_osc_control_set = *cxl_mask;
 	return AE_OK;
 }
 
@@ -442,6 +524,19 @@ static u32 calculate_support(void)
 	return support;
 }
 
+static u32 calculate_cxl_support(void)
+{
+	u32 support;
+
+	support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
+	if (pci_aer_available())
+		support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
+	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+		support |= OSC_CXL_NATIVE_HP_SUPPORT;
+
+	return support;
+}
+
 static u32 calculate_control(void)
 {
 	u32 control;
@@ -473,6 +568,16 @@ static u32 calculate_control(void)
 	return control;
 }
 
+static u32 calculate_cxl_control(void)
+{
+	u32 control = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE))
+		control |= OSC_CXL_ERROR_REPORTING_CONTROL;
+
+	return control;
+}
+
 static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
 {
 	struct acpi_device *device = root->device;
@@ -494,6 +599,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 {
 	u32 support, control = 0, requested = 0;
+	u32 cxl_support = 0, cxl_control = 0, cxl_requested = 0;
 	acpi_status status;
 	struct acpi_device *device = root->device;
 	acpi_handle handle = device->handle;
@@ -517,10 +623,20 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 	if (os_control_query_checks(root, support))
 		requested = control = calculate_control();
 
-	status = acpi_pci_osc_control_set(handle, &control, support);
+	if (is_cxl(root)) {
+		cxl_support = calculate_cxl_support();
+		decode_cxl_osc_support(root, "OS supports", cxl_support);
+		cxl_requested = cxl_control = calculate_cxl_control();
+	}
+
+	status = acpi_pci_osc_control_set(handle, &control, support,
+					  &cxl_control, cxl_support);
 	if (ACPI_SUCCESS(status)) {
 		if (control)
 			decode_osc_control(root, "OS now controls", control);
+		if (cxl_control)
+			decode_cxl_osc_control(root, "OS now controls",
+					   cxl_control);
 
 		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 			/*
@@ -549,6 +665,11 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 			decode_osc_control(root, "OS requested", requested);
 			decode_osc_control(root, "platform willing to grant", control);
 		}
+		if (cxl_control) {
+			decode_cxl_osc_control(root, "OS requested", cxl_requested);
+			decode_cxl_osc_control(root, "platform willing to grant",
+					   cxl_control);
+		}
 
 		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
 			 acpi_format_exception(status));
-- 
2.35.1

