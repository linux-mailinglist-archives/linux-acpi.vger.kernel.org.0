Return-Path: <linux-acpi+bounces-12901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB051A8264E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 15:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B591D1B819C8
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D27264603;
	Wed,  9 Apr 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTUIYjSp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AEF2638B8;
	Wed,  9 Apr 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205390; cv=none; b=LHX3bdG+1Y6y0uv02lFwZY8t5EXfZ+j5JM6t2fgumJAq6EYXbmBMVRu8K+8MjtFaoKsoltdF1x99Ny1pFIs+mgjfLmtWj2gZX+6Chbzfx9G5aFfJI3VEuY+r1xlM9/VlsN/SfRZsAEYrBn+DrWCw7ewX1oaPR7cuKvxnoqUoMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205390; c=relaxed/simple;
	bh=WGqk/2EVEjZ1Rlyihh/W+qt1GXz6ybM69ER2KNQFH68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPIQ9THytergl0HQ3YYAMzBvidi0c4rV43wdUIcJJtMd3FmKhP0ITIjMOhmHCNCu+DCqepjYaQ2q5avHR1i5qgVuc/16/YyzysrqHFMW1n8eKDAynyQ+zCjNTIWjLpluZxD/9X8AVuCPdWrRzkY6/JJHiWVqSTzdnCFKkYntzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTUIYjSp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744205388; x=1775741388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGqk/2EVEjZ1Rlyihh/W+qt1GXz6ybM69ER2KNQFH68=;
  b=jTUIYjSpEnq7SZM15w75+alIGcUUKwdC8xSoddmlkUwdsFd5nhuFee52
   2Dwww6pTgfJCZg1oNVEnXNDvmu8pqoT4zprMUlb7Cm5cOPFdSZm/iaVQK
   S5rXEhIuoUek5AwVIrGtxBfX1+IwE/auFrdEqFYFxmWYrNTzZ0OkAlqVd
   Uf4PR2+kpC4Op/talSYtZAvwzlu7jx2r9xneQIyb2Ng+9LP+zqTfd3kZ9
   0p5Za3o7WE/QxihM5YyrfcieQqOIf17jEqJ0CaUT/u94uIQawPRo23d9x
   QBJm0OTFgqWKPFBMzFHcRaRAn6ocl3CiixV8M5048YCPpDE/AOvV+rLS7
   A==;
X-CSE-ConnectionGUID: /UbRBUwQTRCEFFI4BPDtww==
X-CSE-MsgGUID: kfc0ibz0SHGVAm5j41wfRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48384175"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="48384175"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 06:29:48 -0700
X-CSE-ConnectionGUID: CIQyYABTRsuIt2cRawWl/A==
X-CSE-MsgGUID: 2rbEOmqDQ9KK9XuQrjml2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128564685"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 09 Apr 2025 06:29:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9B7C95CE; Wed, 09 Apr 2025 16:29:44 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kees Bakker <kees@ijzerbout.nl>
Subject: [PATCH v1 2/2] gpiolib: acpi: Make sure we fill struct acpi_gpio_info
Date: Wed,  9 Apr 2025 16:27:54 +0300
Message-ID: <20250409132942.2550719-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>
References: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous refactoring missed the filling of the struct acpi_gpio_info
and that's how the lot of the code got eliminated. Restore those pieces
by passing the pointer all down in the call stack.

With this, the code grows by ~6%, but in conjunction with the previous
refactoring it still gives -387 bytes

add/remove: 2/0 grow/shrink: 5/1 up/down: 852/-35 (817)
Function                                     old     new   delta
acpi_dev_gpio_irq_wake_get_by                129     695    +566
acpi_find_gpio                               216     354    +138
acpi_find_gpio.__UNIQUE_ID_ddebug504           -      56     +56
acpi_dev_gpio_irq_wake_get_by.__UNIQUE_ID_ddebug506       -      56     +56
acpi_populate_gpio_lookup                    536     548     +12
acpi_gpio_property_lookup                    414     426     +12
acpi_get_gpiod_by_index                      307     319     +12
__acpi_find_gpio                             638     603     -35
Total: Before=14154, After=14971, chg +5.77%

As a positive side effect, it improves memory footprint for
struct acpi_gpio_lookup. `pahole` difference before and after:

-       /* size: 64, cachelines: 1, members: 4 */
-       /* member types with holes: 1, total: 1 */

+       /* size: 32, cachelines: 1, members: 4 */

Reported-by: Kees Bakker <kees@ijzerbout.nl>
Closes: https://lore.kernel.org/r/9715c8dd-38df-48fd-a9d1-7a78163dc989@ijzerbout.nl
Fixes: 8b4f52ef7a41 ("gpiolib: acpi: Deduplicate some code in __acpi_find_gpio()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 5b6344f0d065..2ac9c7b31908 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -742,8 +742,8 @@ static int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 }
 
 struct acpi_gpio_lookup {
-	struct acpi_gpio_info info;
 	struct acpi_gpio_params params;
+	struct acpi_gpio_info *info;
 	struct gpio_desc *desc;
 	int n;
 };
@@ -752,7 +752,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 {
 	struct acpi_gpio_lookup *lookup = data;
 	struct acpi_gpio_params *params = &lookup->params;
-	struct acpi_gpio_info *info = &lookup->info;
+	struct acpi_gpio_info *info = lookup->info;
 
 	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
 		return 1;
@@ -806,7 +806,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 
 static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup)
 {
-	struct acpi_gpio_info *info = &lookup->info;
+	struct acpi_gpio_info *info = lookup->info;
 	struct acpi_device *adev = info->adev;
 	struct list_head res_list;
 	int ret;
@@ -832,7 +832,7 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
 {
 	struct fwnode_reference_args args;
 	struct acpi_gpio_params *params = &lookup->params;
-	struct acpi_gpio_info *info = &lookup->info;
+	struct acpi_gpio_info *info = lookup->info;
 	unsigned int index = params->crs_entry_index;
 	unsigned int quirks = 0;
 	int ret;
@@ -893,8 +893,8 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
 static int acpi_get_gpiod_by_index(struct acpi_device *adev, const char *propname,
 				   struct acpi_gpio_lookup *lookup)
 {
-	struct acpi_gpio_info *info = &lookup->info;
 	struct acpi_gpio_params *params = &lookup->params;
+	struct acpi_gpio_info *info = lookup->info;
 	int ret;
 
 	if (propname) {
@@ -975,6 +975,7 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.params.crs_entry_index = idx;
+	lookup.info = info;
 
 	/* Try first from _DSD */
 	for_each_gpio_property_name(propname, con_id) {
-- 
2.47.2


