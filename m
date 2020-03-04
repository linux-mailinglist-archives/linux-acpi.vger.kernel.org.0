Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBB1178EFA
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 11:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgCDKwz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 05:52:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61188 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgCDKwz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 05:52:55 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id e6e3b8ac55937e48; Wed, 4 Mar 2020 11:52:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2 4/6] ACPI: EC: Simplify acpi_ec_add()
Date:   Wed, 04 Mar 2020 11:48:10 +0100
Message-ID: <3645328.ZVAHyXvlRV@kreacher>
In-Reply-To: <2411774.6kdisLRoUK@kreacher>
References: <2094703.CetWLLyMuz@kreacher> <2411774.6kdisLRoUK@kreacher>
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

-> v2: Reorder (previously [5/6]) and rebase.

---
 drivers/acpi/ec.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 6f501d552e6e..116163add41b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1605,19 +1605,18 @@ static bool acpi_ec_ecdt_get_handle(acpi_handle *phandle)
 
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
@@ -1660,10 +1659,9 @@ static int acpi_ec_add(struct acpi_device *device)
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
 
-- 
2.16.4




