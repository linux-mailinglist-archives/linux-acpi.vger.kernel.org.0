Return-Path: <linux-acpi+bounces-8393-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6022598587D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF491F2183F
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D218E742;
	Wed, 25 Sep 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV3VZwOC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339A18E058;
	Wed, 25 Sep 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264264; cv=none; b=iGarWz4ccXFQBXePjYBTd/QUIkljsjgQUc5YOZaa1QsjMojQCANDki+OXrZh7ld6WC2RrIqka5WqhZCRnIrXoTLJyl8xzgUNazQQJ/R2IS/4osOyYXvixSc9DApjFKcdqetNbR4+hm0sVZlNMBNG+sGMldq1FH8F2BejSqUws74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264264; c=relaxed/simple;
	bh=dG2FNYsxY5ffasvNaKu5vc7ys635v04UcJp/Azs/Yp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKDGOKwmup1eRHwWsMy9sY5mqnCcthojQCfzJidlTkvGKlEmD16rwGqf7XWpwSZFtO6l/4IO2uraAgtMsLkkyEkP1vSTguJh1POG/9p4iDZsLofGbJRBATeqZLSsFxyZgT9T6uNpVY42fsRKIlB6ssVizCnjG8s7UdWCfot1t1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV3VZwOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6377EC4CEC3;
	Wed, 25 Sep 2024 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264264;
	bh=dG2FNYsxY5ffasvNaKu5vc7ys635v04UcJp/Azs/Yp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PV3VZwOCtNTNQjEzU8YMp6J1rB1Yhg3hoRmliKIHnHEq8XCueaNNMMIhnEyQoMBCu
	 IqKv3c8iI51TIvKRe5RWMn7CjryR2MzhhhkqFmkQHQXcwd+nuWeVOJlA4CcpSDIfwc
	 oD4DFA6uO5d/CpWHmr+eR2DLPMDYaje84LRR+0Xnod9y/T/lY0PvvoG1+jOadvIW6z
	 feMb8FfZ4/o/MUbuk6OFD67tCKYlU467TiciUZwO9OkLdNqNj42icThDdIBX5otT0+
	 0SjQKWjHnWp2MsCQpVFpDQTyqxKh2sp1TegnUe6LEH4wj51EGJo1M70VcjD57tEC70
	 F1SH+daUqdZ8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 028/244] ACPI: video: Add force_vendor quirk for Panasonic Toughbook CF-18
Date: Wed, 25 Sep 2024 07:24:09 -0400
Message-ID: <20240925113641.1297102-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 674b9db7a1ef8..c35e96c6c1901 100644
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


