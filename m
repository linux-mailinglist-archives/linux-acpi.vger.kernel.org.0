Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B031C5DA8C
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 03:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfGCBRi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Jul 2019 21:17:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:46865 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGCBRi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Jul 2019 21:17:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 18:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; 
   d="scan'208";a="315420868"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2019 18:17:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47F4712C; Wed,  3 Jul 2019 04:17:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI / PMIC: intel: Drop double removal of address space handler
Date:   Wed,  3 Jul 2019 04:17:34 +0300
Message-Id: <20190703011734.82614-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no need to remove address space handler twice,
because removal is idempotent.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 1b722fd57d5e..452041398b34 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -284,8 +284,6 @@ int intel_pmic_install_opregion_handler(struct device *dev, acpi_handle handle,
 						    intel_pmic_thermal_handler,
 						    NULL, opregion);
 	if (ACPI_FAILURE(status)) {
-		acpi_remove_address_space_handler(handle, PMIC_POWER_OPREGION_ID,
-						  intel_pmic_power_handler);
 		ret = -ENODEV;
 		goto out_remove_power_handler;
 	}
-- 
2.20.1

