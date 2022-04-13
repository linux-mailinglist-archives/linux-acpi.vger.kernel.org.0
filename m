Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9694FF0A5
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Apr 2022 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiDMHiu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Apr 2022 03:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiDMHir (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Apr 2022 03:38:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2704D9DA;
        Wed, 13 Apr 2022 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649835387; x=1681371387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KuDyMjgZJkRQezDGFR0bJFAQ24ixyH7tcQKp+n2rFSw=;
  b=HFVfwa/UW4P62lwDnBNSk3YiFJ3W92DjshQEo3bE9MNHna9t4eUTjWXW
   GnBNjN/EpIcNng4fmAgYmzTWjZOMOJGOOJCfyMuvhIGvBBmnTFQK0ZyrD
   WPDjQm8CxtmjzP1b7PduOE3ZVwW52SKFwlEIFycTDjmjqerVTC+w9U/ES
   vlj27sUJMzStVD8unRFumm0zOTqjUiJoW2cxM1Bwoegeje7lo0jAAvGe8
   rWGGoZg1Esy/8lv7vQDLOE+16Hutg4oVs2qq8GJowcLE8PvmlRSlt3Fe/
   CBvRL9Qk0NO7QhIelvJ03y2+fzGnzRTzBF0szDKjIeX3XPC0rnoEl6QZB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261446327"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="261446327"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 00:36:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="590658961"
Received: from boturkot-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.35.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 00:36:26 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>, a.manzanares@samsung.com,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v6 1/3] PCI/ACPI: add a helper for retrieving _OSC Control DWORDs
Date:   Wed, 13 Apr 2022 01:36:16 -0600
Message-Id: <20220413073618.291335-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413073618.291335-1-vishal.l.verma@intel.com>
References: <20220413073618.291335-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2993; h=from:subject; bh=KuDyMjgZJkRQezDGFR0bJFAQ24ixyH7tcQKp+n2rFSw=; b=owGbwMvMwCXGf25diOft7jLG02pJDElhtYXljcHROlZ6CkfNcmsYHnJUXc4qqA5+y+BzI+3rxlWf Ogo7SlkYxLgYZMUUWf7u+ch4TG57Pk9ggiPMHFYmkCEMXJwCMJHgBYwM3yr4z/Vc6bVae9nNQ6qp+l vqjjkqvpbeX6sZP5me3rM7l5HhX7/Hw+ILf365l7YXFgfOVu/nM2a6xXlow6LfHbr7n8SxAAA=
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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

