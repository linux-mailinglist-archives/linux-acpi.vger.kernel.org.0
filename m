Return-Path: <linux-acpi+bounces-7666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7662956D3E
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 16:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5464E1F23140
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705A2171E55;
	Mon, 19 Aug 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtLRLm6b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED90171E69;
	Mon, 19 Aug 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077795; cv=none; b=AqaYQUU/BIW/riMxDm1JsQzVcKK9GxCvSJ7Ys5rurxPSw9GvxX3962BuVsNqmhO9kM4ZCzIMVJMMt06T2E07OtEHYPzDnH1T9Ghj8hatA4izNcIfB+YuxF7QATNyzaYp01wlUMaJNPkboVZfDpIvWAyoFnfOLsCVb6+FVCM5Qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077795; c=relaxed/simple;
	bh=dmKhPReYD4J99q0uHP9FDEoqkLnDOYZIsfRxqA+9vEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBf/Xzo1tKw2z5hzB0ECCCiMurxiUdfuECRX+dLkhbPyybZFjESL9NAsxWhrm/LyPH+Ru/EnF+PmXbxVl79S4Y+W9OT1P2/QbGE1+P++CZw7yPdoyTcI8NfJA4J4Ha84Rr0opFoUeLt+56FYu38hyOawYff12b8RZovLBFeucrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtLRLm6b; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724077794; x=1755613794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dmKhPReYD4J99q0uHP9FDEoqkLnDOYZIsfRxqA+9vEc=;
  b=LtLRLm6bS5sMEwWJVn2dD71Q6JJfYWp7FiYoB9bep8mPEtuzDEKuTvc4
   hJxwq9gm9OOtLh/PWBad8lHyivtPrtfSOQdGMXqBN/MvNiD8CnCStnoNU
   nxYPx0A5HcC5iTfTaAzIVN4d8wiITbo7SjvNuGSJz/+Pdb/e1eB3YkLeO
   ncRqxQmylgM5lrRRRNbLXz8y+LZavRvPnA2+98NYggLsTrg5dBsiwKDkF
   eyJ7VopOT0rICVgsAWIKi4+kf3XRdXYrdSLJ+X6m9lrBAQOzGx2+NZ8Xc
   5+7PMDTniv3Zzav30iGmgCm+htT0nTWwaf+6Qpge7BGtSo48TxoY+pZ+a
   g==;
X-CSE-ConnectionGUID: EA7bml2LRw+D0cImCoAF7g==
X-CSE-MsgGUID: PcKnHIqDR8mVrmdKPvxHzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33744482"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33744482"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:29:53 -0700
X-CSE-ConnectionGUID: cWTko2zsSySHfiu6rbz7rA==
X-CSE-MsgGUID: fUdlcGbNQu6V+ySKIVw48w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64783796"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 07:29:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3C76751C; Mon, 19 Aug 2024 17:29:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/5] gpiolib: swnode: Unify return code variable name
Date: Mon, 19 Aug 2024 17:28:57 +0300
Message-ID: <20240819142945.327808-3-andriy.shevchenko@linux.intel.com>
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

In one case 'ret' is used in the other 'error'. Make the latter
use the former, i.e. 'ret'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-swnode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index cec1ab878af8..e7ba6cc73966 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -67,7 +67,7 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 	struct fwnode_reference_args args;
 	struct gpio_desc *desc;
 	char propname[32]; /* 32 is max size of property name */
-	int error;
+	int ret;
 
 	swnode = to_software_node(fwnode);
 	if (!swnode)
@@ -79,11 +79,11 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 	 * We expect all swnode-described GPIOs have GPIO number and
 	 * polarity arguments, hence nargs is set to 2.
 	 */
-	error = fwnode_property_get_reference_args(fwnode, propname, NULL, 2, idx, &args);
-	if (error) {
+	ret = fwnode_property_get_reference_args(fwnode, propname, NULL, 2, idx, &args);
+	if (ret) {
 		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
 			__func__, propname, fwnode, idx);
-		return ERR_PTR(error);
+		return ERR_PTR(ret);
 	}
 
 	struct gpio_device *gdev __free(gpio_device_put) =
-- 
2.43.0.rc1.1336.g36b5255a03ac


