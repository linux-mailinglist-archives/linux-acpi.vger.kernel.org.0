Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5CEB15956A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2020 17:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgBKQyI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 11:54:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55993 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgBKQyI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Feb 2020 11:54:08 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id bf497f49ca41fc91; Tue, 11 Feb 2020 17:54:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 2/2] ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system
Date:   Tue, 11 Feb 2020 17:53:52 +0100
Message-ID: <7099853.cFaFQmLQCt@kreacher>
In-Reply-To: <6974889.tv0o8xEHfr@kreacher>
References: <6974889.tv0o8xEHfr@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the platform triggers a spurious SCI even though the status bit
is not set for any GPE when the system is suspended to idle, it will
be treated as a genuine wakeup, so avoid that by checking if any GPEs
are active at all before returning 'true' from acpi_s2idle_wake().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206413
Fixes: 56b991849009 ("PM: sleep: Simplify suspend-to-idle control flow")
Reported-by: Tsuchiya Yuto <kitakar@gmail.com>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -1006,10 +1006,16 @@ static bool acpi_s2idle_wake(void)
 			return true;
 
 		/*
-		 * If there are no EC events to process, the wakeup is regarded
-		 * as a genuine one.
+		 * If there are no EC events to process and at least one of the
+		 * other enabled GPEs is active, the wakeup is regarded as a
+		 * genuine one.
+		 *
+		 * Note that the checks below must be carried out in this order
+		 * to avoid returning prematurely due to a change of the EC GPE
+		 * status bit from unset to set between the checks with the
+		 * status bits of all the other GPEs unset.
 		 */
-		if (!acpi_ec_dispatch_gpe())
+		if (acpi_any_gpe_status_set() && !acpi_ec_dispatch_gpe())
 			return true;
 
 		/*



