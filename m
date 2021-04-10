Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4F35ADEC
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Apr 2021 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhDJODN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Apr 2021 10:03:13 -0400
Received: from fgw23-7.mail.saunalahti.fi ([62.142.5.84]:53775 "EHLO
        fgw23-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234761AbhDJODM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Apr 2021 10:03:12 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 73771275-9a05-11eb-8ccd-005056bdfda7;
        Sat, 10 Apr 2021 17:02:56 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] ACPI: scan: Utilize match_string() API
Date:   Sat, 10 Apr 2021 17:02:53 +0300
Message-Id: <20210410140253.1966892-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We have already an API to match a string in the array of strings.
Utilize it instead of open coded analogues.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/acpi/scan.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b1d1f1a8ce69..bba6b529cf6c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -756,27 +756,25 @@ static bool acpi_info_matches_ids(struct acpi_device_info *info,
 				  const char * const ids[])
 {
 	struct acpi_pnp_device_id_list *cid_list = NULL;
-	int i;
+	int i, index;
 
 	if (!(info->valid & ACPI_VALID_HID))
 		return false;
 
+	index = match_string(ids, -1, info->hardware_id.string);
+	if (index >= 0)
+		return true;
+
 	if (info->valid & ACPI_VALID_CID)
 		cid_list = &info->compatible_id_list;
 
-	for (i = 0; ids[i]; i++) {
-		int j;
+	if (!cid_list)
+		return false;
 
-		if (!strcmp(info->hardware_id.string, ids[i]))
+	for (i = 0; i < cid_list->count; i++) {
+		index = match_string(ids, -1, cid_list->ids[i].string);
+		if (index >= 0)
 			return true;
-
-		if (!cid_list)
-			continue;
-
-		for (j = 0; j < cid_list->count; j++) {
-			if (!strcmp(cid_list->ids[j].string, ids[i]))
-				return true;
-		}
 	}
 
 	return false;
-- 
2.31.1

