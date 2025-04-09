Return-Path: <linux-acpi+bounces-12876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49030A81A21
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 02:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306E04278CE
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 00:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46114A4CC;
	Wed,  9 Apr 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSWSCGhf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D713A265;
	Wed,  9 Apr 2025 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744159835; cv=none; b=qEP5ylFp+hnxZbj2wodhFIwNO5agtQKBigp5ja6zAK9xSAYBc38Ze+CmsDWH5rptR5xcwkA/JOa4r6GoALgwnNOOobX9rXASYWeitchBCD/U8rrstaZvM+aGz1f/IlAu9tvkZ86DPfPUjMofuGl0Dgz0mmQeieh2Pkfk7yfXbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744159835; c=relaxed/simple;
	bh=bVh50W/06oFUVmTSZNyIfxGCe7IOik9ucMy2Q0xFECA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTps1zDWdHhSMta4IWvJMpeuM67oGxdiNH/t3RmaSQBAgZ5A5j7Y4RTZ07xZQ0UQ3x6tyl2Z3MCccwk6ZFzIfTBZKw6QhAra/xy3/ue2cw6F8qdJzttcbvyuH4BR6VEoZS6Li1EwKELhzAe6YlmYuooqUojgO9OLuXLhU2pQ3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSWSCGhf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744159833; x=1775695833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bVh50W/06oFUVmTSZNyIfxGCe7IOik9ucMy2Q0xFECA=;
  b=cSWSCGhfIGWRlmSTDVrQ9l/O+7ShIKJyW8GI11+eweyzrrmdmLGblTYC
   Zxi2XIKDMZHqHUoSqmjgrvLdsQmkvTppmTP9hPK0/SUOXQh8F8irQIVMn
   gyNVi4hoY4Jzmh4oOCHMMdk5Iy+9nvj6J5UL4/Tzllcxs6j30pb0dUQPf
   YyXke9nkSwR1CYKUsQuFJ1Vm2x23HI0sTtBPck4Nw9NL8YMojt5AK78bf
   Qu7lf9CBubDzrEUpLhOm85mWFD2H/t6x6B+iFTq61yE21xNUcnSR4fbNd
   VVwxdTvUmX74L1dOMPqielPY/AZhvNJK1SIGrEOww/cuIngIiLax/FG2Y
   Q==;
X-CSE-ConnectionGUID: CnkTWisQRH+1LQdZdEKwRg==
X-CSE-MsgGUID: +esdBoC/TcO6Qzlr3j1+Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68095414"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="68095414"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 17:50:33 -0700
X-CSE-ConnectionGUID: bnCG4pKPR6qkpkLQJgww7g==
X-CSE-MsgGUID: 2nRf4wDmRv68LhAuqMW7hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="151611734"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by fmviesa002.fm.intel.com with ESMTP; 08 Apr 2025 17:50:31 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: ggherdovich@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI: processor: idle: Remove redundant pr->power.count assignment
Date: Wed,  9 Apr 2025 08:50:26 +0800
Message-ID: <20250409005026.1932637-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409005026.1932637-1-rui.zhang@intel.com>
References: <20250409005026.1932637-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pr->power.count stands for the number of valid processor cstates. And it
is correctly set with the return value of acpi_processor_power_verify(),
in acpi_processor_get_cstate_info().

Remove the redundant logic that unnecessarily overrides pr->power.count
value.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_idle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 7264444d56b8..623c415790b0 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -483,12 +483,6 @@ static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
 	pr->power.count = acpi_processor_power_verify(pr);
 	pr->flags.power = 1;
 
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
-		if (pr->power.states[i].valid) {
-			pr->power.count = i;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.43.0


