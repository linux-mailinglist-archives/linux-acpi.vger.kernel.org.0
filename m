Return-Path: <linux-acpi+bounces-12689-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D79A7A761
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98271163BE7
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FF8250C14;
	Thu,  3 Apr 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLBDjuwe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C32505C5;
	Thu,  3 Apr 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696049; cv=none; b=mDKdD7yh5FgYg5EtPC5wv+lVd6YYN1/byh6tizoT+8GTaPH84zjCjTKXuVx+fzpi33ecBi0+7jPPF/Dj8AoulszqLul7Cj3PKm4OcakLDJhVyvF5qUuJuutQSdnFrPXnmqqWRjia46EXsq6z2FJMFtDLD5SEMQ+E94pq5hiGSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696049; c=relaxed/simple;
	bh=EYqRRIvChNysyHW42375kUULY/8ylt1wkfHfK562yro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0+E9JEX3ceMrYihj//ahFBkdehfoUF+e6kYALltlVytB2OCx1A7kkqJYtC+uw0N6MLEt61sAupggYWM7u9s/vnSbMoTGoMWOrV8rD3T3G4T8JiRL7M9y/9d4++3iVv2Ic+vfxtp+zzAAOXWZ+K/aq/mQ1wFjWfhpbCxgzx/6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLBDjuwe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743696048; x=1775232048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EYqRRIvChNysyHW42375kUULY/8ylt1wkfHfK562yro=;
  b=iLBDjuweH5GMRBdB27HypxzYI9tYK1CxD8GQsi33Gtn7ggfdeIRvBTVc
   N8r8S5kDCR6ePrPxgOjOIa+CITTP4GZMIMIn2bx3BwIy27bjpprcJDHF0
   aa6/ut7QNv/0LmI3HKstXmKXnyeMTBRIZLzRfVAesNi2LZBdZ28mf6cz2
   fr92lI59MlXs1NyslC4DiT0A0jQuWbc5H+IsS61EHCKbW5T+IM/JgTxzW
   Q/XBcKWUlyEgDogycqJGPkB/D9XpTxbAl+wsGNpXp++3Ovkl+wjn1MKvf
   +Nt/RUXLIW3mCChaf8y+3P7bA8jrQjAVlLs2L3lkpFCSvZcvVRbTSdTP0
   Q==;
X-CSE-ConnectionGUID: pGOxPb/iRFKpW98XdRomKQ==
X-CSE-MsgGUID: v6A/aWitTIqZavOkkzL7qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="32716816"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="32716816"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 09:00:39 -0700
X-CSE-ConnectionGUID: MxpNcL4kTM6mEpH1B9TRFg==
X-CSE-MsgGUID: mCmAcwSQQ+6cLX44AY1gCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127036147"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 03 Apr 2025 09:00:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1EC30109; Thu, 03 Apr 2025 19:00:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/6] gpiolib: acpi: Refactor to shrink the code by ~8%
Date: Thu,  3 Apr 2025 18:59:11 +0300
Message-ID: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A simple refactoring of the GPIO ACPI library parts to get an impressive
~8% code shrink on x86_64 and ~2% on x86_32. Also reduces a C code a bit.

add/remove: 0/2 grow/shrink: 0/5 up/down: 0/-1221 (-1221)
Function                                     old     new   delta
acpi_gpio_property_lookup                    425     414     -11
acpi_find_gpio.__UNIQUE_ID_ddebug478          56       -     -56
acpi_dev_gpio_irq_wake_get_by.__UNIQUE_ID_ddebug480      56       -     -56
acpi_find_gpio                               354     216    -138
acpi_get_gpiod_by_index                      462     307    -155
__acpi_find_gpio                             877     638    -239
acpi_dev_gpio_irq_wake_get_by                695     129    -566
Total: Before=15375, After=14154, chg -7.94%

In v2:
- renamed par to params (Mika, Bart)

Andy Shevchenko (6):
  gpiolib: acpi: Improve struct acpi_gpio_info memory footprint
  gpiolib: acpi: Remove index parameter from acpi_gpio_property_lookup()
  gpiolib: acpi: Reduce memory footprint for struct acpi_gpio_params
  gpiolib: acpi: Rename par to params for better readability
  gpiolib: acpi: Reuse struct acpi_gpio_params in struct
    acpi_gpio_lookup
  gpiolib: acpi: Deduplicate some code in __acpi_find_gpio()

 drivers/gpio/gpiolib-acpi.c   | 146 +++++++++++++++++-----------------
 include/linux/gpio/consumer.h |   2 +-
 2 files changed, 72 insertions(+), 76 deletions(-)

-- 
2.47.2


