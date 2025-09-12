Return-Path: <linux-acpi+bounces-16779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E4DB5576F
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96961AA2AE8
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E0350846;
	Fri, 12 Sep 2025 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpHXJ9FP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822E2E1F16;
	Fri, 12 Sep 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707626; cv=none; b=ADxANg1fHoTVI9XXYMcCONoh4NQhpnhLxxDE7pScNkh8n5PvlQmO3z+JFHOtGoxCjaMN+qnKEyVi8ahn5BP+XvdkT0ni60L2+I/3RjjEuhOlqFHaCtl4sXL3M11FG+vEimzrL3y7qHXN7GSbUcmHYPHXvEAeUf/icz52dDJ3zss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707626; c=relaxed/simple;
	bh=PX7b+P18w1cO1y8m2CkDlV0ibVD7KJgHZJ4YYqbMfEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdMq/AFxwRThuD+lDiu7C4ws6nj4PAhx5K1YBWWoaZ+7THEQy9C4M50z8RNb0cOczUXm97fJLDLB0o5CNWTluX/GEhjjrEVQ78/UI9v222/rsY3Rou0cRRBkIuNLsAyOs9qCGvFQf60vEH4QiQVTy8HAbD0kPvzA3b5mS4SuPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpHXJ9FP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C42C4CEF4;
	Fri, 12 Sep 2025 20:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707625;
	bh=PX7b+P18w1cO1y8m2CkDlV0ibVD7KJgHZJ4YYqbMfEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpHXJ9FP8+zDU16RNXwJ0keRJZj9xEU3rkG0KlkFDScPsFbPe38ADH8UT60Jxq/lt
	 ynpKZy561LWPtCZuFWCAkJ+uk70+CaAt3ScgyWq0b7thgZq99oDNm7CpfwpWU7CuCH
	 lFGFo425x/INVaYJIBUtWrAxJmuKIgpIBeWgbeSBtGk87cJKFr7zhgSjHyTVMYjKnl
	 CF12SX5/8YHIU9ePUX3p2eRfvICUMWWPQVzPGTGaOHYSgmAIrGJzMy4tZLFAMk/+2M
	 ZSljIylFtrX0aOtwxF/pYn+iufkSuA1FtcHYztew68wzGfnOba8C/OxanyYR8gzT8H
	 geUnCCRyADDvg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 01/16] ACPICA: Modify variable definition position
Date: Fri, 12 Sep 2025 21:52:39 +0200
Message-ID: <7857160.EvYhyI6sBW@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2021361.PYKUYFuaPT@rafael.j.wysocki>
References: <2021361.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Zhe Qiao <qiaozhe@iscas.ac.cn>

To prevent potential undefined risks.

Link: https://github.com/acpica/acpica/commit/efc4d8ab
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/psopinfo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/psopinfo.c b/drivers/acpi/acpica/psopinfo.c
index 1c8044ffcb97..5168b4a04670 100644
--- a/drivers/acpi/acpica/psopinfo.c
+++ b/drivers/acpi/acpica/psopinfo.c
@@ -35,7 +35,7 @@ static const u8 acpi_gbl_argument_count[] =
 const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 {
 #ifdef ACPI_DEBUG_OUTPUT
-	const char *opcode_name = "Unknown AML opcode";
+
 #endif
 
 	ACPI_FUNCTION_NAME(ps_get_opcode_info);
@@ -62,6 +62,8 @@ const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 #if defined ACPI_ASL_COMPILER && defined ACPI_DEBUG_OUTPUT
 #include "asldefine.h"
 
+	const char *opcode_name = "Unknown AML opcode";
+
 	switch (opcode) {
 	case AML_RAW_DATA_BYTE:
 		opcode_name = "-Raw Data Byte-";
@@ -102,11 +104,11 @@ const struct acpi_opcode_info *acpi_ps_get_opcode_info(u16 opcode)
 	default:
 		break;
 	}
-#endif
 
 	/* Unknown AML opcode */
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%s [%4.4X]\n", opcode_name, opcode));
+#endif
 
 	return (&acpi_gbl_aml_op_info[_UNK]);
 }
-- 
2.51.0





