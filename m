Return-Path: <linux-acpi+bounces-9420-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCFD9C1032
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 21:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA97AB23B77
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25EB219485;
	Thu,  7 Nov 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgqWGMrR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7802185A3;
	Thu,  7 Nov 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013115; cv=none; b=owz4aDtb6GdNdHeoDQWVcew1o2TRYCG303jl3L4erCi/mkg6ZMRkNScGS8fe8nDOuM6pYiUG7oW/hO2ZtJdZzf47LEim5Esa3urT2vPao5qRJ8oYFBgRMLqUpyFMrsiC1+8Kv49WZGa6vaYnbrMB/bYujHNK47d6fmhFCv9qfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013115; c=relaxed/simple;
	bh=cSMvJkX51N5SZd4M/a76wB0H3R/PAuQxBIejQHOLvpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYPsNp6ed6NrB39HmG1fWw6wrrSouu0zx1WYP41ETdL/GvYNfoH0T+uHC754X3wmua7xKI5PjHenZFn5JkIosMmU6TjLyRfBFDdivpnbUo33rh2DomQRmuXM8qxbEwMRAmPmpYgXzOmHpBOi5z2/wqiX0OGYGZkbt8HWaTcmmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgqWGMrR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731013114; x=1762549114;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cSMvJkX51N5SZd4M/a76wB0H3R/PAuQxBIejQHOLvpQ=;
  b=cgqWGMrRqzCfhY8EJcqQb2Y7O+k0gEv5oifSIHUAa43NCtmOtGviRSEh
   iqIVgFLsm6bXES2chAufqKmDj5Ij45zAeDO16wG72k5m9VyvLnLvEoqSU
   8lzBOHNx0oNk22PmEQqemBpZQ4CTwfaiBx4B0TgmuncdiMwqMmr0zlfZd
   +Jn+asWwMrAncXKFCSPBBigSXoD3JJyXX2UFCNbJajaOGrZvmSS525/V8
   s+PPAmOzTj5tH+R6dskNET8u57bVi7TZAm2aeXypfkAcIuTwSZDstU2K0
   Zy9zL9aee1Xh+BAmpqGeZBQ6wcC4OofqmjpfnxI5PKtNJ6pXJ1qPXrmjn
   A==;
X-CSE-ConnectionGUID: kt6V8aHURfC0RZb4HNNgOg==
X-CSE-MsgGUID: C5enpCHqS3G+TZ56OWCKFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30300317"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="30300317"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:33 -0800
X-CSE-ConnectionGUID: JVKLk2P4TLSaUd1DIFL9SA==
X-CSE-MsgGUID: zxiGuk0jSZee4Mz22ZEHeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="90093588"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.195])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:32 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 07 Nov 2024 14:58:20 -0600
Subject: [PATCH v7 02/27] ACPI/CDAT: Add CDAT/DSMAS shared and read only
 flag values
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-dcd-type2-upstream-v7-2-56a84e66bc36@intel.com>
References: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
In-Reply-To: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731013104; l=1396;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=cSMvJkX51N5SZd4M/a76wB0H3R/PAuQxBIejQHOLvpQ=;
 b=z2BQlqBVQRzSIOea9aSZ3mKia0/yYjWvDVWSXOZmb9+T/4l35RyKgajzpDqsbaka1Sb+agahK
 anSxXg8dEN1DYqTcqqUY9ZV2pc/Vxksjh6VyGDUIWV6MiqayH97WPkG
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The Coherent Device Attribute Table (CDAT) Device Scoped Memory Affinity
Structure (DSMAS) version 1.04 [1] defines flags to indicate if a DPA range
is read only and/or shared.

Add read only and shareable flag definitions.

This change was merged in ACPICA via PR 976.[2]

Link: https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.04%20published_0.pdf [1]
Link: https://github.com/acpica/acpica/pull/976 [2]
Cc: Robert Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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


