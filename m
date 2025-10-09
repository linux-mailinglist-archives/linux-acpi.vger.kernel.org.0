Return-Path: <linux-acpi+bounces-17695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1492BCAB0E
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 21:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6183B4C47
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 19:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12525784B;
	Thu,  9 Oct 2025 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyvgJBpx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6C257448;
	Thu,  9 Oct 2025 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038052; cv=none; b=qdZyZudVfv+WK2krSAmkt2FxwhoMdifXj4hVC0DLgy40GN7u1YXoXrTitNYTRtXC9YIh+GyaY4j9ZtLcXYqbHz4WLPS70B7PCFijHf3ePsJ1bCaBnc2QdNjG7ZxtBfhGvLlXZDI9ahpk+YhHK0TKsAyivV1EppvZ80fzeSHH2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038052; c=relaxed/simple;
	bh=UTW2ZGiyy69eDiDpqlp14GE5qGdW3hytlY6efzzvicY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA9sSKCW+ZxZ2pCcPVrHGjm51vwxEygKH4EdmEAEtVl/vbIMWl94yc5hi94GYRRcuMstqGSq/o8GOuYeS94/5qrCE/8y6PeYDsBgs1KI7tnUFPPdqwCcPj9aiKTG7nVWx4G7WNX+w+Xcw8cVyo/+uShkc9DKeZOXvaQ5XSNKeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyvgJBpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F933C4CEF8;
	Thu,  9 Oct 2025 19:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038051;
	bh=UTW2ZGiyy69eDiDpqlp14GE5qGdW3hytlY6efzzvicY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyvgJBpxlel4K0G8hQSPenCYoEaIWjFSbfDsvJ7VOJUJPeUEjfjIE9KH0AFg8UpQX
	 KYdWFIpvtSBqpAiKfz+hj5EU7JUbv381HsWV+3c3OUHNEV6tJBNk3aBIkgfgjDNdS0
	 EMLmRuF2+ef4vpbpvU6w2SNUoGQwGLW5Wt+Or8G8pDb18HIW8ok+GGDBYP0DQWJ4dt
	 H8tg2oDqzYd9t3pKCppREmF37H5xg6LT/4tC2cyKuhmfSnl40IRiQn0yxF6bwQumsv
	 q/6CneJsie18i4SOvXwhPAu/J4atLgHsytTzL03mzc4b6UpLzxrzv2TANpM0B56VFL
	 ZLKDidAyZ7GJA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 3/3] ACPI: PM: s2idle: Only retrieve constraints when needed
Date: Thu, 09 Oct 2025 21:27:11 +0200
Message-ID: <3027060.e9J7NaK4W3@rafael.j.wysocki>
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

The evaluation of LPS0 _DSM Function 1 in lps0_device_attach() may be
useless if pm_debug_messages_on is never set.

For this reason, instead of evaluating it in lps0_device_attach(), do
that in a new .begin() callback for s2idle, acpi_s2idle_begin_lps0(),
only when pm_debug_messages_on is set at that point.

However, never attempt to evaluate LPS0 _DSM Function 1 more than once
to avoid recurring failures.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/s2idle.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -303,6 +303,9 @@ static void lpi_check_constraints(void)
 {
 	struct lpi_constraints *entry;
 
+	if (IS_ERR_OR_NULL(lpi_constraints_table))
+		return;
+
 	for_each_lpi_constraint(entry) {
 		struct acpi_device *adev = acpi_fetch_acpi_dev(entry->handle);
 
@@ -484,11 +487,6 @@ static int lps0_device_attach(struct acp
 
 	lps0_device_handle = adev->handle;
 
-	if (acpi_s2idle_vendor_amd())
-		lpi_device_get_constraints_amd();
-	else
-		lpi_device_get_constraints();
-
 	/*
 	 * Use suspend-to-idle by default if ACPI_FADT_LOW_POWER_S0 is set in
 	 * the FADT and the default suspend mode was not set from the command
@@ -515,6 +513,25 @@ static struct acpi_scan_handler lps0_han
 	.attach = lps0_device_attach,
 };
 
+static int acpi_s2idle_begin_lps0(void)
+{
+	if (pm_debug_messages_on && !lpi_constraints_table) {
+		if (acpi_s2idle_vendor_amd())
+			lpi_device_get_constraints_amd();
+		else
+			lpi_device_get_constraints();
+
+		/*
+		 * Try to retrieve the constraints only once because failures
+		 * to do so usually are sticky.
+		 */
+		if (!lpi_constraints_table)
+			lpi_constraints_table = ERR_PTR(-ENODATA);
+	}
+
+	return acpi_s2idle_begin();
+}
+
 static int acpi_s2idle_prepare_late_lps0(void)
 {
 	struct acpi_s2idle_dev_ops *handler;
@@ -612,7 +629,7 @@ static void acpi_s2idle_restore_early_lp
 }
 
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
-	.begin = acpi_s2idle_begin,
+	.begin = acpi_s2idle_begin_lps0,
 	.prepare = acpi_s2idle_prepare,
 	.prepare_late = acpi_s2idle_prepare_late_lps0,
 	.check = acpi_s2idle_check_lps0,




