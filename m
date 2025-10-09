Return-Path: <linux-acpi+bounces-17696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB1DBCAB14
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 21:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E9B4F0889
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B7625A32E;
	Thu,  9 Oct 2025 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQDVSKEZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B3025A2C2;
	Thu,  9 Oct 2025 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038054; cv=none; b=K6mvtAWEsTu2Bo/374KeqVL6jBV8ZvyZVCgU1vfeL/ZSIPnblZpDnzZMfSeUXB+XLIOu4OILqsof8mR2R/wjWQgsEeMGXHoD+t+IJWzBJpIJD5t7klArpu65ImOYniS1qJEB7qek7D3WrRltO/7jzRmP934xIqqbJRwFtmHCyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038054; c=relaxed/simple;
	bh=uog5pb5sRxGQVzSDZkzBL65tJAlNagTCYW9kBRKRyjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYKsPLg64qyzx3JePINEBE+KlEhqwpYGF/6KpUQD9riKfzFVee+r9iPRmHuWDf50bf9hXRItXpW6GuBKdN5l51JKieE25va+UE3FyrkO2HSWwykdrWWTyEJaq3YFJEIfKIpdGMKuXa6lY9LPJFOiELRUYMuu04SwYjHvbXUgIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQDVSKEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F66FC4CEE7;
	Thu,  9 Oct 2025 19:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038054;
	bh=uog5pb5sRxGQVzSDZkzBL65tJAlNagTCYW9kBRKRyjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQDVSKEZYzznzV4/T36F4sAaIse4bDxd6mKqZotnkO7LsMAX0Zz+qRVN5t6Z17Lsb
	 FZ5pyzItpE+PMbg7vzDIvXryxQ3reQqyqo/XnfexrOUeei+U6lgUq//opuxsheMsef
	 89a7waW3RmISn5I2iA3R8Sv2mlqYnrIgCkyNdeEFlC3FbnzbkJapAY0XBjFEAPaia6
	 zhONkjPyILSghQVfzO5Fl3otgHK9vCDMtuyGJaie7+KteTLwltq+N/U1IXErpDLnjo
	 RmstrFUjlxnH3KvWNiWA2CMbq9sfEuQ/YdSrRvCXPKN1ZvVhW+xUjeWm1+mXfVI8Zm
	 n3uIHw22JL8bQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 2/3] ACPI: PM: s2idle: Staticise LPS0 callback functions
Date: Thu, 09 Oct 2025 21:26:30 +0200
Message-ID: <2254836.irdbgypaU6@rafael.j.wysocki>
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

The LPS0 callback functions in x86/s2idle.c can be made static, so do
that and remove their declarations from sleep.h.

While at it, add the _lps0 suffix to their names to indicate that
they are LPS0-specific.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.h      |    3 ---
 drivers/acpi/x86/s2idle.c |   12 ++++++------
 2 files changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -17,10 +17,7 @@ static inline acpi_status acpi_set_wakin
 
 extern int acpi_s2idle_begin(void);
 extern int acpi_s2idle_prepare(void);
-extern int acpi_s2idle_prepare_late(void);
-extern void acpi_s2idle_check(void);
 extern bool acpi_s2idle_wake(void);
-extern void acpi_s2idle_restore_early(void);
 extern void acpi_s2idle_restore(void);
 extern void acpi_s2idle_end(void);
 
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -515,7 +515,7 @@ static struct acpi_scan_handler lps0_han
 	.attach = lps0_device_attach,
 };
 
-int acpi_s2idle_prepare_late(void)
+static int acpi_s2idle_prepare_late_lps0(void)
 {
 	struct acpi_s2idle_dev_ops *handler;
 
@@ -561,7 +561,7 @@ int acpi_s2idle_prepare_late(void)
 	return 0;
 }
 
-void acpi_s2idle_check(void)
+static void acpi_s2idle_check_lps0(void)
 {
 	struct acpi_s2idle_dev_ops *handler;
 
@@ -574,7 +574,7 @@ void acpi_s2idle_check(void)
 	}
 }
 
-void acpi_s2idle_restore_early(void)
+static void acpi_s2idle_restore_early_lps0(void)
 {
 	struct acpi_s2idle_dev_ops *handler;
 
@@ -614,10 +614,10 @@ void acpi_s2idle_restore_early(void)
 static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
-	.prepare_late = acpi_s2idle_prepare_late,
-	.check = acpi_s2idle_check,
+	.prepare_late = acpi_s2idle_prepare_late_lps0,
+	.check = acpi_s2idle_check_lps0,
 	.wake = acpi_s2idle_wake,
-	.restore_early = acpi_s2idle_restore_early,
+	.restore_early = acpi_s2idle_restore_early_lps0,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
 };




