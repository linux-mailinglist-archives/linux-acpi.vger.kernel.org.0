Return-Path: <linux-acpi+bounces-6063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360E8D2371
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 20:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66C1B22384
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113FC176FD2;
	Tue, 28 May 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1w6NZWt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2B173349;
	Tue, 28 May 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922061; cv=none; b=Rn0Ik4fgRL3gimgVSVjqzZRB0AXLfJ5qARQiNfKsGCjYupNqAudwV0r2fqrVicihoIHpsd+5ydcGPE0Mk4lIbchFqDXqIm87IhueRCEERmP05l0dsDmVyMDct2lxddBCqESC0zJ0Dbq4r1hEn3ISJn11R4ObEAdDCrTysvQoNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922061; c=relaxed/simple;
	bh=mv/DdbZyo6eomJ/rc6S48OLZws5x/hvaTKemElND+wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5YKYqo1PyV+ALqLAMl8giHd+KiJL8w1o8Ikp3txUFUsEvLrWNKw4vSBodK2jc7Fb80TUe31BRsAQ/XI7fYj3YdDh0lj4cxk3tCH9ahuyhGw0ZsOc7YOGjNuc46fZ0NZwruLPnICqvoCwQhFAqwzoY43Jb+jV2anJ8PAJiF5+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1w6NZWt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716922060; x=1748458060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mv/DdbZyo6eomJ/rc6S48OLZws5x/hvaTKemElND+wk=;
  b=A1w6NZWtdJqHsBZAE4r4Yd0knVjXeDsir9X8nsiHq0VbRB6GvHuahCLL
   Kgh10BLxleGAkGUL3ZwnGtz/nHUrsAXWIAOeFuJ9a2jeXfmvn/8clrWxS
   61VKpDSy1jPF//WWXQcBym25bQTJzd/O9ZbHt0r7LJDCDECrzrS/0Bk4u
   c4HfZ1y0GCffeSKi4IXGLHYqd6wr5fXUyCQ90ayCb5o9emXvJKwvQwQtA
   TCp0RTe2CeE3scLoie3/+vUCYywTNSuStc4zHyzfJbFeVgO7A9ixokNg5
   i418659nRLFLlzaiLHBiSFEOH/YW4gl5/iQSOUromQbVdPu/WQGhjnhHr
   w==;
X-CSE-ConnectionGUID: REIgV/b6Q46XprDa5U3+Xw==
X-CSE-MsgGUID: EXv0LSHFQK2HESkPUfACDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17121567"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="17121567"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:31 -0700
X-CSE-ConnectionGUID: owEPKT1fSsamN5emdtsNUQ==
X-CSE-MsgGUID: zVn8l6NsSlqAnxkuaCBFIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72605181"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:30 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6/8] ACPI: LPSS: Switch to new Intel CPU model defines
Date: Tue, 28 May 2024 11:47:18 -0700
Message-ID: <20240528184720.56259-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528184720.56259-1-tony.luck@intel.com>
References: <20240528184720.56259-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/lpss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/lpss.c b/drivers/acpi/x86/lpss.c
index 148e29c2c526..258440b899a9 100644
--- a/drivers/acpi/x86/lpss.c
+++ b/drivers/acpi/x86/lpss.c
@@ -338,8 +338,8 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
 };
 
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	NULL),
 	{}
 };
 
-- 
2.45.0


