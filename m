Return-Path: <linux-acpi+bounces-12690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F898A7A763
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B153B70E8
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82E2512DF;
	Thu,  3 Apr 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="be4NgbCF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335D250C19;
	Thu,  3 Apr 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696051; cv=none; b=ckkftzseACObZNqvMjqgrK6Kh1qtARMemUR6Aue4aL9C+noMNZ4lh8/gYlH2Bm2vGSdaUlqpZp+OH6+lbWpCQBAuzX4gwytZH8FGZ39SKULGmIQxn0ImHW2mUu2agaLyQYS5bYsMO5bCPrF/dLgIqXbgI4td/ENf+EC9w3pdcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696051; c=relaxed/simple;
	bh=iZYIMc6tqqQjamxndLTziI4yLhoLETWBDIAWhz1dFLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJlJn20lTYuRcpmmLNyG7NfftY76uoQQpX8ZCKMxcCd+Nq7Yca0t2+nWyWAPMZpH/QxUkTZtBL8Ztm0hKhKCn+5gos5E6DgGKdloAkt+Br/EzTNKqgxcqpEV061pObqybGrEGf9QxSuOifaEN0vVRqAr45V6+d64bxRdirW+hAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=be4NgbCF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743696050; x=1775232050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZYIMc6tqqQjamxndLTziI4yLhoLETWBDIAWhz1dFLQ=;
  b=be4NgbCFpFh3rxXVe22YZ6K8E65bK0IGwvdaly+5evAoKsC1Y7Lsafna
   trfhN3W/bYptaTi0xCVoTt/6grixTjR3orhFj/oxnD6io1ttyX+bBA+P3
   nQgSeUD4R1Rh2dYROzOYNjlArOVf9XeF/Nrg3qEiDt4a+90e0U351wKBr
   f/ZjBXJKQLiq4VEgvr33HcwcU7E84G09caEsEGU31XrNqT1oZEDNimuO3
   hzMVcxbagtk4qaDFn70Rb9kpdVhJoXMcWoR7BE0WqWgn8LpoMphl+exjY
   4bVbV7q4Is1Y8XdKXZQkiTHmoY9Alyn/Q6hEyKu3hApuXo4w9RPVJzhxY
   g==;
X-CSE-ConnectionGUID: N+KKVia3RbqQgfp7DGsdKA==
X-CSE-MsgGUID: dBTrUlERS/a8NCnnThvXBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="32716811"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="32716811"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 09:00:39 -0700
X-CSE-ConnectionGUID: 8xJgQ5D5QYKulp3uRIvluA==
X-CSE-MsgGUID: FFgZtgaaQV2RusdiN9NVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127036146"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 03 Apr 2025 09:00:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3CA981BC; Thu, 03 Apr 2025 19:00:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/6] gpiolib: acpi: Remove index parameter from acpi_gpio_property_lookup()
Date: Thu,  3 Apr 2025 18:59:13 +0300
Message-ID: <20250403160034.2680485-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
References: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In all cases the supplied index is the same as the passed one in
the struct acpi_gpio_lookup. Remove index parameter and reuse one
from the struct acpi_gpio_lookup instead.

add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-14 (-14)
Function                                     old     new   delta
acpi_get_gpiod_by_index                      462     456      -6
acpi_gpio_property_lookup                    425     417      -8
Total: Before=15375, After=15361, chg -0.09%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 878b11c81c7b..afeb8d1c7102 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -830,17 +830,17 @@ static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup,
 	return 0;
 }
 
-static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
-				     const char *propname, int index,
+static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *propname,
 				     struct acpi_gpio_lookup *lookup)
 {
 	struct fwnode_reference_args args;
+	unsigned int index = lookup->index;
 	unsigned int quirks = 0;
 	int ret;
 
 	memset(&args, 0, sizeof(args));
-	ret = __acpi_node_get_property_reference(fwnode, propname, index, 3,
-						 &args);
+
+	ret = __acpi_node_get_property_reference(fwnode, propname, index, 3, &args);
 	if (ret) {
 		struct acpi_device *adev;
 
@@ -905,8 +905,7 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 	if (propname) {
 		dev_dbg(&adev->dev, "GPIO: looking up %s\n", propname);
 
-		ret = acpi_gpio_property_lookup(acpi_fwnode_handle(adev),
-						propname, index, &lookup);
+		ret = acpi_gpio_property_lookup(acpi_fwnode_handle(adev), propname, &lookup);
 		if (ret)
 			return ERR_PTR(ret);
 
@@ -955,7 +954,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.index = index;
 
-	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
+	ret = acpi_gpio_property_lookup(fwnode, propname, &lookup);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.47.2


