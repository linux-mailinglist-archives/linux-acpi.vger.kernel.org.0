Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188B332B442
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353068AbhCCE4B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:56:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:56274 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376694AbhCBNin (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 08:38:43 -0500
IronPort-SDR: vc5qYVqY5qb8LyqX76SgGk5ktxsMV9Rby7ivEHQIyPIe0NN6en5ve2vufnva56UoeYV6RryTJV
 AfriyL33aVhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="250856195"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="250856195"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 05:35:55 -0800
IronPort-SDR: +eBSO8i7q0dLr1Wa0uO8cwePxTtFaCaNSgmefH9c0+SxGRGWcugvC7TryGhqan+Smdopzct7Lm
 y288fYruUFxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="585939105"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2021 05:35:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB4E913A; Tue,  2 Mar 2021 15:35:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: bus: Constify is_acpi_node() and friends (part 2)
Date:   Tue,  2 Mar 2021 15:35:48 +0200
Message-Id: <20210302133548.88230-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit 8b9d6802583a ("ACPI: Constify acpi_bus helper functions,
switch to macros") only changed functions for CONFIG_ACPI=y case.
This part adjusts the rest.

Fixes: 8b9d6802583a ("ACPI: Constify acpi_bus helper functions, switch to macros")
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/acpi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 095bf2b147c7..fcdaab723916 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -746,12 +746,12 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 
 static inline void acpi_dev_put(struct acpi_device *adev) {}
 
-static inline bool is_acpi_node(struct fwnode_handle *fwnode)
+static inline bool is_acpi_node(const struct fwnode_handle *fwnode)
 {
 	return false;
 }
 
-static inline bool is_acpi_device_node(struct fwnode_handle *fwnode)
+static inline bool is_acpi_device_node(const struct fwnode_handle *fwnode)
 {
 	return false;
 }
@@ -761,7 +761,7 @@ static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwno
 	return NULL;
 }
 
-static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
+static inline bool is_acpi_data_node(const struct fwnode_handle *fwnode)
 {
 	return false;
 }
-- 
2.30.1

