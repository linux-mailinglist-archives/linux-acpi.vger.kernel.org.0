Return-Path: <linux-acpi+bounces-16969-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ABBB58624
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 22:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894AB7AC6AA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A5B29DB8F;
	Mon, 15 Sep 2025 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAaymJYX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C81DE4EF
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969005; cv=none; b=uJhInacFJ2+iDcgEg4koJGFsh1SAtk94gVaHAjLOqh7phtYfw9OI4uFVhJFTOffUk9jydPqjEDgYWWsBPJYPYHz5SoVNCuWbT0YSWcvrPQHV/DoH9eCpGber1ljrEPCd9xOxfQgFP5wKIF+IKUeyIZycGUgOwK1RK6xQtofCnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969005; c=relaxed/simple;
	bh=7oKU06A7dwB39qlDptweTTRyRjpoKBf3sQ+syLVsEfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=na2HLH7PNy36rfZE2IZvr36fe1RmAeiVR4HFMWTkF7QdceMIKuCREQQ2vMiZFsvtXK/tpCflf1fo/JyVwbUu6bgE/BbpDCrWYvBO97KH+olFqnYyKbJIWIkpMiGgaPdM/1T2Ibq5uHnZseLEnvGR27NecSbxhHCm2AK3Ox7gTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAaymJYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23215C4CEF1;
	Mon, 15 Sep 2025 20:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757969004;
	bh=7oKU06A7dwB39qlDptweTTRyRjpoKBf3sQ+syLVsEfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAaymJYXM0AYezhRBEqoKN5yLG8PNjvo9nhxqvdpzgcDD5ZSZdIwpOo/Ia2s+bVLg
	 4PHwsou1yHUTJB6K8veUL7djqvQlcKQY+7tcmXJZlVias75JhltSPc8CxQBuq/ZiOD
	 R5jSfq7fNBb6XlCzIOv6oK3wMmjPeS5KUx6jFWWQEIk0gXshlVSzoXcTx9JC5TZb9+
	 odfXbjFOeoXay2pA8oVporzh+qJNfXU2YJILdH1o6x5dxiqeWW5gf24vkk14NT10B7
	 BjUFXI2SmQGa5bAr2bNOuJ+uMV7voc8qjYIoAsUX9+06ggvWqEe6YpGqvau0Ffq8fp
	 hDNERsoVklEnA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-acpi@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 2/2] ACPI: processor: Add support for ACPI C4 state
Date: Mon, 15 Sep 2025 15:43:17 -0500
Message-ID: <20250915204318.696058-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915204318.696058-1-superm1@kernel.org>
References: <20250915204318.696058-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The _CST object described in the ACPI specification [1] allows processors
to support any arbitrary number of power states that are described by
a package describing the register used, the type of C-state, latency
and the power consumption.

Currently the Linux kernel supports up to ACPI C3, and if a system
supports any further states they are ignored.  This causes problems on
some AMD hardware which can support up to ACPI C4.

AMD systems that support up to C3 will enter CPUOFF and VDDOFF
when entering C3. Systems that support up to C4 will enter CPUOFF
when going to C3 and will enter VDDOFF when entering into C4.

The existing semantics for bus mastering around C3 are also valid for C4,
so instead of hardcoding to C3, map then >= C3. In the case of s2idle
detect the deepest C-state supported and enter the deepest.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/08_Processor_Configuration_and_Control/declaring-processors.html?#cst-c-states [1]
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/acpi/processor_idle.c | 10 +++++++---
 include/acpi/actypes.h        |  5 +++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5dacf41d7cc0a..537b0119535ea 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -444,6 +444,10 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 		case ACPI_STATE_C3:
 			acpi_processor_power_verify_c3(pr, cx);
 			break;
+		case ACPI_STATE_C4:
+			if (!cx->latency || !cx->address)
+				break;
+			cx->valid = 1;
 		}
 		if (!cx->valid)
 			continue;
@@ -685,7 +689,7 @@ static int __cpuidle acpi_idle_enter(struct cpuidle_device *dev,
 		return -EINVAL;
 
 	if (cx->type != ACPI_STATE_C1) {
-		if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check)
+		if (cx->type >= ACPI_STATE_C3 && pr->flags.bm_check)
 			return acpi_idle_enter_bm(drv, pr, cx, index);
 
 		/* C2 to C1 demotion. */
@@ -708,7 +712,7 @@ static int __cpuidle acpi_idle_enter_s2idle(struct cpuidle_device *dev,
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
 
-	if (cx->type == ACPI_STATE_C3) {
+	if (cx->index == drv->state_count - 1) {
 		struct acpi_processor *pr = __this_cpu_read(processors);
 
 		if (unlikely(!pr))
@@ -754,7 +758,7 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 		if (lapic_timer_needs_broadcast(pr, cx))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
-		if (cx->type == ACPI_STATE_C3) {
+		if (cx->type >= ACPI_STATE_C3) {
 			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
 			if (pr->flags.bm_check)
 				state->flags |= CPUIDLE_FLAG_RCU_IDLE;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 8fe893d776dde..6c9f472af482c 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -600,8 +600,9 @@ typedef u64 acpi_integer;
 #define ACPI_STATE_C1                   (u8) 1
 #define ACPI_STATE_C2                   (u8) 2
 #define ACPI_STATE_C3                   (u8) 3
-#define ACPI_C_STATES_MAX               ACPI_STATE_C3
-#define ACPI_C_STATE_COUNT              4
+#define ACPI_STATE_C4                   (u8) 4
+#define ACPI_C_STATES_MAX               ACPI_STATE_C4
+#define ACPI_C_STATE_COUNT              5
 
 /*
  * Sleep type invalid value
-- 
2.43.0


