Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE68431A06C
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 15:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhBLOOY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 09:14:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:44070 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbhBLOOH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 09:14:07 -0500
IronPort-SDR: JJcxaZJOXb/1c2UFZvjyMewnRB79iOAL1gKXcj0q6484UFjWhUS6vt9qDDiOZOfZyzBGPWv6AD
 ya4cv/br1Z4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="246483854"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="246483854"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 06:11:36 -0800
IronPort-SDR: sAy79xcTxwAb2fsnOOT57eigZ/hCy3V6uK5MaCAOcBJtB1iXPwkaSFFZQYpXVUSOhwA/+dDEoP
 YrxAiTFZSMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="437596732"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2021 06:11:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B46954BE; Fri, 12 Feb 2021 16:11:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 5/5] ACPI: property: Refactor acpi_data_prop_read_single()
Date:   Fri, 12 Feb 2021 16:11:21 +0200
Message-Id: <20210212141121.62115-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
References: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Refactor acpi_data_prop_read_single() for less LOCs and better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 80 ++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e312ebaed8db..494cf283a573 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -785,60 +785,48 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 				      enum dev_prop_type proptype, void *val)
 {
 	const union acpi_object *obj;
-	int ret;
+	int ret = 0;
 
-	if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64) {
+	if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64)
 		ret = acpi_data_get_property(data, propname, ACPI_TYPE_INTEGER, &obj);
-		if (ret)
-			return ret;
-
-		switch (proptype) {
-		case DEV_PROP_U8:
-			if (obj->integer.value > U8_MAX)
-				return -EOVERFLOW;
-
-			if (val)
-				*(u8 *)val = obj->integer.value;
-
-			break;
-		case DEV_PROP_U16:
-			if (obj->integer.value > U16_MAX)
-				return -EOVERFLOW;
-
-			if (val)
-				*(u16 *)val = obj->integer.value;
-
-			break;
-		case DEV_PROP_U32:
-			if (obj->integer.value > U32_MAX)
-				return -EOVERFLOW;
-
-			if (val)
-				*(u32 *)val = obj->integer.value;
-
-			break;
-		default:
-			if (val)
-				*(u64 *)val = obj->integer.value;
-
-			break;
-		}
-
-		if (!val)
-			return 1;
-	} else if (proptype == DEV_PROP_STRING) {
+	else if (proptype == DEV_PROP_STRING)
 		ret = acpi_data_get_property(data, propname, ACPI_TYPE_STRING, &obj);
-		if (ret)
-			return ret;
+	if (ret)
+		return ret;
 
+	switch (proptype) {
+	case DEV_PROP_U8:
+		if (obj->integer.value > U8_MAX)
+			return -EOVERFLOW;
+		if (val)
+			*(u8 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_U16:
+		if (obj->integer.value > U16_MAX)
+			return -EOVERFLOW;
+		if (val)
+			*(u16 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_U32:
+		if (obj->integer.value > U32_MAX)
+			return -EOVERFLOW;
+		if (val)
+			*(u32 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_U64:
+		if (val)
+			*(u64 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_STRING:
 		if (val)
 			*(char **)val = obj->string.pointer;
-
 		return 1;
-	} else {
-		ret = -EINVAL;
+	default:
+		return -EINVAL;
 	}
-	return ret;
+
+	/* When no storage provided return number of available values */
+	return val ? 0 : 1;
 }
 
 static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
-- 
2.30.0

