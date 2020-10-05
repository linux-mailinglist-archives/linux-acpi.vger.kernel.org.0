Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2E283D18
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgJERNx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 13:13:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45260 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgJERNx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 13:13:53 -0400
Received: from 89-64-89-50.dynamic.chello.pl (89.64.89.50) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.489)
 id b1023543e698b084; Mon, 5 Oct 2020 19:13:50 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 2/2] ACPI: EC: PM: Drop ec_no_wakeup check from acpi_ec_dispatch_gpe()
Date:   Mon, 05 Oct 2020 19:13:46 +0200
Message-ID: <4751045.iUa6gZp90W@kreacher>
In-Reply-To: <1969699.iD4Ik4PeQO@kreacher>
References: <1969699.iD4Ik4PeQO@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It turns out that in some cases there are EC events to flush in
acpi_ec_dispatch_gpe() even though the ec_no_wakeup kernel parameter
is set and the EC GPE is disabled while sleeping, so drop the
ec_no_wakeup check that prevents those events from being processed
from acpi_ec_dispatch_gpe().

Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -2011,9 +2011,6 @@ bool acpi_ec_dispatch_gpe(void)
 	if (acpi_any_gpe_status_set(first_ec->gpe))
 		return true;
 
-	if (ec_no_wakeup)
-		return false;
-
 	/*
 	 * Dispatch the EC GPE in-band, but do not report wakeup in any case
 	 * to allow the caller to process events properly after that.



