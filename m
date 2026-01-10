Return-Path: <linux-acpi+bounces-20145-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A58D0D5D5
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E961300766E
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92220340260;
	Sat, 10 Jan 2026 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEQ2yD5S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73C310762;
	Sat, 10 Jan 2026 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768046334; cv=none; b=qbeDSiBkk1Rh1sAKRp6EbB6ZsGB5hM4f6MfejGm7NX/PboehoVNiceDz4Ig/Od4UlOZuFAPNQu8ZEjVE7QhqcvUaoGI8j4vQi5cJv0GWniTzxOr8fcKAo+UFLK3vuD4oChECrEQbDU14MbDRxt9hWu1zUGsf4xGAN71ZRN5m8Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768046334; c=relaxed/simple;
	bh=FCOWl4yw+VMo5TGGk5bY/Pb9NJpiUs0WNN1ZgzgWjX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNMpJXRjt5gzik3yjkJl128F6F+uJlGG2YVfKsP/UBg+WzOj0l3phJeBtNnm4N5jH+rHBg5cmsGq/sWzXHjMuQgiusLkvCEYiS1qU8Cxfe5CWGaekMl5DcVf1gycmPtuihYNPM/SSdARGowVRVkjbKgPtiOrcD8b3lrpCC8m+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEQ2yD5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D6FC4CEF1;
	Sat, 10 Jan 2026 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768046334;
	bh=FCOWl4yw+VMo5TGGk5bY/Pb9NJpiUs0WNN1ZgzgWjX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEQ2yD5SP0B7N9u67uLOGw66knf4yk7Tn7hgTTZ5tMUhUcbJXhxiN8YQ7Nr07SFe2
	 Lm6MU7cL1erkfZfb+WrMYUDgyk5GoWz+1lODbjV54nKrz9+XUekKnzXAHzxF+KdM68
	 DFVTpmWusVoIIC8zgzrXKtM8cgUbjXfATXEZzSToaXb0saZCJQvSbV9ZLwFr71tA8U
	 CdmdZLz41mFvC9+XEazdCbF+1nrjk5/0xrxv587v59jz/CtJqbKpA1eMMoE6UWBG6m
	 +UBdCfL4Lhgey3zGLMuPDLl6VzQzCZsZC876LyNOCKgO4W2yowEBKLeAxPRO8GhfOJ
	 EO6nA6ykhbEfg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Todd Brandt <todd.e.brandt@linux.intel.com>,
 Xi Pardee <xi.pardee@linux.intel.com>
Subject:
 [PATCH v1 1/2] ACPI: PM: Let acpi_dev_pm_attach() skip devices without ACPI
 PM
Date: Sat, 10 Jan 2026 12:57:00 +0100
Message-ID: <5050298.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4715380.LvFx2qVVIh@rafael.j.wysocki>
References: <4715380.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is pointless to attach the generic ACPI PM domain to devices whose
ACPI companions don't support ACPI power management and don't have a
wakeup GPE, so update acpi_dev_pm_attach() to skip such devices.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1457,6 +1457,15 @@ int acpi_dev_pm_attach(struct device *de
 		return 0;
 
 	/*
+	 * Skip devices whose ACPI companions don't support power management and
+	 * don't have a wakeup GPE.
+	 */
+	if (!acpi_device_power_manageable(adev) && !acpi_device_can_wakeup(adev)) {
+		dev_dbg(dev, "No ACPI power management or wakeup GPE\n");
+		return 0;
+	}
+
+	/*
 	 * Only attach the power domain to the first device if the
 	 * companion is shared by multiple. This is to prevent doing power
 	 * management twice.




