Return-Path: <linux-acpi+bounces-20295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B526D1ED7D
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D988A3004EC0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6FA39902A;
	Wed, 14 Jan 2026 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJwSdVkw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92AE397AAB;
	Wed, 14 Jan 2026 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394500; cv=none; b=LMeg7M4oNaSUpmUae+87XK1LRiGgW6kMCYW40fnvkkDOrc5UD2dh/qCWS3g5p6WVyRaHIp+nIPSj1HD3SAQDlqHulNhZjISbQn/IAmMwrRveQ4BOYV3r3JoQLLOPXVV0NuaRzGIYszTejWamupD58pweTeSaGC1UlTWn/0/InnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394500; c=relaxed/simple;
	bh=1gYFt1xifIWczuMwbykWCsBZsfxXqRjU2KgI8ngRJqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdoa6VMuTY9pBbiO2154aYEXQgU5L8vdRpUJuX7COUoboC2DdkV35rvFU20msAihCNfOzyYOkzlDth9cqvzOGGtjW6O/3FcBTYcdA9v/DHNt41Wub1Hb1W10aq1JTg9Q6GTud8kn7l4Knk4drccuUlUyH0J/j6KR9JrYUt9jJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJwSdVkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960E1C4CEF7;
	Wed, 14 Jan 2026 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394500;
	bh=1gYFt1xifIWczuMwbykWCsBZsfxXqRjU2KgI8ngRJqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJwSdVkwyMfow6YT8HPqwmnwbLokMzvqGmZI+ltmk2+BCL+eO9igT9JnSTM9LcjaF
	 gTqgnjVVEuk8xCTM4hMLgxTS4Uyyi8iHfFdAHUH99DynvBcqeWIanWw72SUsHNCZZF
	 OfaXZ/bDP08z/7RvyY2+6oFOV7qbPihb8IAeWuxB0ouRk/9NihUgdzQp2Liykk1Jw/
	 hdX9+QmH2SzBuVO8dB3M1AFIQINJ1MqQRSiIiu3wm0EJuZHdVfBt9nMiIpcs19VOUY
	 KYU6jTduFOCqVSUJQMjGM9EO7JsmEXHNnAnY8g5O9u7/+EHfyEuxS966OOXoiFcakw
	 6UkfcI11O9WTA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 22/26] ACPICA: Cleanup comments and DTPR Table handle functions
Date: Wed, 14 Jan 2026 13:36:32 +0100
Message-ID: <2042656.yKVeVyVuyW@rafael.j.wysocki>
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

Link: https://github.com/acpica/acpica/commit/cc480264335e
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index a580b993cc48..c5ff63fc3b72 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -2003,7 +2003,9 @@ struct acpi_tpr_instance {
 
 struct acpi_tpr_aux_sr {
 	u32 srl_cnt;
-	/* ACPI_TPR_SERIALIZE_REQUEST tpr_sr_arr[]; */
+	/*
+	 * ACPI_TPR_SERIALIZE_REQUEST tpr_sr_arr[];
+	 */
 };
 
 /*
@@ -2020,13 +2022,13 @@ struct acpi_tprn_base_reg {
 	u64 rw:1;		/* access: 1 == RO, 0 == RW (for TPR must be RW) */
 	u64 enable:1;		/* 0 == range enabled, 1 == range disabled */
 	u64 reserved1:15;
-	u64 tpr_base_rw:44;	/* Minimal TPRn_Base resolution is 1MB.
-				 *  Applied to the incoming address, to determine if
-				 *  an access fall within the TPRn defined region.
-				 *  Width is determined by a bus width which can be
-				 *  obtained via CPUID function 0x80000008.
+	u64 tpr_base_rw:44;	/*
+				 * Minimal TPRn_Base resolution is 1MB.
+				 * Applied to the incoming address, to determine if
+				 * an access fall within the TPRn defined region.
+				 * Width is determined by a bus width which can be
+				 * obtained via CPUID function 0x80000008.
 				 */
-	/* u64 unused : 1;   */
 };
 
 /*
@@ -2043,12 +2045,11 @@ struct acpi_tprn_limit_reg {
 	u64 rw:1;		/* access: 1 == RO, 0 == RW (for TPR must be RW) */
 	u64 enable:1;		/* 0 == range enabled, 1 == range disabled */
 	u64 reserved1:15;
-	u64 tpr_limit_rw:44;	/* Minimal TPRn_Limit resolution is 1MB.
-				 *  These bits define TPR limit address.
-				 *  Width is determined by a bus width.
+	u64 tpr_limit_rw:44;	/*
+				 * Minimal TPRn_Limit resolution is 1MB.
+				 * These bits define TPR limit address.
+				 * Width is determined by a bus width.
 				 */
-
-	/* u64 unused : 1; */
 };
 
 /*
@@ -2062,11 +2063,11 @@ struct acpi_tprn_limit_reg {
 struct acpi_tpr_serialize_request {
 	u64 sr_register;
 	/*
-	 *  BIT 1 - Status of serialization request (RO)
-	 *          0 == register idle, 1 == serialization in progress
-	 *  BIT 2 - Control field to initiate serialization (RW)
-	 *          0 == normal, 1 == initialize serialization
-	 *  (self-clear to allow multiple serialization requests)
+	 * BIT 1 - Status of serialization request (RO)
+	 *         0 == register idle, 1 == serialization in progress
+	 * BIT 2 - Control field to initiate serialization (RW)
+	 *         0 == normal, 1 == initialize serialization
+	 * (self-clear to allow multiple serialization requests)
 	 */
 };
 
-- 
2.51.0





