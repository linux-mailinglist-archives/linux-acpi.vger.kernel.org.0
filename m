Return-Path: <linux-acpi+bounces-20294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1ED1ED86
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7043F303EB4F
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D22F399A4C;
	Wed, 14 Jan 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEyXh0z5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42B399009;
	Wed, 14 Jan 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394497; cv=none; b=for+IZEec6hD3w4mWn2Eb4+Oqf5k7ELX2Qy7jmFZa2sjwuJxJhGEAfCcgT5AnkxcY3PzjY1+kzndB3kl5j38ot0xgh17Bn/I3NZ27kzHLXv8Jyc9FFZRs1Ry3MR1E8R/LozPMaryMy8Xxf05HHfRMdsRrC/ERBpMJ5K8Mt3LJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394497; c=relaxed/simple;
	bh=Tu94OyBbNdZz5SzbD5HG5KcO2kNbx/3aH40qQ3j3KeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSa+f1pAnVl9kHizArNz23cw/1dvTzpplNxMyrNsG4TQ4amB9tl1whOZuXm1zQNVh9vHKnwNXYnK4TzjP1TtH3vGbYI1sNJnao337yW1Q4rgbIE4b2Yde+aE965Xrwq8NTdpVrs+ubVX4dFI0gxoIeFfiSHyLEvQJi8CqVpwrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEyXh0z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205B0C4CEF7;
	Wed, 14 Jan 2026 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394497;
	bh=Tu94OyBbNdZz5SzbD5HG5KcO2kNbx/3aH40qQ3j3KeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEyXh0z5ZJ2I6nskFhgSObdjfcR916rQImMm7bhGR11YtbBj+DCaKoB3CF9Wveir+
	 QO0UKT3nZJTOrxd6Fh1TMYERNQxNdx5Saw9PUXseQycJlFIpsJhvjMMHWIgEnsivvV
	 8snyea088vMMZH8pbRe1L43FdjxxJYy4uUm73TssyPUMYFsbNkE0ALpoh8BTZ2cFIY
	 tzY8M5C86z1jmOQ/jO1bsCIrx4sOECMxGhO1KQHwLyVhroVNJbUDjEiHbqrdWFBMss
	 U2fNVkVqGqYfnPR2o2QQFUWvRMJDUGvKrPjgdG3/SlmHAIW1Zip7KW4rWlE3SeXop7
	 hycpNrZCYvaQA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 23/26] ACPICA: Align comments in TPRn-related structures
Date: Wed, 14 Jan 2026 13:37:19 +0100
Message-ID: <2286538.NgBsaNRSFp@rafael.j.wysocki>
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

Align comments in ACPI_TPRN_BASE_REG and ACPI_TPRN_LIMIT_REG structures.

Link: https://github.com/acpica/acpica/commit/95815d550969
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index c5ff63fc3b72..cdcda64d1d8e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1998,14 +1998,10 @@ struct acpi_tpr_array {
 struct acpi_tpr_instance {
 	u32 flags;
 	u32 tpr_cnt;
-	struct acpi_tpr_array tpr_array[];
 };
 
 struct acpi_tpr_aux_sr {
 	u32 srl_cnt;
-	/*
-	 * ACPI_TPR_SERIALIZE_REQUEST tpr_sr_arr[];
-	 */
 };
 
 /*
@@ -2022,13 +2018,14 @@ struct acpi_tprn_base_reg {
 	u64 rw:1;		/* access: 1 == RO, 0 == RW (for TPR must be RW) */
 	u64 enable:1;		/* 0 == range enabled, 1 == range disabled */
 	u64 reserved1:15;
-	u64 tpr_base_rw:44;	/*
-				 * Minimal TPRn_Base resolution is 1MB.
-				 * Applied to the incoming address, to determine if
-				 * an access fall within the TPRn defined region.
-				 * Width is determined by a bus width which can be
-				 * obtained via CPUID function 0x80000008.
-				 */
+	u64 tpr_base_rw:44;
+	/*
+	 * Minimal TPRn_Base resolution is 1MB.
+	 * Applied to the incoming address, to determine if
+	 * an access fall within the TPRn defined region.
+	 * Width is determined by a bus width which can be
+	 * obtained via CPUID function 0x80000008.
+	 */
 };
 
 /*
@@ -2045,11 +2042,12 @@ struct acpi_tprn_limit_reg {
 	u64 rw:1;		/* access: 1 == RO, 0 == RW (for TPR must be RW) */
 	u64 enable:1;		/* 0 == range enabled, 1 == range disabled */
 	u64 reserved1:15;
-	u64 tpr_limit_rw:44;	/*
-				 * Minimal TPRn_Limit resolution is 1MB.
-				 * These bits define TPR limit address.
-				 * Width is determined by a bus width.
-				 */
+	u64 tpr_limit_rw:44;
+	/*
+	 * Minimal TPRn_Limit resolution is 1MB.
+	 * These bits define TPR limit address.
+	 * Width is determined by a bus width.
+	 */
 };
 
 /*
-- 
2.51.0





