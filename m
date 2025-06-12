Return-Path: <linux-acpi+bounces-14307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA4AD7C26
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 22:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D07B031D
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8862E0B70;
	Thu, 12 Jun 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fhh5t5Vr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF12E0B4E;
	Thu, 12 Jun 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759211; cv=none; b=EpVWJVLDW++nfuOVZ3wf8oBhOzDAXMj9tJKzIT9yk+fsXrs1FlxJPMLoTd1jeY24WcOtgXd5yKxTIQPY4Na594akFrylQaXra0QiRWirxThD5GCzOUw+eUNUbGVMP3eMx3OTmIOLuIFEd0CAuNYK0PsJ+goGlGVgzJGajeykKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759211; c=relaxed/simple;
	bh=L7YFZq1wVfVaEXIz+Ocyiu/l1qr9rs048kh/X14R9zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xrn7/AdZphFalZEjlOllG7TtxHAFX0zm8oFdpnq1o/glwHKppN3BcE8nVtg3PJHAbJl3q3ra/NKPGDXjnYtNdiBjXUL4hDkus/ChM+IMqZh6zXYQydiyaWLfo/NHBLR/ziBlfxTs/Ig6ZIDIRgg0SIrxc3or6AgLi9iVL2ihzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fhh5t5Vr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749759210; x=1781295210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L7YFZq1wVfVaEXIz+Ocyiu/l1qr9rs048kh/X14R9zs=;
  b=Fhh5t5VrMuX27GLe4BssjmFXV0AcsarI/5EQKCY85GJwu1cipNlWVcYi
   kJQC7BCcgV14rMLuvMjTW9YWLyOvzuIMUiUU/GeZRh4BnS2PMtckEZ+Mi
   mSz1mtWxdskDZI9oS8y3sIuV6Zs4gZJkL4gYT3iHfMuQB+jArhONkKCZ9
   E/MiuBDczROcrUSNkacRdT4AyT9rrdy8oGe/RQqFTj8cZFnBx70hYMwDJ
   4X9/R6x1jZQ1A5jYg1vhhyXwvlfY1S9F4yZordszdlc5h68h/TqP0dsij
   HFL8PR6zY4M/BjvyKfeUPQC97mbAYewkBy/BDCYGwa2eMclCqQ0/36C80
   Q==;
X-CSE-ConnectionGUID: IDO+sNWVQN66MnmtXhSa6Q==
X-CSE-MsgGUID: AglEISMMRWeOSqehryN+yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55761144"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55761144"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 13:13:29 -0700
X-CSE-ConnectionGUID: vkz1oB/3TPi/juxiPwfG9g==
X-CSE-MsgGUID: 7Fi6nuDhR3KDt1gH0/cmKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148114144"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 12 Jun 2025 13:13:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9CA4351D; Thu, 12 Jun 2025 23:13:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 5/5] ACPI: proc: Prefer to use octal permission
Date: Thu, 12 Jun 2025 23:11:29 +0300
Message-ID: <20250612201321.3536493-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com>
References: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Octal permissions are preferred over the symbolics ones
for readbility. This ceases warning message pointed by checkpatch.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 440150c67ba6..c08ead07252b 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -139,6 +139,5 @@ static const struct proc_ops acpi_system_wakeup_device_proc_ops = {
 void __init acpi_sleep_proc_init(void)
 {
 	/* 'wakeup device' [R/W] */
-	proc_create("wakeup", S_IFREG | S_IRUGO | S_IWUSR,
-		    acpi_root_dir, &acpi_system_wakeup_device_proc_ops);
+	proc_create("wakeup", 0644, acpi_root_dir, &acpi_system_wakeup_device_proc_ops);
 }
-- 
2.47.2


