Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732E04ECB8E
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349865AbiC3SQu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 14:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349824AbiC3SQh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 14:16:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E3275C9;
        Wed, 30 Mar 2022 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648664092; x=1680200092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v2aVAJGUf+hBjQ8T05t5SoZ5dzwy5YTP0J26NB+Tvs0=;
  b=FufQVpW45Sfu7L6xX3iyrS6mOV0xhAJ+KiiRACkZCA0D6P342GOSgmu6
   AEV09+Qd1gYPA0LlfLdvs70tgffs1D5dcth06JIXmtGJhsVASXT4IBs0v
   osfwlCNwUxqvsHiQdscEG6SxpimLFagul8oLYol5CnfmAlQzHYe1539D7
   jv11OqcNNa2wZmWRWXP4oj6lZnVlRyDuy2g8y+vscCH+Qp0Gqa4HWRJen
   fYy3u8VjyFOCGfCSnUNBaCNp3L+rNFCtXVheifotAxTTmvWuUkIRnbrqH
   vwvIraTft1kfsQgyAOEtLx1znWqXJbAPJqflIMOhRWvmdauDSR8T4HgZq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241764490"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241764490"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:14:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="653992041"
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
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 1/3] acpi: add a helper for retrieving _OSC Control DWORDs
Date:   Wed, 30 Mar 2022 12:14:32 -0600
Message-Id: <20220330181434.1515791-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330181434.1515791-1-vishal.l.verma@intel.com>
References: <20220330181434.1515791-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2739; h=from:subject; bh=v2aVAJGUf+hBjQ8T05t5SoZ5dzwy5YTP0J26NB+Tvs0=; b=owGbwMvMwCXGf25diOft7jLG02pJDEku87h+hG3ey9s0JbbJp0ri3svVAgtkEvj2de4+26SV2XSg UDWro5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABPxlmH4H8rT8Xl+oc2ttCev3xZYLk vi4tKdZPlbwLbl8y5B2ZYtexgZWn9UdiSxJ8/ceUHX42XNc4YW5lrWbfMeK70zPfNq7+xuXgA=
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
 include/linux/acpi.h    | 12 ++++++++++++
 drivers/acpi/bus.c      |  2 +-
 drivers/acpi/pci_root.c |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6274758648e3..5c5bac255d35 100644
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
@@ -1003,6 +1010,11 @@ static inline int acpi_register_wakeup_handler(int wake_irq,
 static inline void acpi_unregister_wakeup_handler(
 	bool (*wakeup)(void *context), void *context) { }
 
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

