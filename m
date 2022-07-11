Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7345700C0
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jul 2022 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiGKLhD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jul 2022 07:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiGKLgn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2022 07:36:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137398AB31
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jul 2022 04:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657538646; x=1689074646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=psNICnFTPbDrrn1NO0zWmVYMlWvqb2EQZh+2TVt76zo=;
  b=HWjQTy/VRw6iVKVgT6ZLCXaCoeaWnUcSaqxjzrzocHHgrk7RITrzmk8F
   UoRdZrLOP6bkORnbywujwd0KFxVWpwYLkH1CpGv0eziLCCtHOPnQOsRkU
   WyQeXN5CkSZ+mFQQ9BP7hHciNbDYx4DVKCv/KIh99puc2z3kJaGjxlNJc
   BJsTH9uRQrIgRc8y5eMQJ/wQHF1wHtEUHi1hD/sjdnL67WzgzWdVBLeb+
   ASnWEkf+LP4OCSnyJHubgJ91PdMWszUaCgyEJF62cFroq/L473Nzc2CyM
   0tryzpzJEf4s1iAgjtY/E0sx+xQpnvRc8hrpH21uYmjjJ+J1aH+ZOb4qT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282186971"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="282186971"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="840973475"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:02 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 349D2220AA;
        Mon, 11 Jul 2022 14:23:58 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oArYE-00CnYo-Jb; Mon, 11 Jul 2022 14:26:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v4 8/8] ACPI: property: Read buffer properties as integers
Date:   Mon, 11 Jul 2022 14:26:06 +0300
Message-Id: <20220711112606.3050368-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
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

Instead of adding a new property type, read buffer properties as integers.
Even though the internal representation in ACPI is different, the data
type is the same (byte) than on 8-bit integers.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 7621f684212ff..9711482014a60 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1033,6 +1033,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 		int ret = 0;						\
 									\
 		for (i = 0; i < __nval; i++) {				\
+			if (__items->type == ACPI_TYPE_BUFFER) {	\
+				__val[i] = __items->buffer.pointer[i];	\
+				continue;				\
+			}						\
 			if (__items[i].type != ACPI_TYPE_INTEGER) {	\
 				ret = -EPROTO;				\
 				break;					\
@@ -1092,18 +1096,41 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
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
+			if (nval > obj->buffer.length)
+				return -EOVERFLOW;
+			break;
+		}
+		fallthrough;
+	default:
+		if (nval > obj->package.count)
+			return -EOVERFLOW;
+		break;
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

