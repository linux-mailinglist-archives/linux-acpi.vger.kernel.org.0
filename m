Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786273BBF50
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 17:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhGEPcH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 11:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232174AbhGEPby (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jul 2021 11:31:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F41161978;
        Mon,  5 Jul 2021 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625498957;
        bh=F0ZOtPaLg7ZLUv7+BtbmeLGwPX6I3v75FrJSUcAv5ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lO5PK4I4i1ncTJ+930HoPiGT78q/fgV3KRxBvVr2zKzwGx3ML3fVIW3UYzfbfOtV7
         pkOuVpBuPtF/J1sxdHj0PWJonS6ua5ee3INX/x2wZCGQWYoa4yFK8r5X6ugGVK+4pT
         CtPGVoLdeT/rsf9ppPTJIhePlC0POo9LcpiVbZy2DUVcZz8jTcB9eTZXocJ33eoOSb
         lMr0V696ECtDRSqb9MLEsWIYchDrFRV0erLtzkXo28j4/wUxrwVERsTcII/w0KTHTa
         pdHJDTnZyu3xgNZ1Lw9im0kVTTMOto33lpwHVOFBp4apuOpSoRgryLCuAxO5JtU3oh
         CfkstquZe7V5g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 03/52] ACPI: PM: s2idle: Add missing LPS0 functions for AMD
Date:   Mon,  5 Jul 2021 11:28:24 -0400
Message-Id: <20210705152913.1521036-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705152913.1521036-1-sashal@kernel.org>
References: <20210705152913.1521036-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit f59a905b962c34642e862b5edec35c0eda72d70d ]

These are supposedly not required for AMD platforms,
but at least some HP laptops seem to require it to
properly turn off the keyboard backlight.

Based on a patch from Marcin Bachry <hegel666@gmail.com>.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/s2idle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2b69536cdccb..2d7ddb8a8cb6 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
+#define ACPI_LPS0_ENTRY_AMD         2
+#define ACPI_LPS0_EXIT_AMD          3
 #define ACPI_LPS0_SCREEN_OFF_AMD    4
 #define ACPI_LPS0_SCREEN_ON_AMD     5
 
@@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
 
 	if (acpi_s2idle_vendor_amd()) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
 	} else {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
@@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
 		return;
 
 	if (acpi_s2idle_vendor_amd()) {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
 	} else {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
-- 
2.30.2

