Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A73418CFB3
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Mar 2020 15:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCTOHc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Mar 2020 10:07:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61321 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTOHc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Mar 2020 10:07:32 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 110b52a977f0d81c; Fri, 20 Mar 2020 15:07:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: s2idle: Fix comment in acpi_s2idle_prepare_late()
Date:   Fri, 20 Mar 2020 15:07:29 +0100
Message-ID: <6786907.GdQOV8UKbS@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix a comment in acpi_s2idle_prepare_late() that has become outdated
after commit f0ac20c3f613 ("ACPI: EC: Fix flushing of pending work").

Fixes: f0ac20c3f613 ("ACPI: EC: Fix flushing of pending work")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -982,10 +982,7 @@ static int acpi_s2idle_prepare_late(void
 
 static void acpi_s2idle_sync(void)
 {
-	/*
-	 * The EC driver uses the system workqueue and an additional special
-	 * one, so those need to be flushed too.
-	 */
+	/* The EC driver uses special workqueues that need to be flushed. */
 	acpi_ec_flush_work();
 	acpi_os_wait_events_complete(); /* synchronize Notify handling */
 }



