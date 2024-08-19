Return-Path: <linux-acpi+bounces-7670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA2956D4A
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58F1284C01
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A43176AA3;
	Mon, 19 Aug 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/jZa4U7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595261741DC;
	Mon, 19 Aug 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077799; cv=none; b=Xo37jqNAMXakX7qFr/WgKrLVz0ps4rY1feoh74n4K4/aay6bsla7KtI4Z/GUyLEqGSRZoLA+LjdeSbyzSc3Fx7SqASfATo879wB00ZclbtMaoWmfuMuICYhb4ajH0c0mRHEYP5/XKv9PU3r+CuZfZnYqNh+ein5gwNwCHVnEAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077799; c=relaxed/simple;
	bh=rFuwdwcbQYp8sy5sHNy4OFa8J5BoSjowDcZF++YteB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSfmwq8KJfuUbI4mnbjOfnlcmy+WsZIZkZ2gXE+E0leBEofsFkZFLVmqnH6TPNM265AkWVmFZfS6tz7RLPTfaBbMsAJzRr1vV3TCSuuDKp0EshkolK0EGKtEjs8Ju1cnjywAK9TQfoXDfij4pCieDpXk/9qToF9mZvXTvfNASK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/jZa4U7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724077798; x=1755613798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFuwdwcbQYp8sy5sHNy4OFa8J5BoSjowDcZF++YteB0=;
  b=Z/jZa4U7qKrEQEAZIq8tBewCE/GgEhSjdXo0BgB6OQUZ1yg+CGcvgMDu
   bNw13pBAgRr4jMW6vy3RXuXWCl8gn7cZGNN2jKrvLjkYm0+VecA7eVQVP
   OBn8zbZn+oa1ElV0JZixO3Yw88aH2Y6+nowkFYB4z9ihz2NM3d34rufty
   gfaRuSN2q9JxQBQcwlGB2vC4uQ2dQRIHfa+sJwPENBBm/ZkpObMQGOelF
   GsHFAybr3oJsyXdjckR546ZrYILttqayVO1b8rrSriGRfCptGMSNqhakk
   sLuexj+mOe2mlKZCsnS0Ubd85EzkVMd67IufCFRPeLUB6bPcYM6o8Cgfa
   Q==;
X-CSE-ConnectionGUID: dUHzdR+jR7idL1cluImErQ==
X-CSE-MsgGUID: nkQf8t19RA2vvJSKkWeMgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33744485"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33744485"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:29:53 -0700
X-CSE-ConnectionGUID: h1FjunUMQgmIcbwYzZk/0A==
X-CSE-MsgGUID: kmiOfzEQQLiS4F+RL2FwCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64783797"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 07:29:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 505A15CF; Mon, 19 Aug 2024 17:29:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 3/5] gpiolib: swnode: Introduce swnode_gpio_get_reference() helper
Date: Mon, 19 Aug 2024 17:28:58 +0300
Message-ID: <20240819142945.327808-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
References: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
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
index e7ba6cc73966..d5e58a9673b5 100644
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


