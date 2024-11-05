Return-Path: <linux-acpi+bounces-9326-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687F9BD4D4
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 19:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5812A1C227DB
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965551EC013;
	Tue,  5 Nov 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7BFJoYR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5561EABD0;
	Tue,  5 Nov 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831916; cv=none; b=CCm531oWxwvLuCuTpPHJgEwyM2DGXaguYRr60JO5bsXRZxmL/wghLHCwHcr8XusBXz1QA2pfVHLMrjyPisvMsHpFyi6nPaaqnEPGYmI6ROvoy38tfS79z7OKBBIHncOVlmNjO6pJENeGiSMSOWmVX7KyX1iyQCAFhOcxTY+ymJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831916; c=relaxed/simple;
	bh=zH2SgYF46BdWpTcAmHbhUXYZc6rF70HffsU2wUsj/bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lF13LZKe4PqreASJFUhrHP2hO1kFx0KU0ufSpvblDjLd180UpCARVSphCU1pVdWrh+iI2LQZ0oSFBMPgerIgga+j0KjX9JplLXWHLBwqbkL/SQAMciOMcVijLz18qqcRh26FZT41TXgPEWUrGytHio9852Fqs4hpVQrI+rdsCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7BFJoYR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730831914; x=1762367914;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zH2SgYF46BdWpTcAmHbhUXYZc6rF70HffsU2wUsj/bc=;
  b=i7BFJoYRprK7bSBpF2FcRWQhnzENDoWRzldtSYFnKcc7s6tYT2aAk7ao
   kmAuTJ7rGDxoFd1uhDGgnfqW9BECg0jwv/Ol6GGNHeDb/zGcJIU9ODEX2
   g2a+W/qs8dFS8kRcp0AEQ+Xx/3h1FkyHb8NFHLah3JMsmWlQGY0PclXDp
   P2mytQmt+4ZCPpT4qFcP7znQRowiCgmijzcmHOY/ofAq2D51Qjcdlq8fI
   Zsm3AkQ+Wua6fR3aoari2u/5d67srRsKSNe9HpbZxV8Ysgg8Iqqy2ErMC
   j4+OlESr4hFASEcOEWw/zgZ5oDdhWLbzbJoTG65orcz0knk8RdWMsmA4N
   A==;
X-CSE-ConnectionGUID: qV0vD1K9QISfbTJn1O99Qw==
X-CSE-MsgGUID: sqHMJffpQNyT2T9PLHlskQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30708381"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30708381"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:34 -0800
X-CSE-ConnectionGUID: zvauHI/8RPu19Qjb5ld8sQ==
X-CSE-MsgGUID: Rki2SOgDRSa7Gl6DAHTNkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84948677"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO localhost) ([10.125.109.247])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:32 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 05 Nov 2024 12:38:24 -0600
Subject: [PATCH v6 02/27] ACPI/CDAT: Add CDAT/DSMAS shared and read only
 flag values
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-dcd-type2-upstream-v6-2-85c7fa2140fe@intel.com>
References: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
In-Reply-To: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730831904; l=1336;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=zH2SgYF46BdWpTcAmHbhUXYZc6rF70HffsU2wUsj/bc=;
 b=7OpkxOF7jW+6i1JPYWi6nLVG0/uyzNOY4VG2smei3DZgilsZW+mSP/1Js3GdDyZ59Bj9yyPk/
 z4l94yGsD9BDa11Gvqx5fugjutE/j8qYTtLANVVpSCAoqSQgHp7XNb8
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The Coherent Device Attribute Table (CDAT) Device Scoped Memory Affinity
Structure (DSMAS) version 1.04 [1] defines flags to indicate if a DPA range
is read only and/or shared.

Add read only and shareable flag definitions.

This change was merged in ACPI via PR 976.[2]

Link: https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.04%20published_0.pdf [1]
Link: https://github.com/acpica/acpica/pull/976 [2]
Cc: Robert Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/acpi/actbl1.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 199afc2cd122ca8b383b1c9286f8c8cc33842fae..387fc821703a80b324637743f0d5afe03b8d7943 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -403,6 +403,8 @@ struct acpi_cdat_dsmas {
 /* Flags for subtable above */
 
 #define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
+#define ACPI_CDAT_DSMAS_SHAREABLE           (1 << 3)
+#define ACPI_CDAT_DSMAS_READ_ONLY           (1 << 6)
 
 /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
 

-- 
2.47.0


