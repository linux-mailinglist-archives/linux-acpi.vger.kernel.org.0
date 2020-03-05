Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4C17B21C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 00:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEXQx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 18:16:53 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44259 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEXQx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2020 18:16:53 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id bb12227a4152f3b0; Fri, 6 Mar 2020 00:16:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] ACPI: EC: Do not clear boot_ec_is_ecdt in acpi_ec_add()
Date:   Fri, 06 Mar 2020 00:15:24 +0100
Message-ID: <3824376.HkUXRVnQtS@kreacher>
In-Reply-To: <2656743.kaaXMJBMQx@kreacher>
References: <2656743.kaaXMJBMQx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The reason for clearing boot_ec_is_ecdt in acpi_ec_add() (if a
PNP0C09 device object matching the ECDT boot EC had been found in
the namespace) was to cause acpi_ec_ecdt_start() to return early,
but since the latter does not look at boot_ec_is_ecdt any more,
acpi_ec_add() need not clear it.

Moreover, doing that may be confusing as it may cause "DSDT" to be
printed instead of "ECDT" in the EC initialization completion
message, so stop doing it.

While at it, split the EC initialization completion message into
two messages, one regarding the boot EC and another one printed
regardless of whether or not the EC at hand is the boot one.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9e7ee6ae4706..8025a070335e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1621,7 +1621,6 @@ static int acpi_ec_add(struct acpi_device *device)
 
 		if (boot_ec && ec->command_addr == boot_ec->command_addr &&
 		    ec->data_addr == boot_ec->data_addr) {
-			boot_ec_is_ecdt = false;
 			/*
 			 * Trust PNP0C09 namespace location rather than
 			 * ECDT ID. But trust ECDT GPE rather than _GPE
@@ -1641,9 +1640,12 @@ static int acpi_ec_add(struct acpi_device *device)
 
 	if (ec == boot_ec)
 		acpi_handle_info(boot_ec->handle,
-				 "Boot %s EC used to handle transactions and events\n",
+				 "Boot %s EC initialization complete\n",
 				 boot_ec_is_ecdt ? "ECDT" : "DSDT");
 
+	acpi_handle_info(ec->handle,
+			 "EC: Used to handle transactions and events\n");
+
 	device->driver_data = ec;
 
 	ret = !!request_region(ec->data_addr, 1, "EC data");
-- 
2.16.4




