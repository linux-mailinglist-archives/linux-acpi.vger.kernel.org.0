Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA8121718
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 19:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfLPSd7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 13:33:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:57077 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbfLPSdo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 13:33:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 10:33:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="389550308"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.172])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2019 10:33:43 -0800
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
Subject: [PATCH v3 3/5] acpi: device_pm: Add new Tiger Lake hardware ID to support ACPI device power management
Date:   Mon, 16 Dec 2019 10:31:50 -0800
Message-Id: <ede54916a71e4e517b533f4e601be9c1284142d7.1576520244.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576520244.git.gayatri.kammela@intel.com>
References: <cover.1576520244.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1576520244.git.gayatri.kammela@intel.com>
References: <cover.1576520244.git.gayatri.kammela@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Tiger Lake has a new unique hardware ID that supports ACPI device power
management. Hence, add it to the list of special device power management
IDs.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/acpi/device_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 5e4a8860a9c0..b64c62bfcea5 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1321,6 +1321,7 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	 */
 	static const struct acpi_device_id special_pm_ids[] = {
 		{"PNP0C0B", }, /* Generic ACPI fan */
+		{"INT1044", }, /* Fan for Tiger Lake generation */
 		{"INT3404", }, /* Fan */
 		{}
 	};
-- 
2.17.1

