Return-Path: <linux-acpi+bounces-10887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C656A27027
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 12:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1282916221B
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6314720C025;
	Tue,  4 Feb 2025 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAMUVlNH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911C202C44
	for <linux-acpi@vger.kernel.org>; Tue,  4 Feb 2025 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668144; cv=none; b=d5aFN923d9vlUHhjw6f96sle48f1whifCGquao/enjQpv+J8wh84JSAVagnAyFtXaqGhy8VUhqWjyqJXbP9KqzWrVHka8zdeEVa5cvM5eWkzK+Dhu2hJPjXCxEJmOJmMa8UokakPPyLtolF5E0oEIWnTPml7PIQ1fVLwKKO+QkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668144; c=relaxed/simple;
	bh=xY6Lnvnb8ciBVRu9nDpfbOScC58vjnaonprn7UBnfaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T375pG6oYjE6RPGOUVe4DM1Zga58fyo47PabAABnBBOcO8eMthHzuSnmICLWDxPgB44fApoSAUJnuPfa+wnglrnBvArGhBF/DvPiRiyLDFbE+tp+9pMVr9vYIBR6GoVewFMY75tYiAmGp42h96mH672DJjLAyoeN2paU7mJdYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAMUVlNH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738668143; x=1770204143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xY6Lnvnb8ciBVRu9nDpfbOScC58vjnaonprn7UBnfaI=;
  b=eAMUVlNH0coxOuaxRRBpAzb0Wi9bvWfEHTw7lAOXLvTH3G5ivPh6Ndwd
   X2eTliYJ0o9ySSfuF1h5HK1/Mtmif2o+njJoNPmykEPfJZupw0eCfLJwn
   9GI0CWEvJ+Rhk3hR7Jm3c9AY2YwagQo1tOxMfIfz1oFK2jgINdK5La7y4
   BxGRedEbFBLdYxLYJGS06bHt+jPF0Nj9vT4xAid5wuqRWtXNd98sVSMF/
   KSI3O4CHpiKnuxCujHFJSWsvKKnnGwlar4S/cX06EwNBnTaMJxwn/AM6D
   bEowjNq5A0+JvcQsluRxbAyQf9e/Xw9EtzZnjKBsKAYLOOi/PR1zhFBPT
   g==;
X-CSE-ConnectionGUID: bXy3AxiZRk696jicOkG2GQ==
X-CSE-MsgGUID: GNmCACJHT9SW9keCuh4K7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56618822"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="56618822"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 03:22:23 -0800
X-CSE-ConnectionGUID: yHpNPed2QreRPF9Zcd4qZg==
X-CSE-MsgGUID: wt1Z1fDAQn249sOpD3GO9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133817823"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 04 Feb 2025 03:22:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5A41C25B; Tue, 04 Feb 2025 13:22:19 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Use my kernel.org address for ACPI PMIC work
Date: Tue,  4 Feb 2025 13:22:19 +0200
Message-ID: <20250204112219.3969629-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to use my kernel.org address for ACPI PMIC work.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..d6283fad64df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -355,7 +355,7 @@ ACPI PMIC DRIVERS
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Len Brown <lenb@kernel.org>
 R:	Andy Shevchenko <andy@kernel.org>
-R:	Mika Westerberg <mika.westerberg@linux.intel.com>
+R:	Mika Westerberg <westeri@kernel.org>
 L:	linux-acpi@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-acpi/list/
-- 
2.47.2


