Return-Path: <linux-acpi+bounces-13375-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9367AA1C14
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Apr 2025 22:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A146825A
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Apr 2025 20:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8044269AE3;
	Tue, 29 Apr 2025 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGBXkxLc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B54266F16;
	Tue, 29 Apr 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958265; cv=none; b=j8ru5f4kENjxCnu0qWtVymD53X+ljj25iobGKhf1ymU8NSkocWP66yNCpBKrnbtH/13z6xTiCisKOmEkcTLYhACzX6dNyviu0TTsUzzNsTUl01pSDG0yjcoaVkMQPVAeMLhsGMDTM2UOzWdJFIA15LxD1CgUNOc/p8f2Ry6qKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958265; c=relaxed/simple;
	bh=Mzf4z3JjeUDeBLBOc9nbGSbBtSvIhz9Znl+rjIhT6PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epNv+wYR3fdzWw9UONGTv3cgZF2YTQYNqU97i4Ni/5HF4RN/yTda4GP74+Kck7z1pJsNn1hQ9PLFTN46e6QO+TkEmaNMG7m++2357uC7h7Fui75x2ERO/ayxhcHjxGuRZTklnJctoQFl8VFsMe5p6fYT501dtpxCnmxHF3paTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGBXkxLc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745958264; x=1777494264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mzf4z3JjeUDeBLBOc9nbGSbBtSvIhz9Znl+rjIhT6PU=;
  b=IGBXkxLcwB//PnxoizvDfaAkgEz8t0ZfN3cwroqSixtpKYcrdwRaUlwD
   M5QvJHGZkIQseVrhhc3tHaM4SyApgnsbI+vvWWfzCCShoNjCzm6v3n28J
   8Cxhgrn0RLIkjHYTEXsyH/g/D2qs3WKASjry++3qNoUv4H8bcqYdBTIQP
   Vxe18jG/LcHTzxp3lM7qVO1V+Q1pHcUxJKpXe8fSSJhnnlRZ+YKXLjU9H
   7wq4LJDbLcsKj9XRyuVk3RauIjLLtjC94beJnFVb6nN/TMBIAtF5ZnwCr
   sDv9Eg92vzRmtZ46fxhbNfXjh5C3pteTlY4m5DMS9KpfPJWWgAaH+YhyZ
   A==;
X-CSE-ConnectionGUID: jP4MXr70QfSoefyasgUo6w==
X-CSE-MsgGUID: C1sys6H0Rhe9h+n/PEmnqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47314075"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47314075"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:24:20 -0700
X-CSE-ConnectionGUID: 32uMB13fTMuHcSEcrV7dmg==
X-CSE-MsgGUID: 3nUPlzM9Roy3ySo/10bv7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="139036137"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:24:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 4/4] ACPI: Add documentation for exposing MRRM data
Date: Tue, 29 Apr 2025 13:24:11 -0700
Message-ID: <20250429202412.380637-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429202412.380637-1-tony.luck@intel.com>
References: <20250429202412.380637-1-tony.luck@intel.com>
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


