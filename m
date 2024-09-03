Return-Path: <linux-acpi+bounces-8120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE9696A88B
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2BCB22A9D
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354671DB92F;
	Tue,  3 Sep 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoHIwq70"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8511DB927;
	Tue,  3 Sep 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395839; cv=none; b=Sy1bdBMr5UePej/o9DlggC3cvkebBL7TP8+MBGa6Zt9qH5lP9F/mFmrKRW84CsIqffByhby8mxmoKD53tEAshfWM/cniSqZXXXW1sptRzdQJyXAHXDZfEBEXo59Xe55aey7IYXCfO+AjTqLpydLmyQFaTsDtlf8CugFbCBe1J8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395839; c=relaxed/simple;
	bh=484zSMM7Xrj+mmOX2bqet96LnZ76/b6dY0o0OgpmyS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDf/NcJ9X7q6WkKJtPC5gtqPohuixDXtI+iz4OnaKPx2w1N7fY3cXmOlDBXK0d+BKu/gflUAKI1LIMVqDNh+OfH42NvKjlyXGN2JFq7cEDkWJikRo+rUvbB7vH3UxPNvpDSOkJwvhPpnqbKe00u3CdrbT21fN/tNuCaDMBY5x5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoHIwq70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0483DC4CEC5;
	Tue,  3 Sep 2024 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395838;
	bh=484zSMM7Xrj+mmOX2bqet96LnZ76/b6dY0o0OgpmyS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HoHIwq70nGdIa9OrtaLyn7TuQZzVGhgf20mwK6h56JHuZq9fbxjOn/1eKm8WhBeCj
	 gKj/VtB/jzWpyZTMI/Onss6KKsBaslYXQiurNdZnPWZVE2gDKBfe2nVu6G8c2ujz28
	 DlY9f//Iex1qWeTjHQp23VAM1zTdFljWiH+ve0YzMuhNFmPEGH25dPKRBk6MfWB5hW
	 7ItoIjFb2JDmNTlY6sp9fH0cyKM/fV5Vj904cQDgRbCZQpUMkUYeaj/ZRViCPk3L0L
	 AX13MkaqfoFUTZqyBAOkPypxHEZNCqPAtKQiQGoS2dKnCGACEcFRPNY/hVBnQvVCal
	 Bd6KclxJsAepA==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 10/11] cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore`
Date: Tue,  3 Sep 2024 15:37:00 -0500
Message-ID: <20240903203701.2695040-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903203701.2695040-1-superm1@kernel.org>
References: <20240903203701.2695040-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Explain that the sysfs file represents both preferred core being
enabled by the user and supported by the hardware.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e13915c540648..d5c050ea390dc 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -263,6 +263,11 @@ lowest non-linear performance in `AMD CPPC Performance Capability
 <perf_cap_>`_.)
 This attribute is read-only.
 
+``amd_pstate_hw_prefcore``
+
+Whether the platform supports the preferred core feature and it has been
+enabled. This attribute is read-only.
+
 ``energy_performance_available_preferences``
 
 A list of all the supported EPP preferences that could be used for
-- 
2.43.0


