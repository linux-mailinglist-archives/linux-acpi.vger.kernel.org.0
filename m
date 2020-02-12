Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6883D15AB87
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 15:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgBLO7q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 09:59:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:12653 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgBLO7q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 09:59:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 06:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="251932288"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 12 Feb 2020 06:59:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B72D524A; Wed, 12 Feb 2020 16:59:41 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Tom Abraham <tabraham@suse.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 2/3] ACPI / watchdog: Fix gas->access_width usage
Date:   Wed, 12 Feb 2020 17:59:40 +0300
Message-Id: <20200212145941.32914-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212145941.32914-1-mika.westerberg@linux.intel.com>
References: <20200212145941.32914-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI Generic Address Structure (GAS) access_width field is not in bytes
as the driver seems to expect in few places so fix this by using the
newly introduced macro ACPI_ACCESS_BYTE_WIDTH().

Fixes: b1abf6fc4982 ("ACPI / watchdog: Fix off-by-one error at resource assignment")
Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
Reported-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_watchdog.c | 3 +--
 drivers/watchdog/wdat_wdt.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index b5516b04ffc0..d827a4a3e946 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -126,12 +126,11 @@ void __init acpi_watchdog_init(void)
 		gas = &entries[i].register_region;
 
 		res.start = gas->address;
+		res.end = res.start + ACPI_ACCESS_BYTE_WIDTH(gas->access_width) - 1;
 		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 			res.flags = IORESOURCE_MEM;
-			res.end = res.start + ALIGN(gas->access_width, 4) - 1;
 		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 			res.flags = IORESOURCE_IO;
-			res.end = res.start + gas->access_width - 1;
 		} else {
 			pr_warn("Unsupported address space: %u\n",
 				gas->space_id);
diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index b069349b52f5..e1b1fcfc02af 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -389,7 +389,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 		memset(&r, 0, sizeof(r));
 		r.start = gas->address;
-		r.end = r.start + gas->access_width - 1;
+		r.end = r.start + ACPI_ACCESS_BYTE_WIDTH(gas->access_width) - 1;
 		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 			r.flags = IORESOURCE_MEM;
 		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-- 
2.25.0

