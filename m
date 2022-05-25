Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA07533D1C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiEYNBI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243712AbiEYNBG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 09:01:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D047A76F6
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653483665; x=1685019665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9Sg0JwYWPaPTvPKRN5ge8hrj3saYnV7hD/myoycKbk=;
  b=ZgB6yiSWsgo1EQfusPmgibmcBU7vMrT14e5RNqeEcK7jEOwfvxXQYsHl
   lm530So/FHVBVV3KBAAVxws7TwQd0aS/AsfqHRhxqJNZWn+X15B2rGUC0
   +ENhFuK5jO+pJIqKAc5yVwro6+Pj8hyBTevcnVZagVo+Ne5KUMJznMntN
   hepojpRFlem2YFUOoAJRPQ5AT8cTFpwqPAFoKssC4YTjtdywwICoxciBg
   ATs0nFLARYEh+TbKW9gk6n/qnZGGT4Xb1JN543epxH9yRTkpgj/9FG9dm
   RlWp23KRPB3+9TDgQdCvLGHkxWaqrnUbF63C3JncB8nK/7kqrqCOLRxzN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273915577"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273915577"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="630337074"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:02 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id B3166208D8;
        Wed, 25 May 2022 16:00:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1ntqdf-003Dem-Jj; Wed, 25 May 2022 16:01:23 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v3 6/8] ACPI: property: Unify integer value reading functions
Date:   Wed, 25 May 2022 16:01:21 +0300
Message-Id: <20220525130123.767410-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Unify functions reading ACPI property integer values into a single macro
using C99 _Generic().

Also use size_t for the counter instead of int.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 93 +++++++++++++----------------------------
 1 file changed, 28 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a8e8a214a524f..5d9805a6ff12d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -910,67 +910,30 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 	return ret;
 }
 
-static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
-				       size_t nval)
-{
-	int i;
-
-	for (i = 0; i < nval; i++) {
-		if (items[i].type != ACPI_TYPE_INTEGER)
-			return -EPROTO;
-		if (items[i].integer.value > U8_MAX)
-			return -EOVERFLOW;
-
-		val[i] = items[i].integer.value;
-	}
-	return 0;
-}
-
-static int acpi_copy_property_array_u16(const union acpi_object *items,
-					u16 *val, size_t nval)
-{
-	int i;
-
-	for (i = 0; i < nval; i++) {
-		if (items[i].type != ACPI_TYPE_INTEGER)
-			return -EPROTO;
-		if (items[i].integer.value > U16_MAX)
-			return -EOVERFLOW;
-
-		val[i] = items[i].integer.value;
-	}
-	return 0;
-}
-
-static int acpi_copy_property_array_u32(const union acpi_object *items,
-					u32 *val, size_t nval)
-{
-	int i;
-
-	for (i = 0; i < nval; i++) {
-		if (items[i].type != ACPI_TYPE_INTEGER)
-			return -EPROTO;
-		if (items[i].integer.value > U32_MAX)
-			return -EOVERFLOW;
-
-		val[i] = items[i].integer.value;
-	}
-	return 0;
-}
-
-static int acpi_copy_property_array_u64(const union acpi_object *items,
-					u64 *val, size_t nval)
-{
-	int i;
-
-	for (i = 0; i < nval; i++) {
-		if (items[i].type != ACPI_TYPE_INTEGER)
-			return -EPROTO;
-
-		val[i] = items[i].integer.value;
-	}
-	return 0;
-}
+#define acpi_copy_property_array_uint(items, val, nval)			\
+	({								\
+		size_t i;						\
+		int ret = 0;						\
+									\
+		for (i = 0; i < (nval); i++) {				\
+			if ((items)[i].type != ACPI_TYPE_INTEGER) {	\
+				ret = -EPROTO;				\
+				break;					\
+			}						\
+			if ((items)[i].integer.value > _Generic((val),	\
+								u8: U8_MAX, \
+								u16: U16_MAX, \
+								u32: U32_MAX, \
+								u64: U64_MAX, \
+								default: 0U)) { \
+				ret = -EOVERFLOW;			\
+				break;					\
+			}						\
+									\
+			(val)[i] = (items)[i].integer.value;		\
+		}							\
+		ret;							\
+	})
 
 static int acpi_copy_property_array_string(const union acpi_object *items,
 					   char **val, size_t nval)
@@ -1027,16 +990,16 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 
 	switch (proptype) {
 	case DEV_PROP_U8:
-		ret = acpi_copy_property_array_u8(items, (u8 *)val, nval);
+		ret = acpi_copy_property_array_uint(items, (u8 *)val, nval);
 		break;
 	case DEV_PROP_U16:
-		ret = acpi_copy_property_array_u16(items, (u16 *)val, nval);
+		ret = acpi_copy_property_array_uint(items, (u16 *)val, nval);
 		break;
 	case DEV_PROP_U32:
-		ret = acpi_copy_property_array_u32(items, (u32 *)val, nval);
+		ret = acpi_copy_property_array_uint(items, (u32 *)val, nval);
 		break;
 	case DEV_PROP_U64:
-		ret = acpi_copy_property_array_u64(items, (u64 *)val, nval);
+		ret = acpi_copy_property_array_uint(items, (u64 *)val, nval);
 		break;
 	case DEV_PROP_STRING:
 		ret = acpi_copy_property_array_string(
-- 
2.30.2

