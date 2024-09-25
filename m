Return-Path: <linux-acpi+bounces-8403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A4E985CAF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 14:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E0DB23CEE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5113E1CEEAF;
	Wed, 25 Sep 2024 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6nKYjk1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A31CEEA9;
	Wed, 25 Sep 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265566; cv=none; b=LJe7npsG4iHjlWt10xmW/biYYoMx2hfz+783c3CBSKiTaOi4ANh/ANjCBcGqb8/DbBITqC1zLSu2777KeFdfj1ZSU1S+FKWHTZ8LPFwzNr2TGHmmSNhRfPZiVK04FI50adqk1n2eT639Gk6/NWQznCjnl1OLuMcwsKy2hKjBRc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265566; c=relaxed/simple;
	bh=tDosBEpQ0p+pvDe/oeuUkL2tz+nvxMO8a+E/xdlrT50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsccUqnvHMe05Mo1dajLSCxsAhLw/yzvckq4oBmfkBGcNuHZjxIbbuJOHudYWKNhKw4+8UgBrZcM2djmPTWhR3HgcaxRPOMHwwYuTf8/4fYVYlzzo/BOVesvORiubMJwcV5iIjfoyPy86kSASUj5fAU52Yiyajmx4WnR7zXWKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6nKYjk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5537C4CEC7;
	Wed, 25 Sep 2024 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265565;
	bh=tDosBEpQ0p+pvDe/oeuUkL2tz+nvxMO8a+E/xdlrT50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6nKYjk1JBjNvKkrPqSo74/EBDDvRO0nTDf0u1gdlr5ksqnaQS5CWZBP0r8X1O5E9
	 ynAO6Vn9Cxxa3aaGcDMtmHnjQJe7tIpa43TCOoBkN0mupZiQunT9S1rs+x+hKN4a09
	 jGXXu1q3uUOREetLV002L8hsSmnU6UTEqfJyjNtAkVYpv+FDKbdl5JHFtrgTIADGtz
	 zFHRZyKUyKt1WmbQsLekf31DgErpzjglE++HWny6OJDhY+NawMH2jVteWsIBYnBvtY
	 Kkvfun3jTLKA+yL00lIrjCP0pxX034N8spPbL3/c+/wv6C1kWbdioPmIPA4hFpRy4A
	 sbX1PZeZadplA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 025/197] ACPI: video: Add force_vendor quirk for Panasonic Toughbook CF-18
Date: Wed, 25 Sep 2024 07:50:44 -0400
Message-ID: <20240925115823.1303019-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index ff6f260433a11..48cf850dd08c7 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -254,6 +254,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
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


