Return-Path: <linux-acpi+bounces-6211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7648FDCC9
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 04:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76781282239
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 02:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8FE17BA7;
	Thu,  6 Jun 2024 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvamltEO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC018638;
	Thu,  6 Jun 2024 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641200; cv=none; b=eky+eLyswsK5Kkp5MaXUfmiQrsX8nMqzorq1HvdjZf++zNflft8bVucvd3Sc9QZDruRfQbAtakC/W6oHkq5zVLndosTZt2nzf0CtknT+ku6zaaOnfAKTUkZtQ9+Ou9FfAsXY6+D1mN63/3IcmVv4P/zNOwE7CXjBr5cKdMrCgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641200; c=relaxed/simple;
	bh=muKFlTEZQ/AQ40SVi7FdGPUE3Q7TaOqoPMNhx6FRIis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pjx9NOEP/H78kAvAb6mGgjgClB9/P60kd/iysJ8nk3a8rCpBwAK6eJs7rDxRS3QIZMXNgLRhykERj/41lW3/yzey6kZD91Dff3AtNxacPGuhmyq3FCHCffIQh5Es1WR1FAQmya6lL9oqLTdkwHnNndYUK6bCiCba0spPrgooMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvamltEO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717641198; x=1749177198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=muKFlTEZQ/AQ40SVi7FdGPUE3Q7TaOqoPMNhx6FRIis=;
  b=IvamltEOgtXMtxdEw4ntO/A1LSgGO+X15yYXIAVjxFR7fX7Pg58M6mpb
   rbqgrMPa8+sRo1yJ7B2eUx9YPd4mn+z4OU/bIoOce/ALLng7lJKJcXmXk
   l8GIP/uVx9IKmCDsCf3lyi8sotouyRh7z3KY0D0mKTKqG8eNTlH+pWzbo
   5BgnzmVvug/sW0EjZ4EjTTjeouS8kgUsuc1PLDTp9V/iiP5pTa4BukFkz
   L8pgb+LgrKlwrha+YW7H/+epocu6VReyJHDXABVibgg9J2V52lgOmWNlO
   wAnyc5CK5HBC6kPSn1kvjbuD9mWz9joQ6VpRHdEOJ0YPspgjWih6lLqpU
   A==;
X-CSE-ConnectionGUID: nhMFWSdRQx63ePPHmkAb2g==
X-CSE-MsgGUID: xe+3TQPGQeSAfoQjFuntbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14126980"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14126980"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 19:33:17 -0700
X-CSE-ConnectionGUID: BrP0J7NBQcSH/Fh3z9CL0g==
X-CSE-MsgGUID: z9U+ODy6T/WnF0YSM+WryQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="68621101"
Received: from unknown (HELO yhuang6-mobl2.sh.intel.com) ([10.238.6.133])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 19:33:14 -0700
From: Huang Ying <ying.huang@intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] acpi,hmat: Use ACCESS_COORDINATE_CPU when appropriate
Date: Thu,  6 Jun 2024 10:28:45 +0800
Message-Id: <20240606022845.189710-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To improve the readability of the code via replacing the magic number
"1" with ACCESS_COORDINATE_CPU when appropriate.  No functionality
change.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/acpi/numa/hmat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c8ccc91ebe6..febd9e51350b 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -408,7 +408,7 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
 	if (target && target->processor_pxm == init_pxm) {
 		hmat_update_target_access(target, type, value,
 					  ACCESS_COORDINATE_LOCAL);
-		/* If the node has a CPU, update access 1 */
+		/* If the node has a CPU, update access ACCESS_COORDINATE_CPU */
 		if (node_state(pxm_to_node(init_pxm), N_CPU))
 			hmat_update_target_access(target, type, value,
 						  ACCESS_COORDINATE_CPU);
@@ -948,7 +948,7 @@ static int hmat_set_default_dram_perf(void)
 		target = find_mem_target(pxm);
 		if (!target)
 			continue;
-		attrs = &target->coord[1];
+		attrs = &target->coord[ACCESS_COORDINATE_CPU];
 		rc = mt_set_default_dram_perf(nid, attrs, "ACPI HMAT");
 		if (rc)
 			return rc;
@@ -975,7 +975,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
 	hmat_update_target_attrs(target, p_nodes, ACCESS_COORDINATE_CPU);
 	mutex_unlock(&target_lock);
 
-	perf = &target->coord[1];
+	perf = &target->coord[ACCESS_COORDINATE_CPU];
 
 	if (mt_perf_to_adistance(perf, adist))
 		return NOTIFY_OK;
-- 
2.39.2


