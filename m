Return-Path: <linux-acpi+bounces-13697-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71827AB5104
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 12:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473D17A3E85
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 10:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D623E34D;
	Tue, 13 May 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATiLhhIt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3F242D6A;
	Tue, 13 May 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130721; cv=none; b=ZOs6vsnTl9CP4HDL3KnrI2sf2awiobsStcR33joQa2L90UNxlo3qOa+dhOAdKeK3WEJzC6dN+tLAgmfe3+vPIpvpYI9uBB9wYPviSKqCrA1L6mI60cW+p9xh8FcS7OWL9jL0bv5HU/5W5i8QVDjl8XLtdPwalU29LH9aSh5CaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130721; c=relaxed/simple;
	bh=Xh9fKQAqfb6ofUz7KYzpmwduHizQHJsdLJ9D0gtxpbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IieRhrzf5yjtJgeBeokfFKPM+T1XQJBviA25Ocf4doIgGUNVgnkB/z9ox0Fk0fo2ZNoUtEN5zvS7PcZkX9/YBiKJM0be1eROfWfISo3W3LpwISluaTODglz68PqE6fJRqgz62OpUX7pLGoV4P74ajsEp2tyP3ExwUW9g/Nq5tyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATiLhhIt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747130720; x=1778666720;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xh9fKQAqfb6ofUz7KYzpmwduHizQHJsdLJ9D0gtxpbs=;
  b=ATiLhhItULekGaq03K6GWodJTniRafqMZrmk6U8/E2p+hO+knnNhd38C
   ZXTuKyCZ9MR15mlAyTspcyyXrXlc8ON1lANSe80hyVQ9MUPsewCK7hG8r
   p5y4RiXiYi0FMHetFI8+pUYkE3mKWaYkFruWlVnp+gzzCC9ihx0Jw0p/e
   661seFfJHKCKq2awachTnzXoOzuuL1nWjOVhXUG2u/pFsRBCxWMFhHs38
   cnQD4/ERumHJN9GMf1NUYhtcUv179vxNegXVXhY58TbsJJnopIBplN4EO
   qI77frWQtC1BWG3MUTfJd3dBeu4zry+whGiZXgCfEqOAUBtyt011NBiFu
   w==;
X-CSE-ConnectionGUID: jTCGZK3SSBqv10tsXGZseg==
X-CSE-MsgGUID: 08c2tKEPSJC2HfycaQrKig==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59606199"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59606199"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:05:19 -0700
X-CSE-ConnectionGUID: XleM/XMsQv2MrHqyR+zYFA==
X-CSE-MsgGUID: 07YhXSkHT8iuKO9MQGvWcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137699044"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 13 May 2025 03:05:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C36A3217; Tue, 13 May 2025 13:05:15 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Date: Tue, 13 May 2025 13:00:30 +0300
Message-ID: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO ACPI helpers use a few quirks which consumes approximately 20%
of the file. Besides that the necessary bits are sparse and being directly
referred. Split them to a separate file. There is no functional change.

For the new file I used the Hans' authorship of Hans as he the author of
all those bits (expect very tiny changes made by this series).

Hans, please check if it's okay and confirm, or suggest better alternative.

Andy Shevchenko (4):
  gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
  gpiolib: acpi: Handle deferred list via new API
  gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
  gpiolib: acpi: Move quirks to a separate file

 drivers/gpio/Makefile                         |   1 +
 .../{gpiolib-acpi.c => gpiolib-acpi-core.c}   | 344 +----------------
 drivers/gpio/gpiolib-acpi-quirks.c            | 363 ++++++++++++++++++
 drivers/gpio/gpiolib-acpi.h                   |  15 +
 4 files changed, 392 insertions(+), 331 deletions(-)
 rename drivers/gpio/{gpiolib-acpi.c => gpiolib-acpi-core.c} (79%)
 create mode 100644 drivers/gpio/gpiolib-acpi-quirks.c

-- 
2.47.2


