Return-Path: <linux-acpi+bounces-7449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C0D94C6EF
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 00:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0541C21DA3
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D115E5CD;
	Thu,  8 Aug 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuCwP/rS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332515A85E;
	Thu,  8 Aug 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155704; cv=none; b=gOqpnKWOsUXcyHgUq2P3WRONUX0FLQk0qF0kD9JxDj+CpaU/ejPjO665CqxVzd/akBq0x90UtcV9aB2U7qe3VbSXSFv5vPym5pL4ZmIehbATV85V2zo1yPYCd5NyHVKluRALy58I7KyVL85GSa/21yvuXz0qUKBqYgZkzc8A3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155704; c=relaxed/simple;
	bh=18WQLSx38osmYOgpmcaBIc7FiYWManq3aNioNdHQhZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPfru7PDSdTozZzwS3Jno6J1Y2ItbJkPUpxr/27NU2mM4k9HXlhE2CkbCGaxdZRMqsagMOBJdW1mPyHuR2uq15u4KWsSrmosrY0X8X0b2aUM04Y2ta4ZDP5Q+AccwAvDnv6jYac12M1oDp3khdqbe+pRN8gBZmYazFpwj3mBfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuCwP/rS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723155702; x=1754691702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=18WQLSx38osmYOgpmcaBIc7FiYWManq3aNioNdHQhZE=;
  b=ZuCwP/rShStcDTEM7axii6lAWJqyT6v6ZUl/uPh/dZGRScR5WctERwhM
   h3Kxnk6oUFgEufRW09vNIqcBxNshMFlqC8C6uK6ASilfkfLsf+OpNKt0N
   Y/+Y9txVVrhDqL6cPZAtT+OhgjMMAIVod8z/5/bxOdx32ZahJqy5g6Cyv
   07Ffl7GE494NpksbX1fdzVV0s1Cx/ic4PhFLyuyUvQiYZ4ZGNZJV4aQqP
   N0V5cJKQc8bD2cszroJBFs7HsyEGIIzdqxmhfHEDrPTvoHKvV4/y8RAh5
   QuhblcLH9HfBhmaOpjaNjYhFdci+GUAQVdoBcW6e/UXJ73+uQdF574LAV
   A==;
X-CSE-ConnectionGUID: cEzZ+1SLTXaW4IMh0JqqYw==
X-CSE-MsgGUID: nOwQvyU9QYOu/T0jIngE2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21194496"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="21194496"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 15:21:42 -0700
X-CSE-ConnectionGUID: M8UTKyQhScuq0XSQe/NQBw==
X-CSE-MsgGUID: wVCVB8OxRtS9ag2/sGaSwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57330120"
Received: from mihailpu-mobl.ger.corp.intel.com (HELO colinkin-mobl.ger.corp.intel.com) ([10.245.145.146])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2024 15:21:39 -0700
From: Colin Ian King <colin.king@intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: align slab for improved memory performance
Date: Thu,  8 Aug 2024 23:21:38 +0100
Message-ID: <20240808222138.51-1-colin.king@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling SLAB_HWCACHE_ALIGN for the ACPI object caches improves
boot speed in the ACPICA core for object allocation and free'ing
especially in the AML parsing and execution phases in boot. Testing
with 100 boots shows an average boot saving in acpi_init of ~35000
usecs compared to the unaligned version. Most of the ACPI objects
being allocated and free'd are of very short life times in the
critical paths for parsing and execution, so the extra memory used
for alignment isn't too onerous.

Signed-off-by: Colin Ian King <colin.king@intel.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 70af3fbbebe5..dab3d5089635 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1549,7 +1549,7 @@ void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags not_used)
 acpi_status
 acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t **cache)
 {
-	*cache = kmem_cache_create(name, size, 0, 0, NULL);
+	*cache = kmem_cache_create(name, size, 0, SLAB_HWCACHE_ALIGN, NULL);
 	if (*cache == NULL)
 		return AE_ERROR;
 	else
-- 
2.45.2


