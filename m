Return-Path: <linux-acpi+bounces-11054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019F8A316B9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 21:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1455D188786F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D22641E8;
	Tue, 11 Feb 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeNjr3LG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBDE2641E1
	for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306009; cv=none; b=EHiWDmuHWUbUYL7IVytzFsdA/LTJ0ygieE02CMdC2a7zFZJDVRCq5qpL74mLV79G2ywJQzoluq0lJ9OPB2b2YMTLRMUaMDn9I+/DtRrj2Cc9DSnDr7NYYee+8auGFaadZMn/XpvmnXKmbnt506C9VsNABMWNEm1L5PMFGWm3onQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306009; c=relaxed/simple;
	bh=fuDk4FX8GgWCx2zPL5aROY9wNvTzY4ZjP60NRa8Rhxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qbajuc8T518KfzxNAzvhHACV55uBgyEP4LMqeRz5P2sk5sp13j+JkzIRzEXC+j1u11QDNKYYXpPyj2M+wxxcBYsApnt0FIJVtFoVFqc70r83x0JC7LqXgorH5g+tEybjbQODOR39jw65+O0g5VsQI0gUMKT+SNq/LYbBEhGU8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeNjr3LG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E4C4CEE7;
	Tue, 11 Feb 2025 20:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739306009;
	bh=fuDk4FX8GgWCx2zPL5aROY9wNvTzY4ZjP60NRa8Rhxo=;
	h=From:To:Cc:Subject:Date:From;
	b=FeNjr3LGV+kDtIJMfwWTIgvzLO0Noy8r8NfDeSwYWqFYKiLTxRajexfdgl5WT577s
	 jnQnwSBu8wiZzbcfMOIAFLWJTCe0ejCvdu7+jRUts/XwLdnc6en/NB2BIIPrTN4jaU
	 K/taqrErPfldVjCy4O7GYCrCE3txWlh4LnoCLZr+adRlBQ/IgPiutPzjPOpMrpnoEC
	 vguWbEbfowBuNBU6R+0+4sqjsvwDwrVI0Igtfjo+ZwXEXu9JiZ3uJo9qF5Lym0fiaF
	 wbO9vEnbYkvUl1y9B7nnF/T4Wp8nwRco0nQy7ZHwdETbhnMXDC0R0oK6s5y3ZmKvcL
	 E9gqnISug7jBg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: CPPC: Add missing include
Date: Tue, 11 Feb 2025 14:32:52 -0600
Message-ID: <20250211203314.762755-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Some minimial kernel configurations will fail with -Werror=implicit-function-declaration
due to a missing header include.

Add that header.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index d68a4cb0168fa..77bfb846490c0 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2016, Intel Corporation.
  */
 
+#include <linux/bitfield.h>
+
 #include <acpi/cppc_acpi.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
-- 
2.43.0


