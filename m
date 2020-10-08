Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCBA286D1E
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 05:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgJHDWC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 23:22:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:29860 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbgJHDWB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 23:22:01 -0400
IronPort-SDR: Agb//3F/jhy1sXS+ibjDXUFVc2HYFyPul60a+KAU3kDvrd01LalZLOjGWLPMI3S4odEdEscsi8
 A1585uSpZHRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162613642"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="162613642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:22:00 -0700
IronPort-SDR: adcyEbOrSP0r2aUwDEaRDR5pPHUzkCUYlkCdoiMo0tCOQCyuj4pVFmiTidsNg6SJ7S36FSX2wv
 5sdJTS3RMelA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355229339"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 20:22:00 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 4/9] ACPICA: Add predefined names found in the SMBus sepcification
Date:   Wed,  7 Oct 2020 19:53:58 -0700
Message-Id: <20201008025403.2401736-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008025403.2401736-1-erik.kaneda@intel.com>
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Affects run-time (kernel) ACPICA, iASL, and acpi_help. The "SMBus
Control Method Interface Specification, Version 1.0, December 10,
1999" containes predefined names: _SBA _SBI _SBR _SBT _SBW. This was
done outside of the ACPI specification. This commit adds support for
ACPICA to recognize these named objects as predefined named objects.

ACPICA commit 2fe13bd7ba9f97d3bf25488bf1bb1b2329427093

Link: https://github.com/acpica/acpica/commit/2fe13bd7
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/acpredef.h    | 33 ++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/nsarguments.c |  4 +++-
 drivers/acpi/acpica/psparse.c     |  4 ++--
 drivers/acpi/acpica/utpredef.c    |  5 ++---
 4 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 2cbb56652f1c..57ea2276790f 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -101,7 +101,7 @@ enum acpi_return_package_types {
 
 /* Support macros for users of the predefined info table */
 
-#define METHOD_PREDEF_ARGS_MAX          4
+#define METHOD_PREDEF_ARGS_MAX          5
 #define METHOD_ARG_BIT_WIDTH            3
 #define METHOD_ARG_MASK                 0x0007
 #define ARG_COUNT_IS_MINIMUM            0x8000
@@ -117,6 +117,7 @@ enum acpi_return_package_types {
 #define METHOD_2ARGS(a1,a2)             (2 | (a1 << 3) | (a2 << 6))
 #define METHOD_3ARGS(a1,a2,a3)          (3 | (a1 << 3) | (a2 << 6) | (a3 << 9))
 #define METHOD_4ARGS(a1,a2,a3,a4)       (4 | (a1 << 3) | (a2 << 6) | (a3 << 9) | (a4 << 12))
+#define METHOD_5ARGS(a1,a2,a3,a4,a5)    (5 | (a1 << 3) | (a2 << 6) | (a3 << 9) | (a4 << 12) | (a5 << 15))
 
 #define METHOD_RETURNS(type)            (type)
 #define METHOD_NO_RETURN_VALUE          0
@@ -902,9 +903,39 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	{{"_S4W", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
 
+	{{"_SBA", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (4 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0),
+
+	{{"_SBI", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (1 Int, 1 Buf) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 1,
+		     ACPI_RTYPE_BUFFER, 1, 0),
+
+	{{"_SBR",
+	  METHOD_3ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
+			ACPI_TYPE_INTEGER),
+	   METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (2 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2,
+		     ACPI_RTYPE_BUFFER | ACPI_RTYPE_INTEGER, 1, 0),
+
 	{{"_SBS", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
 
+	{{"_SBT",
+	  METHOD_4ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
+			ACPI_TYPE_ANY),
+	   METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (2 Int, 1 Buf | Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2,
+		     ACPI_RTYPE_BUFFER | ACPI_RTYPE_INTEGER, 1, 0),
+
+	{{"_SBW",
+	  METHOD_5ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
+			ACPI_TYPE_INTEGER, ACPI_TYPE_ANY),
+	   METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_BUFFER | ACPI_RTYPE_INTEGER,
+		     1, 0, 0, 0),
+
 	{{"_SCP", METHOD_1ARGS(ACPI_TYPE_INTEGER) | ARG_COUNT_IS_MINIMUM,
 	  METHOD_NO_RETURN_VALUE}},	/* Acpi 1.0 allowed 1 integer arg. Acpi 3.0 expanded to 3 args. Allow both. */
 
diff --git a/drivers/acpi/acpica/nsarguments.c b/drivers/acpi/acpica/nsarguments.c
index d5e8405e9d8f..6bbc7d350a16 100644
--- a/drivers/acpi/acpica/nsarguments.c
+++ b/drivers/acpi/acpica/nsarguments.c
@@ -55,7 +55,9 @@ void acpi_ns_check_argument_types(struct acpi_evaluate_info *info)
 		arg_type = METHOD_GET_NEXT_TYPE(arg_type_list);
 		user_arg_type = info->parameters[i]->common.type;
 
-		if (user_arg_type != arg_type) {
+		/* No typechecking for ACPI_TYPE_ANY */
+
+		if ((user_arg_type != arg_type) && (arg_type != ACPI_TYPE_ANY)) {
 			ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
 					      ACPI_WARN_ALWAYS,
 					      "Argument #%u type mismatch - "
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index c780046bf294..bd3caf735be3 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -508,8 +508,8 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 			}
 
 			/*
-			 * If the transfer to the new method method call worked
-			 *, a new walk state was created -- get it
+			 * If the transfer to the new method method call worked,
+			 * a new walk state was created -- get it
 			 */
 			walk_state = acpi_ds_get_current_walk_state(thread);
 			continue;
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index 05fe3470fb93..dd277f7e9f10 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -151,7 +151,7 @@ static u32 acpi_ut_get_argument_types(char *buffer, u16 argument_types);
 
 static const char *ut_external_type_names[] =	/* Indexed by ACPI_TYPE_* */
 {
-	", UNSUPPORTED-TYPE",
+	", Type_ANY",
 	", Integer",
 	", String",
 	", Buffer",
@@ -311,8 +311,7 @@ static u32 acpi_ut_get_argument_types(char *buffer, u16 argument_types)
 	for (i = 0; i < arg_count; i++) {
 		this_argument_type = METHOD_GET_NEXT_TYPE(argument_types);
 
-		if (!this_argument_type
-		    || (this_argument_type > METHOD_MAX_ARG_TYPE)) {
+		if (this_argument_type > METHOD_MAX_ARG_TYPE) {
 			printf("**** Invalid argument type (%u) "
 			       "in predefined info structure\n",
 			       this_argument_type);
-- 
2.25.1

