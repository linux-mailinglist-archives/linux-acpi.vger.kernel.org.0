Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FCA54E55
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 14:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFYMGg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jun 2019 08:06:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64675 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfFYMGf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2019 08:06:35 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 1a82a834c616ac79; Tue, 25 Jun 2019 14:06:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] ACPI: PM: Avoid evaluating _PS3 on transitions from D3hot to D3cold
Date:   Tue, 25 Jun 2019 14:04:45 +0200
Message-ID: <3012059.oderKuhLE3@kreacher>
In-Reply-To: <10419005.Mb09WM6RCc@kreacher>
References: <10419005.Mb09WM6RCc@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the power state of a device with ACPI PM is changed from D3hot to
D3cold, it merely is a matter of dropping references to additional
power resources (specifically, those in the list returned by _PR3),
and the _PS3 method should not be invoked for the device then (as
it has already been evaluated during the previous transition to
D3hot).

Fixes: 20dacb71ad28 (ACPI / PM: Rework device power management to follow ACPI 6)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -215,9 +215,15 @@ int acpi_device_set_power(struct acpi_de
 			return -ENODEV;
 		}
 
-		result = acpi_dev_pm_explicit_set(device, state);
-		if (result)
-			goto end;
+		/*
+		 * If the device goes from D3hot to D3cold, _PS3 has been
+		 * evaluated for it already, so skip it in that case.
+		 */
+		if (device->power.state < ACPI_STATE_D3_HOT) {
+			result = acpi_dev_pm_explicit_set(device, state);
+			if (result)
+				goto end;
+		}
 
 		if (device->power.flags.power_resources)
 			result = acpi_power_transition(device, target_state);



