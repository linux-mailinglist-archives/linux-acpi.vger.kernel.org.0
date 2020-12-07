Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B8A2D16E9
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 17:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLGQzy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 11:55:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58684 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGQzy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 11:55:54 -0500
Received: from 89-64-79-106.dynamic.chello.pl (89.64.79.106) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 6b646fca232dded6; Mon, 7 Dec 2020 17:55:11 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI: scan: Drop INT3396 from acpi_ignore_dep_ids[]
Date:   Mon, 07 Dec 2020 17:55:11 +0100
Message-ID: <12017158.VsPUki9SGr@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to Hans, all device objects where the _HID returns
"INT3396" also have a _CID returning "PNP0D80", so the former
need not be present in acpi_ignore_dep_ids[] any more.

Link: https://lore.kernel.org/linux-acpi/52a2b98c-6bf3-760b-eca9-93cf05fb4877@redhat.com/
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/project/linux-acpi/patch/3849919.JfvvSOo2yN@kreacher/

---
 drivers/acpi/scan.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -751,7 +751,6 @@ static bool acpi_info_matches_ids(struct
 
 /* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
 static const char * const acpi_ignore_dep_ids[] = {
-	"INT3396", /* Windows System Power Management Controller */
 	"PNP0D80", /* Windows-compatible System Power Management Controller */
 	NULL
 };



