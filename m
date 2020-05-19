Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10EC1D9665
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgESMdO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 08:33:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57550 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgESMdO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 08:33:14 -0400
Received: from 89-64-84-14.dynamic.chello.pl (89.64.84.14) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id a5a690b566f2bc2b; Tue, 19 May 2020 14:33:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI: EC: PM: s2idle: Extend GPE dispatching debug message
Date:   Tue, 19 May 2020 14:33:10 +0200
Message-ID: <9095435.I46LYtAkWL@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add the "ACPI" string to the "EC GPE dispatched" message as it is
ACPI-related.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -2020,7 +2020,7 @@ bool acpi_ec_dispatch_gpe(void)
 	 */
 	ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
 	if (ret == ACPI_INTERRUPT_HANDLED) {
-		pm_pr_dbg("EC GPE dispatched\n");
+		pm_pr_dbg("ACPI EC GPE dispatched\n");
 
 		/* Flush the event and query workqueues. */
 		acpi_ec_flush_work();



