Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE417283D1E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 19:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgJERN5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 13:13:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54784 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgJERNy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 13:13:54 -0400
Received: from 89-64-89-50.dynamic.chello.pl (89.64.89.50) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.489)
 id d247e9a3d79801fb; Mon, 5 Oct 2020 19:13:51 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH 1/2] ACPI: EC: PM: Flush EC work unconditionally after wakeup
Date:   Mon, 05 Oct 2020 19:13:15 +0200
Message-ID: <66772207.vZgp7G9zJX@kreacher>
In-Reply-To: <1969699.iD4Ik4PeQO@kreacher>
References: <1969699.iD4Ik4PeQO@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: EC: PM: Flush EC work unconditionally after wakeup

Commit 607b9df63057 ("ACPI: EC: PM: Avoid flushing EC work when EC
GPE is inactive") has been reported to cause some power button wakeup
events to be missed on some systems, so modify acpi_ec_dispatch_gpe()
to call acpi_ec_flush_work() unconditionally to effectively reverse
the changes made by that commit.

Also note that the problem which prompted commit 607b9df63057 is not
reproducible any more on the affected machine.

Fixes: 607b9df63057 ("ACPI: EC: PM: Avoid flushing EC work when EC GPE is inactive")
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Reported-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -2019,12 +2019,11 @@ bool acpi_ec_dispatch_gpe(void)
 	 * to allow the caller to process events properly after that.
 	 */
 	ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
-	if (ret == ACPI_INTERRUPT_HANDLED) {
+	if (ret == ACPI_INTERRUPT_HANDLED)
 		pm_pr_dbg("ACPI EC GPE dispatched\n");
 
-		/* Flush the event and query workqueues. */
-		acpi_ec_flush_work();
-	}
+	/* Flush the event and query workqueues. */
+	acpi_ec_flush_work();
 
 	return false;
 }



