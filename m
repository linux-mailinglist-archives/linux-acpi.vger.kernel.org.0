Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49AD2DA1BC
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 21:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503371AbgLNUef (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 15:34:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61792 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503353AbgLNUeb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2020 15:34:31 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 9c0cdc76c89b6df9; Mon, 14 Dec 2020 21:33:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Hans De Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFT][PATCH v1 3/3] ACPI: scan: Avoid unnecessary second pass in acpi_bus_scan()
Date:   Mon, 14 Dec 2020 21:32:44 +0100
Message-ID: <1954514.xqII67ylRR@kreacher>
In-Reply-To: <1646930.v2jOOB1UEN@kreacher>
References: <1646930.v2jOOB1UEN@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If there are no devices whose enumeration has been deferred after
the first pass in acpi_bus_scan(), the second pass is not necssary,
so avoid it with the help of a new static variable.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1910,6 +1910,8 @@ static void acpi_scan_dep_init(struct ac
 	mutex_unlock(&acpi_dep_list_lock);
 }
 
+static bool acpi_bus_scan_second_pass;
+
 static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 				      struct acpi_device **adev_p)
 {
@@ -1934,8 +1936,10 @@ static acpi_status acpi_bus_check_add(ac
 	if (type == ACPI_BUS_TYPE_DEVICE && check_dep) {
 		u32 count = acpi_scan_check_dep(handle);
 		/* Bail out if the number of recorded dependencies is not 0. */
-		if (count > 0)
+		if (count > 0) {
+			acpi_bus_scan_second_pass = true;
 			return AE_CTRL_DEPTH;
+		}
 	}
 
 	acpi_add_single_object(&device, handle, type, sta);
@@ -2136,6 +2140,8 @@ int acpi_bus_scan(acpi_handle handle)
 {
 	struct acpi_device *device = NULL;
 
+	acpi_bus_scan_second_pass = false;
+
 	/* Pass 1: Avoid enumerating devices with missing dependencies. */
 
 	if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
@@ -2148,6 +2154,9 @@ int acpi_bus_scan(acpi_handle handle)
 
 	acpi_bus_attach(device, true);
 
+	if (!acpi_bus_scan_second_pass)
+		return 0;
+
 	/* Pass 2: Enumerate all of the remaining devices. */
 
 	device = NULL;



