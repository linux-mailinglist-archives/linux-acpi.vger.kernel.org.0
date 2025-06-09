Return-Path: <linux-acpi+bounces-14230-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB9AD1782
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 05:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2087A21C7
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0E2571C5;
	Mon,  9 Jun 2025 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8aUmXJR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6421E9B31;
	Mon,  9 Jun 2025 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749439742; cv=none; b=aMr1NyF8uI6HP4h7N1SByddx1jIrgOyL+7vwIlq4nnpXf2G4TmW8XkPuPAiM/Z21XDPKKBDS4tDq1Oa/5SECdavahv/hYe5CLPoxko4S3FMUnH5kYcjWkANFm2TN4VrnHg53lDZ/NZKYqt/7KZPH6N+ey1IKFDFwAotG9zuWtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749439742; c=relaxed/simple;
	bh=FIZCeDHhIcD/G5rEpEosyRIB9Fjmx7EMGigu02ZAuVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWeqvYu01DvLWHmVC8d1EuvTKxG7jcb3hVlJ4W53JzO5af+slkcq2XWgWIHDu3Y/1C13sZKXAyQY0L768zIj7tp4HEAo44qomrjXYhBF0i4xzE7OSnmbPA3PdGxHbnaSpJ3Cg1YWyqViyqt4LFKEbeeqJBsFDpXhiNT2vyP4Srw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8aUmXJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6C4C4CEEE;
	Mon,  9 Jun 2025 03:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749439741;
	bh=FIZCeDHhIcD/G5rEpEosyRIB9Fjmx7EMGigu02ZAuVc=;
	h=From:To:Cc:Subject:Date:From;
	b=n8aUmXJRY6L/Vhp8K2Xn/qvFqya7E3YTQT8ObMuDO89HQmpt5fiJInJ9ZyOHHbFkd
	 5ff3bpf44N+TCq853Fur3XGR8CbGoO76Egeau4pp4ZNcCx1z5RwaCEXC/9d3UeHWHi
	 D+m0lUKmy4YTqBR/Lk8bCdn40yFe291xPpK3dPqjvob162N4aIPsL4KODC1idWbLCB
	 lk3Gag59DRONceMvLXDUTqCZ3Mi9doW9ySiQ+guEMw9iF83Vr/tpwpObufNIICcghA
	 xtIa//Nbgo32rHa/HFoK1ebZxBuf+wcituOk7tXLxsf32Zp/7izecNrtMwd90+UU7S
	 2Zo0XY05uHS1A==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH] Decrease `AcpiExTracePoint` verbosity
Date: Sun,  8 Jun 2025 22:28:34 -0500
Message-ID: <20250609032839.525087-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Early in kernel boot pointers can't be used and so %p shows up
incorrectly:

```
extrace-0138 ex_trace_point        : Method Begin [0x(____ptrval____):\M460] execution.
```

Later in the boot %p works, but it's not really actually useful when
the pathname can resolve properly. Adjust the debug print so that if
the Pathname resolves that the pointer isn't also printed:

```
extrace-0138 ex_trace_point        : Method Begin [\M460] execution.
```

Link: https://github.com/acpica/acpica/pull/1013
Link: https://github.com/acpica/acpica/commit/bdc2a4e646f097b693aa60f1f2c4228d1e31b0d1
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/acpica/extrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index d34497f3576a4..36934d4f26fb4 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -136,9 +136,9 @@ acpi_ex_trace_point(acpi_trace_event_type type,
 
 	if (pathname) {
 		ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT,
-				  "%s %s [0x%p:%s] execution.\n",
+				  "%s %s [%s] execution.\n",
 				  acpi_ex_get_trace_event_name(type),
-				  begin ? "Begin" : "End", aml, pathname));
+				  begin ? "Begin" : "End", pathname));
 	} else {
 		ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT,
 				  "%s %s [0x%p] execution.\n",
-- 
2.43.0


