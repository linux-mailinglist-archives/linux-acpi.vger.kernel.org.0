Return-Path: <linux-acpi+bounces-7660-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A33956C03
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC67B22DD7
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56AA16EB70;
	Mon, 19 Aug 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqHTC0gI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1638216CD13;
	Mon, 19 Aug 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073926; cv=none; b=ciyZAN2pJ/9gDk/LYJZhGoC7kdBl65WqK1Wqw6TK9XoLGKVD5JvACf4/viPG1WVshlp7Cml0i4PU+4Rj9YmgtWfo+v1mi12ZsVoytRgXlROwSqKgJP3TS5LJGQErw2W0MirV8mRe7JPYNVz1XHss0ba41pz/byTKeppbw3ncKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073926; c=relaxed/simple;
	bh=Opo/TKxoGD6nvQw3E8EezstpfD5n92ncSnypBJ/zreE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWRup4LgCKRNsJt3D2xySo6CpaFyVq8cVSSdiq3hfXWAHd5fQm4KjWl/2WjOfFBkvzKgg1r6ku66EZBZrNRbEO6ofvJcBusdu9USmvaf3OfUz55+hMvdNDXksmcxvArfFFN9SdHWQLTDsFHlqCivezD5IdYATXiEEnh7cYQd7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqHTC0gI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724073925; x=1755609925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Opo/TKxoGD6nvQw3E8EezstpfD5n92ncSnypBJ/zreE=;
  b=EqHTC0gIUm3pukU4W7Jnsds3lVQqK9V0BPCgyEs4IU5JyfMdHWbkUrLV
   TOmODLvQgAD7e6osepYRomx79Z2MeIIUk4+JLzuTOnZnkcS0N+U/McUq/
   E88URUiqkuJckW4bwYm2qIXSjSscJ9mUOWRC2rv1Ug0f5/rdzZ58fueEU
   yWWUtUq7wt6r1l/STtf+AqwA/hdItw4Vgm9vYiuPbgIs/2CNbfDIzbDUL
   pFaIOCpTdODJevRxZcp51cagpA/S6qdtkcebuNUsZIlRo1Kl0vN6hbqiE
   p1zhNp6LSlMh6Hqy799pRFkAEVu4v49pb8ycmdFK8HiDiyerJbqIQ2o1C
   A==;
X-CSE-ConnectionGUID: pOFPAnAjRUKEKuHUNI2mGQ==
X-CSE-MsgGUID: Ne8shGjXQMyHmU64SC238A==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22462697"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22462697"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:25:05 -0700
X-CSE-ConnectionGUID: XPRKBWGURIO6Tny1a7IiIA==
X-CSE-MsgGUID: dwpzRfANRAaUyU9qsVTwQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64531824"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 06:25:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C01132D8; Mon, 19 Aug 2024 16:25:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 0/5] gpiolib: Add and utilise for_each_gpio_property_name()
Date: Mon, 19 Aug 2024 16:22:42 +0300
Message-ID: <20240819132458.208677-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few of duplication of the same for-loop against GPIO
suffixes. This series addresses that along with proposal to eliminate
the exported gpio_suffix_count by converting the array to be
NULL-terminated.

Andy Shevchenko (5):
  gpiolib: Introduce for_each_gpio_property_name() helper
  gpiolib: swnode: Unify return code variable name
  gpiolib: swnode: Introduce swnode_gpio_get_reference() helper
  gpiolib: swnode: Make use of for_each_gpio_property_name()
  gpiolib: Replace gpio_suffix_count with NULL-terminated array

 drivers/gpio/gpiolib-acpi.c   | 21 ++----------
 drivers/gpio/gpiolib-of.c     | 25 +++------------
 drivers/gpio/gpiolib-swnode.c | 60 ++++++++++++++++-------------------
 drivers/gpio/gpiolib.c        |  3 +-
 drivers/gpio/gpiolib.h        | 16 ++++++++--
 5 files changed, 49 insertions(+), 76 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


