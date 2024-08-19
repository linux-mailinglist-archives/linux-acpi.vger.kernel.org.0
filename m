Return-Path: <linux-acpi+bounces-7661-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F1F956C05
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 15:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1ED1C238CC
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5699E175D46;
	Mon, 19 Aug 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ig0qMFJ1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524E16CD2B;
	Mon, 19 Aug 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073928; cv=none; b=PG714vw9syVWDmc6HZXSLHkhJ8clXhoQ/Q/77iwEu74+abCS6N5/9df9w7n2SwCobr/Fh9sd0dBLXwCxCDhzTeQ/oLZ/wkUO+DxLehTvES0SdkaWnoksN2VOk1FKJJTzjnFQOyzWZ4CsOrUuJSg8tF7jdm9brrjSF4Vr1Urwusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073928; c=relaxed/simple;
	bh=+5ZWeQfq9pc8g+Da+jIQ//Boi20g3garQCTXou+6Uts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c444oIgVDE40b0qv5D14/v3tlMQjBzOHjBOS9oBr1c/tIBOMg54HkVoLAfPcCBSuBEmRBMSpI83ViuBY1+ifyFD6FDLpCr3lAs2fH0PxQZe2AuGihhceVv50ppRCRggtBE35yARnvdTIBCVXmH4iY8Y83BEHc08VZzF42eBnrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ig0qMFJ1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724073926; x=1755609926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5ZWeQfq9pc8g+Da+jIQ//Boi20g3garQCTXou+6Uts=;
  b=ig0qMFJ1hEnyDAOjG01AI083t/VCQ2JnEXpdrJOThs2RTmw5+A5NZGhD
   oEnb+Ub6rPfVGeRI+Q3wf+p6ktGoSo4mGW9MpBRuaE2rzzMBOG2QRm6rQ
   PS6apHRB1Zkne7VDw1IaJJRtDJfEoKeLMSA4jFESPxn8QFBeWAzpsbyPR
   /l4umqKaPeJDO+dFmsu9ArMyA+JhThxY4oTXSgUhjHqSKrxTH9UoDGjG/
   bQqVmfKZIxb25C2lG1qVJ6Idy7pNfDAfl8LciUfUFH0SaJm5YScgFjpeG
   lCw8i1JOmpuzfwBu8rzB5RTvFUHVuk3p3s4RSBQhU27q5KGyH6IBBG92s
   g==;
X-CSE-ConnectionGUID: jw+m/q7HTdaW9dK62P+Rgg==
X-CSE-MsgGUID: TDfBjuDKSOGBfiVvLemA6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22462709"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22462709"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:25:05 -0700
X-CSE-ConnectionGUID: OYgQGcj8TU+ZqdCWUiD80g==
X-CSE-MsgGUID: E1WrySN9QlmHec6dItHoSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64531827"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 06:25:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E600751C; Mon, 19 Aug 2024 16:25:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 3/5] gpiolib: swnode: Introduce swnode_gpio_get_reference() helper
Date: Mon, 19 Aug 2024 16:22:45 +0300
Message-ID: <20240819132458.208677-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240819132458.208677-1-andriy.shevchenko@linux.intel.com>
References: <20240819132458.208677-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of the spreading simlar code over the file, introduce a helper.
It also enforces the nargs validation for all GPIO software node APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-swnode.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index e72576908d8f..8dd3c1a5dc55 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -59,6 +59,17 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
 
+static int swnode_gpio_get_reference(const struct fwnode_handle *fwnode,
+				     const char *propname, unsigned int idx,
+				     struct fwnode_reference_args *args)
+{
+	/*
+	 * We expect all swnode-described GPIOs have GPIO number and
+	 * polarity arguments, hence nargs is set to 2.
+	 */
+	return fwnode_property_get_reference_args(fwnode, propname, NULL, 2, idx, args);
+}
+
 struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 				   const char *con_id, unsigned int idx,
 				   unsigned long *flags)
@@ -75,11 +86,7 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 
 	swnode_format_propname(con_id, propname, sizeof(propname));
 
-	/*
-	 * We expect all swnode-described GPIOs have GPIO number and
-	 * polarity arguments, hence nargs is set to 2.
-	 */
-	ret = fwnode_property_get_reference_args(fwnode, propname, NULL, 2, idx, &args);
+	ret = swnode_gpio_get_reference(fwnode, propname, idx, &args);
 	if (ret) {
 		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
 			__func__, propname, fwnode, idx);
@@ -128,8 +135,7 @@ int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 	 * 1 or 2 entries.
 	 */
 	count = 0;
-	while (fwnode_property_get_reference_args(fwnode, propname, NULL, 0,
-						  count, &args) == 0) {
+	while (swnode_gpio_get_reference(fwnode, propname, count, &args) == 0) {
 		fwnode_handle_put(args.fwnode);
 		count++;
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


