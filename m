Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4712C8E6B
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbgK3Tsu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 14:48:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:18529 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388096AbgK3Tst (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Nov 2020 14:48:49 -0500
IronPort-SDR: mYi3WqZy7MedbziwTrOI/I5s9JMOgIKoJlZ+px2eD/yz4SmAOftgm4ZxawnTKN7zSB/S8pFEbR
 35OFBNhL3Mpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151954750"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151954750"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:47:59 -0800
IronPort-SDR: ie7J4z8JAcoY4iuiglC5306yGMx6m5FNHSM41r0yy6fXmFlJEjForEt+xbNcsIQr5kZrqm3Xm9
 yWNGnFirQZiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="404844937"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2020 11:47:59 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 5/6] ACPICA: Interpreter: fix memory leak by using existing buffer
Date:   Mon, 30 Nov 2020 11:20:47 -0800
Message-Id: <20201130192048.3093726-6-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130192048.3093726-1-erik.kaneda@intel.com>
References: <20201130192048.3093726-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 52d1da5dcbd79a722b70f02a1a83f04088f51ff6

There was a memory leak that ocurred when a _CID object is defined as
a package containing string objects. When _CID is checked for any
possible repairs, it calls a helper function to repair _HID (because
_CID basically contains multiple _HID entries).

The _HID repair function assumes that string objects are standalone
objects that are not contained inside of any packages. The _HID
repair function replaces the string object with a brand new object
and attempts to delete the old object by decrementing the reference
count of the old object. Strings inside of packages have a reference
count of 2 so the _HID repair function leaves this object in a
dangling state and causes a memory leak.

Instead of allocating a brand new object and removing the old object,
use the existing object when repairing the _HID object.

Link: https://github.com/acpica/acpica/commit/52d1da5d
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsrepair2.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 24c197d91f29..d2c8d8279e7a 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -495,9 +495,8 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
-	union acpi_operand_object *new_string;
-	char *source;
 	char *dest;
+	char *source;
 
 	ACPI_FUNCTION_NAME(ns_repair_HID);
 
@@ -518,13 +517,6 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	/* It is simplest to always create a new string object */
-
-	new_string = acpi_ut_create_string_object(return_object->string.length);
-	if (!new_string) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
 	/*
 	 * Remove a leading asterisk if present. For some unknown reason, there
 	 * are many machines in the field that contains IDs like this.
@@ -534,7 +526,7 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 	source = return_object->string.pointer;
 	if (*source == '*') {
 		source++;
-		new_string->string.length--;
+		return_object->string.length--;
 
 		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 				  "%s: Removed invalid leading asterisk\n",
@@ -549,12 +541,11 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 	 * "NNNN####" where N is an uppercase letter or decimal digit, and
 	 * # is a hex digit.
 	 */
-	for (dest = new_string->string.pointer; *source; dest++, source++) {
+	for (dest = return_object->string.pointer; *source; dest++, source++) {
 		*dest = (char)toupper((int)*source);
 	}
+	return_object->string.pointer[return_object->string.length] = 0;
 
-	acpi_ut_remove_reference(return_object);
-	*return_object_ptr = new_string;
 	return_ACPI_STATUS(AE_OK);
 }
 
-- 
2.25.1

