Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9E26276
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2019 12:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfEVKvb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 May 2019 06:51:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:32515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbfEVKvb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 May 2019 06:51:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 03:51:30 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 03:51:28 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 07/16] ACPI / property: Don't limit named child node matching to data nodes
Date:   Wed, 22 May 2019 13:51:04 +0300
Message-Id: <20190522105113.11153-8-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no reason why we should limit the use of
fwnode_get_named_child_node() to data nodes only.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/property.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 9d460a859be0..39c64291098f 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -603,15 +603,29 @@ static struct fwnode_handle *
 acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 				 const char *childname)
 {
+	char name[ACPI_PATH_SEGMENT_LENGTH];
 	struct fwnode_handle *child;
+	struct acpi_buffer path;
+	acpi_status status;
 
-	/*
-	 * Find first matching named child node of this fwnode.
-	 * For ACPI this will be a data only sub-node.
-	 */
-	fwnode_for_each_child_node(fwnode, child)
-		if (acpi_data_node_match(child, childname))
+	path.length = sizeof(name);
+	path.pointer = name;
+
+	fwnode_for_each_child_node(fwnode, child) {
+		if (is_acpi_data_node(child)) {
+			if (acpi_data_node_match(child, childname))
+				return child;
+			continue;
+		}
+
+		status = acpi_get_name(ACPI_HANDLE_FWNODE(child),
+				       ACPI_SINGLE_NAME, &path);
+		if (ACPI_FAILURE(status))
+			break;
+
+		if (!strncmp(name, childname, ACPI_NAMESEG_SIZE))
 			return child;
+	}
 
 	return NULL;
 }
-- 
2.20.1

