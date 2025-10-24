Return-Path: <linux-acpi+bounces-18208-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C20C07C87
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB961C8104B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD15634AAE7;
	Fri, 24 Oct 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Stl8IX9m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0F309EFF;
	Fri, 24 Oct 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331120; cv=none; b=NQ0sfZg2Yo2gEqpPBJ5GQF/xqLAmd/KeoeRJh5ff8fksVM0d/jRdVWo4LLM7U3XWvGMUa1og1vCb0/1Kw9AoUiTuyvY3Mc3fJHz60wfTV6FG5Z1Q/pZtVvHWO7Op5gPzvYhCPd5IBlv9r8iV+o7vpynuLeSoY14sJzI270ygUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331120; c=relaxed/simple;
	bh=8gDu5zuPLk33NAmJ3WZKbijbJ8qnTqrJoej7WwiPsqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDtINrl/+5Vq9y1Nw5S4GT4wHL3y5I/RDx7Z+SDAw0j5BuxuvixMUcDr3oR1WsqvO6oHsQel0G0XhCC2okKv/4BLA1FRvIGhpjZUYwOtg5CK2lasgbT0mhRZnRW8sDeuMA0Bc6BRAaXpSm/ByP+M8hZ1oc5tXhdSlb8p3P2V2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Stl8IX9m; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761331116; x=1761935916; i=w_armin@gmx.de;
	bh=yaJ2vhZGJYLCCzCma1kImL1OBNIVEEsDW59LF7HCr40=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Stl8IX9mMvtMNN0X86W5G29zT7M/3Glhjs/7Er/vP+5NpMGEXN8Vh/L5cFmrNDDK
	 8fyjtEfooqd8sTRNDPd66urIRQ1Fbvz6S56CcGVP6vpgZ1Clf4XHF3dOu6EgAckhM
	 e1AiF5WH1Cs6J3fC9KBqwgkYWUfWZS7RQk37UTs7wFcdtQLiPZTfuo119bJQI2nJe
	 y5MdDeOQMR465x5v8pbgj5571QWOBkUke0AGu/TX0YKYYeqf/zwISXjugVtPkytuX
	 tWf2SViZa3fz6ve7lhz5fvmalgHBbBshYazt282z+yMGoool76hFSRygOQBES3gDs
	 +XRdq9hn1Ten4yVDcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MJVDM-1usVRj3oEq-00Wvza; Fri, 24 Oct 2025 20:38:36 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ACPI: fan: Add basic notification support
Date: Fri, 24 Oct 2025 20:38:22 +0200
Message-Id: <20251024183824.5656-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251024183824.5656-1-W_Armin@gmx.de>
References: <20251024183824.5656-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sAx+YDn3Kngldh7pYaKdnsuCXB1Tah0peK2LDXrPY+0mCuIs/6E
 IGBTuO6JZJutP9NMpEU+svXgByKWrwngYRkddCI+j/p2YgouWqNAhNtbkhlfT3/gvRaQsud
 hHAw9OKTlCaBQ0qPpRxOft4IvKevOzzrvlf5Hj7tan/DkHcU2xY7p9Oul5MU8YtqvwCohr7
 BCc/DfqNUKCoQCOv2HYsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kWWG2Izpzbc=;q2sjXVM5KVQiOjzZ38QzExt35BY
 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
 39pSA==

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


