Return-Path: <linux-acpi+bounces-17653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C153BC2F98
	for <lists+linux-acpi@lfdr.de>; Wed, 08 Oct 2025 01:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020833E24B5
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE240262FFC;
	Tue,  7 Oct 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XxTAtHqP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B725F984;
	Tue,  7 Oct 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880532; cv=none; b=JR4pUlJI1McH9uVSO+TOESLMssLpl+1nzbpt5HtIwxlxwWC8Ck0GbZsZHA3K48eakIBOi3ZDvqKSvN6lA98KPIeBHzJuCT4C/N7UxYE0Q6s0sajtkZRhgArd5sDbxqDjBscMQgYBOT+SJN3OHOGbUUK3EXP7hN7aWDJ84nnHPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880532; c=relaxed/simple;
	bh=MlHP0jd+Gi1z2ooUPOaFjRaMw+08hV/BrOOkBN8UX5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KS6NHja++cAkXABukFpSADdkr4EM9bNeH8BPlC9WCu8Se7rx3jt+xYANH9I5o1Ux+ZetgfEjWKo1oS1L5/16bsmOu9lGgWCFoJbZKWGw54n8pe6jHw0y7NNg8ScigpgnuBNEZ0d0ITlD+o1XECns+iTR0o1w71rs6IU+9O+NtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XxTAtHqP; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759880524; x=1760485324; i=w_armin@gmx.de;
	bh=bWLZsCK16J6VPDI6PSn/FWwhJiH9UOgcLVn6IdHq3lk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XxTAtHqPEiZSLDv1Fq74sm75EC4zyPESkKpYydApQSLlLlle73M361MIUi49c4/R
	 NkZaDFBylI30oulV+Bo96owKrky4w8AJUVQZ5bME7CglhAxC4+/xnZc09TzSpQJbG
	 rQI71J6XOrnoGrWxhZjbQQghQYc1n4rH9pge/Gicj2zbjIpas0Ge01QmnupyXMdJm
	 TrZScvWFs3P8y0KccFV3UhtWDaIG8sW250Mlg/6LBa2oISDSd520ho+gvacr5NxHd
	 OkU/619l4AdHvxSDn2JorY88ycgoUpjcQaOqNOGuYXBGqfnR0ZwMItzD9ISBiT2nx
	 9JhFzYoT5QdoDGLgfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MjjCL-1uQaut1OHr-00og63; Wed, 08 Oct 2025 01:42:04 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ACPI: fan: Use platform device for devres-related actions
Date: Wed,  8 Oct 2025 01:41:46 +0200
Message-Id: <20251007234149.2769-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251007234149.2769-1-W_Armin@gmx.de>
References: <20251007234149.2769-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CwqvnkJRmHarAWAcnGW1kSunDZpCEUCSkDS5bSJrEspbdNpC+rZ
 XUZWxKmvhCnkT07yDzjxFtWBQBxQ72TR7bkjzcYQyrozt2T7yuWiQk/ApQMry5lW+aGOya2
 du3+cgNuKUldhEBSPv+ie04PrbRZBpDft+0yoiSODYc9lqM0NNcG0eRJjj1BP5o0snPkyNm
 YVn1I7eaRVzKElTTmmtcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:th76yd9AJ/U=;bYVlvmZvjrejEO/ZLKdqmqpWplO
 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

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


