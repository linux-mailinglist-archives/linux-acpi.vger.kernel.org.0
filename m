Return-Path: <linux-acpi+bounces-20296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4253ED1ED98
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D22DF3064609
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66E397ADD;
	Wed, 14 Jan 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXxvuesQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF393397AAB;
	Wed, 14 Jan 2026 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394504; cv=none; b=b8N90m6Mf/1Lfxnq+Mf0jKx9iECBD2mG2y51Re4dVvFyv0qOYW3761DuL/jZ7gJEApyqpj43YEBw6SfS8PDwXP/0Mz0csJA7xm7g1v/tlyYj7oPNlFN+g26nJhzUvoLyeQZIYxoWmfOOyImkKFbrT4FWrfjV++DbS38zs6mdeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394504; c=relaxed/simple;
	bh=7Sl0C0P7lwlqk8VrV6z0XBBHQe6QSDirGg1+YKphjpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MErW0QSk4MN6LPXSCacmoqw1m1aQqosb87SDNYLJW5g1uW+mjIUKd/CG7xFKflE2mwDLCUp4YlVEFRq51Aa4cQ8zagFeJaKY2uXeUoB4t4bpiZnzhfKRlhWtluhZbAEAD+EjPnXreXfUOurbU3fPMywFz5l8G918QCWjJcsLB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXxvuesQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA831C16AAE;
	Wed, 14 Jan 2026 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394503;
	bh=7Sl0C0P7lwlqk8VrV6z0XBBHQe6QSDirGg1+YKphjpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXxvuesQt8YYH/WmNEOWHaeX0iCvdsLb/16+Lir4ie8l/LQRKpeY86Gllv1W1yM17
	 lVH9da5nUNlMAhgNs+oujk3OOp1aMaqajjuLHvbxaQDmaBieVTbMuZd7hZkX65xa5Q
	 CtBeF2UuTTyD9HM7PN6o9rOrJv33SjTZCHKLS0ta7myJz+GkQDQHexVCTaBOdu5giU
	 2zRUhjO/EOn5Fo6ObNxCAci1NKuCdvIJxp+lSoY8SxOeCuLLQrhu7e4QZuvOiI2RQC
	 qwTlN8BlALPv4v6cO3k1mb0tfIuaJO+2HSieB80ZSbkRz8jsa/6s0P4gda9C+ArCoL
	 19Qxl6lcoW3zQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 21/26] ACPICA: Verify DTPR and TPR Instance buffer pointers
Date: Wed, 14 Jan 2026 13:35:31 +0100
Message-ID: <884204745.0ifERbkFSE@rafael.j.wysocki>
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

Verify DTPR and TPR Instance buffer pointers and refactor comments.

Link: https://github.com/acpica/acpica/commit/bdec5b61cf5b
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 59 +++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 59fbd64405be..a580b993cc48 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1987,7 +1987,7 @@ struct acpi_ibft_target {
 
 struct acpi_table_dtpr {
 	struct acpi_table_header header;
-	u32 flags;		// 36
+	u32 flags;		/* 36 */
 	u32 ins_cnt;
 };
 
@@ -2003,66 +2003,71 @@ struct acpi_tpr_instance {
 
 struct acpi_tpr_aux_sr {
 	u32 srl_cnt;
-	//ACPI_TPR_SERIALIZE_REQUEST tpr_sr_arr[];
+	/* ACPI_TPR_SERIALIZE_REQUEST tpr_sr_arr[]; */
 };
 
-/*******************************************************************************
+/*
  * TPRn_BASE
  *
  * Specifies the start address of TPRn region. TPR region address and size must
  * be with 1MB resolution. These bits are compared with the result of the
  * TPRn_LIMIT[63:20] * applied to the incoming address, to determine if an
  * access fall within the TPRn defined region.
-*******************************************************************************/
+ */
+
 struct acpi_tprn_base_reg {
 	u64 reserved0:3;
-	u64 rw:1;		// access: 1 == RO, 0 == RW (for TPR must be RW)
-	u64 enable:1;		// 0 == range enabled, 1 == range disabled
+	u64 rw:1;		/* access: 1 == RO, 0 == RW (for TPR must be RW) */
+	u64 enable:1;		/* 0 == range enabled, 1 == range disabled */
 	u64 reserved1:15;
-	u64 tpr_base_rw:44;	// minimal TPrn_base resolution is 1MB.
-	// applied to the incoming address, to determine if an
-	// access fall within the TPrn defined region.
-	// width is determined by a bus width which can be
-	// obtainedvia CPUID function 0x80000008.
-	//u64 unused : 1;
+	u64 tpr_base_rw:44;	/* Minimal TPRn_Base resolution is 1MB.
+				 *  Applied to the incoming address, to determine if
+				 *  an access fall within the TPRn defined region.
+				 *  Width is determined by a bus width which can be
+				 *  obtained via CPUID function 0x80000008.
+				 */
+	/* u64 unused : 1;   */
 };
 
-/*******************************************************************************
+/*
  * TPRn_LIMIT
  *
  * This register defines an isolated region of memory that can be enabled
  * to prohibit certain system agents from accessing memory. When an agent
  * sends a request upstream, whether snooped or not, a TPR prevents that
  * transaction from changing the state of memory.
-*******************************************************************************/
+ */
 
 struct acpi_tprn_limit_reg {
 	u64 reserved0:3;
-	u64 rw:1;		// access: 1 == RO, 0 == RW (for TPR must be RW)
-	u64 enable:1;		// 0 == range enabled, 1 == range disabled
+	u64 rw:1;		/* access: 1 == RO, 0 == RW (for TPR must be RW) */
+	u64 enable:1;		/* 0 == range enabled, 1 == range disabled */
 	u64 reserved1:15;
-	u64 tpr_limit_rw:44;	// minimal TPrn_limit resolution is 1MB.
-	// these bits define TPR limit address.
-	// width is determined by a bus width.
+	u64 tpr_limit_rw:44;	/* Minimal TPRn_Limit resolution is 1MB.
+				 *  These bits define TPR limit address.
+				 *  Width is determined by a bus width.
+				 */
 
-	//u64 unused : 1;
+	/* u64 unused : 1; */
 };
 
-/*******************************************************************************
+/*
  * SERIALIZE_REQUEST
  *
  * This register is used to request serialization of non-coherent DMA
  * transactions. OS shall  issue it before changing of TPR settings
  * (base / size).
-*******************************************************************************/
+ */
 
 struct acpi_tpr_serialize_request {
 	u64 sr_register;
-	// BIT 1 - status of serialization request (RO)
-	//         0 == register idle, 1 == serialization in progress
-	// BIT 2 - control field to initiate serialization (RW)
-	//         0 == normal, 1 == initialize serialization
-	// (self-clear to allow multiple serialization requests)
+	/*
+	 *  BIT 1 - Status of serialization request (RO)
+	 *          0 == register idle, 1 == serialization in progress
+	 *  BIT 2 - Control field to initiate serialization (RW)
+	 *          0 == normal, 1 == initialize serialization
+	 *  (self-clear to allow multiple serialization requests)
+	 */
 };
 
 /* Reset to default packing */
-- 
2.51.0





