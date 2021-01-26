Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F376F30434B
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 17:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404259AbhAZQA4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 11:00:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:61215 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404817AbhAZQAm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 11:00:42 -0500
IronPort-SDR: T5uM2Lzwrx3ep6SOFikIeV7XYbtkOX+pRPOVFp9AYdRvrJIpEaSZaO2+hk5Q411ogy9xVbE1dS
 Dd3rXccbayAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="241451044"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="241451044"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:57:32 -0800
IronPort-SDR: u21nFRlciH5GWRkNVNQTD8FBZo89WqHHhxd/jjhWPYnHlCCoT5P+PwAUfcOHsC0WS8NhOI+1Tl
 opUpvgPIZr2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="356757334"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2021 07:57:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 50C00173; Tue, 26 Jan 2021 17:57:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 5/6] ACPI: Add support for native USB4 control _OSC
Date:   Tue, 26 Jan 2021 18:57:22 +0300
Message-Id: <20210126155723.9388-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.4 introduced a new _OSC capability that is used negotiate native
connection manager support. Connection manager is the entity that is
responsible for tunneling over the USB4 fabric. If the platform rejects
the native access then firmware based connection manager is used.

The new _OSC also includes a set of bits that can be used to disable
certain tunnel types such as PCIe for security reasons for instance.

This implements the new USB4 _OSC so that we try to negotiate native
USB4 support if the Thunderbolt/USB4 (CONFIG_USB4) driver is enabled.
Drivers can determine what was negotiated by checking two new variables
exposed in this patch.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/bus.c   | 76 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h | 10 ++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index ca7c7b2bf56e..f7ad2d283e51 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -281,6 +281,12 @@ bool osc_sb_apei_support_acked;
 bool osc_pc_lpi_support_confirmed;
 EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
 
+/*
+ * ACPI 6.4 Operating System Capabilities for USB.
+ */
+bool osc_sb_native_usb4_support_confirmed;
+EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
+
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
@@ -317,6 +323,9 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (IS_ENABLED(CONFIG_SCHED_MC_PRIO))
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_DIVERSE_HIGH_SUPPORT;
 
+	if (IS_ENABLED(CONFIG_USB4))
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_NATIVE_USB4_SUPPORT;
+
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
@@ -348,8 +357,74 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
 		osc_pc_lpi_support_confirmed =
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
+		osc_sb_native_usb4_support_confirmed =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
+	}
+
+	kfree(context.ret.pointer);
+}
+
+/*
+ * Native control of USB4 capabilities. If any of the tunneling bits is
+ * set it means OS is in control and we use software based connection
+ * manager.
+ */
+u32 osc_sb_native_usb4_control;
+EXPORT_SYMBOL_GPL(osc_sb_native_usb4_control);
+
+static void acpi_bus_decode_usb_osc(const char *msg, u32 bits)
+{
+	printk(KERN_INFO PREFIX "%s USB3%c DisplayPort%c PCIe%c XDomain%c\n", msg,
+	       (bits & OSC_USB_USB3_TUNNELING) ? '+' : '-',
+	       (bits & OSC_USB_DP_TUNNELING) ? '+' : '-',
+	       (bits & OSC_USB_PCIE_TUNNELING) ? '+' : '-',
+	       (bits & OSC_USB_XDOMAIN) ? '+' : '-');
+}
+
+static u8 sb_usb_uuid_str[] = "23A0D13A-26AB-486C-9C5F-0FFA525A575A";
+static void acpi_bus_osc_negotiate_usb_control(void)
+{
+	u32 capbuf[3];
+	struct acpi_osc_context context = {
+		.uuid_str = sb_usb_uuid_str,
+		.rev = 1,
+		.cap.length = sizeof(capbuf),
+		.cap.pointer = capbuf,
+	};
+	acpi_handle handle;
+	acpi_status status;
+	u32 control;
+
+	if (!osc_sb_native_usb4_support_confirmed)
+		return;
+
+	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
+		return;
+
+	control = OSC_USB_USB3_TUNNELING | OSC_USB_DP_TUNNELING |
+		  OSC_USB_PCIE_TUNNELING | OSC_USB_XDOMAIN;
+
+	capbuf[OSC_QUERY_DWORD] = 0;
+	capbuf[OSC_SUPPORT_DWORD] = 0;
+	capbuf[OSC_CONTROL_DWORD] = control;
+
+	status = acpi_run_osc(handle, &context);
+	if (ACPI_FAILURE(status))
+		return;
+
+	if (context.ret.length != sizeof(capbuf)) {
+		printk(KERN_INFO PREFIX "USB4 _OSC: returned invalid length buffer\n");
+		goto out_free;
 	}
 
+	osc_sb_native_usb4_control =
+		control & ((u32 *)context.ret.pointer)[OSC_CONTROL_DWORD];
+
+	acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
+	acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
+				osc_sb_native_usb4_control);
+
+out_free:
 	kfree(context.ret.pointer);
 }
 
@@ -1188,6 +1263,7 @@ static int __init acpi_bus_init(void)
 	 * so it must be run after ACPI_FULL_INITIALIZATION
 	 */
 	acpi_bus_osc_negotiate_platform_control();
+	acpi_bus_osc_negotiate_usb_control();
 
 	/*
 	 * _PDC control method may load dynamic SSDT tables,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 2630c2e953f7..ac68c2d4e393 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -546,9 +546,19 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
+#define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
+extern bool osc_sb_native_usb4_support_confirmed;
+
+/* USB4 Capabilities */
+#define OSC_USB_USB3_TUNNELING			0x00000001
+#define OSC_USB_DP_TUNNELING			0x00000002
+#define OSC_USB_PCIE_TUNNELING			0x00000004
+#define OSC_USB_XDOMAIN				0x00000008
+
+extern u32 osc_sb_native_usb4_control;
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 2: Support Field */
 #define OSC_PCI_EXT_CONFIG_SUPPORT		0x00000001
-- 
2.29.2

