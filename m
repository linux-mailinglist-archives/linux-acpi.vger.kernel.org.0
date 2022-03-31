Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C04EE28B
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Mar 2022 22:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiCaUWT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 31 Mar 2022 16:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbiCaUWR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Mar 2022 16:22:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6328119E3B5;
        Thu, 31 Mar 2022 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648758028; x=1680294028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GfsAn5oqzNd2AGFzMfIDMiJW1RIrHvAPUCkC4/jLGnw=;
  b=LgY1EgRhgunwM4z/jX063dKBm9u5N0FgyEbIaKKPwIdfgm1EOaB3aEBu
   fg7gosla1JbwkURAryzigXyEGTfE9QBvMrWuT3uvl+o8F2L4vXYzNL/qv
   ANgeTrS4l5QcecbtXXgom3rh+hgp++m8205j5Jk256IX1/rzIhR6qUO+d
   l5/p3lBE9nF+AsPrvRXqUqyNcElNen3cTbmMciLEy0/GqRTOgbtMjngDc
   Yx/gP0u3kASfBNzE8SWpyHcqxREOzvXfN4TYBJUgOwAUlAHrUKMi3mmxR
   P0PB2FYCKSIpV58C2uLQrSzlO8mzAml1CezEUSgAtLY4lmMyetgt5zJC0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="240543571"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="240543571"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 13:20:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="503899657"
Received: from pmuthurs-mobl4.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.72.98])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 13:20:26 -0700
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 1/3] PCI/ACPI: add a helper for retrieving _OSC Control DWORDs
Date:   Thu, 31 Mar 2022 14:20:20 -0600
Message-Id: <20220331202022.1823174-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331202022.1823174-1-vishal.l.verma@intel.com>
References: <20220331202022.1823174-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2767; h=from:subject; bh=GfsAn5oqzNd2AGFzMfIDMiJW1RIrHvAPUCkC4/jLGnw=; b=owGbwMvMwCXGf25diOft7jLG02pJDEluvGyi2/bsS1JorvWZtPzSxqQ1nx8eFs/YfqY668UG4WfS bzWOdZSyMIhxMciKKbL83fOR8Zjc9nyewARHmDmsTCBDGLg4BWAi4s8Y/ueXP0nclSk5xfn3+XXpXo du6L4PMo407pyp9fxzK+O0jv8M/4vb1n+4Z/q45HG5Y00Sl5dxzvZrEm4LpLoMU+pyqr2OsAMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

During _OSC negotiation, when the 'Control' DWORD is needed from the
result buffer after running _OSC, a couple of places performed manual
pointer arithmetic to offset into the right spot in the raw buffer.
Add a acpi_osc_ctx_get_pci_control() helper to use the #define'd
DWORD offsets to fetch the DWORDs needed from @acpi_osc_context, and
replace the above instances of the open-coded arithmetic.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 include/linux/acpi.h    | 13 +++++++++++++
 drivers/acpi/bus.c      |  2 +-
 drivers/acpi/pci_root.c |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6274758648e3..ff4d1fdd9009 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -607,6 +607,13 @@ extern u32 osc_sb_native_usb4_control;
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
 #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
 
+static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
+{
+	u32 *ret = context->ret.pointer;
+
+	return ret[OSC_CONTROL_DWORD];
+}
+
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
 #define ACPI_GSB_ACCESS_ATTRIB_BYTE		0x00000006
@@ -1003,6 +1010,12 @@ static inline int acpi_register_wakeup_handler(int wake_irq,
 static inline void acpi_unregister_wakeup_handler(
 	bool (*wakeup)(void *context), void *context) { }
 
+struct acpi_osc_context;
+static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
+{
+	return 0;
+}
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 07f604832fd6..4992e05cf429 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -405,7 +405,7 @@ static void acpi_bus_osc_negotiate_usb_control(void)
 	}
 
 	osc_sb_native_usb4_control =
-		control & ((u32 *)context.ret.pointer)[OSC_CONTROL_DWORD];
+		control &  acpi_osc_ctx_get_pci_control(&context);
 
 	acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
 	acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b76db99cced3..40a74ff3fa02 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -185,7 +185,7 @@ static acpi_status acpi_pci_run_osc(acpi_handle handle,
 
 	status = acpi_run_osc(handle, &context);
 	if (ACPI_SUCCESS(status)) {
-		*retval = *((u32 *)(context.ret.pointer + 8));
+		*retval = acpi_osc_ctx_get_pci_control(&context);
 		kfree(context.ret.pointer);
 	}
 	return status;
-- 
2.35.1

