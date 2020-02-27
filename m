Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C45172B10
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2020 23:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgB0WZU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Feb 2020 17:25:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43956 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgB0WZU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Feb 2020 17:25:20 -0500
Received: from 79.184.237.30.ipv4.supernova.orange.pl (79.184.237.30) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id fcd830566f8affb9; Thu, 27 Feb 2020 23:25:17 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 5/6] ACPI: EC: Simplify acpi_ec_add()
Date:   Thu, 27 Feb 2020 23:23:40 +0100
Message-ID: <2410193.UcW0be6u46@kreacher>
In-Reply-To: <2094703.CetWLLyMuz@kreacher>
References: <2094703.CetWLLyMuz@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

First, notice that if the device ID in acpi_ec_add() is equal to
ACPI_ECDT_HID, boot_ec_is_ecdt must be set, because this means
that the device object passed to acpi_ec_add() comes from
acpi_ec_ecdt_start() which fails if boot_ec_is_ecdt is unset.
Accordingly, boot_ec_is_ecdt need not be set again in that case,
so drop that redundant update of it from the code.

Next, ec->handle must be a valid ACPI handle right before
returning 0 from acpi_ec_add(), because it either is the handle
of the device object passed to that function, or it is the boot EC
handle coming from acpi_ec_ecdt_start() which fails if it cannot
find a valid handle for the boot EC.  Moreover, the object with
that handle is regarded as a valid representation of the EC in all
cases, so there is no reason to avoid the _DEP list update walk if
that handle is the boot EC handle.  Accordingly, drop the dep_update
local variable from acpi_ec_add() and call acpi_walk_dep_device_list()
for ec->handle unconditionally before returning 0 from it.

Finally, the ec local variable in acpi_ec_add() need not be
initialized to NULL and the status local variable declaration
can be moved to the block in which it is used, so change the code
in accordance with these observations.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3f6127e919ab..4ed0c6155d3f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1608,19 +1608,18 @@ static bool acpi_ec_ecdt_get_handle(acpi_handle *phandle)
 
 static int acpi_ec_add(struct acpi_device *device)
 {
-	struct acpi_ec *ec = NULL;
-	bool dep_update = true;
-	acpi_status status;
+	struct acpi_ec *ec;
 	int ret;
 
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 
 	if (!strcmp(acpi_device_hid(device), ACPI_ECDT_HID)) {
-		boot_ec_is_ecdt = true;
+		/* Fast path: this device corresponds to the boot EC. */
 		ec = boot_ec;
-		dep_update = false;
 	} else {
+		acpi_status status;
+
 		ec = acpi_ec_alloc();
 		if (!ec)
 			return -ENOMEM;
@@ -1663,16 +1662,16 @@ static int acpi_ec_add(struct acpi_device *device)
 	ret = !!request_region(ec->command_addr, 1, "EC cmd");
 	WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_addr);
 
-	if (dep_update) {
-		/* Reprobe devices depending on the EC */
-		acpi_walk_dep_device_list(ec->handle);
-	}
+	/* Reprobe devices depending on the EC */
+	acpi_walk_dep_device_list(ec->handle);
+
 	acpi_handle_debug(ec->handle, "enumerated.\n");
 	return 0;
 
 err:
 	if (ec != boot_ec)
 		acpi_ec_free(ec);
+
 	return ret;
 }
 
-- 
2.16.4





