Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75B2D17C7
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 18:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgLGRqu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 12:46:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50016 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGRqu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 12:46:50 -0500
Received: from 89-64-79-106.dynamic.chello.pl (89.64.79.106) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 15eef89c5e0b1054; Mon, 7 Dec 2020 18:46:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hans De Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI: scan: Fix up _DEP-related terminology with supplier/consumer
Date:   Mon, 07 Dec 2020 18:46:06 +0100
Message-ID: <6314382.p3e4rEhblS@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI namespace scanning code uses the terms master/slave when
populating the list of _DEP dependencies, but that use has no
external exposures and is not mandated by nor associated with any
external specifications.

Change the language used through-out to supplier/consumer.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -51,8 +51,8 @@ static u64 spcr_uart_addr;
 
 struct acpi_dep_data {
 	struct list_head node;
-	acpi_handle master;
-	acpi_handle slave;
+	acpi_handle supplier;
+	acpi_handle consumer;
 };
 
 void acpi_scan_lock_acquire(void)
@@ -1881,8 +1881,8 @@ static void acpi_device_dep_initialize(s
 		if (!dep)
 			return;
 
-		dep->master = dep_devices.handles[i];
-		dep->slave  = adev->handle;
+		dep->supplier = dep_devices.handles[i];
+		dep->consumer  = adev->handle;
 		adev->dep_unmet++;
 
 		mutex_lock(&acpi_dep_list_lock);
@@ -2058,8 +2058,8 @@ void acpi_walk_dep_device_list(acpi_hand
 
 	mutex_lock(&acpi_dep_list_lock);
 	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
-		if (dep->master == handle) {
-			acpi_bus_get_device(dep->slave, &adev);
+		if (dep->supplier == handle) {
+			acpi_bus_get_device(dep->consumer, &adev);
 			if (!adev)
 				continue;
 



