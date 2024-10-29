Return-Path: <linux-acpi+bounces-9099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0B9B53CC
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8EAB22444
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A7208232;
	Tue, 29 Oct 2024 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEw04E8W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3280B207A3D;
	Tue, 29 Oct 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234116; cv=none; b=PJbjSwYdO5OboGUaXGIqa92KXuVtvLKeWVh+zh5nW7aoG5sA58D9ru3/En8LCB+yqCTm5URVnYjBAlpCMECUjlPW0DbDLVhtbtSzLkojAn3XVpIPAzDmBMF1eE3yMoBgZ6eIu/0f93ho3AW0vBFOoA39N9LC0r8fqMFHM1bdkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234116; c=relaxed/simple;
	bh=WcyOhqmbAJbI4zlEI4VTeKAJjqyCmcPYDhiIc+W374Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QStHChp5sEkbRl0dlgrnWNGCDDI3xrM9ysUrGF/7tTQYLV7ESn3GvykBAa3D/K/F8HOp0lhhbNYu+Ik+2+tSdhfJytQUAfzxftiG1nLiaf58t0cKNr+EE3l3RYOibOXIIT40+9ZUPR5lI4Edd3UbvjEOjUBo2Z8fYslbgEeFVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEw04E8W; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730234114; x=1761770114;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WcyOhqmbAJbI4zlEI4VTeKAJjqyCmcPYDhiIc+W374Y=;
  b=UEw04E8W2B7AR3xPOLZS48UhL5hQHaoEBAsue88jI1J7IDFdghTvEsRu
   hQesgeQyOM7DdBKyAgNAsS42xA6A7HqAoHqFQfXUKyogMsLjmfoVbnP7d
   tQB1xz/2uTnRYE7upozmZtiENlDslwr4OToRpyT2rCdVPOI5ziGms6Ris
   eNVJIqz1W0vdnzIj3lXrrILpYAyCMcocvX3nQFV1QbmURJRYA7CafVY+j
   skEbwxmySxR7k2ElGv99y1plLKc8qnwOF95pgesAwp7d5UvGULiCREOI5
   gqJrafiwRcqIXZpBnthijILQl42sS6hbwcwDvVhvgXNVIjuIH/jd1/Vc7
   g==;
X-CSE-ConnectionGUID: 0HXRcNTjTRajql04zW/bVA==
X-CSE-MsgGUID: oY43DDEcRfWR/IGsdBZVvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29865473"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29865473"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 13:35:13 -0700
X-CSE-ConnectionGUID: oAuC1Uq6S7a7c4RouEKYng==
X-CSE-MsgGUID: 3Zp9l1tySrmBzjLb95T34g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="81712105"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.108.77])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 13:35:11 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 29 Oct 2024 15:34:37 -0500
Subject: [PATCH v5 02/27] ACPI/CDAT: Add CDAT/DSMAS shared and read only
 flag values
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-dcd-type2-upstream-v5-2-8739cb67c374@intel.com>
References: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
In-Reply-To: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730234086; l=1418;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=WcyOhqmbAJbI4zlEI4VTeKAJjqyCmcPYDhiIc+W374Y=;
 b=8OK8+P3kLn1IozCNb0Hd33oFxcWFqHzI7FSfElJ4iisM6KLFb7nquGjsxJAWeO2CYLljmQGb+
 X8EWao4NwqdA+opFS9BdO7+0GDRjnUUMr2Ap8lZ9s0+vT3F7ypqdE98
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
Changes:
[Rafael: new patch based on requirement to send an ACPI commit]
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


