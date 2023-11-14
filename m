Return-Path: <linux-acpi+bounces-1470-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F47EAFF1
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 13:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1420D1C20A23
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E53FB0E
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpbzR3NC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A31291F
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 12:06:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CBEF1
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 04:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699963574; x=1731499574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+d1VgXtsMVypOfMYs/7Q06rifgb26FWvYxnEZRZq3rc=;
  b=YpbzR3NCpHvM4N8PNKys2A+BM7MeMnbYGB6ykB3faGhMUliRaY5yhOG4
   0nHiofqe7VGJIeXRyIKYlhcpLrRE2dAKIuON607tRf5oG4/jyNyU3ypb3
   4oNsO1Mjhl3dQsic6M7WJY/gU62l1XWUdEU5FUrqUiV9z38jaCslu9wW+
   Ky25DnBiTHCNxWYPwg8R4hHTdJLWsZjHxaDYMsY1f29QMpSiv2rsPDpq1
   17D9j6487UV9NB3yXRJEWRlascFDRrJJHhH61WLubUAtF54Aqc01/qyCq
   xRzyF8ATl7z+j0FycRH0+0FGLmRPp3AGCJA5D2E2dtsGKwSN6NLDAjmrX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="454934665"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="454934665"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:06:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888232003"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="888232003"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 14 Nov 2023 04:06:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 33BA75C2; Tue, 14 Nov 2023 14:06:11 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	NaamaX Shachar <naamax.shachar@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: Run USB4 _OSC() first with query bit set
Date: Tue, 14 Nov 2023 14:06:11 +0200
Message-ID: <20231114120611.128054-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform can deny certain tunneling from the OS and it does that by
clearing the control bits it does not want the OS to get and returning
with OSC_CAPABILITIES_MASK_ERROR bit set. Currently we do not handle
this properly so if this happens, for example when the platform denies
PCIe tunneling, we just fail the whole negotiation and revert back to
what the Thunderbolt driver is doing to figure out whether the
controller is running firmware connection manager or not. However, we
should honor what the platform returns.

For this reason run the USB4 _OSC() first with query bit set, and then
use the returned control double word (that may contain some of the bits
cleared by the platform) and run it second time with query bit clear.

While there, remove an extra space from the assignment of the control
double word.

Reported-by: NaamaX Shachar <naamax.shachar@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/bus.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 72e64c0718c9..569bd15f211b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -408,7 +408,7 @@ static void acpi_bus_decode_usb_osc(const char *msg, u32 bits)
 static u8 sb_usb_uuid_str[] = "23A0D13A-26AB-486C-9C5F-0FFA525A575A";
 static void acpi_bus_osc_negotiate_usb_control(void)
 {
-	u32 capbuf[3];
+	u32 capbuf[3], *capbuf_ret;
 	struct acpi_osc_context context = {
 		.uuid_str = sb_usb_uuid_str,
 		.rev = 1,
@@ -428,7 +428,12 @@ static void acpi_bus_osc_negotiate_usb_control(void)
 	control = OSC_USB_USB3_TUNNELING | OSC_USB_DP_TUNNELING |
 		  OSC_USB_PCIE_TUNNELING | OSC_USB_XDOMAIN;
 
-	capbuf[OSC_QUERY_DWORD] = 0;
+	/*
+	 * Run _OSC first with query bit set, trying to get control over
+	 * all tunneling. The platform can then clear out bits in the
+	 * control dword that it does not want to grant to the OS.
+	 */
+	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = 0;
 	capbuf[OSC_CONTROL_DWORD] = control;
 
@@ -441,8 +446,29 @@ static void acpi_bus_osc_negotiate_usb_control(void)
 		goto out_free;
 	}
 
+	/*
+	 * Run _OSC again now with query bit clear and the control dword
+	 * matching what the platform granted (which may not have all
+	 * the control bits set).
+	 */
+	capbuf_ret = context.ret.pointer;
+
+	capbuf[OSC_QUERY_DWORD] = 0;
+	capbuf[OSC_CONTROL_DWORD] = capbuf_ret[OSC_CONTROL_DWORD];
+
+	kfree(context.ret.pointer);
+
+	status = acpi_run_osc(handle, &context);
+	if (ACPI_FAILURE(status))
+		return;
+
+	if (context.ret.length != sizeof(capbuf)) {
+		pr_info("USB4 _OSC: returned invalid length buffer\n");
+		goto out_free;
+	}
+
 	osc_sb_native_usb4_control =
-		control &  acpi_osc_ctx_get_pci_control(&context);
+		control & acpi_osc_ctx_get_pci_control(&context);
 
 	acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
 	acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
-- 
2.42.0


