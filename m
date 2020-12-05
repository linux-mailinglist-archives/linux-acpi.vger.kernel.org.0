Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C872F2CFE62
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Dec 2020 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgLETaY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Dec 2020 14:30:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44830 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLETaY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2020 14:30:24 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 1acd33b1d947bb61; Sat, 5 Dec 2020 16:29:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH] ACPI: scan: Add PNP0D80 to the _DEP exceptions list
Date:   Sat, 05 Dec 2020 16:29:41 +0100
Message-ID: <3849919.JfvvSOo2yN@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PNP0D80 ("Windows-compatible System Power Management Controller")
device ID is used for identifying the special device object providing
the LPI (Low-power S0 Idle) _DSM interface [1].  That device object
does not supply any operation regions, but it appears in _DEP lists
for other devices in the ACPI tables on some systems to enforce
specific enumeration ordering that does not matter in Linux.

For this reason, _DEP list entries pointing to the device object whose
_CID returns PNP0D80 need not be taken into account as real operation
region dependencies, so add that device ID to the list of device IDs
for which the matching _DEP list entries should be ignored.

Accordingly, update the function used for matching device IDs in that
list to allow it to check _CID as well as _HID and rename it to
acpi_info_matches_ids().

Link: https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -719,25 +719,40 @@ int acpi_device_add(struct acpi_device *
 /* --------------------------------------------------------------------------
                                  Device Enumeration
    -------------------------------------------------------------------------- */
-static bool acpi_info_matches_hids(struct acpi_device_info *info,
-				   const char * const hids[])
+static bool acpi_info_matches_ids(struct acpi_device_info *info,
+				  const char * const ids[])
 {
+	struct acpi_pnp_device_id_list *cid_list = NULL;
 	int i;
 
 	if (!(info->valid & ACPI_VALID_HID))
 		return false;
 
-	for (i = 0; hids[i]; i++) {
-		if (!strcmp(info->hardware_id.string, hids[i]))
+	if (info->valid & ACPI_VALID_CID)
+		cid_list = &info->compatible_id_list;
+
+	for (i = 0; ids[i]; i++) {
+		int j;
+
+		if (!strcmp(info->hardware_id.string, ids[i]))
 			return true;
+
+		if (!cid_list)
+			continue;
+
+		for (j = 0; j < cid_list->count; j++) {
+			if (!strcmp(cid_list->ids[j].string, ids[i]))
+				return true;
+		}
 	}
 
 	return false;
 }
 
 /* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
-static const char * const acpi_ignore_dep_hids[] = {
+static const char * const acpi_ignore_dep_ids[] = {
 	"INT3396", /* Windows System Power Management Controller */
+	"PNP0D80", /* Windows-compatible System Power Management Controller */
 	NULL
 };
 
@@ -1857,7 +1872,7 @@ static void acpi_device_dep_initialize(s
 			continue;
 		}
 
-		skip = acpi_info_matches_hids(info, acpi_ignore_dep_hids);
+		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
 		kfree(info);
 
 		if (skip)



