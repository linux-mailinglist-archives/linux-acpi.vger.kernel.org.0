Return-Path: <linux-acpi+bounces-5768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7D38C2F98
	for <lists+linux-acpi@lfdr.de>; Sat, 11 May 2024 06:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE4C1C212B1
	for <lists+linux-acpi@lfdr.de>; Sat, 11 May 2024 04:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369BB3CF65;
	Sat, 11 May 2024 04:57:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 05FBD335C0;
	Sat, 11 May 2024 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715403422; cv=none; b=IAtk/pTGp3y855MAyF27CnFI7DeZxuvx1nV9xkOl7lGqW5b3xBnJAmjEeDs36GaOzFTfngUY3HszcLSWk14uB0SVlwou6Z2jHc/bHVaXNMgazmgDblQgHHpipxDvgfMQH8jbSZCfhd4vf874vGf4N/LWyqM2d8QxF+8YhxL58Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715403422; c=relaxed/simple;
	bh=35IFkb2sCI/q3Dkj/60wbU07Uyb9qQTaJ6ONuH/kRKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M6+k0kcafRWJwagtAM5AHXZZQcC8KtggZvsqtsDHDDM3iIqJPlEuBoHyX5NGCmMNpWhax443p7hNN2YZBDBgYN1Jo+vBiDGOd0eFz71SyDu/Y+0x5TyP8LNCFOrTm5nLqQ0Y71BgP8PUAnSf/I9wS4Y6A4pLVl2hOnr1vc4YfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 98FB6602F9065;
	Sat, 11 May 2024 12:56:55 +0800 (CST)
X-MD-Sfrom: dengxiang@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: dengxiang <dengxiang@nfschina.com>
To: lenb@kernel.org
Cc: rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dengxiang <dengxiang@nfschina.com>
Subject: [PATCH]  ACPI: video: Add force_vendor quirk for Lenovo X1 Carbon.
Date: Sat, 11 May 2024 12:56:34 +0800
Message-Id: <20240511045634.12270-1-dengxiang@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

 Lenovo X1 Carbon advertises both native 0 and native 1 backlight
 control interfaces.It will result that native zx_backlight
 interface does not work.

 Add a DMI quirk to force use of the vendor interface.

Signed-off-by: dengxiang <dengxiang@nfschina.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 2cc3821b2b16..ed02b2d8b619 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -271,6 +271,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R600"),
 		},
 	},
+	{
+	 .callback = video_detect_force_vendor,
+	 .ident = "KaiTian X1 G1d",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "KaiTian"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "KaiTian X1 G1d"),
+		},
+	},
 
 	/*
 	 * Toshiba Portégé R100 has working both acpi_video and toshiba_acpi
-- 
2.30.2


