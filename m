Return-Path: <linux-acpi+bounces-15829-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F7B2BAE5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 09:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AAD1BA4D24
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766892D7809;
	Tue, 19 Aug 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVUmU+fT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCFD2727FE
	for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589006; cv=none; b=Lr0P9YkajJSALd4bG6avfSJfnH0RWwnCKeQkeF2hRpYrmxE71nBoMpiZFOJskb6i7q1poidFtyLehe1pI7yweyM8pHdisDbhEO5vieKKPKNNv1SBHY4Fncz0MRL8uKVNx57u6XhlxkF2GDhuBbr1CTyiR1aNHrKjysPyofU/tvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589006; c=relaxed/simple;
	bh=qN3OyIl/JEbloqqidUjkpbQmbXoFWM8R/SHqx5Z28+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a16LYRuiMwWbElornNoXfPrSn1azXZlPY3SMFi7Q62z2AbWXdAmLqEj/HvAlF2M7+0zCDLaJFyCy9QKyresPcXdX9+THiR8sf24KJ7naYQQLRXBr/zruw1tOVXlVmxWBliJ6xC0voEaEgfCw6Bai07kkudf+tAhVGePWUH1QXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVUmU+fT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755589004; x=1787125004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qN3OyIl/JEbloqqidUjkpbQmbXoFWM8R/SHqx5Z28+s=;
  b=MVUmU+fTyBczuOu/XROIQa8bC2diGtisER1TSxoFR0ySWbawWxhvCzsK
   126c/X/PcGnK9clfX/rfTG5zgFqtX+yOw/hj0AqTEwNc6toL1al4SCr//
   zTQfODh++e4qaW3Fz/yyLjvkS3gaBekPiDcnBRSP7w5SrkO/ZlWbUFuxT
   P1xF3Aqk+UAqIxFiefYn93FTrmxR0KeX4DX9RR7W/W+6NtkbLDe7Z+pzb
   lfy+WPDFh1rIcGHrxyXfvLc4a3m/+4zbYoENaUFRiFvGoNK033/CpiSIR
   +WslK4iey8+m1owpiM+2BvFxdG+B9bEHUnaSZKcST07ba5l1h1YOKt3zx
   A==;
X-CSE-ConnectionGUID: IJGFChtbS8aLxfGFzuhSmg==
X-CSE-MsgGUID: R8lOuPSUSwyYbCTODPB+nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57894542"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57894542"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 00:36:42 -0700
X-CSE-ConnectionGUID: h5/52WaZT8qnQH9qJmnArg==
X-CSE-MsgGUID: V0YX5NVGReeFKb+jmmJEEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168016008"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa008.jf.intel.com with ESMTP; 19 Aug 2025 00:36:40 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] ACPI: PM: s2idle: Fix memory leak in lpi_device_get_constraints()
Date: Tue, 19 Aug 2025 13:05:17 +0530
Message-Id: <20250819073517.3962847-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add proper cleanup of lpi_constraints_table to prevent memory leaks
when  the driver is reloaded or lpi_device_get_constraints() is called
multiple times.

The function lpi_device_get_constraints() allocates memory for
lpi_constraints_table using kcalloc() but never frees any previously
allocated memory. This leads to a memory leak on subsequent calls to
the function.

Fix this by:
1. Adding a new helper function lpi_constraints_table_free() that properly
   frees the allocated memory and resets the table pointer and size
2. Calling this cleanup function before allocating new memory in
   lpi_device_get_constraints()

This ensures that any previously allocated lpi_constraints_table is
properly freed before allocating a new one, preventing memory leaks.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/acpi/x86/s2idle.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index dd0b40b9bbe8..1ae954c0ef15 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -189,6 +189,13 @@ static void lpi_device_get_constraints_amd(void)
 	ACPI_FREE(out_obj);
 }
 
+static void lpi_constraints_table_free(void)
+{
+	kfree(lpi_constraints_table);
+	lpi_constraints_table = NULL;
+	lpi_constraints_table_size = 0;
+}
+
 static void lpi_device_get_constraints(void)
 {
 	union acpi_object *out_obj;
@@ -203,6 +210,8 @@ static void lpi_device_get_constraints(void)
 
 	if (!out_obj)
 		return;
+	/* Function to free lpi_constraints_table before allocating a new one */
+	lpi_constraints_table_free();
 
 	lpi_constraints_table = kcalloc(out_obj->package.count,
 					sizeof(*lpi_constraints_table),
-- 
2.34.1


