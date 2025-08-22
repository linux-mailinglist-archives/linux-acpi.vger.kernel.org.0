Return-Path: <linux-acpi+bounces-15904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F88B30EBF
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 08:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4459017476C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 06:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F82E3AEF;
	Fri, 22 Aug 2025 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLORCvcN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D952E3714
	for <linux-acpi@vger.kernel.org>; Fri, 22 Aug 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843672; cv=none; b=frtoXcMVcUoAd/Xz5tNXOwOYjnxB4I30OMQ2Ga5EOadvQQc9JXuEWefUjeonfDjJzpj1WocdEFyFGWd6uSpHjaL4CLdzFEWbD6oucnJuuBfo52JwhjL36E9ZYKt/xjs/0MzQbfe7QNc3mSe72sHF/MiRi8oyqerR4TThqlDFNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843672; c=relaxed/simple;
	bh=mQn023bWntVB0woxYukcX2soH/vMlNnZfvGirxBZZH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pF8Kwt264c5beJcV9bMPZ2Y6c11VmEY+q7GJmpTga6NrLktNfilFoVdQfc33RGHJ2/QEQZmH+EsRH4+zYUXU/FtXL3kPPgIf5lnwqEV9kIMOcrgEjusmtIYjS9ER/bKG1OoVb87oQEb1u6k0mkUyJZnxw6lcd9b5Uk+rMKm8hK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLORCvcN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755843671; x=1787379671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mQn023bWntVB0woxYukcX2soH/vMlNnZfvGirxBZZH4=;
  b=iLORCvcNjbfZd4/GjCvf5mp3Uyb/0pYthLfOdHz3r7lpW99KJoVoe0Zj
   tVpqOPI8rAYrK6KUz3ACB84RQhtZ05SbgGENS2/AUh6Utcv2SbV/ZVzU6
   1i0N79f/ucnyjV2GAqblYnYnFwedd9XaH/sDp/vGqAixVjmjayfqR3aKw
   z6kUv4cyg6pPFU/R8vI3uqG4WmU+Ji9JHr5t+VyDFZU9kIxyzRUDFWY/h
   XeCPapE5WzKlfMwEKUIPwFW5uTnJbN0JOHmXhh9+VmINbRY4+c7rJ/RNB
   oy3IMvo6NHLK9zcQE9zmlQGPqYDsEtjOFqKCFScD08P/SyewOEaHnFYOJ
   w==;
X-CSE-ConnectionGUID: XdS5lK+fQdKcOZOmOJoIRA==
X-CSE-MsgGUID: kjeAPy4+S8upCE4wcIU9Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69247239"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69247239"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 23:21:11 -0700
X-CSE-ConnectionGUID: tjbEHW9/R4yrB3AAZXK7zw==
X-CSE-MsgGUID: 2VGLu/20SFCIKdrNqgF10w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="192292385"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2025 23:21:09 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] ACPI / device_sysfs: Use ACPI_FREE for ACPI object deallocation
Date: Fri, 22 Aug 2025 11:49:46 +0530
Message-Id: <20250822061946.472594-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree() with ACPI_FREE() for deallocating ACPI objects in the
description_show() function.

The str_obj variable contains an ACPI object that was allocated through
ACPI subsystem functions. Such objects should be freed using ACPI_FREE()
rather than the generic kfree() to ensure proper cleanup and maintain
consistency with ACPI memory management conventions.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/acpi/device_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 3961fc47152c..cd199fbe4dc9 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -464,7 +464,7 @@ static ssize_t description_show(struct device *dev,
 
 	buf[result++] = '\n';
 
-	kfree(str_obj);
+	ACPI_FREE(str_obj);
 
 	return result;
 }
-- 
2.34.1


