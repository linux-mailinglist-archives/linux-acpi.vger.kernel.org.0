Return-Path: <linux-acpi+bounces-4866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF388A0130
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Apr 2024 22:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B73D1C22273
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Apr 2024 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D47A181B92;
	Wed, 10 Apr 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acjdbxwv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00293172BBA;
	Wed, 10 Apr 2024 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780571; cv=none; b=tsZYaqp+1Nih5tdLaQi3f8y18vKgCJjpASip4/shNsOnK4nIi6iKDl15ZSsbFmI6aVNRGesWnoTMUHgb+gVXrJah0rl7+9TT17X2XV3xTjA2sjvxWyOoNwZxqJKe+OjgFMl8djFXeBLbmrLzSp7JZpr0y5Op7Itv0xUO7C1HIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780571; c=relaxed/simple;
	bh=fOVy9ydfSMk2C1SidmQiLPrlYSYUlhiiUAewIdJa42E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SW7omyHbLm2kXrm0cVjyuMgE54YoOmQUXI4JSO9Vvus0tPjP93W7BSob9RaRhMdm2KAbTxg2kJIpDHLJ9DVPnrdE+c+qDQGYS390qSO11JvgwmpUirQGuRQig5BSl1G4ts8gveOqX0/xC7x10VKDBwhhgJItDvN56byvkufw+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acjdbxwv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712780570; x=1744316570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fOVy9ydfSMk2C1SidmQiLPrlYSYUlhiiUAewIdJa42E=;
  b=acjdbxwvytgjYFy52sCuu8EYpuuveTJBrrfmTtZYcKp1VMmLbwFMobLK
   cGfBkn+XRKEA45RBPgNE/R7HB5ApYXGfe0Hy38izibJ+pylJ2D4VL1fR3
   BFnPqeH/AJfHuMU8EzX+df7Ab0k1WSuFBDwXBi1trLr4zL/ZDXjEvht8+
   sSk0qSea07bAtS78xgHAbQNTu7P4tSOFcc36w3Sfg5J0qlDqWNVYyzWii
   EMClCpmCRJ1+xv6kjpzR4uYkc2h3T3k8mmJOP1JdjAN//7NHakJBPVtxs
   bI3wqcyryHP6aGfta3V87cyVPfGijZUU5kPYDpfeq95nKbl+K06+HSHC+
   w==;
X-CSE-ConnectionGUID: OSxV6P1vRXeSmMIwCTDirQ==
X-CSE-MsgGUID: TLoREJdKR6GRXIhZY4tw9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11960661"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="11960661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095428"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="937095428"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 13:22:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 091D92A4; Wed, 10 Apr 2024 23:22:44 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH v1 0/2] gpiolib: acpi: A couple of error checks amendmends
Date: Wed, 10 Apr 2024 23:21:45 +0300
Message-ID: <20240410202243.1658129-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One error check is moved and one is dropped.
No functional changes intended.

Andy Shevchenko (2):
  gpiolib: acpi: Remove never true check in acpi_get_gpiod_by_index()
  gpiolib: acpi: Check for errors first in acpi_find_gpio()

 drivers/gpio/gpiolib-acpi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


