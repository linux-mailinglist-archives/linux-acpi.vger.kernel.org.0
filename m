Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14463AE14A
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jun 2021 03:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhFUB3x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 20 Jun 2021 21:29:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:2355 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhFUB3w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 20 Jun 2021 21:29:52 -0400
IronPort-SDR: R6UBIlJmVq/ZthIZw+kpsq/RZY4tBIW1KyfCyQbzuP0M0V4TPjEAL3k7SOrEVlO28+vv1IUiL9
 scgoZC4b8zCg==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="187134744"
X-IronPort-AV: E=Sophos;i="5.83,288,1616482800"; 
   d="scan'208";a="187134744"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 18:27:39 -0700
IronPort-SDR: Y9hW6rU8N+KWucZwHj0p9FphnnFNSHEijjjjhlv0al2CDAgXBHgiztw4wbyzfb5eGv9Yt1H97q
 qviNQWCM3sRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,288,1616482800"; 
   d="scan'208";a="641181800"
Received: from power-sh.sh.intel.com ([10.239.48.130])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jun 2021 18:27:33 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rjw@rjwysocki.net, leo881003@gmail.com, rui.zhang@intel.com
Subject: [PATCH] ACPI: EC: trust DSDT GPE for certain HP laptop
Date:   Mon, 21 Jun 2021 09:37:27 +0800
Message-Id: <20210621013727.30621-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On HP Pavilion Gaming Laptop 15-cx0xxx, the ECDT EC and DSDT EC share
the same port addresses but different GPEs. And the DSDT GPE is the
right one to use.

The current code duplicates DSDT EC with ECDT EC if the port addresses
are the same, and uses ECDT GPE as a result, which breaks this machine.

Introduce a new quirk for the HP laptop to trust the DSDT GPE,
and avoid duplicating even if the port addresses are the same.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209989
Reported-and-tested-by: Shao Fu, Chen <leo881003@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/ec.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 13565629ce0a..34a472600e63 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -183,6 +183,7 @@ static struct workqueue_struct *ec_query_wq;
 
 static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port address correction */
 static int EC_FLAGS_IGNORE_DSDT_GPE; /* Needs ECDT GPE as correction setting */
+static int EC_FLAGS_TRUST_DSDT_GPE; /* Needs DSDT GPE as correction setting */
 static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
 
 /* --------------------------------------------------------------------------
@@ -1593,7 +1594,8 @@ static int acpi_ec_add(struct acpi_device *device)
 		}
 
 		if (boot_ec && ec->command_addr == boot_ec->command_addr &&
-		    ec->data_addr == boot_ec->data_addr) {
+		    ec->data_addr == boot_ec->data_addr &&
+		    !EC_FLAGS_TRUST_DSDT_GPE) {
 			/*
 			 * Trust PNP0C09 namespace location rather than
 			 * ECDT ID. But trust ECDT GPE rather than _GPE
@@ -1816,6 +1818,18 @@ static int ec_correct_ecdt(const struct dmi_system_id *id)
 	return 0;
 }
 
+/*
+ * Some ECDTs contain wrong GPE setting, but they share the same port addresses
+ * with DSDT EC, don't duplicate the DSDT EC with ECDT EC in this case.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=209989
+ */
+static int ec_honor_dsdt_gpe(const struct dmi_system_id *id)
+{
+	pr_debug("Detected system needing DSDT GPE setting.\n");
+	EC_FLAGS_TRUST_DSDT_GPE = 1;
+	return 0;
+}
+
 /*
  * Some DSDTs contain wrong GPE setting.
  * Asus FX502VD/VE, GL702VMK, X550VXK, X580VD
@@ -1854,6 +1868,11 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 	DMI_MATCH(DMI_PRODUCT_NAME, "X580VD"),}, NULL},
 	{
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=209989 */
+	ec_honor_dsdt_gpe, "HP Pavilion Gaming Laptop 15-cx0xxx", {
+	DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-cx0xxx"),}, NULL},
+	{
 	ec_clear_on_resume, "Samsung hardware", {
 	DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")}, NULL},
 	{},
-- 
2.17.1

