Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0552E4CD
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 08:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbiETGLp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 02:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbiETGLm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 02:11:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A466980AB
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 23:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653027101; x=1684563101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bPXXKavxL+d6+YbI5ot0vxwKxtnOjhjq2wIhHY2Abec=;
  b=NLJNP6UND89JGaVEs4A5HKJ5MQV0yN9+mnOqt5sDuJo/b0woTmMlSkIy
   UXh+XboRoZf7r9YL2i2T9H8UgNJS65hpEDSyNR9bolkyL0WCFpegXNsUV
   CmFugBPJgptHPvTxEBK3pBUgnODI5kPAa8KrxIU8mXiQFgA4x2qCTK4zA
   gJilHapAleSsX+HeKHGUlYf5WdM2nNOKaNCawSvLzcJk9TrdTB1PQSz4F
   dHWK+34UamAjb9Qgp/zC2A5kbHVVw1HKRMy8oi9fy78hDJi0rihpsSNp9
   sf/4a+sgiTsiTvnt2VJ5ynDQLm1Piaiz9BAS0Ewb072MUqlahNB7/zcE5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="253020036"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="253020036"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="627996999"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:11:40 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 46F4120FA1;
        Fri, 20 May 2022 09:11:35 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nrvrZ-0005Zw-Ef; Fri, 20 May 2022 09:11:49 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v2 8/8] ACPI: property: Read buffer properties as integers
Date:   Fri, 20 May 2022 09:11:48 +0300
Message-Id: <20220520061148.21366-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
References: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Instead of adding a new property type, read buffer properties as integers.
Even though the internal representation in ACPI is different, the data
type is the same (byte) than on 8-bit integers.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 93157af151c9b..e94dc4dbbf627 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1033,6 +1033,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 		size_t i;						\
 									\
 		for (i = 0; i < nval; i++) {				\
+			if (items->type == ACPI_TYPE_BUFFER) {		\
+				val[i] = items->buffer.pointer[i];	\
+				continue;				\
+			}						\
 			if (items[i].type != ACPI_TYPE_INTEGER)		\
 				return -EPROTO;				\
 			if (items[i].integer.value > U##bits##_MAX)	\
@@ -1088,18 +1092,40 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 	}
 
 	ret = acpi_data_get_property_array(data, propname, ACPI_TYPE_ANY, &obj);
+	if (ret && proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64)
+		ret = acpi_data_get_property(data, propname, ACPI_TYPE_BUFFER,
+					     &obj);
 	if (ret)
 		return ret;
 
-	if (!val)
+	if (!val) {
+		if (obj->type == ACPI_TYPE_BUFFER)
+			return obj->buffer.length;
+
 		return obj->package.count;
+	}
 
-	if (proptype != DEV_PROP_STRING && nval > obj->package.count)
-		return -EOVERFLOW;
+	switch (proptype) {
+	case DEV_PROP_STRING:
+		break;
+	case DEV_PROP_U8 ... DEV_PROP_U64:
+		if (obj->type == ACPI_TYPE_BUFFER) {
+			if (nval <= obj->buffer.length)
+				break;
+			return -EOVERFLOW;
+		}
+		fallthrough;
+	default:
+		if (nval > obj->package.count)
+			return -EOVERFLOW;
+	}
 	if (nval == 0)
 		return -EINVAL;
 
-	items = obj->package.elements;
+	if (obj->type != ACPI_TYPE_BUFFER)
+		items = obj->package.elements;
+	else
+		items = obj;
 
 	switch (proptype) {
 	case DEV_PROP_U8:
-- 
2.30.2

