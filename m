Return-Path: <linux-acpi+bounces-16554-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1685DB50FF4
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409A21C26C52
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 07:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D1230DEA6;
	Wed, 10 Sep 2025 07:47:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66530DD3D;
	Wed, 10 Sep 2025 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490446; cv=none; b=uisTGJNjyq3iA7FjhZbgdisNt539jJ/sVZ4wLLir5ruCDngA9mnOigwpJVmOoa6TINrDcVG+gTZF/fnB+lgmO5L1xEpUv5E55D+wWGrpUg3sXkbT2RpesFKz7bS1RjwHWggzY7L1a6T22tkQ3gigDjqAKdcgvJzXoMy9iEqmlJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490446; c=relaxed/simple;
	bh=HrkZ7QmyC0ko9xZZhLgcxejf/rH/pOxKsUUUy4ZqFIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SnzygRbgIQb31/oHwMfmKNryLiyumHLAZAkzG6XjeTuFGXU5Ujw10wL/noKXeZ5+SjGnZj1IC+73XgyFkMLCU1TjuL7rShlugF/2cK4K3C5gdNL78+hBhUff7ZR9lI9Kfxs1ddmbf6vrX8232HIPo8qhXto+FJnFBh7M5Gp+6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5ec13dee8e1a11f0b29709d653e92f7d-20250910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b0f74bbd-84c0-49b8-8258-c438c2ef876d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:e94c29525daa99a61a755ff701b91a0a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5ec13dee8e1a11f0b29709d653e92f7d-20250910
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 162616005; Wed, 10 Sep 2025 15:47:15 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A3DBDE009008;
	Wed, 10 Sep 2025 15:47:15 +0800 (CST)
X-ns-mid: postfix-68C12D03-4921011059
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 40575E009007;
	Wed, 10 Sep 2025 15:47:14 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v1] ACPI: video: Fix missing backlight node creation on Zhaoxin platforms
Date: Wed, 10 Sep 2025 15:47:11 +0800
Message-Id: <20250910074711.1511753-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some recent Lenovo and Inspur machines with Zhaoxin CPUs fail to create
/sys/class/backlight/acpi_video0 on v6.6 kernels, while the same hardware
works correctly on v5.4.

Our analysis shows that the current implementation assumes the presence o=
f a
GPU. The backlight registration is only triggered if a GPU is detected, b=
ut on
these platforms the backlight is handled purely by the EC without any GPU=
.
As a result, the detection path does not create the expected backlight no=
de.

To fix this, move the following logic:

/* Use ACPI video if available, except when native should be preferred. *=
/
if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
    !(native_available && prefer_native_over_acpi_video()))
        return acpi_backlight_video;

above the if (auto_detect) *auto_detect =3D true; statement.

This ensures that the ACPI video backlight node is created even when no G=
PU is
present, restoring the correct behavior observed on older kernels.

Fixes: 78dfc9d1d1ab ("ACPI: video: Add auto_detect arg to __acpi_video_ge=
t_backlight_type()")
Cc: stable@vger.kernel.org
Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/acpi/video_detect.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index d507d5e08435..c1bb22b57f56 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -1011,6 +1011,11 @@ enum acpi_backlight_type __acpi_video_get_backligh=
t_type(bool native, bool *auto
 	if (acpi_backlight_dmi !=3D acpi_backlight_undef)
 		return acpi_backlight_dmi;
=20
+	/* Use ACPI video if available, except when native should be preferred.=
 */
+	if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
+	     !(native_available && prefer_native_over_acpi_video()))
+		return acpi_backlight_video;
+
 	if (auto_detect)
 		*auto_detect =3D true;
=20
@@ -1024,11 +1029,6 @@ enum acpi_backlight_type __acpi_video_get_backligh=
t_type(bool native, bool *auto
 	if (dell_uart_present)
 		return acpi_backlight_dell_uart;
=20
-	/* Use ACPI video if available, except when native should be preferred.=
 */
-	if ((video_caps & ACPI_VIDEO_BACKLIGHT) &&
-	     !(native_available && prefer_native_over_acpi_video()))
-		return acpi_backlight_video;
-
 	/* Use native if available */
 	if (native_available)
 		return acpi_backlight_native;
--=20
2.25.1


