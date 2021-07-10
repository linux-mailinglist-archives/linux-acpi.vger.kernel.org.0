Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2899B3C3854
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jul 2021 01:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhGJXyd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Jul 2021 19:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233464AbhGJXxw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Jul 2021 19:53:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABECA613D8;
        Sat, 10 Jul 2021 23:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961059;
        bh=OBUDEwLW8QxBiAPrBetZCJEGlhRS5cHmP3/lfv6A0Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biUdfd8RilcXBLmE2mW8oyEsl4OmgmMz6gymEU+1ad7t3LcWkCGQTLZcgxzI/4XfP
         7Zjsn4qKGntGbyeH9vZkWAfyazVWE2RElO8h22elJe0X8DD3o+fR2JQOqN1fxDmQom
         wOGUHSnsoSrzVh42x6+LL1USYObp4Qdt3UlUgssOXF1iW4/Re6v3P9E79oDgcxqgQw
         ImKBf13/EbnWQgbD4GQhqiyZT1z0WNkOCjaX85ohRffYa0Kt1WZaXS6MCS0T4m7VG+
         caM0+HCFGNm2ETqWl9W6teGKe2kt7JbtuHXYSVyJePRH62Qf+/A6d+/qeYkWs2FCth
         +Wt1m+fFVgUKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 32/37] ACPI: video: Add quirk for the Dell Vostro 3350
Date:   Sat, 10 Jul 2021 19:50:10 -0400
Message-Id: <20210710235016.3221124-32-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710235016.3221124-1-sashal@kernel.org>
References: <20210710235016.3221124-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 9249c32ec9197e8d34fe5179c9e31668a205db04 ]

The Dell Vostro 3350 ACPI video-bus device reports spurious
ACPI_VIDEO_NOTIFY_CYCLE events resulting in spurious KEY_SWITCHVIDEOMODE
events being reported to userspace (and causing trouble there).

Add a quirk setting the report_key_events mask to
REPORT_BRIGHTNESS_KEY_EVENTS so that the ACPI_VIDEO_NOTIFY_CYCLE
events will be ignored, while still reporting brightness up/down
hotkey-presses to userspace normally.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1911763
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_video.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index a322a7bd286b..eb04b2f828ee 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -543,6 +543,15 @@ static const struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V131"),
 		},
 	},
+	{
+	 .callback = video_set_report_key_events,
+	 .driver_data = (void *)((uintptr_t)REPORT_BRIGHTNESS_KEY_EVENTS),
+	 .ident = "Dell Vostro 3350",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3350"),
+		},
+	},
 	/*
 	 * Some machines change the brightness themselves when a brightness
 	 * hotkey gets pressed, despite us telling them not to. In this case
-- 
2.30.2

