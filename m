Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAB2121719
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 19:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfLPSdi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 13:33:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:15476 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbfLPSdh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 13:33:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 10:33:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="389550279"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.172])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2019 10:33:36 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, alex.hung@canonical.com,
        linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, charles.d.prestopine@intel.com,
        dvhart@infradead.org, Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH v3 1/5] acpi: dptf: Add new Tiger Lake hardware IDs to support DPTF drivers in ACPI
Date:   Mon, 16 Dec 2019 10:31:48 -0800
Message-Id: <887468770c82ed69ddd124529fe001598acd4e57.1576520244.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576520244.git.gayatri.kammela@intel.com>
References: <cover.1576520244.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1576520244.git.gayatri.kammela@intel.com>
References: <cover.1576520244.git.gayatri.kammela@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Tiger Lake has new unique hardware IDs that are needed to support
DPTF drivers. Hence, add them.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/acpi/dptf/dptf_power.c      | 1 +
 drivers/acpi/dptf/int340x_thermal.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index eb58fc475a03..387f27ef3368 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -97,6 +97,7 @@ static int dptf_power_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3407_device_ids[] = {
+	{"INT1047", 0},
 	{"INT3407", 0},
 	{"", 0},
 };
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 5c7a90186e3c..1ec7b6900662 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -13,6 +13,10 @@
 
 #define INT3401_DEVICE 0X01
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
+	{"INT1040"},
+	{"INT1043"},
+	{"INT1044"},
+	{"INT1047"},
 	{"INT3400"},
 	{"INT3401", INT3401_DEVICE},
 	{"INT3402"},
-- 
2.17.1

