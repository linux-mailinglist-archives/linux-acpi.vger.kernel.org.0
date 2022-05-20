Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3235F52E4D4
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 08:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbiETGLu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 02:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345749AbiETGLn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 02:11:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566CE9968E
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 23:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653027102; x=1684563102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3P0dUciLnGB0TF3Km1s18i8l/6YKxsugCmYC0o7NSlY=;
  b=PaNXLzunW3YV8QoMrUqMzwcMJgnhIaZwXGVJ+5ov/xlZlxxpsL2DD6IS
   l/qTVCYuknf3UM9J13DuRVq/XEE1kurSKZ6AwDkxmYAyX5Q0mXtpnKwnr
   +SGu4tj2+pHNe4w0zRdKm35Cj15IBL7yfHslz5JNMWzrwi5iVgL2LUEGK
   ESai4dLsvjlAX/QY5iloTCuGkl5ZB3W5UnAq7RZ7DxI9N+BShb7nZ4pzC
   r4OvMl0/JtFIFrWVQoYGE21dL+Kkhx0OQsu9wywkOIfqRFlS55nNR13mD
   u6iDv18VtzrFEJsC2I/mH9+rpCuLKzvhlWe/46VDsbHl4fj44mbSHZG1f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="252390965"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="252390965"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="546518553"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:40 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 2E8CA20F37;
        Fri, 20 May 2022 09:11:35 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nrvrZ-0005Zo-BU; Fri, 20 May 2022 09:11:49 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v2 6/8] ACPI: property: Unify integer value reading functions
Date:   Fri, 20 May 2022 09:11:46 +0300
Message-Id: <20220520061148.21366-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
References: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Unify functions reading ACPI property integer values into a single macro,
and call that macro to generate the functions for each bit depth.

Also use size_t for the counter instead of int.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 79 +++++++++++------------------------------
 1 file changed, 20 insertions(+), 59 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a8e8a214a524f..8449479e18442 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -910,67 +910,28 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
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
+#define DECLARE_ACPI_PROPERTY_COPY(bits)				\
+	static int							\
+	acpi_copy_property_array_u##bits(const union acpi_object *items, \
+					 u##bits *val, size_t nval)	\
+	{								\
+		size_t i;						\
+									\
+		for (i = 0; i < nval; i++) {				\
+			if (items[i].type != ACPI_TYPE_INTEGER)		\
+				return -EPROTO;				\
+			if (items[i].integer.value > U##bits##_MAX)	\
+				return -EOVERFLOW;			\
+									\
+			val[i] = items[i].integer.value;		\
+		}							\
+		return 0;						\
 	}
-	return 0;
-}
 
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
+DECLARE_ACPI_PROPERTY_COPY(8)
+DECLARE_ACPI_PROPERTY_COPY(16)
+DECLARE_ACPI_PROPERTY_COPY(32)
+DECLARE_ACPI_PROPERTY_COPY(64)
 
 static int acpi_copy_property_array_string(const union acpi_object *items,
 					   char **val, size_t nval)
-- 
2.30.2

