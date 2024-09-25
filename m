Return-Path: <linux-acpi+bounces-8411-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9647D985EA3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 15:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D4528A50B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C682141B3;
	Wed, 25 Sep 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjyE9cKU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE1A2141AE;
	Wed, 25 Sep 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266351; cv=none; b=ufKCcy1JZRcZ+Snk68w7CghuWUirPB/dYscfsoTzdazCcQNm5iX7N1emFhlJg6mIyOZmAbmxR1GCPOV2WZ4JqvfdLqujCsZeYbbDL6BPX7BMvGtmyf6iheHHuxwzOhmZ/B8FjAbmLR8fYYdypdL/0vhtn4cy3pzDxPCI9iupaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266351; c=relaxed/simple;
	bh=qXzFBmeGGR4ZWh1gpembWTg3vGj87Ym7NJoIge59Vd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SneZ4oUFeuDmeuEkt/db7Zm1KcWc3sqN17b6ZhoymuoJl35AAED44S70M67rN6s26SBn+XuQHHdGc+rP7duoKhn27DNBZWWpwkIVyl+tMJosPmfBT1KC4CMdRsToLeYG9J6b8w4EzqsvjZtwoqjtwtsvPXxJhnFqs4Ee3t5jtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjyE9cKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A155FC4CECE;
	Wed, 25 Sep 2024 12:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266351;
	bh=qXzFBmeGGR4ZWh1gpembWTg3vGj87Ym7NJoIge59Vd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjyE9cKUu3K9yDd20o7jTycBumLmbsoJKUGqkCXyjGqRB3jHmslxtsW0+oboPdcPl
	 R54N008gJebQoh8AaxT+rlMCJMXwgzndGbiSOwX/6akn6WeLGeVfLNHvxhtO1sAfej
	 pg0LFYCyyis+p/DqDO7jlhjpNitbFAHkFif50a+BQ2gdh2R5fAbBCxfrWCutN2fyZv
	 ix4okEJlz9atRyjc6zdQpJ82F2UPlcxLO+TARtZjvEyuoYiS2xJCsjCpUoeY3I4Li2
	 NweSGE2le4bVGuzkCqSrgbvv/aafPqF8B/DuWBxXaqOE2uzgzEUDNT5suOnik52ngj
	 jdVtETwvqtw2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 023/139] ACPI: video: Add force_vendor quirk for Panasonic Toughbook CF-18
Date: Wed, 25 Sep 2024 08:07:23 -0400
Message-ID: <20240925121137.1307574-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit eb7b0f12e13ba99e64e3a690c2166895ed63b437 ]

The Panasonic Toughbook CF-18 advertises both native and vendor backlight
control interfaces. But only the vendor one actually works.

acpi_video_get_backlight_type() will pick the non working native backlight
by default, add a quirk to select the working vendor backlight instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20240907124419.21195-1-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 16ab2d9ef67f3..e96afb1622f95 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -260,6 +260,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "PCG-FRV35"),
 		},
 	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Panasonic Toughbook CF-18 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Matsushita Electric Industrial"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "CF-18"),
+		},
+	},
 
 	/*
 	 * Toshiba models with Transflective display, these need to use
-- 
2.43.0


