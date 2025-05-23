Return-Path: <linux-acpi+bounces-13867-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8699DAC2867
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0024F1B667B9
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B18729713D;
	Fri, 23 May 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqNZjBTS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6579223DED;
	Fri, 23 May 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020753; cv=none; b=iQNlIEE7s7vm7ofuk49dQS39rdAdd6XzzDQHFcSzPGRDzsYbEZTMKFFUD0hz4VoU13wgArAA9QwERWYUvz4jzRJia6ZiPTpvRtVh7t2SvTp52gk5i5OQehwcHYLMxda4xWB/IeAdieLVyZnfQJxy3bi4XWc9CsvjY/I8yTL1+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020753; c=relaxed/simple;
	bh=JFhrayBhJRC4b/wXiM0S9wcKDa4EYnZywdbZUgnJV1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqYWHJdAV9ncD4CzNQR269haTJt1nUSJsLg1frwuaUXqYmXkRrXf01JN0+tZ/6trgBa2XO4wCoTKaDf23V+r3oM+ftGzUtTjxzpCvnvJkGFwGx41cezWDO+aSKfrjS1IIYdmiY1N8wa0KFlV0hf43Pg8zBIPjp99Ym5tHNCTWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqNZjBTS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748020752; x=1779556752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JFhrayBhJRC4b/wXiM0S9wcKDa4EYnZywdbZUgnJV1A=;
  b=TqNZjBTSW0EzrHX0hLlOsf5ftWANa5OGPpGKq9Y9xoo5NRIcKfCETtkp
   L4wYXsr3lo6veVCh1CNKvkPCGy9vak2Nh7cw9xg7Hv4a54wrPd6P5s5iN
   POt7HmndT7Y1V/7C9vXNOLcPu+aH9d7RJbplYzgKnZtM2EPKLI+ITKOgY
   nQtn1fLkdXXRE6FzYBkqYjWcH4RC2knvrP+lkI1P89u/9K7dFxKg4OujX
   JOS5l7lnpk9pEsFQ7797G75RM/XY2cOwpJGzL9dL4/mwgLIFGJkN7m8z6
   jcctFDopUu3ytdA+hAJmpHpCLJRYkDndWPcoKzo0Cd1gh18z9QYURj7dF
   w==;
X-CSE-ConnectionGUID: yb9RC2UuQc+S5RRot5beVg==
X-CSE-MsgGUID: cIy8n+9CQPe4ZobDAuSB0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60740027"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="60740027"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:19:06 -0700
X-CSE-ConnectionGUID: SzLbJRTkRoWK5B/6NfJo+g==
X-CSE-MsgGUID: looBECrOQrasZJMLHF3bZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="146383529"
Received: from dev.sc.intel.com ([172.25.103.134])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:19:06 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: tony.luck@intel.com,
	rafael@kernel.org
Cc: anil.s.keshavamurthy@intel.com,
	yu.c.chen@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] ACPI/MRRM: Fix default max memory region
Date: Fri, 23 May 2025 13:20:01 -0400
Message-ID: <20250523172001.1761634-1-anil.s.keshavamurthy@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the spec, the default max memory region must be 1 covering
all system memory.

When platform does not provide ACPI MRRM table or
when CONFIG_ACPI is opted out, the acpi_mrrm_max_mem_region() function
defaults to  returning 1 region complying to RDT spec.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---
 drivers/acpi/acpi_mrrm.c | 3 ++-
 include/linux/acpi.h     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index 2f22f013959a..26c1a4e6b6ec 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -14,7 +14,8 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 
-static int max_mem_region = -ENOENT;
+/* Default assume one memory region covering all system memory, per the spec */
+static int max_mem_region = 1;
 
 /* Access for use by resctrl file system */
 int acpi_mrrm_max_mem_region(void)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e72100c0684f..f102c0fe3431 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1101,7 +1101,7 @@ static inline acpi_handle acpi_get_processor_handle(int cpu)
 
 static inline int acpi_mrrm_max_mem_region(void)
 {
-	return -ENOENT;
+	return 1;
 }
 
 #endif	/* !CONFIG_ACPI */
-- 
2.47.1


