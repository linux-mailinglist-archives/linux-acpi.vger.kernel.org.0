Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1774A11D991
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 23:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfLLWjY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 17:39:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:52808 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbfLLWjY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Dec 2019 17:39:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 14:39:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="220787478"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.172])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2019 14:39:23 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, alex.hung@canonical.com,
        linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, charles.d.prestopine@intel.com,
        dvhart@infradead.org, Gayatri Kammela <gayatri.kammela@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH v1 2/4] acpi: fan: Add new Tiger Lake hardware ID to support fan driver in acpi
Date:   Thu, 12 Dec 2019 14:37:18 -0800
Message-Id: <68c6a37a5fcce792de61c4a0adcce0b83694e8d0.1576189376.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576189376.git.gayatri.kammela@intel.com>
References: <cover.1576189376.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1576189376.git.gayatri.kammela@intel.com>
References: <cover.1576189376.git.gayatri.kammela@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Tiger Lake has a new unique hardware ID to support fan driver. Hence,
add it.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/acpi/fan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 816b0803f7fb..16e1ca23f573 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -26,6 +26,7 @@ static int acpi_fan_remove(struct platform_device *pdev);
 static const struct acpi_device_id fan_device_ids[] = {
 	{"PNP0C0B", 0},
 	{"INT3404", 0},
+	{"INT1044", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, fan_device_ids);
-- 
2.17.1

