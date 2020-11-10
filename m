Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92D2ADD67
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 18:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgKJRvK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 12:51:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:35400 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJRvJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Nov 2020 12:51:09 -0500
IronPort-SDR: DY9+/byUR4HE7VhngHNNITx+7BnOx2ByVD7ywyYtlZtIVAnLT7WvBB+mJfitSlwVlm6MWx7wEO
 oXh+Fqiin71g==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170177791"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="170177791"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 09:51:08 -0800
IronPort-SDR: zdJNpYrSKwfrJlqftnGkOloGkkS2E6l0bRgE1fhTb7ryTDgAQBv6n6hqJ4pUeHB9CBOor0X+hc
 pMbYCTZjKp1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="327755853"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2020 09:51:08 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, lenb@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI: DPTF: Support Alder Lake
Date:   Tue, 10 Nov 2020 09:50:58 -0800
Message-Id: <20201110175058.88137-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add Alder Lake ACPI IDs for DPTF devices.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c   | 1 +
 drivers/acpi/dptf/dptf_power.c      | 2 ++
 drivers/acpi/dptf/int340x_thermal.c | 6 ++++++
 drivers/acpi/fan.c                  | 1 +
 4 files changed, 10 insertions(+)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 4c1992fce150..5fca18296bf6 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -106,6 +106,7 @@ static int pch_fivr_remove(struct platform_device *pdev)
 
 static const struct acpi_device_id pch_fivr_device_ids[] = {
 	{"INTC1045", 0},
+	{"INTC1049", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 06741305fc77..a24d5d7aa117 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -229,6 +229,8 @@ static const struct acpi_device_id int3407_device_ids[] = {
 	{"INT3532", 0},
 	{"INTC1047", 0},
 	{"INTC1050", 0},
+	{"INTC1060", 0},
+	{"INTC1061", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 8d420c7e7178..d14025a85ce8 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -25,10 +25,16 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT340A"},
 	{"INT340B"},
 	{"INTC1040"},
+	{"INTC1041"},
 	{"INTC1043"},
 	{"INTC1044"},
 	{"INTC1045"},
+	{"INTC1046"},
 	{"INTC1047"},
+	{"INTC1048"},
+	{"INTC1049"},
+	{"INTC1060"},
+	{"INTC1061"},
 	{""},
 };
 
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 62873388b24f..48354f82fba6 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -27,6 +27,7 @@ static const struct acpi_device_id fan_device_ids[] = {
 	{"PNP0C0B", 0},
 	{"INT3404", 0},
 	{"INTC1044", 0},
+	{"INTC1048", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, fan_device_ids);
-- 
2.25.4

