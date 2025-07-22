Return-Path: <linux-acpi+bounces-15278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A038B0DF36
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E14E172D9A
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Jul 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96712EAB7A;
	Tue, 22 Jul 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjGF1Ng9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63570838;
	Tue, 22 Jul 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195165; cv=none; b=Ye6SaRxDmiHWTHISlxNsAh1SV42InU1SSwMXi5Q6VZ/qVqpjP+KB3tROMyGD8jmYLj3YGgYeAlo698fcgEDKyUUeC1n+taHxITgUEMcogiS8jvMw7sgJfEbr9Bw7iCois7Q5lM0YDbFAAHQOJw84c7IlyX4GDsD55fV/AeqD4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195165; c=relaxed/simple;
	bh=evC1DJGyohfqttWOa/YapWO9JgbCdy7a+QBu40TKE8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgzI9XIKFJcwIlVsKwhBxOAju7/trWHPuZK/14GDlp8/DbgsPllms8/RfLkHrDo2hTaiG+Pg2sowxvybC0lYEfaHNvqB/SwZ1QnU6b4a7ZjlZ4VGt/C3YP3Js3bItYDQnlH/4/rM93ccJpDgkS1ETOy7bmEXZr6xv2fWtXwj4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjGF1Ng9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753195164; x=1784731164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=evC1DJGyohfqttWOa/YapWO9JgbCdy7a+QBu40TKE8M=;
  b=hjGF1Ng9AbYfmcOUjNEZCmJlTpLVSeONoIjCnEX6SE/T7BeebeeqBQut
   zeEH8m0c+8R23Qv/EmhEtEE61S2eI0C8qxxMlL7llUB+pbP70tVg41JV/
   wG0HDN4dj3nKWWVI3c9UfQsjN5D0RM/X8QP4XgLSAKyvr+CedSxpp65pU
   PYb9whHN3SwTy+XgppRohhxFgiafnf6wlX/EuIlrQ/0vQoX4mGa64oSih
   L/XNmhvTSpg0+cf70o3wmGn3z3HGn0NnY4Qfdiw1g6duF1jyQH2Qf3ymu
   RMibpT6vIUaf9bbnu73ChNFIuh2ttqOt2V278JPBUHVHPMU1EdrvegKUA
   w==;
X-CSE-ConnectionGUID: 6Xv/qgDoS3uyo4e8OlEgDg==
X-CSE-MsgGUID: F5ESOWFgTmy2T6QhDKy2AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54667676"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="54667676"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 07:39:23 -0700
X-CSE-ConnectionGUID: 8pnyQWiGTMO7UiIPOZIabg==
X-CSE-MsgGUID: GO5eu8wfR+ugLAPG1lQrog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="164820245"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa005.jf.intel.com with ESMTP; 22 Jul 2025 07:39:21 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.chen.surf@foxmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	"Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.com>
Subject: [PATCH] ACPI: pfr_update: Fix the driver update version check
Date: Tue, 22 Jul 2025 22:32:33 +0800
Message-Id: <20250722143233.3970607-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The security-version-number check should be used rather
than the runtime version check for driver update. Otherwise
the firmware update would fail when the update binary
has a lower number of the runtime version than the
current one.

Reported-by: "Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/pfr_update.c  | 2 +-
 include/uapi/linux/pfrut.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 031d1ba81b86..08b9b2bc2d97 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -310,7 +310,7 @@ static bool applicable_image(const void *data, struct pfru_update_cap_info *cap,
 	if (type == PFRU_CODE_INJECT_TYPE)
 		return payload_hdr->rt_ver >= cap->code_rt_version;
 
-	return payload_hdr->rt_ver >= cap->drv_rt_version;
+	return payload_hdr->svn_ver >= cap->drv_svn;
 }
 
 static void print_update_debug_info(struct pfru_updated_result *result,
diff --git a/include/uapi/linux/pfrut.h b/include/uapi/linux/pfrut.h
index 42fa15f8310d..b77d5c210c26 100644
--- a/include/uapi/linux/pfrut.h
+++ b/include/uapi/linux/pfrut.h
@@ -89,6 +89,7 @@ struct pfru_payload_hdr {
 	__u32 hw_ver;
 	__u32 rt_ver;
 	__u8 platform_id[16];
+	__u32 svn_ver;
 };
 
 enum pfru_dsm_status {
-- 
2.25.1


