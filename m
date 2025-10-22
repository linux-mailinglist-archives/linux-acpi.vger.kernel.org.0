Return-Path: <linux-acpi+bounces-18128-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CE8BFE370
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 22:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A40919C0654
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 20:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED73A2FE575;
	Wed, 22 Oct 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSYHwqrA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD22FE560;
	Wed, 22 Oct 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165932; cv=none; b=Ils28+6Qs25TGmhyAECQeIgF24gkVBbBXgufsuqgGBEC6PLkrBZo9L4kforr5Qw/+/ClnITrdAD/HSAeGSLtRAvFoq6BHaQlySQQMl+MJC8tGv84Y/y7Yzfn3gkieXomMRjjexijGykQD50poKT8DoT5yMRqZhw2k5vMv/7rbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165932; c=relaxed/simple;
	bh=YWlHyzihnVjS1Y22x469698+jpX/0sqFDbsHjYf3Hto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1SH+sUCarIPucZVeMv8xMLRioK0gTJG99sM0uG0eQcA2U4nXhPWvo3jOVMZnuH4m+qCsYYLPAsYb+GulQVubC5lqhPkLiPGEj9AGUkV0jkaTOUl6hfQVVeLqMZ8EANN4gYri14TTJPHBgaRWmDX+M28B0UQTAgEvmWE88SQc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSYHwqrA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761165931; x=1792701931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YWlHyzihnVjS1Y22x469698+jpX/0sqFDbsHjYf3Hto=;
  b=dSYHwqrA3f3C27SAKW+vXvlCHhec8gkdteTlDSRPG4LpAK2Tkeoo54FL
   M3B5Y/qRSeJK1eOAKve/Bnblshu2/DvRh0uRf5tuw+P/G4Z1RQqWF+E6I
   xZIvliwnCLJzWbRZyDJckqWoJ4w4f7Gl/d/aDvLkGERG+GN6BwMT7XC1l
   qt3/xgw2wmY2/YRPnBD8sMRPhpGFjRmyPb9tH1t4xh8T8jcqLZEUKfUH4
   cv1DZYQVbDjg93mCvx5Qjqml/2Y29tsB5dOEQUwtujbqm+Z8hL4f5NC0L
   M5zMv9OK2oOzZ5fH9zNGp9g7tLrzs2bDgRSXapjhPwcGZiEtLYSADKpNG
   A==;
X-CSE-ConnectionGUID: +bq3H/yzR1ynwCWSl//m8A==
X-CSE-MsgGUID: vj5j7N5kTZmkv2IG+WpvhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63030048"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="63030048"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 13:45:30 -0700
X-CSE-ConnectionGUID: crn79BJiR3O4ihpirT+QTQ==
X-CSE-MsgGUID: DAXSrVtpSCGKonvPjrHizQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="189096027"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.221.80])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 13:45:30 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] ACPI: MRRM: Check revision of MRRM table
Date: Wed, 22 Oct 2025 13:45:23 -0700
Message-ID: <20251022204523.10752-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before trying to parse the MRRM table, check that the table revision
is the one that is expected.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/acpi_mrrm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index 47ea3ccc2142..a6dbf623e557 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -63,6 +63,9 @@ static __init int acpi_parse_mrrm(struct acpi_table_header *table)
 	if (!mrrm)
 		return -ENODEV;
 
+	if (mrrm->header.revision != 1)
+		return -EINVAL;
+
 	if (mrrm->flags & ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS)
 		return -EOPNOTSUPP;
 
-- 
2.51.0


