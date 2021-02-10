Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EAB316590
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 12:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhBJLr5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 06:47:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:64430 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhBJLpk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 06:45:40 -0500
IronPort-SDR: wSheto1sOsf4cVLgtdomFFgtfAe3a8Tg6kX3ts0pqY0nNi6j5Ip5Ivlyg4sEE4v3B0Qr1kK4Yf
 KmkvHIpb53wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169181911"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="169181911"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 03:43:34 -0800
IronPort-SDR: 1EEOWmLHG9eeh7iZ+/W2gJzwBCcl3cmva7DnQ3zFVjiueCBigrBqOO6PdDMNCgiP5ZazAIjcOv
 mkz29nzXwLew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="488729858"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2021 03:43:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5FDF235E; Wed, 10 Feb 2021 13:43:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/7] ACPI: property: Refactor acpi_data_prop_read_single()
Date:   Wed, 10 Feb 2021 13:43:18 +0200
Message-Id: <20210210114320.3478-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Refactor acpi_data_prop_read_single() for less LOCs and better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 59 +++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 167338fe9b04..f2386ef32ff1 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -785,47 +785,44 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 				      enum dev_prop_type proptype, void *val)
 {
 	const union acpi_object *obj;
-	int ret;
+	int ret = 0;
 
 	if (!val)
 		return -EINVAL;
 
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
-			*(u8 *)val = obj->integer.value;
-			break;
-		case DEV_PROP_U16:
-			if (obj->integer.value > U16_MAX)
-				return -EOVERFLOW;
-			*(u16 *)val = obj->integer.value;
-			break;
-		case DEV_PROP_U32:
-			if (obj->integer.value > U32_MAX)
-				return -EOVERFLOW;
-			*(u32 *)val = obj->integer.value;
-			break;
-		default:
-			*(u64 *)val = obj->integer.value;
-			break;
-		}
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
+		*(u8 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_U16:
+		if (obj->integer.value > U16_MAX)
+			return -EOVERFLOW;
+		*(u16 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_U32:
+		if (obj->integer.value > U32_MAX)
+			return -EOVERFLOW;
+		*(u32 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_U64:
+		*(u64 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_STRING:
 		*(char **)val = obj->string.pointer;
-
 		return 1;
-	} else {
-		ret = -EINVAL;
+	default:
+		return -EINVAL;
 	}
+
 	return ret;
 }
 
-- 
2.30.0

