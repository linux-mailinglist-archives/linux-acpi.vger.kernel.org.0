Return-Path: <linux-acpi+bounces-10882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A6CA263FA
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Feb 2025 20:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA064165F6B
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Feb 2025 19:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E7C1D47AD;
	Mon,  3 Feb 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEvInlyL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE825A623;
	Mon,  3 Feb 2025 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612042; cv=none; b=X1qfxk1ck4kEsoylVmDjKKqss0OKhT/IsmORWySIb7qljmQQvvetKiX7guFCtZVAnrcqwhTtQ9cnBxPKcP1jr20nx9/vCfRpma5d2gsnFJxcAlnRzTBiE45B78N4d/9VemPtMzboDkHaQ9N1h1VwuBRyU0Wp5qg1r7/+2Arn2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612042; c=relaxed/simple;
	bh=m4U7xFFLg++Pozd3+X5web1+L1b+FX/ZNZOJPseBAAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCWue0/5V96nkRMgHw/vit5QHms8R6H9EB7ZtB90igLHT2HNXN2xEWiPl7Pv+9SE2UfOwtmDCGkMZ6LnRtJGTYcTrVRMdYfW5UR/eRYJUYKADncXqEa9L+vpDFLBsbwTnvJy5F1lEAVqNovCeBXxHm2ugnj/YOcug1fyflD7yM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEvInlyL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738612042; x=1770148042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m4U7xFFLg++Pozd3+X5web1+L1b+FX/ZNZOJPseBAAg=;
  b=GEvInlyLXHF6ivxZ9eDOjXd+Ywu+UL4KDyfAURyPb58bwno7qRYolaKO
   ETOwjExk3jgTWHa+GlWi3C6hLFa93kSvPFzrEwuWv6wNUfFWnxdOoORmY
   10EVqXR2hdpSN0fTIRFrjJ5pWiPgvEnP9mlOpWBFbht0BCTyBgonbP2h1
   cSTGyxCWhYTrzTUICgp4MelWhjO6LWAbDo5VKj0JsrWER55/jMvAo60oV
   0PYl5OJhI9JQv0DIx7FKvgQT4I3rT6hqNh7PsPbtLwbZkqDvulVg04itQ
   uyHgCG2b+CD7ootcWxLI2CXh4XQ9N/Z6V/9DdnfuGQ7EOfIhHVWTX+ajR
   Q==;
X-CSE-ConnectionGUID: wBdGAbWZRsGA4tgaovkRmg==
X-CSE-MsgGUID: P7GGv4KIRl2HQKMpKvd9wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="50113353"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="50113353"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 11:46:34 -0800
X-CSE-ConnectionGUID: 3Vag7cZCSIG8K9QW4q7I0Q==
X-CSE-MsgGUID: jv3KzLAjSr68hzjQJA5O4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="115404791"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2025 11:46:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 84BB723F; Mon, 03 Feb 2025 21:46:30 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] ACPI: property: Fix return value for nval == 0 in acpi_data_prop_read()
Date: Mon,  3 Feb 2025 21:46:29 +0200
Message-ID: <20250203194629.3731895-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While analysing code for software and OF node for the corner case when
caller asks to read zero items in the supposed to be an array of values
I found that ACPI behaves differently to what OF does, i.e.

1. It returns -EINVAL when caller asks to read zero items from integer
array, while OF returns 0, if no other errors happened.

2. It returns -EINVAL when caller asks to read zero items from string
array, while OF returns -ENODATA, if no other errors happened.

Amend ACPI implementation to follow what OF does.

Fixes: b31384fa5de3 ("Driver core: Unified device properties interface for platform firmware")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1144c2368d89..7d7f4974c5b1 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1189,8 +1189,6 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 			return -EOVERFLOW;
 		break;
 	}
-	if (nval == 0)
-		return -EINVAL;
 
 	if (obj->type == ACPI_TYPE_BUFFER) {
 		if (proptype != DEV_PROP_U8)
@@ -1214,9 +1212,10 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 		ret = acpi_copy_property_array_uint(items, (u64 *)val, nval);
 		break;
 	case DEV_PROP_STRING:
-		ret = acpi_copy_property_array_string(
-			items, (char **)val,
-			min_t(u32, nval, obj->package.count));
+		nval = min_t(u32, nval, obj->package.count);
+		if (nval == 0)
+			return -ENODATA;
+		ret = acpi_copy_property_array_string(items, (char **)val, nval);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.43.0.rc1.1336.g36b5255a03ac


