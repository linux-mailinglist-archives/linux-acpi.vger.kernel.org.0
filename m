Return-Path: <linux-acpi+bounces-7658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942B1956BFC
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 15:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D672866B2
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0480716CD0E;
	Mon, 19 Aug 2024 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RS+OQT1r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6F16BE27;
	Mon, 19 Aug 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073910; cv=none; b=kRbBhG5phI1ouagmI4dxcaW5HwWh2mflobLx3fbyI3zJ6/679ZOs/6OL68IS5su0Zx6/dm8XXKpVgW1slX27jQSPusi8uzT3c1lMLNZJTCgIbWiCXfiobj878+nLF77zr6phf9xJFouOkIM131Mv5lzllkKcNXZ+k8/voxkrYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073910; c=relaxed/simple;
	bh=hLCbDRbO3vEot9Et5IQ5IhvldkSR77khW+PBp6rjsHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpdzsiBQx5F/3w+IccBmYk4uhopUHZKEqnWt6susqBSimHNR1psGdciuz0rUhXnMI1OEeoq/35FzJ8O8ONfGeBhnV3ByQdWmsKJLu/WmbwIz6R+Z1j0ZujQvbB+n/znCRCrA8XGQu18sfCTKfslInLSU/IxJcIhH1ZRHXeNoyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RS+OQT1r; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724073909; x=1755609909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLCbDRbO3vEot9Et5IQ5IhvldkSR77khW+PBp6rjsHc=;
  b=RS+OQT1rx1uaWx7+MXRphZ8X5jUtu/863Ep7B6/V1GczratwOdT2KSxB
   SoSGXfXAGVWJnX37ZcGzrPdgAc+UheFTo94rzbIWJifkoLbsKdgy+l82l
   ahcNlekihWqc2lCyQyNSPgjKH1Gi37/uZYpwzrBdSU/OmesR/pAlRq1LH
   CyK0avq1fhs9wH+0RiiO0GuPD7uJ7qRo17nwYa23ztVRIlIcaJqEGP9oW
   0FQtTBlugKtxJXbDGwRj+Z2LsVzGi8wnYY5zc2nTBQWhwiwC28v+NDGsm
   wsglbD5MMLr5gwyPrxfft7KruLoNg9uUtqJ9R67rvyGBq2dk9LVpRVgti
   w==;
X-CSE-ConnectionGUID: NQNrUPwvRsOOKk/fNrjCxw==
X-CSE-MsgGUID: IgQpJQt0Q0WvyeizQ6gmUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="47718618"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="47718618"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:25:08 -0700
X-CSE-ConnectionGUID: fzK9yMD2SFGxB9XEqFbMSg==
X-CSE-MsgGUID: /rvbQcs/S2iTvb7SBr2HNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60211764"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 19 Aug 2024 06:25:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E04A4562; Mon, 19 Aug 2024 16:25:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/5] gpiolib: swnode: Unify return code variable name
Date: Mon, 19 Aug 2024 16:22:44 +0300
Message-ID: <20240819132458.208677-3-andriy.shevchenko@linux.intel.com>
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

In one case 'ret' is used in the other 'error'. Make the latter
use the former, i.e. 'ret'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-swnode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index 0578e1be159f..e72576908d8f 100644
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


