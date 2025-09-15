Return-Path: <linux-acpi+bounces-16968-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4CFB58623
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 22:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B952078F8
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06929D294;
	Mon, 15 Sep 2025 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtI5KRI3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A961DE4EF
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969004; cv=none; b=ZbzGAYdGAgnbVUuwc3wiVwB3anuDLCTvZRM7RJicYlCdRUKysD0sZfzDdEAjOqNNeLgflLYQlXWAGxTp+I83ZtRwXYXK1hbOqyrO5KcgM9LGsfECw/MgCnKK6xk1WSUn5aJWexeZ7BDQGSZrziFIWfnsTp/t2UtTj8Kt9xnJXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969004; c=relaxed/simple;
	bh=Q4VfzmNdjCwYLmqQeia9N1/AGY+8zueOVy6vwE0F0Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avIJ4NCNVQODztXqkqM7j4xOEVmvtBflRJV/zaKO/v0U2Hifkb0CboUNr1+Wad/Up3gDf/+DEkwL9KwITJHRy5g2JoXVzy4WKWmhv/0M25DOQEBsQsnsNZBEJjEfHrbLFiqzI9q3OgSYY7GltJAuvfk1sdd4T24zDyTxprbsGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtI5KRI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82671C4CEF7;
	Mon, 15 Sep 2025 20:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757969003;
	bh=Q4VfzmNdjCwYLmqQeia9N1/AGY+8zueOVy6vwE0F0Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtI5KRI35R3joUrX0NeIkEV84UU3JqDA82aqiLa7WtGXAHvGSnLFp1YmnwohJCLyb
	 PNj4F8UlASNeIPSbutCnWIZKkwihmjzYIKoYbDmwwPPHxaFYe2Gc41PpghZeWwoGm3
	 SNlFdTRDv2qFJAxqRtCp8kSabjDgLJF0XdVMn9WkgAyx8Uw8pthdF3sjDFhx1Eoar7
	 kyXW7w4eX9TeJdGidR5wHcg4o5EiHuS5Vvw4n3IBQrbdbyHhRuAKHBZkQxvlOMaxU/
	 3stLxLtqKXOf8tjAvd4838kJOCzaUJwZrPiW7uNPLptiE6Zu7oMGsFcOOy29O+Qtc6
	 c9aLEtRczwcVw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-acpi@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 1/2] x86/acpi/cstate: Remove open coded check for cpu_feature_enabled()
Date: Mon, 15 Sep 2025 15:43:16 -0500
Message-ID: <20250915204318.696058-2-superm1@kernel.org>
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

acpi_processor_power_init_bm_check() has an open coded implementation
of cpu_feature_enabled() to detect X86_FEATURE_ZEN.
Switch to using cpu_feature_enabled().

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 arch/x86/kernel/acpi/cstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 8698d66563ed6..0281703da5e26 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -89,7 +89,7 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 		 */
 		flags->bm_control = 0;
 	}
-	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17) {
+	if (cpu_feature_enabled(X86_FEATURE_ZEN)) {
 		/*
 		 * For all AMD Zen or newer CPUs that support C3, caches
 		 * should not be flushed by software while entering C3
-- 
2.43.0


