Return-Path: <linux-acpi+bounces-16367-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD7DB44180
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9DA5637F7
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1AE2D23AD;
	Thu,  4 Sep 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZ9Vqu+z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FEF28152D
	for <linux-acpi@vger.kernel.org>; Thu,  4 Sep 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001450; cv=none; b=uKf+dW4psC3wZcmeMPe0IqLSfDHAUlpIuIgOlbVzFp4TwB695HiNeDwR6bdaTXMbjqh3UtB/NE125KkPAFqt7spKkDPOK2P+pKy3QcZeHa6yvmouxHD0Yl8s0J0eUAmsdJxFnVAEr6k4wsqv4soRpksLml+DUyxBZYuj8yd1kbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001450; c=relaxed/simple;
	bh=U/9erhoYhlZcSpBP7NuPGJz8BINSYeuVYu8DDPGpOvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5cAfQ9IfL4h93Y68TZ1JBP7DQDUAbfIXJH6W/6DvOsMzJiZ6Q6ws4oVitu64O37fuCRbcsupZc7lmvsidGlAkvkldweQbNPNiECLNi4RFmmTrJM3b8lYV4Pti6DU+oqatJlBXce7Yarmq2ggOzhYkPXxQWUrXKeQf+ovKABZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZ9Vqu+z; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757001449; x=1788537449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U/9erhoYhlZcSpBP7NuPGJz8BINSYeuVYu8DDPGpOvA=;
  b=NZ9Vqu+zQ0dnPP/8bvAZmGzC45E1MBTB0/crMhGvsX9vqc9F4wU10tYQ
   iX8k+vHtSrQclyXBZwoqwdhFKmgdwKScoLrx6UJSaYrE1V/Z7M0anMruD
   KyR3VPd7bD4ADJ2DLiIgrgwGnRhmrX6Uh4cXFYuX4Q7ulVNSdD6UIYnKo
   oazSAN8bNK9dIu6sgpDMmnOL6BLQBejG4r0ssDD7BU+k7oVSQ+4VSavg/
   Nd3XMVu0Ktj1zQIH+GWuo2y6m7eHSWd30S/thvo82RcC97g/kc4RqEvIj
   5CfQh1654Xt87JGa5R7SPVkZUsLOxNL6zAOQAygto68Oj8PCuBOUTGuiz
   w==;
X-CSE-ConnectionGUID: PM9rHcY3TxCFdqHLFDnYDg==
X-CSE-MsgGUID: QRb0+D08S7mhoRTvsCaExw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70051441"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70051441"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 08:57:28 -0700
X-CSE-ConnectionGUID: +QT80w01RuKeaW/5MpWErg==
X-CSE-MsgGUID: D1btvDC7T4aF9bwmLrnVfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171824229"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.222.122])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 08:57:27 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: surenb@google.com,
	"Anderson, Russ" <russ.anderson@hpe.com>,
	rppt@kernel.org,
	osalvador@suse.de,
	nao.horiguchi@gmail.com,
	mhocko@suse.com,
	lorenzo.stoakes@oracle.com,
	linmiaohe@huawei.com,
	liam.howlett@oracle.com,
	jiaqiyan@google.com,
	jane.chu@oracle.com,
	david@redhat.com,
	bp@alien8.de,
	"Meyer, Kyle" <kyle.meyer@hpe.com>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	linux-acpi@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Shawn Fan <shawn.fan@intel.com>
Subject: [PATCH] ACPI: APEI: GHES: Don't offline huge pages just because BIOS asked
Date: Thu,  4 Sep 2025 08:57:20 -0700
Message-ID: <20250904155720.22149-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BIOS can supply a GHES error record that reports that the corrected
error threshold has been exceeded. Linux will attempt to soft offline
the page in response.

But "exceeded threshold" has many interpretations. Some BIOS versions
accumulate error counts per-rank, and then report threshold exceeded
when the number of errors crosses a threshold for the rank. Taking
a page offline in this case is unlikely to solve any problems. But
losing a 4KB page will have little impact on the overall system.

On the other hand, taking a huge page offline will have significant
impact (and still not solve any problems).

Check if the GHES record refers to a huge page. Skip the offline
process if the page is huge.

Reported-by: Shawn Fan <shawn.fan@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/ghes.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..bacfebdd4969 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -540,8 +540,16 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 
 	/* iff following two events can be handled properly by now */
 	if (sec_sev == GHES_SEV_CORRECTED &&
-	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
+	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED)) {
+		unsigned long pfn = PHYS_PFN(mem_err->physical_addr);
+		struct page *page = pfn_to_page(pfn);
+		struct folio *folio = page_folio(page);
+
+		if (folio_test_hugetlb(folio))
+			return false;
+
 		flags = MF_SOFT_OFFLINE;
+	}
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
 		flags = sync ? MF_ACTION_REQUIRED : 0;
 
-- 
2.51.0


