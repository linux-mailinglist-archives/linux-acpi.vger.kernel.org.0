Return-Path: <linux-acpi+bounces-7669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56309956D46
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878071C22BD0
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8967E174ED0;
	Mon, 19 Aug 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BroEVKs1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2899172BCE;
	Mon, 19 Aug 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077797; cv=none; b=OCmTghARkXtDe0BjJ9gFJicN7E6l2GlCErtu6eFfDqiIFl2YEWffgZh3Mk24NxR45ecE5JMhqOSIU0fXRhUPnTn2kG9dXi0a7Z62X2uDta9Mr8iokwxIzH29yLfDlxyUxYFwllgyYkDzDFsp82I1AH8M2PoB5SmQ1pryFtWDZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077797; c=relaxed/simple;
	bh=3vFAVBemVu5G1r3HkBWDFfS7TdtqyGi99iIkVJzw9PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ai6+Isu61Oijw67OGf4prqtyqu2t+Z8Bq6cly7Ceb969z0JQQe73xnDOS+g5XzX3Bpd95RE7ivffCJ+1Gu4kjOG9uVkmitLW84M3tLAwUKJ9hybcU2BZtS6rMoTcBf6lFuKeLtIAo1DmyTDlhIH4zmew8ynHDQgMaRxlw/LCXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BroEVKs1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724077796; x=1755613796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3vFAVBemVu5G1r3HkBWDFfS7TdtqyGi99iIkVJzw9PY=;
  b=BroEVKs1m/VXgx0+H+x7rHBbEYyvyxKpIZmkbux4D+xhJCE48ifwXbKm
   TkaSBWqZG6BB+S7HorKc0gatkPrLt10XWlk8m2dL22SoQnAuZnVwBQNQa
   ozoJfZGh6EiMJi2Zq8exEXNmtS7hyO7WjedUQ50ifyKHrggIu3Ue9jWUb
   QqWwUsMusa5vxZCVz40S3gPAYeyi5dX9Ht8PBnMDOB/8Haf5y7tqxg5Vt
   20COoDNSQ7jWmV/VcX3nVxMb6nY98wV8w6+KYMe0QvGUwIiFPEadJxuEx
   0ra/2+/+OdP8Aa+/UzKlpyG6ApOn79XKul8ssnopqaYG/xY4Dte91aDrt
   A==;
X-CSE-ConnectionGUID: e9g6iYBNSIepzx7RgnxdSQ==
X-CSE-MsgGUID: +fa5viyuSJyIcAPUkYp3fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33744479"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33744479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:29:53 -0700
X-CSE-ConnectionGUID: VoU4aJEGTwuzkfGhXKHkJQ==
X-CSE-MsgGUID: pyBIB+YtTUW0xEw9aS1BdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64783798"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 07:29:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1B34A2D8; Mon, 19 Aug 2024 17:29:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/5] gpiolib: Add and utilise for_each_gpio_property_name()
Date: Mon, 19 Aug 2024 17:28:55 +0300
Message-ID: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
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

v2:
- fixed a rebase issue (LKP)

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


