Return-Path: <linux-acpi+bounces-15849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BFB2D322
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 06:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0586869A7
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 04:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03C194C86;
	Wed, 20 Aug 2025 04:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GP+5wQBE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61E78F34
	for <linux-acpi@vger.kernel.org>; Wed, 20 Aug 2025 04:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665075; cv=none; b=VFuRileHkQbOd/gU8zGGjBYf+ileAu8bEor5gsoR/R1Qg16fQtcp4zA6OKHjnZzMSbC1FemaOm7qGgo7J9at9t5kGlyFLUJDcFpXZ+KSqOUI0kd9+Yypon1DCycspAjV7OytsvVjPeatdWrUoh5fIg6HzirSVIbRA5BSBRiAej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665075; c=relaxed/simple;
	bh=Wuo+MVG+FGFpbnTbhgHJA2dTrPMPvyXhLahkY+nbLAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gGnLJPiA7YUlIGsPJjSW5nKJcH6soa7lynbj/j38PVVdhBnjh22lyfLbKDlhUp/lv9d093YQrZdmCS+xekou0cmQERL5rzFqrZ7VbRsRDc8IjtqnAHwCSJlfbZ7CWQ3jf/gElLjIcw4oWU2d4l/NwVMUoFshf/Y+boucChCzz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GP+5wQBE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755665074; x=1787201074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wuo+MVG+FGFpbnTbhgHJA2dTrPMPvyXhLahkY+nbLAA=;
  b=GP+5wQBEC4kPYDoWT1Oqby2PHCI3abEZ+lLBOWAvwnbnFHuouoRlPWH2
   fhpl8TQYc9LqBe1c1Wum6zTIVlIeqb+jSP/Pz0AGDhtcPBs5B1jMn+StD
   ZALaUOpyQ/LF2AcKXqzvfHcaB4MM0qfixojbeOY5nNW869ki2fM2xRwMu
   8qFp4nuF4RJEYNHW2+Q060UltvFDj9pV72dbcVR/6JrqDR9x7oP7ixyTY
   t2i/DyxhF9H7sxVPE1FXH2owHuX0rCSe7lyRcoXQvIlBf6njhL/BtF2Sj
   X9lOimL9zoDCf+Xe2sd8tKBhIORq+jp2AEiUXbdVjfnJjFLQfDXAEyyQ+
   w==;
X-CSE-ConnectionGUID: H3UkthB4TGy2MVZ9T4oSlA==
X-CSE-MsgGUID: URr6e4RwTW+CqWxeFGYNRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57992491"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57992491"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 21:44:33 -0700
X-CSE-ConnectionGUID: aiILRsOERx+HTP0gswZ4Vg==
X-CSE-MsgGUID: 4JBBgmBiR+KB+Z6cBSiyXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172271647"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2025 21:44:32 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] ACPI: Battery: Fix incorrect fallthrough in extract_package()
Date: Wed, 20 Aug 2025 10:13:09 +0530
Message-Id: <20250820044309.4133802-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect fallthrough behavior in the ACPI_TYPE_BUFFER case of
extract_package().

The current code processes ACPI_TYPE_BUFFER data and then falls through
to also process it as ACPI_TYPE_STRING data, which is incorrect. The
buffer case should copy the buffer data and then break, not fall through
to the string handling code. This ensures that buffer and string types
are handled correctly and independently in the switch statement.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/acpi/battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6905b56bf3e4..18fc5d828e70 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -445,8 +445,9 @@ static int extract_package(struct acpi_battery *battery,
 			case ACPI_TYPE_BUFFER:
 				if (len > element->buffer.length + 1)
 					len = element->buffer.length + 1;
+				strscpy(ptr, element->buffer.pointer, len);
 
-				fallthrough;
+				break;
 			case ACPI_TYPE_STRING:
 				strscpy(ptr, element->string.pointer, len);
 
-- 
2.34.1


