Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24061316591
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 12:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhBJLsB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 06:48:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:35842 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhBJLpq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 06:45:46 -0500
IronPort-SDR: mRqAMFhw9wnHudgI/f8KPpsmjWQu7XLKBJLOJq8TYWP4AHASMwhJjKJ2rUOFyTotVdjva1An6S
 194UYHSW1/Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="181283663"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="181283663"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 03:43:36 -0800
IronPort-SDR: bbPMqO0O8CLgv1cqYS7a6OjiNs3DZBAvu1C6NRzyeJ3H7KDbr1mSHDjnxNc8fwpP6n0maCn2ei
 1xFbCEilQdfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="436645535"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2021 03:43:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 683AA4BE; Wed, 10 Feb 2021 13:43:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/7] ACPI: property: Allow to validate a single value
Date:   Wed, 10 Feb 2021 13:43:19 +0200
Message-Id: <20210210114320.3478-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_data_prop_read_single() doesn't accept a NULL parameter for
the value. Let's modify it to accept NULL pointer in order to validate
the single value. This will be needed for the further changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index f2386ef32ff1..236316ee0e25 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -787,9 +787,6 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 	const union acpi_object *obj;
 	int ret = 0;
 
-	if (!val)
-		return -EINVAL;
-
 	if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64)
 		ret = acpi_data_get_property(data, propname, ACPI_TYPE_INTEGER, &obj);
 	else if (proptype == DEV_PROP_STRING)
@@ -801,23 +798,28 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 	case DEV_PROP_U8:
 		if (obj->integer.value > U8_MAX)
 			return -EOVERFLOW;
-		*(u8 *)val = obj->integer.value;
+		if (val)
+			*(u8 *)val = obj->integer.value;
 		break;
 	case DEV_PROP_U16:
 		if (obj->integer.value > U16_MAX)
 			return -EOVERFLOW;
-		*(u16 *)val = obj->integer.value;
+		if (val)
+			*(u16 *)val = obj->integer.value;
 		break;
 	case DEV_PROP_U32:
 		if (obj->integer.value > U32_MAX)
 			return -EOVERFLOW;
-		*(u32 *)val = obj->integer.value;
+		if (val)
+			*(u32 *)val = obj->integer.value;
 		break;
 	case DEV_PROP_U64:
-		*(u64 *)val = obj->integer.value;
+		if (val)
+			*(u64 *)val = obj->integer.value;
 		break;
 	case DEV_PROP_STRING:
-		*(char **)val = obj->string.pointer;
+		if (val)
+			*(char **)val = obj->string.pointer;
 		return 1;
 	default:
 		return -EINVAL;
-- 
2.30.0

