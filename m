Return-Path: <linux-acpi+bounces-17655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F11BC2FAA
	for <lists+linux-acpi@lfdr.de>; Wed, 08 Oct 2025 01:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72D0E4F56AF
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 23:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB3265CDD;
	Tue,  7 Oct 2025 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OStsaVJ3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9120261B76;
	Tue,  7 Oct 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880533; cv=none; b=aeCKpjBct2Ko3x2j5w/UN4KY9EnR7ICGNM5NflVO1qXhLfMn/vFyfx7YZOj5ue5AyIUhnI6j7veIWU5e0kc5/nYRvb9vgDM4d+ogd1fWyhUF4HP4oRWOxQ/bND/hUhxTq3aGqsGm46YSn5YX7pb2+2G7Ks92G6CML/KDRDbeAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880533; c=relaxed/simple;
	bh=8gDu5zuPLk33NAmJ3WZKbijbJ8qnTqrJoej7WwiPsqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZX9+gd7qH/j8jHd8IveNwiWfR6zfyvC4rSQBZ0x2VsbeKZvRGtSiQRRxHYs9QEcTLmZnprvVcQdaTR26t3XxzuiZmp5Qaan9MeC63TcPOSV5ngqk8G+mLKZsVyhW6GNSlAAU71cEjKI1edEOqMzyR/I2PzEpBiRW+7dNTvgROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OStsaVJ3; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759880526; x=1760485326; i=w_armin@gmx.de;
	bh=yaJ2vhZGJYLCCzCma1kImL1OBNIVEEsDW59LF7HCr40=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OStsaVJ3jx4X89owsDy1ornkRO7FRzpKIn7r5wQwBNEnSTxP/PYJie7z6R7FLxlF
	 hsBdmxZVr/wcqOaPrgtwJ4yhwGE+Q8Uxa36DNeqU4dbgT2TKwuImxkidxIGiGrstG
	 vembPlkReEbo8gXn1dy2N3UZ5BlfsSQAqOi1DXZYOZYUJsC42hB34s5J4K86J5Fkf
	 TKuFRZZ22XmZFBK4odAGl/5gusp+m4F1mXJWsLZFWy++CvAnBK2FS+SVdZ/o/WnzE
	 vRQGTmJiF/ZAxHWQRf9gNYOR/6drzRLq+t3JWD0DNPwOPRYZh7LQwRDQFpemOzylh
	 jyK7pBG1CGAFACmsYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MY68d-1ul9wO3dvh-00TqZT; Wed, 08 Oct 2025 01:42:06 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] ACPI: fan: Add basic notification support
Date: Wed,  8 Oct 2025 01:41:47 +0200
Message-Id: <20251007234149.2769-5-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:GjDZly3HOaBdgNzypycznTKqVTOFUVFLkbAiKf6FxKh9/8YTJdK
 fcvDFeAMpT7RnQZ4Gm0vc6uXXRFX65Sga0Cc5VNco62q0b0MwZ3aQ+9IIlW32VgJESFSW9i
 /eHUC55oFPySnG93x3vfGZxb16g85NULM6PXU61WL9hqRmtc+yKPWHsTq3BCZp67sBuiG8z
 Icorq/laUHCEvnV2CDHVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hkI5xRsF1x0=;qLHquQXYs+TeL5eMmplf+s/3icY
 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
 ATa1g==

The ACPI specification states that the platform firmware can notify
the ACPI fan device that the fan speed has changed an that the _FST
control method should be reevaluated. Add support for this mechanism
to prepare for future changes.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan_core.c | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 46e7fe7a506d..9ee4ef2d6dbc 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -19,6 +19,8 @@
=20
 #include "fan.h"
=20
+#define ACPI_FAN_NOTIFY_STATE_CHANGED	0x80
+
 static const struct acpi_device_id fan_device_ids[] =3D {
 	ACPI_FAN_DEVICE_IDS,
 	{"", 0},
@@ -308,6 +310,50 @@ static int acpi_fan_get_fps(struct acpi_device *devic=
e)
 	return status;
 }
=20
+static void acpi_fan_notify_handler(acpi_handle handle, u32 event, void *=
context)
+{
+	struct device *dev =3D context;
+	struct acpi_fan_fst fst;
+	int ret;
+
+	switch (event) {
+	case ACPI_FAN_NOTIFY_STATE_CHANGED:
+		/*
+		 * The ACPI specification says that we must evaluate _FST when we
+		 * receive an ACPI event indicating that the fan state has changed.
+		 */
+		ret =3D acpi_fan_get_fst(handle, &fst);
+		if (ret < 0)
+			dev_err(dev, "Error retrieving current fan status: %d\n", ret);
+
+		acpi_bus_generate_netlink_event("fan", dev_name(dev), event, 0);
+		break;
+	default:
+		dev_dbg(dev, "Unsupported ACPI notification 0x%x\n", event);
+		break;
+	}
+}
+
+static void acpi_fan_notify_remove(void *data)
+{
+	struct acpi_fan *fan =3D data;
+
+	acpi_remove_notify_handler(fan->handle, ACPI_DEVICE_NOTIFY, acpi_fan_not=
ify_handler);
+}
+
+static int devm_acpi_fan_notify_init(struct device *dev)
+{
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+	acpi_status status;
+
+	status =3D acpi_install_notify_handler(fan->handle, ACPI_DEVICE_NOTIFY,
+					     acpi_fan_notify_handler, dev);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return devm_add_action_or_reset(dev, acpi_fan_notify_remove, fan);
+}
+
 static int acpi_fan_probe(struct platform_device *pdev)
 {
 	int result =3D 0;
@@ -351,6 +397,10 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
 		if (result)
 			return result;
=20
+		result =3D devm_acpi_fan_notify_init(&pdev->dev);
+		if (result)
+			return result;
+
 		result =3D acpi_fan_create_attributes(device);
 		if (result)
 			return result;
=2D-=20
2.39.5


