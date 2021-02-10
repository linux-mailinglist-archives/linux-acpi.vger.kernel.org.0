Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A0A31658F
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 12:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBJLry (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 06:47:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:33771 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhBJLpk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 06:45:40 -0500
IronPort-SDR: OCJ4FrDaBJwLu/MAgh0WNGKfTO9k4FyPBMHBfLJuGMCHzGY6DZR5p26oGeKj4RwXJHIz1EYdLG
 i6Ee2wWZxnSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182197777"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="182197777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 03:43:35 -0800
IronPort-SDR: NXMVZ80IcihnIlKnMWebkJkjEfI81rjTJNeIvg6l8MUTQDpS+93mPgj164SqQgqNNhqrxW+y75
 srvjGFX5q+0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380026988"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2021 03:43:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 45FE66B; Wed, 10 Feb 2021 13:43:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/7] ACPI: property: Make acpi_node_prop_read() static
Date:   Wed, 10 Feb 2021 13:43:15 +0200
Message-Id: <20210210114320.3478-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no users outside of property.c. No need to export
acpi_node_prop_read(), hence make it static.

Fixes: 3708184afc77 ("device property: Move FW type specific functionality to FW specific files")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c |  6 +++---
 include/linux/acpi.h    | 11 -----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d9f3132466b5..9304c88ce446 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -971,9 +971,9 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
  * of the property.  Otherwise, read at most @nval values to the array at the
  * location pointed to by @val.
  */
-int acpi_node_prop_read(const struct fwnode_handle *fwnode,
-			const char *propname, enum dev_prop_type proptype,
-			void *val, size_t nval)
+static int acpi_node_prop_read(const struct fwnode_handle *fwnode,
+			       const char *propname, enum dev_prop_type proptype,
+			       void *val, size_t nval)
 {
 	return acpi_data_prop_read(acpi_device_data_of_node(fwnode),
 				   propname, proptype, val, nval);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 14ac25165ae1..3c5757d539ab 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1121,9 +1121,6 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
 
 int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 		       void **valptr);
-int acpi_node_prop_read(const struct fwnode_handle *fwnode,
-			const char *propname, enum dev_prop_type proptype,
-			void *val, size_t nval);
 
 struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child);
@@ -1225,14 +1222,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static inline int acpi_node_prop_read(const struct fwnode_handle *fwnode,
-				      const char *propname,
-				      enum dev_prop_type proptype,
-				      void *val, size_t nval)
-{
-	return -ENXIO;
-}
-
 static inline struct fwnode_handle *
 acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 		      struct fwnode_handle *child)
-- 
2.30.0

