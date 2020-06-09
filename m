Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083F21F3C39
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jun 2020 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgFINWm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Jun 2020 09:22:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:17193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgFINWm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Jun 2020 09:22:42 -0400
IronPort-SDR: AiyUB6L67L/1CfFzQMMSNjBYGBhjMHjTsn93slCFhjspF/mlXGsBNFssehMDl8x+bDfb1MpW0V
 6eoFdrrbrlKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 06:22:41 -0700
IronPort-SDR: bh6qIMK0CBJdcZASAB7jHkSz62uUW5DCf5EO21s+gcrCC9hJh20iY6VpjzsKweFgOZ1YGBzPPl
 qSB6QS91aQUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="379734592"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2020 06:22:40 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI / property: use cached name in acpi_fwnode_get_named_child_node()
Date:   Tue,  9 Jun 2020 16:22:39 +0300
Message-Id: <20200609132239.27272-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no need to re-evaluate the object name.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/property.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e601c4511a8b5..6941062272e0b 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -606,13 +606,7 @@ static struct fwnode_handle *
 acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 				 const char *childname)
 {
-	char name[ACPI_PATH_SEGMENT_LENGTH];
 	struct fwnode_handle *child;
-	struct acpi_buffer path;
-	acpi_status status;
-
-	path.length = sizeof(name);
-	path.pointer = name;
 
 	fwnode_for_each_child_node(fwnode, child) {
 		if (is_acpi_data_node(child)) {
@@ -621,12 +615,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 			continue;
 		}
 
-		status = acpi_get_name(ACPI_HANDLE_FWNODE(child),
-				       ACPI_SINGLE_NAME, &path);
-		if (ACPI_FAILURE(status))
-			break;
-
-		if (!strncmp(name, childname, ACPI_NAMESEG_SIZE))
+		if (!strncmp(acpi_device_bid(to_acpi_device_node(child)),
+			     childname, ACPI_NAMESEG_SIZE))
 			return child;
 	}
 
-- 
2.27.0.rc2

