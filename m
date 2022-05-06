Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259D451D861
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392220AbiEFNCZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392209AbiEFNCW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AF06338E
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841915; x=1683377915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AWXX9RIJyfn+TklamiDPXtkmP70XK6wxbDByAy02EMA=;
  b=QTzrj5CvTGk2CvOAK+itSIAmulNCO875cxPVRMbe0h6zyYMaWP3OR7Av
   wkLK9rW4wks1bV9/R1pGiNbMsaPajDa8Lz9MmYUbffbBUdEvHCScE1SU6
   0KmuGmCVf+tQiHCjHSACFAR2bT20S5NoQfhl1ghvwvgS6R059owKg2QMU
   ML7+9/8RFq2OLYZjrp2UTzhFwGrWMjz2ZzwjsAGCOnkOHRhyYIyPnttcM
   0qG9pxV0Px7QDymmG+hiN36OvCZMDWz+7cqlgoYIAGd5084JQMpZXnRB4
   2rWq+FIXSIoC6JdDRxpP9M6z74cEl+4oaS2y7vY0/dbadrUEA/FjSJgZr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266051622"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266051622"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="695169289"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:34 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id EAA3E20EAC;
        Fri,  6 May 2022 15:58:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480p-IU; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 09/11] ACPI: property: Unify integer value reading functions
Date:   Fri,  6 May 2022 16:00:23 +0300
Message-Id: <20220506130025.984026-10-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
index 9325a9b2c0543..2205612fd6e98 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -985,67 +985,28 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
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

