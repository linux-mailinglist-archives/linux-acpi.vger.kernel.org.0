Return-Path: <linux-acpi+bounces-12693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A38CA7A770
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925AF189787C
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8784F2517BE;
	Thu,  3 Apr 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFXehhq7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF953251796;
	Thu,  3 Apr 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696058; cv=none; b=t1+1aGT/nYf/yM0ZzKZfgULJMLScFXXFou/qjxQCtbxSMMOwHBZtSWuYai1gIuIVWOwKByVW4tSJi4zaCWuwqGT5BSXU4Yee4RwL+OXvL7lox2MYNT/I7i7SPDQAIX7FjDLr52MrAUyGX+gap6c/+nw406cVtuSQX7U2W9IX7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696058; c=relaxed/simple;
	bh=zi/0itXjLWX25lyreRTOs04H8X0b6Vm47Emh2xv1hAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDDotZW7mhrb483/QV9NN+lB3WAfpeHh/YszG0EYAR6mqbJqJnK149DKyMXT41dTjRK/C/GwgLkRKcYTGbERI01qFOVgLrZmH6et2zNLDB7RI4KVkTuKfsKfzAkj/UNsHIKbzjTxGuFkUX1Z/eYJBk6/YEKMSjhVr+bvpEaV3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFXehhq7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743696056; x=1775232056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zi/0itXjLWX25lyreRTOs04H8X0b6Vm47Emh2xv1hAA=;
  b=VFXehhq7B2S5nZ+rmas56ne7alcZlntP2jbQRtC1hFm1uMyGV3YYWRP0
   e0Di7k2z1FC347EYBUMveGSLajZBx6RtWR7j15ebzU7Vasa+uVm99fZMg
   7g32vIZGt8ueY1OZpy7e1fIO8jseasbyyvBqWHsph3nPuxClAtpLIxPHn
   SqygVy42NAEQ5P1lQVtSqcCae339Q988HXhPka870PsdniJKu3GUKAEsz
   bNBY0iN/pe+XYOefhxuKrXBla4RpKMMy1zNAnGGhzFl7lCvs65Fx1Klv3
   qShYGDytToKy47Rm5uXAga1JQ+e3ZLnwafP4/FNYYsLBplC3MBHBpLJbi
   A==;
X-CSE-ConnectionGUID: YR120+xpQF2OHWZKxkDnuQ==
X-CSE-MsgGUID: Zvm5LHJlSligPmcKQONJWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="44369234"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44369234"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 09:00:52 -0700
X-CSE-ConnectionGUID: BLo9hNJPTIe+0GcLGLcoxQ==
X-CSE-MsgGUID: NXJHmboGS52qmYKbTNXC/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="158036300"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 03 Apr 2025 09:00:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 53AE1245; Thu, 03 Apr 2025 19:00:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 4/6] gpiolib: acpi: Rename par to params for better readability
Date: Thu,  3 Apr 2025 18:59:15 +0300
Message-ID: <20250403160034.2680485-5-andriy.shevchenko@linux.intel.com>
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

Rename par to params for better readability in acpi_get_driver_gpio_data().
No functional changes intended.

Requested-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index afeb8d1c7102..d6e9563d9364 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -653,12 +653,12 @@ static bool acpi_get_driver_gpio_data(struct acpi_device *adev,
 
 	for (gm = adev->driver_gpios; gm->name; gm++)
 		if (!strcmp(name, gm->name) && gm->data && index < gm->size) {
-			const struct acpi_gpio_params *par = gm->data + index;
+			const struct acpi_gpio_params *params = gm->data + index;
 
 			args->fwnode = acpi_fwnode_handle(adev);
-			args->args[0] = par->crs_entry_index;
-			args->args[1] = par->line_index;
-			args->args[2] = par->active_low;
+			args->args[0] = params->crs_entry_index;
+			args->args[1] = params->line_index;
+			args->args[2] = params->active_low;
 			args->nargs = 3;
 
 			*quirks = gm->quirks;
-- 
2.47.2


