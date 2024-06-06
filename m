Return-Path: <linux-acpi+bounces-6245-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D8C8FF62D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 22:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07871F281DA
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49FD139D1B;
	Thu,  6 Jun 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9sAOFxa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49D433C7;
	Thu,  6 Jun 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707443; cv=none; b=kVuaFUWkoT4e3tskWLyk+eabIP5tdd7LByByjNu+y+Ip9sdvpZmdfy5qZYRYDlLv1WZh86CJ663ajuSoPjrsgi3dZtwN7NPbGymoLE1wwusBVL49h6Qv2dHKNt+sxkuz3W4a8Mumehch3uO7uZqzQ69SxcE36sQ2DKw2upFqPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707443; c=relaxed/simple;
	bh=uPfvi/t2adMr7i5mPoSHlWgo4zQ4sxgP+GI6tGZ/ZYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldnZlFKdOyRJcAMMoweTWD/JK3IfCTzlBTiCK3xL/MOnxnw3fBOxvITNJqbTEcAPCjaWTxY24yZKtgENiWE3nxE3ZN74COVlGnfu3ABIDVTpvvoFqgErS/Nz3y7gew6BFgMZ1EnH2jEyCsvcmsaWxuv+y7VZT0TK8gyI7Mid+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9sAOFxa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717707442; x=1749243442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uPfvi/t2adMr7i5mPoSHlWgo4zQ4sxgP+GI6tGZ/ZYE=;
  b=b9sAOFxa91tnoA+FipQDxusyiPTwg9vR6HQtJ3ytvme9yBxXP5AK8YRs
   epfnuIuwQAYnT0bmJuHkG9xLQIOQwqzDGgrT8RHstoSF1s+h/snL6GX8O
   +UY5/rRyzMIh5gZiqjymeJN/8Fhwz7ZXvT2F/287N+nQT24aKvCFQTDXs
   gwdA6hIRZ0zGfTIoRNinDV5pNRvm2Bai6cR/cJWBmXma19QY5mwUEO5iK
   6Cba9vvmSE41W5SkXtkX3mvq9yu0QFv78rgpy3T/o8qO9RcSPwthbog97
   cLitNtYahypZEXEaLDECpGnyYKMOyNLxA+l6nxLBoenHjWfNhmSjLVDuO
   A==;
X-CSE-ConnectionGUID: R24sBf5hSGiTQk8+n7jmYA==
X-CSE-MsgGUID: zsuzj//oQXiOZ0nYgj7b+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25037100"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25037100"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:57:21 -0700
X-CSE-ConnectionGUID: Th1RMlleQwmCVLBqoGr/mg==
X-CSE-MsgGUID: j0ZKRAj/SDq0K1plkw3Emg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="61304492"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 06 Jun 2024 13:57:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5DA8C1C9; Thu, 06 Jun 2024 23:57:18 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 0/3] ACPI: PMIC: a small refactoring
Date: Thu,  6 Jun 2024 23:54:13 +0300
Message-ID: <20240606205712.3187675-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sizeof(), dev_err()/dev_warn(), and regmap bulk read
where it makes sense.

In v4:
- dropped controversial changes (Hans)

Andy Shevchenko (3):
  ACPI: PMIC: Use sizeof() instead of hard coded value
  ACPI: PMIC: Convert pr_*() to dev_*() printing macros
  ACPI: PMIC: Replace open coded be16_to_cpu()

 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 13 ++++++++-----
 drivers/acpi/pmic/intel_pmic_chtwc.c    |  5 +++--
 drivers/acpi/pmic/intel_pmic_xpower.c   |  7 ++++---
 3 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


