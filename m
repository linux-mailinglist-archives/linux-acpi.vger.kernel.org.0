Return-Path: <linux-acpi+bounces-13296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4DA9D1CC
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADE79E20DE
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA0322D79F;
	Fri, 25 Apr 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="U0FN4Pug"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA521E0A8;
	Fri, 25 Apr 2025 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609671; cv=none; b=ExK5dIFr8O6ZZm0y8l4oMirXYrqGrvf3DHnuD5sVdip40XOrua8RrHcHxkbLsMbC9kYRe6xv4AVyPTytqcTJRgDbMxDMM5EYVo3+gqRnT/Tkx9fKHXE2jWbQgcj5aqEWSjeUDKO65jqZIcSL38+jqxVY7cdml0dEDVScnCtsL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609671; c=relaxed/simple;
	bh=fcUyw/L0DFzb2ipYI8FwhDAL9CGzl11b7KW9rFCp5jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVKTsXrAn7Ho34xBKHWpUwbUDkrzjNMpXPtCgpqeeh/TCR5byBGgv4ATk7//nhKvJWHVMzMqlIyqVdvBanDGV2EUGUvFKP3LOpm9lAqI/xtBMVBROixvBWUB/lC2IuY5wFYwh+6eHbEO0kZ0YxBbrFlY3VIdUeut5I/Y2qbp+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=U0FN4Pug; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EAEA26644DF;
	Fri, 25 Apr 2025 21:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609667;
	bh=fcUyw/L0DFzb2ipYI8FwhDAL9CGzl11b7KW9rFCp5jA=;
	h=From:Subject:Date;
	b=U0FN4PugFhphdzeDYjQcjsFyEKpMcQu3Xb3ANtKH4iO/BT7/hBo6em+ug8c/3qHYg
	 cz1EyYrKx8xxRLRLtx9Z1WU2ylDib/J9XCZ7m1kn85VkVo4VPXYD/snNxtVKcMfxGa
	 3iOgTIijMq57QjZl1R1cbs4/XjDCxLFQmWMBqlzCwgyWCb7NQOF0pf7tycjEf0CZjb
	 dcf6OLfV1w4DwCtnJ8vDBSC95M/RyhoCoNC6rl3QE2Ap2AUNobiX/82moeghz87alx
	 //it3eK/dsdcnf8G2zYO2bYSoEVHKXOm6VSOiqhvZf3TGILyekQZvrgUQf3r8MYlEe
	 uI2Daq2+5Tokg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 01/19] ACPICA: Drop stale comment about the header file  content
Date: Fri, 25 Apr 2025 21:20:21 +0200
Message-ID: <6168200.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <12671029.O9o76ZdvQC@rjwysocki.net>
References: <12671029.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Sudeep Holla <sudeep.holla@arm.com>

ACPICA commit 48e7c4cd893270dab8d05e6d75fbf23d0fcbb267

Commit a025731aec31 ("Restructure ACPI table files") restructed the
header files and moved lots of tables that are in the ACPI specification
to actbl2.h(e.g.: APIC/MADT, PCCT, PPTT, ..etc).

This restructure made the comment stating this header file contains tables
that are not in the ACPI specification incorrect. From that commit onwards
it has remained as stale. Let us get rid of it as it might be misleading.

Link: https://github.com/acpica/acpica/commit/48e7c4cd
Reported-by: Sahil Kaushal <sahil.kaushal@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2e917a8f8bca..a3008bae6f48 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
 /******************************************************************************
  *
- * Name: actbl2.h - ACPI Table Definitions (tables not in ACPI spec)
+ * Name: actbl2.h - ACPI Table Definitions
  *
  * Copyright (C) 2000 - 2023, Intel Corp.
  *
-- 
2.43.0





