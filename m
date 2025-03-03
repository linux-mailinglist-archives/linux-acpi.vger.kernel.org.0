Return-Path: <linux-acpi+bounces-11732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A14A4C639
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 17:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530E81752E0
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF0234962;
	Mon,  3 Mar 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7yzthA7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108A3233D9E;
	Mon,  3 Mar 2025 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017829; cv=none; b=jn4PzJO2swNYLiLlnJDO+1k1v55mWpBiCYMINOyL/olaADUvBneckDhZFP2kW44tHAGJ2bzJ86iSO8/TkDpnOKWMpgrOrO813Bg+fVQgU5iXpmVZ9n6WJpaqCg1mdV3EE2JMRGS5hpCeb4VNukpeafUgsLZBxM1JWnD+KOYUiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017829; c=relaxed/simple;
	bh=VfUfBazaoqubUxlgLIIUGrH2Uw82Bzpw0S3vE1d9/58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0SqlCfEHLhTZ49SJktg/oPOa9T6Y80XE4Pn3c+MIucQZj1wpJ+TcNOhAVqHnOkNK/VQMWF5HIe/B3Ln5VhxTvwb89GZ4c+T76z3v2xbtgHhCUQhyTlfIuFDbsCWCVOAkN3HpPW5+Mrqy3/QTwYKM8fcFfzx9K2QWBWnMM6tovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7yzthA7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741017828; x=1772553828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VfUfBazaoqubUxlgLIIUGrH2Uw82Bzpw0S3vE1d9/58=;
  b=X7yzthA7twSoQodegi4cse3gSEuc+xH1P8lnV4XQIxr6UfsJ8dSUFfOm
   iVjlpFzvKtEsUX6tjvrbhXKZEAueyzvXx4CEszQH+Xj3PLMg52QMY3TFH
   xxqz7n9OyOIiLl+zAxEngwRKAukK/wTF5qoMn3xZH2YK4jB1xVSgPUlK4
   /9DtocxgFYjIcAvtZgMTEquXKHtweTouQKfEzQ2i7xQ+ip9ZnpvPANEFS
   Th7R7keYUi4Q14alv9lGRuhwvPWq+Iy5Wnmtx9sh0Tb7HWbT/t+DjaRfN
   ORtaXkj6gUYl0YFVKOEYaCVX+wFB9O+uZwXF447kvkbIzD9o1919LOUGg
   g==;
X-CSE-ConnectionGUID: bMChJzXjTci89QZpq6Vkrg==
X-CSE-MsgGUID: r41q44H8RjiEoKDYak2nDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41606682"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41606682"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:03:47 -0800
X-CSE-ConnectionGUID: t/LpSJxFRNyMlPvJPvX7uA==
X-CSE-MsgGUID: JKDWSQQlSg2/pNjtfrw5Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="141285578"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 03 Mar 2025 08:03:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E39FB156; Mon, 03 Mar 2025 18:03:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v1 0/3] gpiolib: Reduce 'gpio' namespace when operate over GPIOd
Date: Mon,  3 Mar 2025 18:00:31 +0200
Message-ID: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to reduce the 'gpio' namespace when operate over GPIO descriptor
rename a couple of functions.

The choice of the name in patch 2 is inspired by the existing
gpio_do_set_config() versus gpiod_set_config(). The patch 3
also fixes it to be gpiod_do_set_config(), so we establish
two namespaces here:
- gpiod_do_foo() for the internal APIs
- gpiod_foo() for the external APIs
for whatever foo that makes sense.

While at it, the ad-hoc amendment to the FLAG_* definitions to increase
readability. No functional changes intended nor made.

Andy Shevchenko (3):
  gpiolib: Align FLAG_* definitions in the struct gpio_desc
  gpiolib: Rename gpio_set_debounce_timeout() to gpiod_do_set_debounce()
  gpiolib: Rename gpio_do_set_config() --> gpiod_do_set_config()

 drivers/gpio/gpiolib-acpi.c |  4 ++--
 drivers/gpio/gpiolib-cdev.c |  2 +-
 drivers/gpio/gpiolib.c      | 10 +++++-----
 drivers/gpio/gpiolib.h      | 40 ++++++++++++++++++-------------------
 4 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.47.2


