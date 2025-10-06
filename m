Return-Path: <linux-acpi+bounces-17599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1710DBBD13D
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 06:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 103524E7B52
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 04:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF25265296;
	Mon,  6 Oct 2025 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+/RH+J+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C925F995
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759726515; cv=none; b=d2V0qMawZW1jBjtMuuhoHVNJwEgK0MC4bxxE5nLtD1vgEXC3RBedEZzPHXBVADJqYwp086RpudZPptJ/5HrCFDsRZVT+uuZb6nj8AOOa8WubUfn79kCZwnpFPz7/1LUlKqpXSMV0F7JBx97HekK3sE5pAgFYQpZ0DUjaqpLbtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759726515; c=relaxed/simple;
	bh=StLCEXEnOrnavx+fKOZDy5dS+Phc/5iTRAEPIihQM68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hrSoqBfO4WZwcsIo1QJkFUT1TXuwUhK2mL7k0uwKnjmoCojhTU5B8gcD2yrC9zK9/gg7g5puVd3MFqZJdQnRvYIgtoCjVIvLc2EXFFCfd++5V0XsbBzLq9SeZf8spj3iQHKXOcDQ4sU9nLEV4Z5JVvfCQeEvuGcp5W4hK1zaVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+/RH+J+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759726514; x=1791262514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=StLCEXEnOrnavx+fKOZDy5dS+Phc/5iTRAEPIihQM68=;
  b=A+/RH+J+ESV9LJwv6UFPEmv4E2OtdrzFzoOM5PkkD/0U2iGrlqN/NVUw
   nucUiJs5p5mUQK3vbSSiC+n1jRlP3xLmYdcG2sltG+J1MaQkpuKCu2ZA9
   +5Mfc9rz2R6OLmMCpbTyvsj+0Ya3FlPI08kg9p7nyPpDlnWPfTkDC0UNl
   vvMFtHAwOFH88MmkWYtN4Y5LBp6c573HHqqDG6CLSiRaexc/4nJar5siJ
   jzFPjcMqnQlyspcNhUPisWBZ4tC7Q7JbTHXXlckW58FkBbGWfNGx7oTmK
   vbBe0KKeBRS+ReLoYZkPh/vcPbtXS3bU0gvP9Prl1EvG97HJaSEZ2y6rK
   w==;
X-CSE-ConnectionGUID: g2mQdFOdQIG4LYhat5iZ/w==
X-CSE-MsgGUID: XXwd29aPRoKaRNIzbjl48g==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="79325741"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="79325741"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2025 21:55:13 -0700
X-CSE-ConnectionGUID: 4RrmfyKCTiePZAFC7ftqBA==
X-CSE-MsgGUID: PxN1b1A1SsuIy5XNL6hBcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="178919031"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa006.jf.intel.com with ESMTP; 05 Oct 2025 21:55:11 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] ACPI / DPTF: Use ACPI_FREE() for ACPI buffer deallocation
Date: Mon,  6 Oct 2025 10:23:20 +0530
Message-Id: <20251006045320.970534-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree() with ACPI_FREE() in pch_fivr_read() for deallocating
ACPI buffer objects. The buffer.pointer contains an ACPI object allocated
through ACPI subsystem functions and should be freed using ACPI_FREE()
to ensure proper cleanup and maintain consistency with ACPI memory
management conventions.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 952216c67d58..8d7e555929d3 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -41,7 +41,7 @@ static int pch_fivr_read(acpi_handle handle, char *method, struct pch_fivr_resp
 	ret = 0;
 
 release_buffer:
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 	return ret;
 }
 
-- 
2.34.1


