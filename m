Return-Path: <linux-acpi+bounces-6237-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73858FF2E2
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86B81C25A93
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11A198E74;
	Thu,  6 Jun 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jitzm3Gs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB53197A8E;
	Thu,  6 Jun 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692611; cv=none; b=RqIjey/F/6HdjTiJBTfyX3aL81Cc6QSjoRh1Kl9L81p2wM7hnh84GQuCbt28LItXkbvL6y5U0DLgcnf2y9/yGgoLqUBzX+rUp0c7rFEZPEXvf50tVPGS++pobnM2T8LI9ya5TxsM0iD+n9oU2wb3JHHKX6H4MOBLE5PFZDdPsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692611; c=relaxed/simple;
	bh=tlaOqTIhOPntNJcdksoYStm3FquF+/nT90DemPfbmLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwAbPpkkpAQL8lqJSUt09zQfSuMJVWTUOaRQgNAr5tuW5XePmxKJyT4V+pxuZQdrwzy4V1Rno68VuBM+rb8P7KFzG7eBZof9oQ4/955JkXdeGOn++5xsnSyPnYWobDn1G3Xv2HH+dwb0TWSOBq0LVWwznj+4X3o6rYHScXnZ4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jitzm3Gs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692610; x=1749228610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tlaOqTIhOPntNJcdksoYStm3FquF+/nT90DemPfbmLU=;
  b=Jitzm3GsCl6kzm+nW9yLofnKXeVevHjqh/d6nANLexGmI4bJ2+tU9ih8
   HqnyfZclH2EMEuxK4Lfe3NaeICYhHgjy0UGF82oktEw751uHaEGPyINNX
   5rspd2i2poAzT1ZAK74f6HlVAH1bXd1/IoPwTwsj/iuD4zM4NyLZHRKlv
   K4IZ2cKSw/xmlZ4UUTZ+kfkwgQEb31V28P56Bo+Q6o01LX70Swh0hvK+C
   65csc8i821tlIYtyx3XybD4QaAGLRVJzYM4i0Mxb5HGCc7GALiuucL+UD
   gi4Nj6JuMoJDf5gAV2J3yw0Z8i/4yajLS0XB8YI/ke9lKCyzavdtSF10z
   Q==;
X-CSE-ConnectionGUID: IASmFAx7TReJM+cnQmEFsg==
X-CSE-MsgGUID: 9aFuuGaVQcKBR/G7/LIWlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25009192"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25009192"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:50:09 -0700
X-CSE-ConnectionGUID: DdXhLnLjRm6K4xL53TTMzg==
X-CSE-MsgGUID: e8p8eG7JTEmDCX/ObJeFsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38591644"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 06 Jun 2024 09:50:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1AF702A4; Thu, 06 Jun 2024 19:50:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI/IORT: Switch to use kmemdup_array()
Date: Thu,  6 Jun 2024 19:50:05 +0300
Message-ID: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c0b1c2c19444..e596dff20f1e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -822,7 +822,7 @@ static struct iommu_iort_rmr_data *iort_rmr_alloc(
 		return NULL;
 
 	/* Create a copy of SIDs array to associate with this rmr_data */
-	sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
+	sids_copy = kmemdup_array(sids, num_sids, sizeof(*sids), GFP_KERNEL);
 	if (!sids_copy) {
 		kfree(rmr_data);
 		return NULL;
-- 
2.43.0.rc1.1336.g36b5255a03ac


