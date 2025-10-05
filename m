Return-Path: <linux-acpi+bounces-17595-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F397BBCD6C
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 00:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03B734E758C
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 22:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280A12512EE;
	Sun,  5 Oct 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RSuAPNuV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4D24A04A;
	Sun,  5 Oct 2025 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759703136; cv=none; b=NO7m5cbTMqMGn6V1Zi7WDsuYE4QGKAAD5kee4xQLZTvXzHWtguU3KGl8J0gJe3FnFuHOYtXKzOa0obdALyXxX6Mb20BVqQVUOzc6xlD5jot0KkhKskaKgw+O56ZmFR0baknWCXu7nIxcZSVsASipPVzj6AJ5Jnr8MAA/zB2Dh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759703136; c=relaxed/simple;
	bh=xqh6pZSk7wn5lhjBA+DBxUBR9bAgiYE7r/8l3/H8sgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EPzAi5l+8GxraYT4pXyLDYT02KN0rfJPY3877RBJVJDe4IoeogFDbTbuxEPe1XH81dcTlneVuZXEr1IOIuTBdFXEN7zyVbm7FRm/7U5bKc1X8syuJDHTHslt/PANj59VZbW2CL2ptn5R8NKoCFq2Ywg8e4XZ7PhRjKWloeoB+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RSuAPNuV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759703132; x=1760307932; i=w_armin@gmx.de;
	bh=vdLDI039lJrjTfOzfv2/hzx80BvbbopABIHNmkFDoos=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RSuAPNuVcxsNJFwcjd2iEjPPAsl0trfThZFERpnNVK+2dl48IORs1X7bWyCRX+Nt
	 ye2UADXAy4k/8sj0dC3A18udM2Rnz4Mt5r1rESkBJTaMe+G1OtrkJOCvUkUG0jDgT
	 Tc38xm/XAYCn0nG8N8SKkM/lRJgXrN+E/XhVYXhG7MPH9V9fYccwkQ1ziNkxTzidj
	 z9ihhuy1X0fncJincwAkjqXPsqCzcX5w3GYJ11KxAUad6fNX9M8jqm/hD6GEJQn3c
	 vn7fjc5gu/4PivjDv3I8krZKepxtzMJqKAmaot59TvVDh3/g02Ptul3H71ENxXvOQ
	 SHJnwVPUqhTjN+BJUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MGyxX-1v0oLQ3qlP-00DX6K; Mon, 06 Oct 2025 00:25:32 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ACPI: fan: Add hwmon notification support
Date: Mon,  6 Oct 2025 00:25:12 +0200
Message-Id: <20251005222513.7794-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251005222513.7794-1-W_Armin@gmx.de>
References: <20251005222513.7794-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cgyzx88MbDOoHeHKsaqQoR5KXXihNpoAORlzvyTVtjzeKnpG+KW
 xoW13ZO6lOLlztcY7TwyIJwQ6w/kk9aUYjf3aA1brcKwr1l/MHGcG4yteTLVouGUa294YxC
 QJzPkD2iyuESE5EmowBILKSPfXgYtAo1U2BCTNTelHnFLn2CIVL6t+wm+En1HOP0WLQ2hEz
 0ygn39FRUUGky25vjYQQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AWIDZv39W5w=;nRsHn975m+gctLoMO+lMLHVZszB
 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

The platform firmware can notify the ACPI fan device that the fan
speed has changed. Relay this notification to the hwmon device if
present so that userspace applications can react to it.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan.h       |  5 +++++
 drivers/acpi/fan_core.c  |  1 +
 drivers/acpi/fan_hwmon.c | 15 +++++++++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 0d73433c3889..dcc1ad3118ff 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -56,6 +56,9 @@ struct acpi_fan {
 	struct acpi_fan_fif fif;
 	struct acpi_fan_fps *fps;
 	int fps_count;
+#if IS_REACHABLE(CONFIG_HWMON)
+	struct device *hdev;
+#endif
 	struct thermal_cooling_device *cdev;
 	struct device_attribute fst_speed;
 	struct device_attribute fine_grain_control;
@@ -99,8 +102,10 @@ void acpi_fan_delete_attributes(struct acpi_device *de=
vice);
=20
 #if IS_REACHABLE(CONFIG_HWMON)
 int devm_acpi_fan_create_hwmon(struct device *dev);
+void acpi_fan_notify_hwmon(struct device *dev);
 #else
 static inline int devm_acpi_fan_create_hwmon(struct device *dev) { return=
 0; };
+static inline void acpi_fan_notify_hwmon(struct device *dev) { };
 #endif
=20
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 545b490d624e..3dbd22bc3a48 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -326,6 +326,7 @@ static void acpi_fan_notify_handler(acpi_handle handle=
, u32 event, void *context
 		if (ret < 0)
 			dev_err(dev, "Error retrieving current fan status: %d\n", ret);
=20
+		acpi_fan_notify_hwmon(dev);
 		break;
 	default:
 		dev_dbg(dev, "Unsupported ACPI notification 0x%x\n", event);
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index 47a02ef5a606..d3374f8f524b 100644
=2D-- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -162,12 +162,19 @@ static const struct hwmon_chip_info acpi_fan_hwmon_c=
hip_info =3D {
 	.info =3D acpi_fan_hwmon_info,
 };
=20
+void acpi_fan_notify_hwmon(struct device *dev)
+{
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+
+	hwmon_notify_event(fan->hdev, hwmon_fan, hwmon_fan_input, 0);
+}
+
 int devm_acpi_fan_create_hwmon(struct device *dev)
 {
 	struct acpi_fan *fan =3D dev_get_drvdata(dev);
-	struct device *hdev;
=20
-	hdev =3D devm_hwmon_device_register_with_info(dev, "acpi_fan", fan, &acp=
i_fan_hwmon_chip_info,
-						    NULL);
-	return PTR_ERR_OR_ZERO(hdev);
+	fan->hdev =3D devm_hwmon_device_register_with_info(dev, "acpi_fan", fan,
+							 &acpi_fan_hwmon_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(fan->hdev);
 }
=2D-=20
2.39.5


