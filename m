Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17656CFB49
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2019 15:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfJHN0K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Oct 2019 09:26:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:25422 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfJHN0K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Oct 2019 09:26:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 06:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206634811"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2019 06:26:06 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] device property: Fix the description of struct fwnode_operations
Date:   Tue,  8 Oct 2019 16:26:06 +0300
Message-Id: <20191008132606.56434-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Adding description for the device_is_available member which
was missing, and fixing the description of the member
property_read_int_array.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/fwnode.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 6ae05b9ce359..fc002aacae8d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -50,11 +50,11 @@ struct fwnode_reference_args {
  * struct fwnode_operations - Operations for fwnode interface
  * @get: Get a reference to an fwnode.
  * @put: Put a reference to an fwnode.
+ * @device_is_available: Return true if the device is available.
  * @device_get_match_data: Return the device driver match data.
  * @property_present: Return true if a property is present.
- * @property_read_integer_array: Read an array of integer properties. Return
- *				 zero on success, a negative error code
- *				 otherwise.
+ * @property_read_int_array: Read an array of integer properties. Return zero on
+ *			     success, a negative error code otherwise.
  * @property_read_string_array: Read an array of string properties. Return zero
  *				on success, a negative error code otherwise.
  * @get_parent: Return the parent of an fwnode.
-- 
2.23.0

