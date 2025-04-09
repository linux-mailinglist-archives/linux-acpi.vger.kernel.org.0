Return-Path: <linux-acpi+bounces-12899-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6EAA82649
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 15:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D8E8C2664
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED6263C88;
	Wed,  9 Apr 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esxzOJm5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045325DD13;
	Wed,  9 Apr 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205389; cv=none; b=Oy7uPIz/6lwSDxQill/REXMIkX8bitklMmIAQKgsiI0/Bq2qpYJ7L7vcTgtps1PgVUQjluBHwSUARyyZOc/SBTrUKjhZSD9iYKBXk31b080XyCkOHWqeiYWy7wQ/EAYPNsgQ2peeYhEEP2AvVPazByYueOyLuJ2y6GrBVo0oN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205389; c=relaxed/simple;
	bh=7hk/iOjkyz02HGui3e7azlVSIa1Sa2ofqEyKDdJ5iJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hipnHjtKKx+uzbbaJJ0p1GYDyrQhJ7K3jx8VN/FsO7w5WjKLoKx7slxfJvAKq33ZEeaSb/1bdoaJP9PvZm1Yc++w/ZXp5aizitAP7yQIMc8bb4gh05hI8k31TarZBZobHMlCFTfEnH4UjNlnHJO1QHyyBI9x9c3fgd11P7KUg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esxzOJm5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744205387; x=1775741387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7hk/iOjkyz02HGui3e7azlVSIa1Sa2ofqEyKDdJ5iJg=;
  b=esxzOJm51YP2O0Rja5tV9oPp20LivPSpCqrU5+A7Ap5mj10xNvt3jF0x
   ZgHwI0BWrQ9dL58m0Lo1/IE3HKbMkhnCTahxSh6Xp/Dyam/wZVMDy/9Jm
   bwks91qhIJYptJP8IX0vu9VAVl023tF54OclWTuDdwxpEGStDcgtyMYe6
   /RLPjaGEcVuRG2+dB7IrLETxnb4UoTRg+nJzoYIUFws6IeiJ3Cm4bLlMO
   d+ql/BLk7jTsZ6ZlrBC4sTquv6J2pKPGfIvTZDsoouhOXKpwKMQJi2CpN
   nzm7cFDjy6H14Hfc1zZjg3j0cRcSwuoNDq30THkiOCmbRyoADGDQx1US1
   w==;
X-CSE-ConnectionGUID: vmKGT4axQVa5HF3/6cjcZg==
X-CSE-MsgGUID: iq4RAG6JSHmlQrgeZbMjCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48384170"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="48384170"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 06:29:46 -0700
X-CSE-ConnectionGUID: TH4YnD0lTLyUQr+qky6OAA==
X-CSE-MsgGUID: l7+IB56iSJq74LUGUK+hVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128564680"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 09 Apr 2025 06:29:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 64EE2541; Wed, 09 Apr 2025 16:29:43 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 0/2] gpiolib: acpi: Fix missing info filling
Date: Wed,  9 Apr 2025 16:27:52 +0300
Message-ID: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kees reported that code, while being refactored, missed the point of
filling the info structure which supplies GPIO flags to the upper layer.
Indeed, without that part the GPIO expander get no IRQ on Intel Edison,
for example. Fix this in this series.

Andy Shevchenko (2):
  gpiolib: acpi: Use temporary variable for struct acpi_gpio_info
  gpiolib: acpi: Make sure we fill struct acpi_gpio_info

 drivers/gpio/gpiolib-acpi.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.47.2


