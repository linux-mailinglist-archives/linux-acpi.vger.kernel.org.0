Return-Path: <linux-acpi+bounces-17593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB9BBCD63
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 00:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5A83B8820
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67495248898;
	Sun,  5 Oct 2025 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gWxUVtQP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630A246BA4;
	Sun,  5 Oct 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759703133; cv=none; b=YSJVemXN2EMcpR5XfcEJ2RRSEAFO/tMDC/rP4wyA8kswIkRszuhPubSdo/fzHABVVg9nzsdZCb+1KK32jSuJl0iD/lGYRVP8FdLdAJFUUlee0MFdFF+QG871M1kwTA9c4q1mA9XjcdA0RBtweU+dEyig57eMKkLPk/i4KjGMufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759703133; c=relaxed/simple;
	bh=MlHP0jd+Gi1z2ooUPOaFjRaMw+08hV/BrOOkBN8UX5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+YLK1zd3kt/lGOnvVeVNGbBLZsE9e+H8Qx4185+oXAghQfBl+FYYadJB9pkcuUjDBXp8FnoUG7IQJF2gb64y7gd88W6cjW/1b30SDo0qxb17rcj/nwTCkp+NICwlUuR9gxfzI8Tn8yxjoLVK8qt0VCWqv/G9MO3xvJuu77khU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gWxUVtQP; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759703129; x=1760307929; i=w_armin@gmx.de;
	bh=bWLZsCK16J6VPDI6PSn/FWwhJiH9UOgcLVn6IdHq3lk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gWxUVtQPrmMStICRz4erNq4pw5TZvnSrw81mg4iE0t7VkHeE6H9i6/fZTOcAjRHy
	 NFHo2bNLbAKSAt1ZuyeREU/tad80aG6Y0ufAxuCTeKshkqXm5r87sUrUBmXQ7h8LA
	 xYsWZYL7HLm7dNvZd5zg/Cht6cxd0uuQLlJvqdqJSMatw48DmQgIaatIEjzD5QLlS
	 tr1q2R5F3MwJWNE/tbHAcUDGwjdreaiXn27dJ3izcDyvdAZigfQSYn/J8m1ICAR9g
	 reSvWL8IwJ0MC4YxrVvD9RB2+wK6CVBeiJFreJLV+bFde7+jKEENKtFflnaFThELS
	 auVOBpboTkAoVWxmWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MOzSu-1uvYrE3bvI-00PwhG; Mon, 06 Oct 2025 00:25:29 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ACPI: fan: Use platform device for devres-related actions
Date: Mon,  6 Oct 2025 00:25:10 +0200
Message-Id: <20251005222513.7794-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:3NNONuo6fOn581SwHidC6t/p7K/Pb9qTzpJMCcLxv06o7iKsweq
 o58WDbixs6A3SGWs9fW7oZ4f6s5PE1gaQdrTY6r7c6z4M9WNWDPe55z7GXrHmoTnddmBEJB
 78xTNlmQ+uVnk3KzKaPaqJcHzi/bA6U5hIYLckc8k9AragC/XwuvgD06ZBT8du5c0RITlLk
 CWD33whLm696O++VyNEhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VARd5Qh4lwk=;9o40UmAKev0R2FNOapnE4L7/Umw
 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
 SyNaKtSK2vNqbmFdo=

Device-managed resources are cleaned up when the driver unbinds from
the underlying device. In our case this is the platform device as this
driver is a platform driver. Registering device-managed resources on
the associated ACPI device will thus result in a resource leak when
this driver unbinds.

Ensure that any device-managed resources are only registered on the
platform device to ensure that they are cleaned up during removal.

Fixes: 35c50d853adc ("ACPI: fan: Add hwmon support")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan.h       | 4 ++--
 drivers/acpi/fan_core.c  | 2 +-
 drivers/acpi/fan_hwmon.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 022bc215cdbc..0d73433c3889 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -98,9 +98,9 @@ int acpi_fan_create_attributes(struct acpi_device *devic=
e);
 void acpi_fan_delete_attributes(struct acpi_device *device);
=20
 #if IS_REACHABLE(CONFIG_HWMON)
-int devm_acpi_fan_create_hwmon(struct acpi_device *device);
+int devm_acpi_fan_create_hwmon(struct device *dev);
 #else
-static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) =
{ return 0; };
+static inline int devm_acpi_fan_create_hwmon(struct device *dev) { return=
 0; };
 #endif
=20
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index ea2c646c470c..46e7fe7a506d 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -347,7 +347,7 @@ static int acpi_fan_probe(struct platform_device *pdev=
)
 	}
=20
 	if (fan->has_fst) {
-		result =3D devm_acpi_fan_create_hwmon(device);
+		result =3D devm_acpi_fan_create_hwmon(&pdev->dev);
 		if (result)
 			return result;
=20
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index 5581aa6fdfa0..47a02ef5a606 100644
=2D-- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -162,12 +162,12 @@ static const struct hwmon_chip_info acpi_fan_hwmon_c=
hip_info =3D {
 	.info =3D acpi_fan_hwmon_info,
 };
=20
-int devm_acpi_fan_create_hwmon(struct acpi_device *device)
+int devm_acpi_fan_create_hwmon(struct device *dev)
 {
-	struct acpi_fan *fan =3D acpi_driver_data(device);
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
 	struct device *hdev;
=20
-	hdev =3D devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", =
fan,
-						    &acpi_fan_hwmon_chip_info, NULL);
+	hdev =3D devm_hwmon_device_register_with_info(dev, "acpi_fan", fan, &acp=
i_fan_hwmon_chip_info,
+						    NULL);
 	return PTR_ERR_OR_ZERO(hdev);
 }
=2D-=20
2.39.5


