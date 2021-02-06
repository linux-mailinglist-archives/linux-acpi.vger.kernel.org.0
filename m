Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C18311C45
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Feb 2021 09:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBFIvG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Feb 2021 03:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBFIvF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 6 Feb 2021 03:51:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B738064E75;
        Sat,  6 Feb 2021 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612601424;
        bh=zU2xiBSt8hLV2J5I2PJQXajZLHybe0rfMUOYGL+cv3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=dvdzuukFUcLRj1GMnFY4O5Xh2jIo4XtQ1oDb+ATVbP208A5+x0KbFzoGYW14gVHwc
         J0+VnTkkaL7Isr0upnQ/EEryKYyGp93J5VwX4o/KCFwVV49ib4ODdUYllyYdQjHqN9
         BZQOppEU74uZv/LFSNki4ghwzo6ixq8a6T4xGCH7JMz+s6VCKfHH7HYFdmZmL8IGS8
         xZil5S9XAUMUO98HdQhi1ILzALSRQSVg18q9jq0boNEq6hcWk9kVZ9ZxVg0vlLtDVp
         Wpm2cCOLN0CmGKb9+G3iZvc3h4RJi84nv35fV8x0wZxj0RjkMMPhZWZxnJhw1muvkv
         zlRzJw6T1ZU2w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org, Ard Biesheuvel <ardb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by using existing buffer"
Date:   Sat,  6 Feb 2021 09:49:37 +0100
Message-Id: <20210206084937.20853-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit 32cf1a12cad43358e47dac8014379c2f33dfbed4.

The 'exisitng buffer' in this case is the firmware provided table, and
we should not modify that in place. This fixes a crash on arm64 with
initrd table overrides, in which case the DSDT is not mapped with
read/write permissions.

Cc: Robert Moore <robert.moore@intel.com>
Cc: Erik Kaneda <erik.kaneda@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Reported-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/acpica/nsrepair2.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index d2c8d8279e7a..24c197d91f29 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -495,8 +495,9 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 		   union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
-	char *dest;
+	union acpi_operand_object *new_string;
 	char *source;
+	char *dest;
 
 	ACPI_FUNCTION_NAME(ns_repair_HID);
 
@@ -517,6 +518,13 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	/* It is simplest to always create a new string object */
+
+	new_string = acpi_ut_create_string_object(return_object->string.length);
+	if (!new_string) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
 	/*
 	 * Remove a leading asterisk if present. For some unknown reason, there
 	 * are many machines in the field that contains IDs like this.
@@ -526,7 +534,7 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 	source = return_object->string.pointer;
 	if (*source == '*') {
 		source++;
-		return_object->string.length--;
+		new_string->string.length--;
 
 		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
 				  "%s: Removed invalid leading asterisk\n",
@@ -541,11 +549,12 @@ acpi_ns_repair_HID(struct acpi_evaluate_info *info,
 	 * "NNNN####" where N is an uppercase letter or decimal digit, and
 	 * # is a hex digit.
 	 */
-	for (dest = return_object->string.pointer; *source; dest++, source++) {
+	for (dest = new_string->string.pointer; *source; dest++, source++) {
 		*dest = (char)toupper((int)*source);
 	}
-	return_object->string.pointer[return_object->string.length] = 0;
 
+	acpi_ut_remove_reference(return_object);
+	*return_object_ptr = new_string;
 	return_ACPI_STATUS(AE_OK);
 }
 
-- 
2.30.0

