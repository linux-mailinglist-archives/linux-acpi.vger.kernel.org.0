Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB0B19F928
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Apr 2020 17:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgDFPtt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Apr 2020 11:49:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44641 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgDFPts (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2020 11:49:48 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 52034e87f0ed0a75; Mon, 6 Apr 2020 17:49:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ACPI: EC: Fix up fast path check in acpi_ec_add()
Date:   Mon, 06 Apr 2020 17:49:45 +0200
Message-ID: <1708495.96b3J6AjSg@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The fast path check in acpi_ec_add() is not incorrect, because in
fact acpi_device_hid(device) can be equal to ACPI_ECDT_HID only if
boot_ec is not NULL, but it may confuse static checkers, so change
it to explicitly check boot_ec upfront and use the slow path if
that pointer is NULL.

Link: https://lore.kernel.org/linux-acpi/20200406144217.GA68494@mwanda/
Fixes: 3d9b8dd8320d ("ACPI: EC: Use fast path in acpi_ec_add() for DSDT boot EC")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1589,8 +1589,8 @@ static int acpi_ec_add(struct acpi_devic
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 
-	if ((boot_ec && boot_ec->handle == device->handle) ||
-	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID)) {
+	if (boot_ec && (boot_ec->handle == device->handle ||
+	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
 		/* Fast path: this device corresponds to the boot EC. */
 		ec = boot_ec;
 	} else {



