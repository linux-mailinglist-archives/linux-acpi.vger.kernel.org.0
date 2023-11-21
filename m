Return-Path: <linux-acpi+bounces-1668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80377F2D5A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 13:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA08B21013
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C74A987
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0ATkxLA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9FF12A;
	Tue, 21 Nov 2023 02:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563122; x=1732099122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vkKEZYR1JQ2LvJYNE9fzcULsL9BK72aBp+vTKNFQKvk=;
  b=V0ATkxLAX2zb5epvwIRWvnnIjc7K4gP1JADnDtvS9t7ZJ/28zKIY+boV
   Qx8qVfTtmeYJtA49bBwArz1yXAaiHOgwxsKTuRvGW5IeSCBB1TNlyKToI
   fJUDeraEm2hV9mZZ8IoY0gDsxdTVICfoS0S8H8OCqlEt/uLkLk1rFWkYl
   gbhRXGxXV20s/BfQvvSdm8AIehMSuQFqJT3CbgIrSb2BnrAxql98vlHQ8
   y0zgT7S3NbHklZJzJnhF5QHbt8ejAdTSVm/oRn3cBXEidMIRz3HPfHw5g
   KTQnDECW6GJaik9bfczUU0Emhuyfxg7dQ2lV6gZlnjF6JYRdHz6k2F+py
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371986859"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371986859"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:38:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871920"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:38:38 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	ardb@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/6] compiler.h: Introduce helpers for identifying array and pointer types
Date: Tue, 21 Nov 2023 16:08:24 +0530
Message-Id: <20231121103829.10027-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121103829.10027-1-raag.jadav@intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Introduce is_array_type() and is_pointer_type() helpers, which compare the
data type of provided argument against the enumeration values defined in
typeclass.h using __builtin_classify_type() function and identify array
and pointer types respectively.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 include/linux/compiler.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index bb1339c7057b..b4f656002c0f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -242,6 +242,11 @@ static inline void *offset_to_ptr(const int *off)
 #define is_signed_type(type) (((type)(-1)) < (__force type)1)
 #define is_unsigned_type(type) (!is_signed_type(type))
 
+/* Classify data type based on enum values in typeclass.h */
+#define is_array_type(x)		(__builtin_classify_type(x) == 14)
+#define is_pointer_type(x)		(__builtin_classify_type(x) == 5)
+#define is_array_or_pointer_type(x)	(is_array_type(x) || is_pointer_type(x))
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
-- 
2.17.1


