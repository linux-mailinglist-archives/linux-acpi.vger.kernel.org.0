Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9644DBBAB
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 01:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348397AbiCQA2Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 20:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCQA2Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 20:28:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38A91C93B;
        Wed, 16 Mar 2022 17:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647476828; x=1679012828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bqPV3IWQ12Km8cWLKnv50eZoThPO3qgM23mzhylluK4=;
  b=JpKcoJKYDpov9J390OBjD9ThjthgSaRXUBdEIEXKga6+nm3O0n8wM61m
   73nu7cZmC6oK/ddwalbwCYqSlrGeGFEGhT5GG+87ln4nbjXL9Gbt5opB2
   7kb2gbxQoc9QxJtQ3TUdaiOl7tSrZ5zKta1rGxvP9gT8KFjWwmUnK0iQN
   4/bO8EV5T3X8OcJHvlHVFqfnf+dDECyHSTS1OoQyH2CPnmLARghPomRvn
   vrVrG9kexcF4YiHtHKg7HOnhQZJLPoDrc5z/BvcDU4I037D9RJFOiHVYd
   7gm+AJp7+FNTI+KAtXCuATmP+PGG9FoKfGDci4/fbg3obNdypKxE7dr/s
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256699164"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256699164"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:27:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="646860801"
Received: from mjbitsoi-mobl2.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.15.66])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:27:07 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [RFC PATCH 1/2] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
Date:   Wed, 16 Mar 2022 18:27:03 -0600
Message-Id: <20220317002704.1835870-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317002704.1835870-1-vishal.l.verma@intel.com>
References: <20220317002704.1835870-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5911; i=vishal.l.verma@intel.com; h=from:subject; bh=VpiTClO6fkOWA6LtNvEzdFE+DIv3LjvrWtvLbxbX65U=; b=owGbwMvMwCXGf25diOft7jLG02pJDElGDRFzmX7Z79fLPvxlKWf9k5lHubfenqXmfudZbaYcV9zE RvULHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZjIjTpGhp2eWf9F58zv7l6ZIHlQyu Tf4+kJenvNwhJSArdxH91mxsLwv+KbzesJv6RTWaby1ExkKTVPeTJlI4OzhZNv5vp9k3ZwsAAA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

In preparation for negotiating OS control of CXL _OSC features, do the
minimal enabling to use CXL _OSC to handle the base PCIe feature
negotiation. Recall that CXL _OSC is a super-set of PCIe _OSC and the
CXL 2.0 specification mandates: "If a CXL Host Bridge device exposes CXL
_OSC, CXL aware OSPM shall evaluate CXL _OSC and not evaluate PCIe
_OSC."

A new ->cxl_osc_disable attribute is added for cases where platform
firmware publishes ACPI0016, but does not also publish CXL _OSC.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/acpi/acpi_bus.h |  1 +
 drivers/acpi/pci_root.c | 62 +++++++++++++++++++++++++++++++----------
 2 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ca88c4706f2b..768ef1584055 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -585,6 +585,7 @@ struct acpi_pci_root {
 	struct acpi_device * device;
 	struct pci_bus *bus;
 	u16 segment;
+	bool cxl_osc_disable;
 	struct resource secondary;	/* downstream bus range */
 
 	u32 osc_support_set;	/* _OSC state of support bits */
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b76db99cced3..2d834504096b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -170,20 +170,47 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
 			ARRAY_SIZE(pci_osc_control_bit));
 }
 
-static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
+static bool is_pcie(struct acpi_pci_root *root)
+{
+	return strcmp(acpi_device_hid(root->device), "PNP0A08") == 0;
+}
 
-static acpi_status acpi_pci_run_osc(acpi_handle handle,
+static bool is_cxl(struct acpi_pci_root *root)
+{
+	if (root->cxl_osc_disable)
+		return false;
+	return strcmp(acpi_device_hid(root->device), "ACPI0016") == 0;
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
+		return sizeof(u32) * 6;
+	return sizeof(u32) * 3;
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
@@ -196,7 +223,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 					u32 *control)
 {
 	acpi_status status;
-	u32 result, capbuf[3];
+	u32 result, capbuf[6];
 
 	support |= root->osc_support_set;
 
@@ -204,10 +231,18 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
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
+		root->cxl_osc_disable = true;
+		goto retry;
 	}
 	return status;
 }
@@ -338,7 +373,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
 	u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
 	struct acpi_pci_root *root;
 	acpi_status status;
-	u32 ctrl, capbuf[3];
+	u32 ctrl, capbuf[6];
 
 	if (!mask)
 		return AE_BAD_PARAMETER;
@@ -375,7 +410,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 s
 	capbuf[OSC_QUERY_DWORD] = 0;
 	capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
 	capbuf[OSC_CONTROL_DWORD] = ctrl;
-	status = acpi_pci_run_osc(handle, capbuf, mask);
+	status = acpi_pci_run_osc(root, capbuf, mask);
 	if (ACPI_FAILURE(status))
 		return status;
 
@@ -454,8 +489,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
 	return true;
 }
 
-static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
-				 bool is_pcie)
+static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 {
 	u32 support, control = 0, requested = 0;
 	acpi_status status;
@@ -506,7 +540,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		*no_aspm = 1;
 
 		/* _OSC is optional for PCI host bridges */
-		if ((status == AE_NOT_FOUND) && !is_pcie)
+		if ((status == AE_NOT_FOUND) && !is_pcie(root))
 			return;
 
 		if (control) {
@@ -529,7 +563,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
 	bool hotadd = system_state == SYSTEM_RUNNING;
-	bool is_pcie;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -587,8 +620,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
 	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
 
-	is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
-	negotiate_os_control(root, &no_aspm, is_pcie);
+	negotiate_os_control(root, &no_aspm);
 
 	/*
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
-- 
2.35.1

