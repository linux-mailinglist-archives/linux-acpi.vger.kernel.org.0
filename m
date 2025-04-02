Return-Path: <linux-acpi+bounces-12645-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E08AA78E43
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD6A1897062
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBCA239089;
	Wed,  2 Apr 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaglpUHh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B4237703;
	Wed,  2 Apr 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596589; cv=none; b=HdOPjHoQL8RmMVasdkHYfrHzcrdlqkwLlTuzcaABlI190LtCiIkfKl3zZoRsKj3WU2Y3i0txvQ+J6er0DWo3h9GOte+YvAWP2sbMC++P6/TkTeOHtlI5+KrJVdL0ZRvRHOOqKa7cE2Mgd1a2YOoaqE0rAZ55Ly/nesjXibYGujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596589; c=relaxed/simple;
	bh=EQIiQqn4MEuK9eRh7/WW34wPqEOkWU+1ubSWfaDXEcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sRX3Tg+aGMKP/31PcgiBBPOnLwd9B/N3ZrSh6LZHaRqtmYH5w7NNFNbK2pl0+iultddqwJZtvLsw4aTfNLwa2WtHo6uPXdXPUf17QrwBXotVPzhd97kNqOyBn6tSAEgGCtaH8I2JR3rfGmdZtmGldIy6GCzkkfI98CDeo5gabWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaglpUHh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743596588; x=1775132588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EQIiQqn4MEuK9eRh7/WW34wPqEOkWU+1ubSWfaDXEcs=;
  b=WaglpUHhQ+Q6JImqMXlTIZ5jdFI0s4x8rwUWqCPmxKqA0MCVw15siy18
   c3TF3geQl56wvPuXjCmwCX4xYgaswhkI4NQQqe44hoOO+Yv64wyKBt6kp
   CKfLhQMglK7aQ6wWUVbkV28n1laLeN3iTivMZcmnjjQmPNxhUywb5x5QM
   zT01GAqlGFd9zC0Pz1JoFwdvds2uB7iVDweEbxeoqs9F98FbeJr6DTK9d
   ZaxxIPt55dsIDSY5trO/8GMyjiVeziQOfTOItzCBd1K157acwZHrA8h/G
   79Wt9zSYpA4hLzi15mgRAMQMX7hBpUKiviY8PGmnVXXLe9bhpf64AyoPC
   g==;
X-CSE-ConnectionGUID: u8VQcyC3QJSlZxTumiwSCQ==
X-CSE-MsgGUID: GJgxNa+IROyMhbflAXokpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44865037"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44865037"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:23:07 -0700
X-CSE-ConnectionGUID: aITze/OwShipQqa5VGs2VA==
X-CSE-MsgGUID: S3J+iroVQKK53DugNUhDKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="157635537"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 02 Apr 2025 05:23:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3719026D; Wed, 02 Apr 2025 15:23:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 0/5] gpiolib: acpi: Refactor to shrink the code by ~8%
Date: Wed,  2 Apr 2025 15:21:15 +0300
Message-ID: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
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

Andy Shevchenko (5):
  gpiolib: acpi: Improve struct acpi_gpio_info memory footprint
  gpiolib: acpi: Remove index parameter from acpi_gpio_property_lookup()
  gpiolib: acpi: Reduce memory footprint for struct acpi_gpio_params
  gpiolib: acpi: Reuse struct acpi_gpio_params in struct
    acpi_gpio_lookup
  gpiolib: acpi: Deduplicate some code in __acpi_find_gpio()

 drivers/gpio/gpiolib-acpi.c   | 138 +++++++++++++++++-----------------
 include/linux/gpio/consumer.h |   2 +-
 2 files changed, 68 insertions(+), 72 deletions(-)

-- 
2.47.2


