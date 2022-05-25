Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FBF533D1A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiEYNBG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243698AbiEYNBF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 09:01:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E059A76EC
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653483664; x=1685019664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6YFtl1CncQBs0qabx3ituBdMIf1Q77I6RUiLHnlVTK0=;
  b=YG4oSYVkt9OYIBCeO+k5OW/ewuGaClbWjs6jGiPqlmatKWf8yKltKhrA
   0mgvF7pgYEU/4Zqp2oAh8W3DarZhm6cclTJFGw8ZvdGsg0sBwaBfxVV84
   qf/PW/feV5i8byGa6WYuSjDFIZRT58eO08L6j3avhr0VUT+iwBQhU6z9K
   9Yms8jJ8bYKCNzKjmGHWKQDuLptrFqAHnlJfEiRN4aUce36ThQdJfPU8O
   4hSndLaJyUXQXgoVCezzs/S1Vad3kvoWNZlbJ1oYAET0yDHqSA9WBbUjz
   h718hWgg1pW4IN//78OvIYKq9B1cDBbjdXV5H2ibCS79ozF7LPqlVJQOS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273915578"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273915578"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="630337077"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:02 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id C9895209CC;
        Wed, 25 May 2022 16:00:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1ntqdf-003Deu-Mm; Wed, 25 May 2022 16:01:23 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v3 8/8] ACPI: property: Read buffer properties as integers
Date:   Wed, 25 May 2022 16:01:23 +0300
Message-Id: <20220525130123.767410-9-sakari.ailus@linux.intel.com>
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

Instead of adding a new property type, read buffer properties as integers.
Even though the internal representation in ACPI is different, the data
type is the same (byte) than on 8-bit integers.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index b07a8c9fee876..9ac5cb03e4914 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1031,6 +1031,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 		int ret = 0;						\
 									\
 		for (i = 0; i < (nval); i++) {				\
+			if ((items)->type == ACPI_TYPE_BUFFER) {	\
+				(val)[i] = (items)->buffer.pointer[i];	\
+				continue;				\
+			}						\
 			if ((items)[i].type != ACPI_TYPE_INTEGER) {	\
 				ret = -EPROTO;				\
 				break;					\
@@ -1090,18 +1094,40 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
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

