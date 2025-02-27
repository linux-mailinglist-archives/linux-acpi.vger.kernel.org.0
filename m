Return-Path: <linux-acpi+bounces-11595-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B3A48C00
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 23:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C5A16D2C6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 22:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511A270EBF;
	Thu, 27 Feb 2025 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLG5yFrt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5623E339;
	Thu, 27 Feb 2025 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696523; cv=none; b=YXRtTleZvCX5VshOnBmYZsbT+0nLKKMr5qzL5k/MlBDw6W/LksgY6OXCHgJT7dSmM+Mq3SjGiREO8Y+xblcQezJRbV0m8154UFwRaX65O67HOkh5FjKw/wT49sp7mdetXXV+8YEybVst3fCJEcORJGvaNpYrr9fg5YaLf5WvYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696523; c=relaxed/simple;
	bh=FIMs4VAiybrc8QrSGXhSrl0CkOILDLgkNgxLuSmq4Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYXzHRUfhjikCtlNL4cmFrWihAY7GgBvtFtUxUTIMzvlG+3ZurvdlGlAoz+Rxx43e2R13+3kOl/Od7ywab9PguGolCTa6ERBJ/FP9JDYWwnB1pBlF80WfzdApMTl5QKuC3wi3kkubtxELHwyU2K6NZYNWHXqoWNK1VK0qd794U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLG5yFrt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740696522; x=1772232522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FIMs4VAiybrc8QrSGXhSrl0CkOILDLgkNgxLuSmq4Yk=;
  b=PLG5yFrtKedevXVHDe2199A//yBTB8iZxzgzmNh7EUUu8ZeXg5OwUa8z
   2k5d6o+qqpQfJs6220LoZkQxhwT39LRRbUOUxtzOOtpjZhunI3kJ6E26l
   GCEWNci1+bOKx1LBb/OQ5ajMZ9OpKiI/tfgnb0E/DW1Y1/fOsavn7kIf0
   ZOvQD4PTgGg18EeFKG4CL8GAQkQjKalYEUcj/zcnmFwQdkkTvtUkYek+2
   LVGW8soS1DIpflAsWajHkkt/IcFY9JawM6q/4+5uRhas9M1tJMnZuV9cT
   AAFf1MyXLtxQ1OsEupyKVIq6VQzFa12c+nvhcQAoV9EuO1SGSFf5qpuME
   w==;
X-CSE-ConnectionGUID: +GwKNAQXRdac/k9Xs2SiAA==
X-CSE-MsgGUID: 0pzID/GJRG2ukyv6VExsgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="64077567"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="64077567"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 14:48:39 -0800
X-CSE-ConnectionGUID: 6LcY9jrsR2+ZW8ferErEPg==
X-CSE-MsgGUID: doWqpQjJRhSO4HnPgdFhJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117187053"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 14:48:39 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 3/4] ACPI: Add documentation for exposing MRRM data
Date: Thu, 27 Feb 2025 14:48:27 -0800
Message-ID: <20250227224828.306537-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227224828.306537-1-tony.luck@intel.com>
References: <20250227224828.306537-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial implementation provides enumeration of the address ranges
and BIOS assigned region IDs for each range.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index 5249ad5a96d9..a3369cf95546 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -248,3 +248,19 @@ Description:
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
+		local_region_id: ID associated with access by agents
+		local to this range of addresses.
+
+		remote_region_id: ID associated with access by agents
+		non-local to this range of addresses.
-- 
2.48.1


