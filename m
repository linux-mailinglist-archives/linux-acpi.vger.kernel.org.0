Return-Path: <linux-acpi+bounces-11779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E2A4E14F
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 15:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8E73A51D6
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E7525D1F8;
	Tue,  4 Mar 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTThw6LO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F225CC9A;
	Tue,  4 Mar 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098685; cv=none; b=Ws47y9uCjdrSK8pP3ELWPeQxuwE+qd8qXEPYFl9VtsIwVwYLCTR6cuGBRtrW6LZ9Cz6VjCuA811yNEqiZcS8JphVo6QkS8GnnKgKX1IrfvDc5yqzCTUW+T7vSz5YyZnJNDtnOI0BXGGZIgaMUIK49IPLTI73jjFRREE7s/C0gK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098685; c=relaxed/simple;
	bh=0JUk0DCDRh3TUcCv++gk4WNLQRgMRu2NMHQHfZboClM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMjShAHMqyD/28si4me1VI1h/yrkTgCgJ3+eZ2y4QaR0eFxFKLr1qW5riS8p0syeiox04MUa4dOEi7XOkae/vKige8nmkEZfU89rUgmxwwz5uFSuU0BZFgkX++ADk/QWR53IsOu70KozmSuDM4iAESZtBiKk3+kFgd/HEpUHDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTThw6LO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741098684; x=1772634684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0JUk0DCDRh3TUcCv++gk4WNLQRgMRu2NMHQHfZboClM=;
  b=TTThw6LO7+0nMaJqt2K3x3XI2tUlB0nligkotrb/kPUCj2QanhQUck6t
   OOqnL8URsXIFSkfyvbmczQiMrkk2LhPtEUKfmQU/ZHtFBXC7cnM8HVhUj
   w9+iKLVv4EVN00Byb9SmjYycKh81G7b5zHPwRaYIBaXd39APwOyw1FAq1
   OxIHQ8mWKQ/1ilZEEp4SxDNsiBLLTjnIvRi3W8P4BP4v79eGeV9qRxr10
   Ewjmg8AhvsXlEU4VeCE1Tc0ivPjqlvYkjV7+l1e+fpXfvXHB0Dkk/wcnA
   ccOe/mYbqM8T+0FS8a5pji5/uFrRKdUJUq2sgzqqMkqczjwydg4Qm40Ac
   A==;
X-CSE-ConnectionGUID: r3RWjMP9TMiwdJ2bPZm7HQ==
X-CSE-MsgGUID: SZL7kIJlTtSbBqpej2n2KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52662444"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="52662444"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:31:23 -0800
X-CSE-ConnectionGUID: hYhul2DrSD2QjKwno/QDTA==
X-CSE-MsgGUID: 1QWI6P1UQfepxNTrIAdXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118394499"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 04 Mar 2025 06:31:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 317BF27D; Tue, 04 Mar 2025 16:31:19 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpiolib-acpi: Drop unneeded ERR_CAST() in __acpi_find_gpio()
Date: Tue,  4 Mar 2025 16:31:19 +0200
Message-ID: <20250304143119.1816463-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checked type by PTR_ERR() is the same as returned by __acpi_find_gpio().
Hence there is no need to cast, drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 2aa88ace5868..90db393377fc 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -993,7 +993,7 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 			desc = acpi_get_gpiod_from_data(fwnode,
 							propname, idx, info);
 		if (PTR_ERR(desc) == -EPROBE_DEFER)
-			return ERR_CAST(desc);
+			return (desc);
 
 		if (!IS_ERR(desc))
 			return desc;
-- 
2.47.2


