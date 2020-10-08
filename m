Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC100286D20
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 05:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgJHDWD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 23:22:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:29860 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgJHDWC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 23:22:02 -0400
IronPort-SDR: R7LT2grrkTdHG66lgvu8TMluSlJPjV4AvHtEtOGi+E3isLhaf+8lcvJIOUH6vykfzg0KNpWGUh
 G/pWnVr18uGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162613649"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="162613649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:22:02 -0700
IronPort-SDR: QmOYT7Ytyc12/ljelaAZgSUUHW68UVkuf7shxsAefiN+9dSfZ6HF1GweurbFaDoYkvnP2QDoJ4
 RMC7+svIw0pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355229347"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 20:22:02 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 6/9] ACPICA: iASL: Return exceptions for string-to-integer conversions
Date:   Wed,  7 Oct 2020 19:54:00 -0700
Message-Id: <20201008025403.2401736-7-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008025403.2401736-1-erik.kaneda@intel.com>
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This allows iASL to generate errors by passing exceptions that may be
encountered during string-to-integer conversions. The exceptions
point out invalid hex, decimal, and octal integers.

ACPICA commit e98b8c0a3d96fdabb167c0ef18a809b32ade3228

Link: https://github.com/acpica/acpica/commit/e98b8c0a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/utstrsuppt.c | 33 +++++++++++++++++++++++---------
 include/acpi/acexcep.h           |  4 ++--
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/utstrsuppt.c b/drivers/acpi/acpica/utstrsuppt.c
index 05ff20049b87..2d91003fcf26 100644
--- a/drivers/acpi/acpica/utstrsuppt.c
+++ b/drivers/acpi/acpica/utstrsuppt.c
@@ -45,10 +45,15 @@ acpi_status acpi_ut_convert_octal_string(char *string, u64 *return_value_ptr)
 	/* Convert each ASCII byte in the input string */
 
 	while (*string) {
-
-		/* Character must be ASCII 0-7, otherwise terminate with no error */
-
+		/*
+		 * Character must be ASCII 0-7, otherwise:
+		 * 1) Runtime: terminate with no error, per the ACPI spec
+		 * 2) Compiler: return an error
+		 */
 		if (!(ACPI_IS_OCTAL_DIGIT(*string))) {
+#ifdef ACPI_ASL_COMPILER
+			status = AE_BAD_OCTAL_CONSTANT;
+#endif
 			break;
 		}
 
@@ -94,10 +99,15 @@ acpi_status acpi_ut_convert_decimal_string(char *string, u64 *return_value_ptr)
 	/* Convert each ASCII byte in the input string */
 
 	while (*string) {
-
-		/* Character must be ASCII 0-9, otherwise terminate with no error */
-
+		/*
+		 * Character must be ASCII 0-9, otherwise:
+		 * 1) Runtime: terminate with no error, per the ACPI spec
+		 * 2) Compiler: return an error
+		 */
 		if (!isdigit(*string)) {
+#ifdef ACPI_ASL_COMPILER
+			status = AE_BAD_DECIMAL_CONSTANT;
+#endif
 			break;
 		}
 
@@ -143,10 +153,15 @@ acpi_status acpi_ut_convert_hex_string(char *string, u64 *return_value_ptr)
 	/* Convert each ASCII byte in the input string */
 
 	while (*string) {
-
-		/* Must be ASCII A-F, a-f, or 0-9, otherwise terminate with no error */
-
+		/*
+		 * Character must be ASCII A-F, a-f, or 0-9, otherwise:
+		 * 1) Runtime: terminate with no error, per the ACPI spec
+		 * 2) Compiler: return an error
+		 */
 		if (!isxdigit(*string)) {
+#ifdef ACPI_ASL_COMPILER
+			status = AE_BAD_HEX_CONSTANT;
+#endif
 			break;
 		}
 
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 436cd1411c3a..2fc624a61769 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -40,12 +40,12 @@
 struct acpi_exception_info {
 	char *name;
 
-#ifdef ACPI_HELP_APP
+#if defined (ACPI_HELP_APP) || defined (ACPI_ASL_COMPILER)
 	char *description;
 #endif
 };
 
-#ifdef ACPI_HELP_APP
+#if defined (ACPI_HELP_APP) || defined (ACPI_ASL_COMPILER)
 #define EXCEP_TXT(name,description)     {name, description}
 #else
 #define EXCEP_TXT(name,description)     {name}
-- 
2.25.1

