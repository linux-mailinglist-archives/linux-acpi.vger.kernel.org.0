Return-Path: <linux-acpi+bounces-12960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73865A84FB3
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 00:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8369319E3DFC
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 22:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AF0214213;
	Thu, 10 Apr 2025 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtI3RCGe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332320FA90;
	Thu, 10 Apr 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744324342; cv=none; b=Expc+wkJ6q+44Iw8CIByOUZekQPxtOH6lAXkio6SlEh6GdaaDVl9OgMk2CE+7OucVAH/obRuuWs1yXWp9qfaa2d6YnTfTvTCDRl8GkLY8/euF94zut3yAV1pz8XyMV01qur1KZoSKEn/qnDWtJ9doft2oHR6noycOioMpQtP5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744324342; c=relaxed/simple;
	bh=Mzf4z3JjeUDeBLBOc9nbGSbBtSvIhz9Znl+rjIhT6PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0WnvHbe2uc5yE5q4bLGp/H3Y8aX+H8BeFDFWl4+toD9jLuKplMNP0+jNhimjerIN2N+uyP3JwIczPr5PUiNvIUVUBZuCigccyamihYQdKYnikVzsjwouOHTwFKYbKnUNj8G3REHlya+245ujWPB6/eC0TamXGF3egkz3MSxlYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtI3RCGe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744324341; x=1775860341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mzf4z3JjeUDeBLBOc9nbGSbBtSvIhz9Znl+rjIhT6PU=;
  b=EtI3RCGet/fs3FICqRpUf5Qe3vFbvLErMH4thHkpfBQA+6+qkTlOsHwr
   zLW/X+RJ8zyriF0jfopST50AnXHbI4u/qs/qsxYROj0ZQCV5tgYv1UxFd
   ydnOrh5Jfti6zQQ45z8gegH87HI8DjoFVLZCWJRlCh21G6xhbPfDNa1tz
   tMt9u4d4cT36sN7/z/cOGm9YowjsVHhfN2YktRMFdv8v4rMy98tDKQapI
   0aMtOYe6ogJHYMlrmS/aktYrr5Esp/S1H4iqudZLbwhKEMVTBD4Xe2Yzs
   nUm5BtUYbr+YDf6WfKerKsIokCSzmSRoR08yFz8lklhg3FGde5ch0swW3
   g==;
X-CSE-ConnectionGUID: DVNr+4zcSseG1Lotvv/kZA==
X-CSE-MsgGUID: 8ojcstYsSFGRCSlQ6yKStA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56845638"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="56845638"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:32:17 -0700
X-CSE-ConnectionGUID: gl2gaP72QhigRiB89MR90g==
X-CSE-MsgGUID: zaO7X4RmSwSvUMSd1VjGkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="128988759"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:32:17 -0700
From: Tony Luck <tony.luck@intel.com>
To: rafael.j.wysocki@intel.com
Cc: lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 4/4] ACPI: Add documentation for exposing MRRM data
Date: Thu, 10 Apr 2025 15:32:07 -0700
Message-ID: <20250410223207.257722-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410223207.257722-1-tony.luck@intel.com>
References: <20250410223207.257722-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial implementation provides enumeration of the address ranges
NUMA node numbers, and BIOS assigned region IDs for each range.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index 5249ad5a96d9..fffba38f9ce1 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -248,3 +248,24 @@ Description:
 		  # cat ff_pwr_btn
 		  7	enabled
 
+What:		/sys/firmware/acpi/memory_ranges/rangeX
+Date:		February 2025
+Contact:	Tony Luck <tony.luck@intel.com>
+Description:
+		On systems with the ACPI MRRM table reports the
+		parameters for each range.
+
+		base: Starting system physical address.
+
+		length: Length of this range in bytes.
+
+		node: NUMA node that this range belongs to. Negative numbers
+		indicate that the node number could not be determined (e.g
+		for an address range that is reserved for future hot add of
+		memory).
+
+		local_region_id: ID associated with access by agents
+		local to this range of addresses.
+
+		remote_region_id: ID associated with access by agents
+		non-local to this range of addresses.
-- 
2.48.1


