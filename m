Return-Path: <linux-acpi+bounces-12875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416CBA81A20
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 02:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99872468769
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861E13C9A3;
	Wed,  9 Apr 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adqebcE7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E841132117;
	Wed,  9 Apr 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744159833; cv=none; b=D+fGVG9JebregQlDt35e52ieKMb6QUJSEUfl/yGfTt5RgHEqO9D3AcVaFO2vq9qee1v86zuMqYiD1QY1qLuxKlS4sA8FvbloLatInVOsKdHAzfOQQBvi/z+BOnLdCOTBrKN2arjV+3pkUJp6rNiL8kT3TUZ2S9JRZtIx4eIB7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744159833; c=relaxed/simple;
	bh=AuklLqaFsH2YuV7VhYot60oXJfik6SRvEYNcB3LgkqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhDg9vSJYCaQZ1YZ1w46ELrkY8zT5OFHjGKuEAYy9E4U1ocImTfehmcX6Ou6dvCxlqSvl0zf7oEiCqZItRR9+j5bC2DUAjCRRKqHCcCAXQce2/9g9Ao2/lMrCL6w4amuLkhMPXQioYa2H1F++BnJ1v/iBsVs1IYjlIIwagkb6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adqebcE7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744159833; x=1775695833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AuklLqaFsH2YuV7VhYot60oXJfik6SRvEYNcB3LgkqQ=;
  b=adqebcE7n9kdd1fBGoZDFvxaxRZWZzb8VwTM3zC2cJ0PpuNmYwj0eEOF
   UJy9k6qkxsUUJQeM4jatQ9vdTAtvHoRelRK91HDrivaw7oD97qnQIuDLQ
   Txuuwrop/bsgn3cGN21B2ciaUDAMCnupygVGT84Kxlg95dfMDOvuKFh+s
   IQVoaZBTEbajZvycLApt4yiBJvHn27+vcQqMeHrUTn7iABM25HAb/094d
   HFL5+imukQvqiEqI1QOMNmupLhPDwUip3S+ZUPVSlZ9vqMJ7z5kMgo86G
   ekr4mzoc2dbG7W14nMUkDOTmSj+rkYCxZ6V8BkicfSG6KM6nDgB4LFMCx
   Q==;
X-CSE-ConnectionGUID: dJipZPcaTKycdl3yrQ05iQ==
X-CSE-MsgGUID: 3uLFJ2BMRHmMIdy4XjIwpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68095410"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="68095410"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 17:50:31 -0700
X-CSE-ConnectionGUID: sVXjBq7HQGuQqaicxpprnA==
X-CSE-MsgGUID: 4c1Lu6w5QdGcHXrPU24sFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="151611730"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by fmviesa002.fm.intel.com with ESMTP; 08 Apr 2025 17:50:29 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: ggherdovich@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: processor: idle: Set pr->flags.power unconditionally
Date: Wed,  9 Apr 2025 08:50:25 +0800
Message-ID: <20250409005026.1932637-2-rui.zhang@intel.com>
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

acpi_processor_get_power_info_default() ensures that the processor's
ACPI_STATE_C1 state is always valid. Consequently, the pr->flags.power
should be set unconditionally after this.

Remove conditional checks and directly set pr->flags.power.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2a076c7a825a..7264444d56b8 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -481,11 +481,11 @@ static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
 	acpi_processor_get_power_info_default(pr);
 
 	pr->power.count = acpi_processor_power_verify(pr);
+	pr->flags.power = 1;
 
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		if (pr->power.states[i].valid) {
 			pr->power.count = i;
-			pr->flags.power = 1;
 		}
 	}
 
-- 
2.43.0


