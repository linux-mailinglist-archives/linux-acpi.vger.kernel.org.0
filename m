Return-Path: <linux-acpi+bounces-14304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72521AD7C33
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 22:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5FF1884ECB
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 20:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872FF2E0B41;
	Thu, 12 Jun 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq0wAQgQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7882DCC01;
	Thu, 12 Jun 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759209; cv=none; b=JCYeB2R0BI1Eh5yEpFBhb5bXuKGNPZXRhTUw04RdN/5unHiv/R+bTectAQ/Qe+iJHhaRRWlp0Dcu7ZTti1ONCq6UvBxBYM8edyrI5exY3kZ7Az7uIS4w9oqyZqi2XzKqH6rlyKenhEJ6nJbhfcmaPfiYbHqWBwNZhQtRgkLhl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759209; c=relaxed/simple;
	bh=R3z9BpBXgHElRv2SUgHKl/vynTFFgd9ABFKTVG9R2PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvARZ8buOyxSuryaXTqVJN6qgP0gjHGpW/3ZdHDO/h+rjjsYIWHnF0zelhg9MzaE5ZIEkz2ZgtlooLmA3axHVJ6/akjnSMldfvhfUCAKn3sVh7edPqVElyNEHv5XarVSLfclulsZjCUqNaO7L3J3nKZfGzRj2rTmlsNwsNhniDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dq0wAQgQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749759208; x=1781295208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R3z9BpBXgHElRv2SUgHKl/vynTFFgd9ABFKTVG9R2PU=;
  b=Dq0wAQgQiwPmaYKXvC6kJOiyHOP6tqdHYn+cC0V2Hb0tOwKg4cufM+Mm
   GFkDOoezUYbNor48+xWQNJGm3j1ixh4De37wNCJQFmTEiwzx643aX/6JV
   xHs4SoJJTKz8Ms0KltnN0fR85glaMAKrdG6GTHDL+DKVxcRvIyFC+7GT4
   Q+MGDgAJEf5GRI2my8ZRK+u6nZtABXrurVWIdK4UCjOs7QcCZzSD0mQqj
   W8v4szjZq/fdOhrvDLvVFazKW0lV6OuoKZwmw00GYZCMrWa0PSi0oc4Hx
   ZBoHjfoyExo36paVSKMxhFSjKnPHztZsBMEs2pHowUmVja/maG5PGd0uN
   A==;
X-CSE-ConnectionGUID: j9YsUvdETmKv1xDpAXnCmQ==
X-CSE-MsgGUID: Z74vatstSDG/hkxRw7N9vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55761134"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55761134"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 13:13:27 -0700
X-CSE-ConnectionGUID: q/el0BrFTJylW2HEBc/AuA==
X-CSE-MsgGUID: NlrffvTxTPasdm+OB2jYQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148114136"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 12 Jun 2025 13:13:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4B8F4191; Thu, 12 Jun 2025 23:13:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 0/5] ACPI: proc: A few cleanups
Date: Thu, 12 Jun 2025 23:11:24 +0300
Message-ID: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While looking into warning related to export.h inclusion, I took
the opportunity to make the module up-to-date to the modern APIs.
Hence this mini-series. Note, the first patch is to make the used
type consistent across the files.

Andy Shevchenko (5):
  ACPI: wakeup: Drop unneeded casting for sleep_state
  ACPI: proc: Use correct format specifier and drop casting
  ACPI: proc: Remove unused header
  ACPI: proc: Use str_enabled_disabled() helper
  ACPI: proc: Prefer to use octal permission

 drivers/acpi/proc.c   | 17 +++++++----------
 drivers/acpi/wakeup.c |  4 ++--
 2 files changed, 9 insertions(+), 12 deletions(-)

-- 
2.47.2


