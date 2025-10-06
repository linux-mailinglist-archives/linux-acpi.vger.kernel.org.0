Return-Path: <linux-acpi+bounces-17601-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C4CBBD629
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7CC3B86C6
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB36261B99;
	Mon,  6 Oct 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6G+Q5Uj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBF1DE885
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740542; cv=none; b=jTabMxHzW+/49OZVb589ehV4tcZlf40g/sTQnu9B1IeaH4PqYvYg9fbDHZ3/i5C2uMOlSnaEdbwZYA2jDLhn/bwE24P3HNno0Zb1KO7FtfzCf8+BJs0K74SkqqJEzUBKDLNS6lyoUo7oQVWZvpNOu7Et8+hv6D0YyKOuuuTkIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740542; c=relaxed/simple;
	bh=r9+kNFURznM1wFtXI9nuGkAoZwSH2TcdV9BPrJwvTco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p3YY4dUSzUdUYn7A0VAcdVvcjt0ieH11zpgZHqgQkSFZ3rpYGt3MOY5IKRIy8FjGR/nzpoWJOfxOFoco4IgsvXF1vfdDYZhhgFNHYhhTzvHfgB7diroDrcfoItGFufAgmVzsofm6IygufnrXdoSYibSzmI+UwxERDNWcptkNkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6G+Q5Uj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759740541; x=1791276541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r9+kNFURznM1wFtXI9nuGkAoZwSH2TcdV9BPrJwvTco=;
  b=N6G+Q5UjOgJSwcSbHvoac+aWY1ASex8Myp4MFI/dp+fc7Ndjf2OeZ1AC
   IlRhIpMxFKfTQu6Vi6ahcX8GDTmKVN0KAHLp/BY/yiWYg87fsSb2jnHeW
   vEv+bqHTcVInuNA6CCAln6rZKHXsCpDaRKM8KxHMaTy/frnWQLfLL/z6N
   mgSlRre611JICIJBA3UQWXdyjyhqQwyZOPwilYc4pTZFbBJcWTsYYcj06
   FT1AihVOGseP2qPSbSBRf07yk/EZVErW+kRHs9ZQ6MaxqEZXkUMF/heID
   2KdMBFeCni0dZ1I3eOupNncwwu2yPJddQFO8FJpFHsF+jMxbMfyOvyu5D
   A==;
X-CSE-ConnectionGUID: ZWfRq/p4RaCc/sPNWWuD8w==
X-CSE-MsgGUID: e/4osEcJQJCJLBOJBam11Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="60948262"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="60948262"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 01:49:00 -0700
X-CSE-ConnectionGUID: lOYl+8QQRyC52BJ3Q1hMBA==
X-CSE-MsgGUID: VsQUU56HRCektFyPrKbDfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="180263738"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa009.fm.intel.com with ESMTP; 06 Oct 2025 01:48:58 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] ACPI / button: Add input_free_device() on registration failure
Date: Mon,  6 Oct 2025 14:17:06 +0530
Message-Id: <20251006084706.971855-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add input_free_device() call when input_register_device() fails to
prevent memory leak. According to input_register_device() documentation,
"If function fails the device must be freed with input_free_device()",
but the current code only jumps to err_remove_fs without freeing the
allocated input device.

This ensures proper cleanup of the input device structure when device
registration encounters an error, preventing resource leaks in the ACPI
button driver.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/acpi/button.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 0a7026040188..3c6dd9b4ba0a 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -619,8 +619,10 @@ static int acpi_button_add(struct acpi_device *device)
 
 	input_set_drvdata(input, device);
 	error = input_register_device(input);
-	if (error)
+	if (error) {
+		input_free_device(input);
 		goto err_remove_fs;
+	}
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
-- 
2.34.1


