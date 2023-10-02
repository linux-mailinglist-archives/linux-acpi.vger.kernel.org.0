Return-Path: <linux-acpi+bounces-328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CCE7B552D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8DFCF2830ED
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768B91A5BE
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 14:32:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CC2106
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 13:46:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1786DB0;
	Mon,  2 Oct 2023 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254395; x=1727790395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AwCB0JAqzDDtRO3CENNhM7InAKHdngeC3934G7S/Ok0=;
  b=XFj33XhlDvoY2MNL2MT37zWTqqrAJ49CwpC+5A3SZGNqP9FwMz/chY3A
   WkabLVuK81xfVDgrqR7lFJ/gTva31d4vRy12pWLMLBI6pBtOpYdh1tza3
   IF7mRCYkYqNg+fbJ9dU3Bnl5mdp2E9f0f/rzfEOf8SG5puCuCAo/bphIV
   DiNlzRHibxAxlFfpkJb+yXFt07QnShctrUMxWWJED53NaMq6Aym6ZbLSV
   o8T78a28QtWFEeW4+UzHhic4QoeXKnXL19V6E3isf98Kak/B/BTQGb0ls
   Din0SWfeLOkKd37tBgbfTFMx8apSa8ES92WxO716ck6miFACT3zkYTooD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="468919050"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="468919050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="894138443"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="894138443"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2023 06:45:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B84ED1A7; Mon,  2 Oct 2023 16:46:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/2] ACPI: property: Allow _DSD buffer data only for byte accessors
Date: Mon,  2 Oct 2023 16:46:29 +0300
Message-Id: <20231002134630.2601294-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In accordance with ACPI specificication and _DSD data buffer
representation the data there is an array of bytes. Hence,
accessing it with something longer will create a sparse data
which is against of how device property APIs work in general
and also not defined in the ACPI specification (see [1]).
Fix the code to emit an error if non-byte accessor is used to
retrieve _DSD buffer data.

Fixes: 369af6bf2c28 ("ACPI: property: Read buffer properties as integers")
Link: https://uefi.org/specs/ACPI/6.5/19_ASL_Reference.html#buffer-declare-buffer-object [1]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 413e4fcadcaf..06550d8c619d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1102,25 +1102,25 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 	switch (proptype) {
 	case DEV_PROP_STRING:
 		break;
-	case DEV_PROP_U8 ... DEV_PROP_U64:
+	default:
 		if (obj->type == ACPI_TYPE_BUFFER) {
 			if (nval > obj->buffer.length)
 				return -EOVERFLOW;
-			break;
+		} else {
+			if (nval > obj->package.count)
+				return -EOVERFLOW;
 		}
-		fallthrough;
-	default:
-		if (nval > obj->package.count)
-			return -EOVERFLOW;
 		break;
 	}
 	if (nval == 0)
 		return -EINVAL;
 
-	if (obj->type != ACPI_TYPE_BUFFER)
-		items = obj->package.elements;
-	else
+	if (obj->type == ACPI_TYPE_BUFFER) {
+		if (proptype != DEV_PROP_U8)
+			return -EPROTO;
 		items = obj;
+	} else
+		items = obj->package.elements;
 
 	switch (proptype) {
 	case DEV_PROP_U8:
-- 
2.40.0.1.gaa8946217a0b


