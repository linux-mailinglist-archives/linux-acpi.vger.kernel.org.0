Return-Path: <linux-acpi+bounces-20315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 474D0D1EE34
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD5B0302FB90
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F9399A6D;
	Wed, 14 Jan 2026 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSoVGui3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65B39903F;
	Wed, 14 Jan 2026 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394570; cv=none; b=TOsCqgFnUEmWUZthkivrcdCQwM3rSP8J09Rwxh3cJ/NHxNAEsy0EddLYmIlA5lFY4wx26bD6fKFLxD0FpKPu3FvQ0PbkQBT0JpoHsMH1QJLM8grpuJ1+vbhzq+weEMEC3ta/Mqfd3Yjjjok3QdpPOOO8tQrGzhthDiYRXeeMdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394570; c=relaxed/simple;
	bh=MBQcKK1xMQX9NcrjlkMsQfXp88GRYyIMCOxYz5PnoRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oW3VbXBEj6hu9DZcoaxAvqrtK0mzF0pWENHzSszuwf8vcZgoGe2ELQXK0ft0ZKNSb8u59bu1vGl4M2DGcRAkvbMga6VjbkuD+AmX23NPeZzWmmcpi8y5MGb9tuqJj2bhD8ukHvw7ldkOTSk9x0NlYRcyy53lgYBbocEn8UiShEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSoVGui3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9EEC16AAE;
	Wed, 14 Jan 2026 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394570;
	bh=MBQcKK1xMQX9NcrjlkMsQfXp88GRYyIMCOxYz5PnoRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSoVGui3E9fZTuxfeM7RciRd6iwEZpNXcFY1zWsioEZuCNslen9iyisrLmubXDqwP
	 4PUycgPKKr6G5E4h0CRDrQL5j9t+4E95MDyOTc47C7LT20zRpcqPTRsL5ncIO7F3ZH
	 nBzgar7wIqnlkN6YYHFMcE2lTYjYUFgFA72HVhBSl4QlQBKh7r+fGR35pT949OAmP+
	 aziHHNlhL0bPFMy0DVgb5j9MFIMpwcvN3vvdE3x9DgWbF8kp6mj2s+ajXE4HG1Equ8
	 +mG1kuEyJGcX+K8qboDDWCEMxO45j9BtiA/mAPpX82gdUsB+dE7BBWg4Qo4e7zXeWB
	 fahgLKqb/b21g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 02/26] ACPICA: ACPICA: replace ACPI_FREE() with
 acpi_ut_delete_object_desc()
Date: Wed, 14 Jan 2026 13:17:36 +0100
Message-ID: <4710853.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Zilin Guan <zilin@seu.edu.cn>

acpi_ut_create_internal_object() may allocate memory from a slab cache
via kmem_cache_zalloc(), but the code currently frees it with ACPI_FREE(),
which calls kfree().

This mismatch prevents the object from being released properly and may
lead to memory leaks or other issues.

Fix this by replacing ACPI_FREE() with acpi_ut_delete_object_desc(),
which matches the allocation method used for internal objects.

Link: https://github.com/acpica/acpica/commit/a1c55dfea194
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/nsxfname.c | 2 +-
 drivers/acpi/acpica/utobject.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 1db831545ec8..b6895a48ae68 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -601,7 +601,7 @@ acpi_status acpi_install_method(u8 *buffer)
 error_exit:
 
 	ACPI_FREE(aml_buffer);
-	ACPI_FREE(method_obj);
+	acpi_ut_delete_object_desc(method_obj);
 	return (status);
 }
 ACPI_EXPORT_SYMBOL(acpi_install_method)
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 272e46208263..8362204b57b5 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -148,7 +148,7 @@ union acpi_operand_object *acpi_ut_create_package_object(u32 count)
 	package_elements = ACPI_ALLOCATE_ZEROED(((acpi_size)count +
 						 1) * sizeof(void *));
 	if (!package_elements) {
-		ACPI_FREE(package_desc);
+		acpi_ut_delete_object_desc(package_desc);
 		return_PTR(NULL);
 	}
 
-- 
2.51.0





