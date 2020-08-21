Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4003C24DEC4
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Aug 2020 19:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgHURnA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Aug 2020 13:43:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48108 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgHURm7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Aug 2020 13:42:59 -0400
Received: from 89-64-88-37.dynamic.chello.pl (89.64.88.37) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id ca2fab7cdb976c2f; Fri, 21 Aug 2020 19:42:56 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: [PATCH] ACPI: OSL: Prevent acpi_release_memory() from returning too early
Date:   Fri, 21 Aug 2020 19:42:55 +0200
Message-ID: <6142241.0H6QnnlUA7@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 1757659d022b ("ACPI: OSL: Implement deferred unmapping
of ACPI memory") in some cases acpi_release_memory() may return
before the target memory mappings actually go away, because they
are released asynchronously now.

Prevent it from returning prematurely by making it wait for the next
RCU grace period to elapse, for all of the RCU callbacks to complete
and for all of the scheduled work items to be flushed before
returning.

Fixes: 1757659d022b ("ACPI: OSL: Implement deferred unmapping of ACPI memory")
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -1575,11 +1575,26 @@ static acpi_status acpi_deactivate_mem_r
 acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
 				u32 level)
 {
+	acpi_status status;
+
 	if (!(res->flags & IORESOURCE_MEM))
 		return AE_TYPE;
 
-	return acpi_walk_namespace(ACPI_TYPE_REGION, handle, level,
-				   acpi_deactivate_mem_region, NULL, res, NULL);
+	status = acpi_walk_namespace(ACPI_TYPE_REGION, handle, level,
+				     acpi_deactivate_mem_region, NULL,
+				     res, NULL);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	/*
+	 * Wait for all of the mappings queued up for removal by
+	 * acpi_deactivate_mem_region() to actually go away.
+	 */
+	synchronize_rcu();
+	rcu_barrier();
+	flush_scheduled_work();
+
+	return AE_OK;
 }
 EXPORT_SYMBOL_GPL(acpi_release_memory);
 



