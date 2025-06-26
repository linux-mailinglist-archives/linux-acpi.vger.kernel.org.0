Return-Path: <linux-acpi+bounces-14689-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470A8AE9E10
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 15:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E2C1C416F5
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929632E4269;
	Thu, 26 Jun 2025 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q28LkwpJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D82E336E;
	Thu, 26 Jun 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942876; cv=none; b=c1aKcSXYjTQ7QGOSPTd8Bm2UoHD9yIhDIFX8oZfwujmajEBNr7FOScnezRe00qt6oZLr8L6Al9QGs5c7pWT4oeOmSXsMtBFMV1c4jHZzoHeL1oeil85pBBdZjgnuoitK0hpcqN8nBSRxy5gYXB7jQCKtmAf10cKHsZy2DhB86yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942876; c=relaxed/simple;
	bh=yIokvzezyxkaDoR3N6Db1QnHti3wLHxdRvurH4Gd3hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CiAX0H22kCBiKqX8ovzyD/ymhUYKHmyxqBoQSdldMNyxIKTE2rSp+nDLIP8Yq+cH3rFwNoo8xKsBs2O8G8G7M+H8yFw86jvB9rn8B6vsVhZ5mPwE4KI/MkNHEFMynzUs0rL7usVt5xo3q5uAkE0bAIP3rJIiS2AbJlndHuxHyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q28LkwpJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750942875; x=1782478875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yIokvzezyxkaDoR3N6Db1QnHti3wLHxdRvurH4Gd3hQ=;
  b=Q28LkwpJD91V9C2PpGlriGKY1Ti1Crda0ka8xO2wHlCYkD5b1bOfp6gx
   LG7h7IPLDQivtRi59e0Td4V1YIppR0t6yx1Etv+lFWQbIxiUSMkbqbUoC
   pquddECptbu18NylqIYgYMjLnOLc0LAwSIWxFK0arZmdw3v3vQed79lWt
   hY5SV0AE6Uhj4XYfqRoB04hSWA2bB+Au1wMhEnsjEi6sTflGTo07aDC9M
   PWPZhQEW6AyTjmSO2Vrv+mhfaa+PvR5xTu8yRHC1NnZoHHgfe1TTW/9Ug
   CJg+G2NHlH4Gn1OhiGfpzYXuPyNvsmzunuo1robCzmJbqvPeAyfOdYui6
   g==;
X-CSE-ConnectionGUID: ffUVeZtAQburegXcMPnnAw==
X-CSE-MsgGUID: T9TpO67TTeSVhUfyVN7umA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="78672894"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="78672894"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:01:14 -0700
X-CSE-ConnectionGUID: Om+uTs5ZRLepCITQ05kCIw==
X-CSE-MsgGUID: 4veAPY2LToqV56gdbka4rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="153014283"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 26 Jun 2025 06:01:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 650952E2; Thu, 26 Jun 2025 16:01:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] Documentation: firmware-guide: gpio-properties: Spelling and style fixes
Date: Thu, 26 Jun 2025 16:01:09 +0300
Message-ID: <20250626130109.215848-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Use consistent style for active-high and active-low
- For C and ASL code snippets use 4-space indentation consistently
- Interleave case examples with the explanations of the certain case
- Remove or add commas when appropriate

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../firmware-guide/acpi/gpio-properties.rst   | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index db0c0b1f3700..5addf7aaa833 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -6,7 +6,7 @@ _DSD Device Properties Related to GPIO
 
 With the release of ACPI 5.1, the _DSD configuration object finally
 allows names to be given to GPIOs (and other things as well) returned
-by _CRS.  Previously, we were only able to use an integer index to find
+by _CRS. Previously we were only able to use an integer index to find
 the corresponding GPIO, which is pretty error prone (it depends on
 the _CRS output ordering, for example).
 
@@ -49,11 +49,11 @@ index
 pin
   Pin in the GpioIo()/GpioInt() resource. Typically this is zero.
 active_low
-  If 1, the GPIO is marked as active_low.
+  If 1, the GPIO is marked as active-low.
 
 Since ACPI GpioIo() resource does not have a field saying whether it is
-active low or high, the "active_low" argument can be used here.  Setting
-it to 1 marks the GPIO as active low.
+active-low or active-high, the "active_low" argument can be used here.
+Setting it to 1 marks the GPIO as active-low.
 
 Note, active_low in _DSD does not make sense for GpioInt() resource and
 must be 0. GpioInt() resource has its own means of defining it.
@@ -231,8 +231,8 @@ In those cases ACPI device identification objects, _HID, _CID, _CLS, _SUB, _HRV,
 available to the driver can be used to identify the device and that is supposed
 to be sufficient to determine the meaning and purpose of all of the GPIO lines
 listed by the GpioIo()/GpioInt() resources returned by _CRS.  In other words,
-the driver is supposed to know what to use the GpioIo()/GpioInt() resources for
-once it has identified the device.  Having done that, it can simply assign names
+the driver is supposed to know what to use from the GpioIo()/GpioInt() resources
+for once it has identified the device. Having done that, it can simply assign names
 to the GPIO lines it is going to use and provide the GPIO subsystem with a
 mapping between those names and the ACPI GPIO resources corresponding to them.
 
@@ -252,9 +252,9 @@ question would look like this::
   static const struct acpi_gpio_params shutdown_gpio = { 0, 0, false };
 
   static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] = {
-    { "reset-gpios", &reset_gpio, 1 },
-    { "shutdown-gpios", &shutdown_gpio, 1 },
-    { }
+      { "reset-gpios", &reset_gpio, 1 },
+      { "shutdown-gpios", &shutdown_gpio, 1 },
+      { }
   };
 
 Next, the mapping table needs to be passed as the second argument to
@@ -270,7 +270,7 @@ Using the _CRS fallback
 
 If a device does not have _DSD or the driver does not create ACPI GPIO
 mapping, the Linux GPIO framework refuses to return any GPIOs. This is
-because the driver does not know what it actually gets. For example if we
+because the driver does not know what it actually gets. For example, if we
 have a device like below::
 
   Device (BTH)
@@ -292,7 +292,7 @@ The driver might expect to get the right GPIO when it does::
 	...error handling...
 
 but since there is no way to know the mapping between "reset" and
-the GpioIo() in _CRS desc will hold ERR_PTR(-ENOENT).
+the GpioIo() in _CRS the desc will hold ERR_PTR(-ENOENT).
 
 The driver author can solve this by passing the mapping explicitly
 (this is the recommended way and it's documented in the above chapter).
@@ -318,15 +318,15 @@ Case 1::
   desc = gpiod_get(dev, "non-null-connection-id", flags);
   desc = gpiod_get_index(dev, "non-null-connection-id", index, flags);
 
+Case 1 assumes that corresponding ACPI device description must have
+defined device properties and will prevent from getting any GPIO resources
+otherwise.
+
 Case 2::
 
   desc = gpiod_get(dev, NULL, flags);
   desc = gpiod_get_index(dev, NULL, index, flags);
 
-Case 1 assumes that corresponding ACPI device description must have
-defined device properties and will prevent to getting any GPIO resources
-otherwise.
-
 Case 2 explicitly tells GPIO core to look for resources in _CRS.
 
 Be aware that gpiod_get_index() in cases 1 and 2, assuming that there
-- 
2.47.2


