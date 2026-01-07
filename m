Return-Path: <linux-acpi+bounces-20001-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF31CFE893
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2BE73008987
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7E34EEEB;
	Wed,  7 Jan 2026 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKuUgufy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566634E763;
	Wed,  7 Jan 2026 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798899; cv=none; b=fi26V0IBoOmDYddAmASqQAIEf37Q+xgf+6xiQQBgJxqdQ1dUAoNwJWtO8mxoXPMrAnGfPNvvN5/lpe1+eryfA1q+sfpie8bahztVIYkr755Ic8pcHqqZsWkDe3GKSw+2izsfHtqtZylX7bXOMAgHPiQY87oajpyJzEdlcK49lOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798899; c=relaxed/simple;
	bh=aXoAB4TQYVaoJ0o2HEc4By9YYpVAPdoBEWf9Bn7JuI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VI2UZyVB14b1ftR/2EtpBt7CoHRxm4uNUp3LsC3/P11d2XI4pHkuQ8yURYaWreWWL1v4CAlPmNT5kQNGEaTU1Mbg657c9oTRefqLF712vwE22AbTsVQORN9wo0Yf8SglO0RP+PTNupYcIFgvcOge2yxvPi8yz4QWXForGdtalik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKuUgufy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FE2C19423;
	Wed,  7 Jan 2026 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767798899;
	bh=aXoAB4TQYVaoJ0o2HEc4By9YYpVAPdoBEWf9Bn7JuI4=;
	h=From:To:Cc:Subject:Date:From;
	b=iKuUgufy8kuF9DoDmwZTtV4tsDCN0xmfxgebX0SByRi0D0fOXIjqNe3Qm6C+QcAFE
	 9cvzrl7nlTzhxdco3U3gnlLZ24yhVvoMEyKts/0uotOiaimeKOtz1faav+ubgpm1Aj
	 LEolisydVQC/bodetOzgvThFP0cTPtiXYy7N1gTfEjbvXO8FHOf22teK02vJT8Sev1
	 KHO+Gm3BHx5tMBBDuMyd/cY66rTjz3e84THQzEg1sB5tQeqBpVP8mJhGZkR+7JtzsV
	 xHO530PPS48lVrvjgjF7neqULxxzlDGDUBLk5IPiSS6CrRpBuZRis3ifDptkcTpOUf
	 tWpt1SpoWrgNQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1] ACPI: PM: s2idle: Add missing checks to acpi_s2idle_begin_lps0()
Date: Wed, 07 Jan 2026 16:14:55 +0100
Message-ID: <2818730.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints
when needed"), that attempted to avoid useless evaluation of LPS0 _DSM
Function 1 in lps0_device_attach(), forgot to add checks for
lps0_device_handle and sleep_no_lps0 to acpi_s2idle_begin_lps0()
where they should be done before calling lpi_device_get_constraints()
or lpi_device_get_constraints_amd().

Add the missing checks.

Fixes: 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when needed")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/s2idle.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -515,7 +515,8 @@ static struct acpi_scan_handler lps0_han
 
 static int acpi_s2idle_begin_lps0(void)
 {
-	if (pm_debug_messages_on && !lpi_constraints_table) {
+	if (lps0_device_handle && !sleep_no_lps0 && pm_debug_messages_on &&
+	    !lpi_constraints_table) {
 		if (acpi_s2idle_vendor_amd())
 			lpi_device_get_constraints_amd();
 		else




