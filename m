Return-Path: <linux-acpi+bounces-20308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15990D1EDFB
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BAC43058574
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC435399037;
	Wed, 14 Jan 2026 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foujHoW9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC9399A7C;
	Wed, 14 Jan 2026 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394545; cv=none; b=UnugaJkuaxHYShmRuf4wkiQkG3QkC5T7tP9RyuPYobFcktZnJMuvmCGrOimIYdWsVUKBUGa+eNUIFUjb1WpL8VovLUnzHN8WvCEe2QlEj1tsRZ/D9VhgePjInGO4kVrmXKTVqd77B5wi8x89EWHO/pN/P/0Gzd9FEZN+Nmiury8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394545; c=relaxed/simple;
	bh=4vc9HwTPaEdKgS5O1T3dPX1jAjvKW/U15VtFc2IOnos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1ZYi6v2fHVAtBpkuwYkvcLSmhk2zHxIgWeNR30k36TsyGBh/nNxwWE3KD7OFTs+ZFMGRuZWMiTjZJA2Ct4lUf2ViVwzMzF1ygGMSfYFAnXp/tHpqYju/5MRzyjjqHNlxoThFtY9yZavnt9VAPfREsB4SrI10Le7YDBLygrZquk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foujHoW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD06C4CEF7;
	Wed, 14 Jan 2026 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394545;
	bh=4vc9HwTPaEdKgS5O1T3dPX1jAjvKW/U15VtFc2IOnos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foujHoW9ktb/nH9IeL5fZIjqsWscke0LusLe+x6XAROZSFM+yeyFyJe8b3eCodGBd
	 dDOwp/qwjLpcbfZTnJ1orTeG/HrmfVkvMtRYACaiWXEmw2DNHqfdXG/NxmTrjpMJI7
	 mF2X1ps0gTqTa9mEWOHVeJbfegYTgv+WClyCGFtgijkTi8aVgmIIGWt+uSFNXVFlez
	 IgMXmR3f7Vfgkayyl+SBiVuzlXc8cOoWvEl9cioia3BHtPvAF49+kQzW2j6TOXG4ug
	 vIyQXERHV1hZ8v6Pyt2+Hce+zfxxuni7H5rPDaVIJgCO1bX9l4ZRCig0EjHfDABhJy
	 OvgdHZ2AybjgA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 09/26] ACPICA: Add DTPR table support for the ASL compiler
Date: Wed, 14 Jan 2026 13:23:40 +0100
Message-ID: <7902293.EvYhyI6sBW@rafael.j.wysocki>
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

From: Michal Camacho Romero <michal.camacho.romero@intel.com>

Define DTPR related structures offsets.

Link: https://github.com/acpica/acpica/commit/c6fc16c8936d
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 23449a068c5c..423e7232974a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -37,6 +37,7 @@
 #define ACPI_SIG_DBGP           "DBGP"	/* Debug Port table */
 #define ACPI_SIG_DMAR           "DMAR"	/* DMA Remapping table */
 #define ACPI_SIG_DRTM           "DRTM"	/* Dynamic Root of Trust for Measurement table */
+#define ACPI_SIG_DTPR           "DTPR"	/* DMA TXT Protection Ranges table */
 #define ACPI_SIG_ECDT           "ECDT"	/* Embedded Controller Boot Resources Table */
 #define ACPI_SIG_EINJ           "EINJ"	/* Error Injection table */
 #define ACPI_SIG_ERST           "ERST"	/* Error Record Serialization Table */
@@ -47,7 +48,6 @@
 #define ACPI_SIG_HPET           "HPET"	/* High Precision Event Timer table */
 #define ACPI_SIG_IBFT           "IBFT"	/* iSCSI Boot Firmware Table */
 #define ACPI_SIG_MSCT           "MSCT"	/* Maximum System Characteristics Table */
-#define ACPI_SIG_DTPR           "DTPR"	/* TXT DMA Protection Ranges reporting table */
 
 #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
 #define ACPI_SIG_PCCS           "PCC"	/* PCC Shared Memory Region */
@@ -1994,7 +1994,7 @@ struct acpi_tpr_array {
 	u64 base;
 };
 
-struct acpi_dtpr_instance {
+struct acpi_tpr_instance {
 	u32 flags;
 	u32 tpr_cnt;
 	struct acpi_tpr_array tpr_array[];
@@ -2008,7 +2008,7 @@ struct acpi_dtpr_instance {
  * TPRn_LIMIT[63:20] * applied to the incoming address, to determine if an
  * access fall within the TPRn defined region.
 *******************************************************************************/
-struct acpi_dtprn_base_reg {
+struct acpi_tprn_base_reg {
 	u64 reserved0:3;
 	u64 rw:1;		// access: 1 == RO, 0 == RW (for TPR must be RW)
 	u64 enable:1;		// 0 == range enabled, 1 == range disabled
@@ -2030,7 +2030,7 @@ struct acpi_dtprn_base_reg {
  * transaction from changing the state of memory.
 *******************************************************************************/
 
-struct acpi_dtprn_limit_reg {
+struct acpi_tprn_limit_reg {
 	u64 reserved0:3;
 	u64 rw:1;		// access: 1 == RO, 0 == RW (for TPR must be RW)
 	u64 enable:1;		// 0 == range enabled, 1 == range disabled
-- 
2.51.0





