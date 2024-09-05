Return-Path: <linux-acpi+bounces-8181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FFE96DFBB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A701C20DA5
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F269E1A3BAB;
	Thu,  5 Sep 2024 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seQyZai6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94091A3A9D;
	Thu,  5 Sep 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553824; cv=none; b=KBDcHfcx9CmNb6fVgh9LPRHM2VkkMw5Lptg+3hmHGS5mCjE93FSOMFXnNCa09BnO4TKIxJd4J7hWPEATNEBkLdZ4+4PijmXcoSXLfaaCepDkrwn8lU+eZfi4TfJMQ3PkSAw/6WEPjBwIeQcpit2+H6Xzm+ExWmDLkCbk9dvbLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553824; c=relaxed/simple;
	bh=SN+VV989YznpmWRMUK1wgF+lwg7k+mPg1elKKPJ0iac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKCZ8+H58YEVwLzWw/1U8hSf7i6NWo4M6Vzqw+Y0Q3/9bl6XLn5YXlGQKh+2nKimX0oRJIMWf+GvOVnuPYhbrehTGs/wFP3Hw/nXfhnyZgxowenjizWxruMuK20xDmCCQR2aEz4g4eyGmFGYWqH8ej3MsXyqH5PSelFIfuPnqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seQyZai6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A097C4CEC7;
	Thu,  5 Sep 2024 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553823;
	bh=SN+VV989YznpmWRMUK1wgF+lwg7k+mPg1elKKPJ0iac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=seQyZai6qK17Jl2DWBqYRgCEG2VfAd8WrVIrexs3RGg4djkF70sVPEPM2UATuUBle
	 PkOuT/q4J3MgRNOHNHjaXw4ilhegmFoR9haxV2BTx6vRJk7rqoZUPbZvnYtAwVR0Nw
	 LVbPU4wKGIT9tq+QJGZ4XLvhwffQzxLFWTilqSp6TW5CIpO/oQQUYFEt++HZDSDqO1
	 Z8hg/0Fg6RWw5ucM5dO+8jU0qoIzm9hSGie2y8WfQeBxR7iTo7K828XQUTcDkzfdMy
	 wIzsgYLYc+NeTWmSUU9R8NyVTymfZJ7wV0R5dgvKUOAnbLxkRaboasTpcLjmrAMbGs
	 C2wtGdkD9FMCw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 05/11] ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn
Date: Thu,  5 Sep 2024 11:30:01 -0500
Message-ID: <20240905163007.1350840-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240905163007.1350840-1-superm1@kernel.org>
References: <20240905163007.1350840-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

If the boost ratio isn't calculated properly for the system for any
reason this can cause other problems that are non-obvious.

Raise all messages to warn instead.

Suggested-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index e65c77afab318..f0328ce98a8fe 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -75,19 +75,19 @@ static void amd_set_max_freq_ratio(void)
 
 	rc = cppc_get_perf_caps(0, &perf_caps);
 	if (rc) {
-		pr_debug("Could not retrieve perf counters (%d)\n", rc);
+		pr_warn("Could not retrieve perf counters (%d)\n", rc);
 		return;
 	}
 
 	rc = amd_get_boost_ratio_numerator(0, &numerator);
 	if (rc) {
-		pr_debug("Could not retrieve highest performance (%d)\n", rc);
+		pr_warn("Could not retrieve highest performance (%d)\n", rc);
 		return;
 	}
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (!nominal_perf) {
-		pr_debug("Could not retrieve nominal performance\n");
+		pr_warn("Could not retrieve nominal performance\n");
 		return;
 	}
 
-- 
2.43.0


