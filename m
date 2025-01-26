Return-Path: <linux-acpi+bounces-10825-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F3A1C619
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 03:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9003C166866
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2025 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59751172767;
	Sun, 26 Jan 2025 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AESrKIKP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A9288DA;
	Sun, 26 Jan 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737857308; cv=none; b=crZUGwErN+vfiyrzEmMPeZvMCd9AwJ+OYwOl228cEmpbXWzUKtb5uwjBVPN5NhoQOmAXb0EaU/rxhNcpoRiOHanK2DdMji2o+9GyIuM6QPc6/2dNVE57ytIUnHLH95fcocrSJdEzFnbwmZ+ajO9cdSkrf4POWjSFuDOeFedCnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737857308; c=relaxed/simple;
	bh=PxZHvhZ+BkqSVTeiAASewWj8FToiphcx8DljG3rQHjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7I1ubUqGpxXQqvsU6Cln2jVk1NGIWEE+68Zlzxhr97wnnwLmpceNrzjDafnlThja9svGoFzzebXWeo+LasNfn9DguxUBCC4rIlxaJS5N+P8MJUMPx2AEHsyFtgpvm2Xo65wVg9QkWI5OapvQwMqFCqRar3Wk3gfTBcTfRAiD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AESrKIKP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737857306; x=1769393306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PxZHvhZ+BkqSVTeiAASewWj8FToiphcx8DljG3rQHjE=;
  b=AESrKIKPuqlJtwwdpIy+un9nEbjIlvKiMZKN+z35hkx0tFtC/oCbTWMA
   3P8M4OMXISEBGcaY7kZtSX0dJgVTrhh4aaXHc9ZFpQ9etLtKV05lJ2mfN
   pDzsmipTEUdSFsHH8msTu30/xTb7sUO8huZ7cUt+4I0rp/QE/Tk9BH7ki
   YmF502SeyrzwlCzqf4kk+QE9ehWuO7XeCeCtnCQuvPP82kVNdLElBvwpv
   uYpmxCbcuGI2+1mGkoL54pix72Y9ElBJbmyklkAoF4jHjpy/Q6bvQ27h6
   PLrLnHXtzgRZ1v/AZYbX4YkuW7UAeKbKNJvPLWMS45W+fVNg61i47sq2e
   w==;
X-CSE-ConnectionGUID: wP27JdLeQxSl1QEmWqAu+A==
X-CSE-MsgGUID: yJ2qYAolT2Wqu6/b/1ikkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="49747707"
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; 
   d="scan'208";a="49747707"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 18:08:26 -0800
X-CSE-ConnectionGUID: kvRKHREcStaAkmQmt6yIrg==
X-CSE-MsgGUID: y1vmS12rTg6NeShcYlkGyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; 
   d="scan'208";a="108093311"
Received: from osv-sh-dnp01.sh.intel.com ([10.239.53.113])
  by orviesa006.jf.intel.com with ESMTP; 25 Jan 2025 18:08:24 -0800
From: Aubrey Li <aubrey.li@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Koba Ko <kobak@nvidia.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Matthew R . Ochs" <mochs@nvidia.com>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aubrey Li <aubrey.li@linux.intel.com>,
	Shi Liu <aurelianliu@tencent.com>,
	All applicable <stable@vger.kernel.org>
Subject: [PATCH] ACPI: PRM: Remove unnecessary strict handler address checks
Date: Sun, 26 Jan 2025 10:22:50 +0800
Message-ID: <20250126022250.3014210-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
handler and context") added unnecessary strict handler address checks,
caused the PRM module to fail in translating memory error addresses.

Both static data buffer address and acpi parameter buffer address may
be NULL if they are not needed, as described in section 4.1.2 PRM Handler
Information Structure of Platform Runtime Mechanism specification [1].

Here are two examples from real hardware:

----PRMT.dsl----

- staic data address is not used
[10Ch 0268   2]                     Revision : 0000
[10Eh 0270   2]                       Length : 002C
[110h 0272  16]                 Handler GUID : F6A58D47-E04F-4F5A-86B8-2A50D4AA109B
[120h 0288   8]              Handler address : 0000000065CE51F4
[128h 0296   8]           Satic Data Address : 0000000000000000
[130h 0304   8]       ACPI Parameter Address : 000000006522A718

- ACPI parameter address is not used
[1B0h 0432   2]                     Revision : 0000
[1B2h 0434   2]                       Length : 002C
[1B4h 0436  16]                 Handler GUID : 657E8AE6-A8FC-4877-BB28-42E7DE1899A5
[1C4h 0452   8]              Handler address : 0000000065C567C8
[1CCh 0460   8]           Satic Data Address : 000000006113FB98
[1D4h 0468   8]       ACPI Parameter Address : 0000000000000000

Fixes: 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context")
Reported-and-tested-by: Shi Liu <aurelianliu@tencent.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf # [1]
---
 drivers/acpi/prmt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 747f83f7114d..e549914a636c 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -287,9 +287,7 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 		if (!handler || !module)
 			goto invalid_guid;
 
-		if (!handler->handler_addr ||
-		    !handler->static_data_buffer_addr ||
-		    !handler->acpi_param_buffer_addr) {
+		if (!handler->handler_addr) {
 			buffer->prm_status = PRM_HANDLER_ERROR;
 			return AE_OK;
 		}
-- 
2.34.1


