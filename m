Return-Path: <linux-acpi+bounces-9869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A789DFE16
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 11:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4B4280A76
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557351FBEAE;
	Mon,  2 Dec 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMhHzCKk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75F15A8;
	Mon,  2 Dec 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133991; cv=none; b=CIs71xYvHIwpEBd4lc9sdRhAsAwSayxQPxET98zOuYTcwSBrE3RV7BDHIu/iRiedmlT9xZcVy2DYLcsitph0fRa8rluC0dblJYb4p5NZGcVAwg8ZxFx+2hbKINkSzxzgi4AGqRYaaDDcWc1KI1PW2bUWTM/pp4MNL0S+bLKZ5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133991; c=relaxed/simple;
	bh=tpy+AYjN2uzbBBhjI4dQGOhHluG542LfSgKZ1ajIBiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EwgvARlJpVhdiOilMaZYNdJv038UsmwjvBa8te8g7KgKDVcy4V5E1WshMPy3YQq9cslhc+j80LsAWnJdr46v+zgPj8I53a6uIZ6z16qYtnif23fBnJ/kRACRj40fTs8xj0wRZo0C5C01nQKgKPM0a3jRnRWQB1brA+HE96Hty0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMhHzCKk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733133990; x=1764669990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tpy+AYjN2uzbBBhjI4dQGOhHluG542LfSgKZ1ajIBiU=;
  b=CMhHzCKkNKJ7KR8bCaKUCSyNnmNir5bxcTp9LqUvatdmvtjN7hwMCQPO
   svOvDHC63IfRpxZdRsCo0ZD2rzdfTv5aeoY997zl8opV7VpeYoxtkJEGB
   23zjBaoAy5aowZDZB5buoOD4KIQ6v7zCXjw2qPhVOjfDpePN4Wrlu1jKV
   SX3jNBOrWcH8rjY090jB/cbvj1oDJp++WPt+rkX70SlzIsbu/oGOQJyVC
   Lf3yF31M5X2ZZ4zxHPQ+OPOWJfAMVuuC9aXGdUYBjbLl/ZNUGOIaDUE+v
   fCLDN/jxRBhwYNA5QRk1FpV9QmcItBmqQ8HpL54/lhThSb2Cc8YPEAW1i
   A==;
X-CSE-ConnectionGUID: h79MmLaWTrCJMlfqkX8pQw==
X-CSE-MsgGUID: BfRc359WQz+91LHW0RhEeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="32647447"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="32647447"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 02:06:29 -0800
X-CSE-ConnectionGUID: GRmKKbWxSYG8eqng4hw0jQ==
X-CSE-MsgGUID: J2Uu1T3xTMertDKYaK2jSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="97133350"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.61])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 02:06:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] ACPI: resource: Fix memory resource type union access
Date: Mon,  2 Dec 2024 12:06:13 +0200
Message-Id: <20241202100614.20731-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In acpi_decode_space() addr->info.mem.caching is checked on main level
for any resource type but addr->info.mem is part of union and thus
valid only if the resource type is memory range.

Move the check inside the preceeding switch/case to only execute it
when the union is of correct type.

Fixes: fcb29bbcd540 ("ACPI: Add prefetch decoding to the address space parser")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I only came across this while reading code around these parts (not
because of investigating some issue).

 drivers/acpi/resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 7fe842dae1ec..821867de43be 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -250,6 +250,9 @@ static bool acpi_decode_space(struct resource_win *win,
 	switch (addr->resource_type) {
 	case ACPI_MEMORY_RANGE:
 		acpi_dev_memresource_flags(res, len, wp);
+
+		if (addr->info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
+			res->flags |= IORESOURCE_PREFETCH;
 		break;
 	case ACPI_IO_RANGE:
 		acpi_dev_ioresource_flags(res, len, iodec,
@@ -265,9 +268,6 @@ static bool acpi_decode_space(struct resource_win *win,
 	if (addr->producer_consumer == ACPI_PRODUCER)
 		res->flags |= IORESOURCE_WINDOW;
 
-	if (addr->info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
-		res->flags |= IORESOURCE_PREFETCH;
-
 	return !(res->flags & IORESOURCE_DISABLED);
 }
 
-- 
2.39.5


