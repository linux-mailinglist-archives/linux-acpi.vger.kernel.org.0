Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9030FE3
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfEaOQI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 10:16:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:8345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfEaOQG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 10:16:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:16:06 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 07:16:04 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 07/16] ACPI / property: Don't limit named child node matching to data nodes
Date:   Fri, 31 May 2019 17:15:38 +0300
Message-Id: <20190531141547.22728-8-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no reason why we should limit the use of
fwnode_get_named_child_node() to data nodes only.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
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

