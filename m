Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61E15700C6
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jul 2022 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiGKLhS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jul 2022 07:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiGKLgz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2022 07:36:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659C8CC8B
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jul 2022 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657538656; x=1689074656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hqFCK5307o7mcbNOsL35AaW+Rib09PnmYoL/+sZ3aQ0=;
  b=Ugm4deItUtIjeJ86PgBSk3d2L9suf3HrOgeF/aVTir2auGjYGOEnJEDS
   JLq41pwmizel8Hrt0f035A89n0nn6pehwxB0bJa7HNHkg2hvZY3hugG+m
   BgJOTVRx1Zlx6noAnqptPjM+eEJ89mhS0Fw4FM2VCbarlEYBRLlE9aPsI
   EvxhPIwqIlygqBzFwysSD/7rPbWEvYbc+v7MxieNuhiC6SFTyIPtTuR81
   mCmXPOwkG0agDpCsZwuOd/oRSwCCykEauVgeAix0mx4xiXqxcSymGYDRD
   C457lSWxjuzfsy6HeqM040u1kGzsYDb/nZ36Jg5VwKlb5spgvWMjy9unP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="310239442"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="310239442"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="684350410"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:02 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 1F1D521FE5;
        Mon, 11 Jul 2022 14:23:58 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oArYE-00CnYg-GS; Mon, 11 Jul 2022 14:26:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v4 6/8] ACPI: property: Unify integer value reading functions
Date:   Mon, 11 Jul 2022 14:26:04 +0300
Message-Id: <20220711112606.3050368-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/acpi/property.c | 96 +++++++++++++----------------------------
 1 file changed, 31 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 3411cd0433b88..236a847f1bfbd 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -908,67 +908,33 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
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
+		typeof(items) __items = items;				\
+		typeof(val) __val = val;				\
+		typeof(nval) __nval = nval;				\
+		size_t i;						\
+		int ret = 0;						\
+									\
+		for (i = 0; i < __nval; i++) {				\
+			if (__items[i].type != ACPI_TYPE_INTEGER) {	\
+				ret = -EPROTO;				\
+				break;					\
+			}						\
+			if (__items[i].integer.value > _Generic(__val,	\
+								u8: U8_MAX, \
+								u16: U16_MAX, \
+								u32: U32_MAX, \
+								u64: U64_MAX, \
+								default: 0U)) { \
+				ret = -EOVERFLOW;			\
+				break;					\
+			}						\
+									\
+			__val[i] = __items[i].integer.value;		\
+		}							\
+		ret;							\
+	})
 
 static int acpi_copy_property_array_string(const union acpi_object *items,
 					   char **val, size_t nval)
@@ -1025,16 +991,16 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 
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

