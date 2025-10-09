Return-Path: <linux-acpi+bounces-17697-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B523ABCAB26
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 21:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82221422127
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 19:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A00525CC62;
	Thu,  9 Oct 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSyw32QP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D425CC5E;
	Thu,  9 Oct 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038058; cv=none; b=mCH0iFzb1zMY0a61NGO/uH/oT0koWFeuN+ok5sBnMcmUJaQVKSdYv2J+XT0xdGf0ZOB24CAp6xtmenW6o8U93DPPV3xSMY6fqeBWFLUIm3nIsfOdqcp9aFmElZAvzqSk/h76vTaVTjJ9Trm9DnKXUqZvn1sKuJZU26SgpaGuNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038058; c=relaxed/simple;
	bh=Hxub+BBBJWcuM1o3YtcwIXYJR3pjBhK3RMfWUPFa5Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLM0ue3nXA4szYS1ln10PbAHNTCil1gWrATZB45j5pFALekfWgog1NzrRv5yFhgJnxZWgDbYf1eDv7Gj9Ayt1oXtxJNjZDmVitCf5Fik1LtV3sEf4AlDxcVU668u2t8q/BG+vqsM3U+GFwLP/EWe7cmWeLEWzbpCx4VPZ3BsuKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSyw32QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49602C4CEE7;
	Thu,  9 Oct 2025 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038057;
	bh=Hxub+BBBJWcuM1o3YtcwIXYJR3pjBhK3RMfWUPFa5Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSyw32QPOc8bwE/gPmdf86b0x0b//0PI+y1PNPDaIRj9QEeE4Q06jnsYEbjr0HPF5
	 M6rL0WvcXrrEGnF4bgvliD9dWHZIasEZ9YtMUaHFIODvq4VVQSyBUL3V4pcsSyAwkw
	 rjDaGzQpzBVgArr2sUo96Y1gFJKaaqY2klcSlDcr+Uf2KCVS7zEVz+GFz+Evoy/5u0
	 mo0vKl/DgzwDbfAKXkb9c2YX3PfWfYXIxHtJP6aQbdvZlSbvLpFlzczeOGr5emTFar
	 G2G59QkaocIlT1W74i3CrUw3zbB8nZvUtvzJyfRGp8Bx3W/MVoWzVQxbx+qfdsjXoQ
	 BOLhGe8G7Fs6A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 1/3] ACPI: PM: s2idle: Drop acpi_get_lps0_constraint()
Date: Thu, 09 Oct 2025 21:25:56 +0200
Message-ID: <5032801.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4699399.LvFx2qVVIh@rafael.j.wysocki>
References: <4699399.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop unused function acpi_get_lps0_constraint().

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/s2idle.c |   24 ------------------------
 include/linux/acpi.h      |    5 -----
 2 files changed, 29 deletions(-)

--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -299,30 +299,6 @@ free_acpi_buffer:
 	ACPI_FREE(out_obj);
 }
 
-/**
- * acpi_get_lps0_constraint - Get the LPS0 constraint for a device.
- * @adev: Device to get the constraint for.
- *
- * The LPS0 constraint is the shallowest (minimum) power state in which the
- * device can be so as to allow the platform as a whole to achieve additional
- * energy conservation by utilizing a system-wide low-power state.
- *
- * Returns:
- *  - ACPI power state value of the constraint for @adev on success.
- *  - Otherwise, ACPI_STATE_UNKNOWN.
- */
-int acpi_get_lps0_constraint(struct acpi_device *adev)
-{
-	struct lpi_constraints *entry;
-
-	for_each_lpi_constraint(entry) {
-		if (adev->handle == entry->handle)
-			return entry->min_dstate;
-	}
-
-	return ACPI_STATE_UNKNOWN;
-}
-
 static void lpi_check_constraints(void)
 {
 	struct lpi_constraints *entry;
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1157,12 +1157,7 @@ struct acpi_s2idle_dev_ops {
 #if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
-int acpi_get_lps0_constraint(struct acpi_device *adev);
 #else /* CONFIG_SUSPEND && CONFIG_X86 */
-static inline int acpi_get_lps0_constraint(struct device *dev)
-{
-	return ACPI_STATE_UNKNOWN;
-}
 static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
 {
 	return -ENODEV;




