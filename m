Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD151D863
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbiEFNCZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392207AbiEFNCV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792016338C
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841915; x=1683377915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NbVeTbVwxSZQoXoxcW2hpdR9WvVt23TD8U7Zul1E8C0=;
  b=n8WGvNX123ARJJAA7zbK0dTG+Ha8OjU5mgrRRHKwax3UhCZbTNZmzf1K
   MJMjJZyFLwEwEHSQ2PPNBUMMmK/gmTp8LUZSviB6qbcqRRQ00x/Mr/BET
   p7YcxfmDXIDsh1iAdGEhJd+KXnFGYYpyWiiexPsR3jnnHXY466oEK214r
   LwmocK9HzeZxzJDHtSAc15DAGXnRKrGvvTDufakhucHeGkt92PjGbFWUW
   hdyyjstjadNqnpzcMR39+lO3VZb7+1qxNGiOcOup0Tem4EkaHUSaftbjM
   THMbxiQZ0HEGJsx0EwtKiNNemPKPpN3uT4w3a0iQEgUTRMpZ8nkrsuLLp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250459088"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250459088"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="563802956"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:34 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 082E221016;
        Fri,  6 May 2022 15:58:29 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480w-Ks; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 11/11] ACPI: property: Read buffer properties as integers
Date:   Fri,  6 May 2022 16:00:25 +0300
Message-Id: <20220506130025.984026-12-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index d3f6d95e0fb19..f23d15abadd65 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1108,6 +1108,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
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
@@ -1163,18 +1167,40 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
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

