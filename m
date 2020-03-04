Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C9E178EEB
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 11:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgCDKwz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 05:52:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61848 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgCDKwz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 05:52:55 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 75065426972dc4d4; Wed, 4 Mar 2020 11:52:53 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2 5/6] ACPI: EC: Use fast path in acpi_ec_add() for DSDT boot EC
Date:   Wed, 04 Mar 2020 11:49:14 +0100
Message-ID: <9601387.QWTSTiWaJV@kreacher>
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

If the boot EC comes from the DSDT, its ACPI handle is equal to the
handle of a device object with the PNP0C09 device ID.  If that
device object is passed to acpi_ec_add(), it is not necessary to
allocate a new EC structure for it and parse it, because that has
been done already, so change the function to use the fast path in
that case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Reorder (previously [6/6]) and rebase.

---
 drivers/acpi/ec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 116163add41b..355d6973cb70 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1611,7 +1611,8 @@ static int acpi_ec_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 
-	if (!strcmp(acpi_device_hid(device), ACPI_ECDT_HID)) {
+	if ((boot_ec && boot_ec->handle == device->handle) ||
+	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID)) {
 		/* Fast path: this device corresponds to the boot EC. */
 		ec = boot_ec;
 	} else {
-- 
2.16.4




