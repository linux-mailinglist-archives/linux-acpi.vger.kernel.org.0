Return-Path: <linux-acpi+bounces-15696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32639B26C6E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 18:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78970172283
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44F220F55;
	Thu, 14 Aug 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ec8Ya6XB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177E1DD889;
	Thu, 14 Aug 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188237; cv=none; b=MGev7OGRX/HhairEvA+LWD/M86KukiK9yA36OiXCKVeHDow/1kqf+5A99fAX5br2ol2HuZrKIZjf1tArzHtFA5vKXtq4v6/Ap2WQQk9Y2fym75Nv5O+pSjrXx8YLRYNzudqUWV5+Oy7qXFnJPjZbOvbn7q7+oFs3cQoS8oOxi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188237; c=relaxed/simple;
	bh=VP/ziay4XX20JtXwVWku6vtOhHXC9F3yoIDWnipRVhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhKU3tm26LkH0hhFgtLEdBrMdEvZ1SgK/IdK7K28JRK2q6oKcfaoGpO5eVcyv49WXw7zKVwOosJVHWQXEzaKKu82fE5nIcBXk+wYlRpYYhAqMN894xmd1yz/nV4P6hnNuHZ4zEKb/iR+SbomrFnhab1U8w8RLa3hBen3svF1gVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ec8Ya6XB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755188236; x=1786724236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VP/ziay4XX20JtXwVWku6vtOhHXC9F3yoIDWnipRVhk=;
  b=Ec8Ya6XBO8lDSCu0t7p9uNAMqPriYcuHX2wuAhnk2/nOaRXdBlEbe/N+
   Q0fTDbjlnCGYvogIjCn4fm47nwK/d1Qu2u1Ng6fXvRyH+tQIwpWhLGtSa
   TQqRO0jI2zFz2d2uuzOXBFAlxRlPFfJs2PXAx/ozBqjsd8IiAkOtIUPv8
   Va5vrFgJoYZiCIDTsPirjCTAfxXzbbP72beI63Qr5/MaVNleOa0Db3WAW
   GzF6R63tSAkQK1EkbzWJ2bld06+GpGrKVNUPxh6IdPet3BW81uwoqM3l5
   FhtEqBca/JN6XS/S/Nxq5NW+gLV3vvhqOUFr8Pfm7cx0jdbeyeF6LUuA7
   g==;
X-CSE-ConnectionGUID: bLQ77NQ+RyGLNb5Hi+UNyQ==
X-CSE-MsgGUID: Sy+6P0JHTEaonqyw56Vxpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57435664"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57435664"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:17:15 -0700
X-CSE-ConnectionGUID: kUnWyTSASNmiq/wvy5LufQ==
X-CSE-MsgGUID: j09L6sUWTfKzx8dpzmkifg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166435476"
Received: from inaky-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.60])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:17:13 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Zaid Alali <zaidal@os.amperecomputing.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Lai, Yi1" <yi1.lai@intel.com>
Subject: [PATCH] ACPI: APEI: EINJ: Check if user asked for EINJV2 injection
Date: Thu, 14 Aug 2025 09:17:06 -0700
Message-ID: <20250814161706.4489-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On an EINJV2 capable system, users may still use the old injection
interface but einj_get_parameter_address() takes the EINJV2 path to map
the parameter structure. This results in the address the user supplied
being stored to the wrong location and the BIOS injecting based on an
uninitialized field (0x0 in the reported case).

Check the version of the request when mapping the EINJ parameter
structure in BIOS reserved memory.

Fixes: 691a0f0a557b ("ACPI: APEI: EINJ: Discover EINJv2 parameters")
Reported-by: Lai, Yi1 <yi1.lai@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/einj-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index bf8dc92a373a..99f1b841fba9 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -315,7 +315,7 @@ static void __iomem *einj_get_parameter_address(void)
 			memcpy_fromio(&v5param, p, v5param_size);
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, &v5param);
-			if (available_error_type & ACPI65_EINJV2_SUPP) {
+			if (is_v2 && available_error_type & ACPI65_EINJV2_SUPP) {
 				len = v5param.einjv2_struct.length;
 				offset = offsetof(struct einjv2_extension_struct, component_arr);
 				max_nr_components = (len - offset) /
-- 
2.50.1


