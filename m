Return-Path: <linux-acpi+bounces-9132-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A4C9B6922
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870301C213A9
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FE62141D8;
	Wed, 30 Oct 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaYyuMUT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C01F4700;
	Wed, 30 Oct 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305681; cv=none; b=Mg6BjGW5djwNANI1DxVbQSt7NQOnW40WXWjkG5Bn7cnHRopcdcQOTgtO76HQnifUvg4ZqIsMsWWn6336pkmDedGbKo1XirwuNCYzUk6cIVTMl7yrgOpzyUVowIPjb9VkVvkmcmvxvbROiG+JHRyh+MxDeVtwkP2Ew4Kn3dKFAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305681; c=relaxed/simple;
	bh=YapAEOo9WUhqkrcilX9GGul5Pc60jS1Np0QltkjGLZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utw9EUXy7itWx9KfMPeXAaKl4NTFWX/kOWBD8og/geXaZbs879m8Eik3yN/4w8nYSIeHEgTa8Mh4JUxGGolEN/LWXl1glVlefFKdNRetShMnB6nPAnEnchNxxT5rDuTsnpNws4Do4hNHRKrJ2F6xCgLvjDt3+RQQYoeq5QGqR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaYyuMUT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730305679; x=1761841679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YapAEOo9WUhqkrcilX9GGul5Pc60jS1Np0QltkjGLZk=;
  b=PaYyuMUT8IQwmz2fGukhArT9Edd3AtC61M/TzpT+IwtJlhlYy9KU7Ouv
   nay/E5hauGs5R7Swl2DP6XHkkRAqRTH8ZTlSvVMnQEllG4QFWId6V+Bmw
   zaXLvu6yH7UplSDyysmY6bKxzwmJw6vA4nDeNpFXorfS2yKlOJ8B7g+qY
   wKRP9oF0GYdpxvJNMsPZvMSFRaThgYIxHtGLsb4/8CammlLdIdc3wiNVv
   F2VUT5BnduRD9brk++T2PRCSv9dEFB3sfrXM48RV8PCPgWSSyZBVzZ6hR
   iGTqNKmvL83SllXbYK9my+b05qeCTomEsh1XteFhyZSZs4sPMGXp1w7D0
   Q==;
X-CSE-ConnectionGUID: mvwh/d6PTx60jSckoQOqMg==
X-CSE-MsgGUID: f0S6A/GrSl6Wo6cOmHCtDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30166942"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30166942"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:27:59 -0700
X-CSE-ConnectionGUID: oAlqyCWUS7ioDloAwnDYlA==
X-CSE-MsgGUID: C1D5emNQTdmCxB77faLgCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="113217111"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 30 Oct 2024 09:27:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9212F1CF; Wed, 30 Oct 2024 18:27:55 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: battery: Check for error code from devm_mutex_init() call
Date: Wed, 30 Oct 2024 18:27:54 +0200
Message-ID: <20241030162754.2110946-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using devm
variant of it. Tomorrow it may even leak something. Add the missed
check.

Fixes: 0710c1ce5045 ("ACPI: battery: initialize mutexes through devm_ APIs")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/battery.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 66662712e288..70f706d7634f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1226,8 +1226,12 @@ static int acpi_battery_add(struct acpi_device *device)
 	strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
-	devm_mutex_init(&device->dev, &battery->lock);
-	devm_mutex_init(&device->dev, &battery->sysfs_lock);
+	result = devm_mutex_init(&device->dev, &battery->lock);
+	if (result)
+		return result;
+	result = devm_mutex_init(&device->dev, &battery->sysfs_lock);
+	if (result)
+		return result;
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


