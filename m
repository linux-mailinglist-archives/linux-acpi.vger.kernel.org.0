Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDB928F758
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgJORAI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 13:00:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41208 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389967AbgJORAF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2020 13:00:05 -0400
Received: from 89-64-88-192.dynamic.chello.pl (89.64.88.192) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id d57e98628d709661; Thu, 15 Oct 2020 19:00:03 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 1/2] ACPI: DPTF: Fix participant driver names
Date:   Thu, 15 Oct 2020 18:58:43 +0200
Message-ID: <2071902.YaQf1D0BmN@kreacher>
In-Reply-To: <2206290.MayQypTng0@kreacher>
References: <2206290.MayQypTng0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Change the names of DPTF participant drivers to adhere to the
sysfs file naming conventions (no spaces present in the name in
particular).

Fixes: 2ce6324eadb0 ("ACPI: DPTF: Add PCH FIVR participant driver")
Fixes: 6256ebd5daf9 ("ACPI / DPTF: Add DPTF power participant driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c |    2 +-
 drivers/acpi/dptf/dptf_power.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/dptf/dptf_pch_fivr.c
===================================================================
--- linux-pm.orig/drivers/acpi/dptf/dptf_pch_fivr.c
+++ linux-pm/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -114,7 +114,7 @@ static struct platform_driver pch_fivr_d
 	.probe = pch_fivr_add,
 	.remove = pch_fivr_remove,
 	.driver = {
-		.name = "DPTF PCH FIVR",
+		.name = "dptf_pch_fivr",
 		.acpi_match_table = pch_fivr_device_ids,
 	},
 };
Index: linux-pm/drivers/acpi/dptf/dptf_power.c
===================================================================
--- linux-pm.orig/drivers/acpi/dptf/dptf_power.c
+++ linux-pm/drivers/acpi/dptf/dptf_power.c
@@ -237,7 +237,7 @@ static struct platform_driver dptf_power
 	.probe = dptf_power_add,
 	.remove = dptf_power_remove,
 	.driver = {
-		.name = "DPTF Platform Power",
+		.name = "dptf_power",
 		.acpi_match_table = int3407_device_ids,
 	},
 };



