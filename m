Return-Path: <linux-acpi+bounces-7786-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A163495BD72
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 19:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F951282CE8
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 17:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D5C1CF2B6;
	Thu, 22 Aug 2024 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RizIsVRn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175831CF291;
	Thu, 22 Aug 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348341; cv=none; b=fQkDm7Li1p2bMBfXwiI8ni6eRpNQsUv+ak34N1gBS2PxdledfeJ7NOaauEQp2DfoaopBYXJxpkro6Ky5q/0ysbMsExWP2Qz5u8ty+8goJcFJtxa2zqc9aAlCu/i3AtLAe3C52ocn0BKu4KZNBplPDE2/vrpdXlxwCxQUAd0CvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348341; c=relaxed/simple;
	bh=0mBU2SlCG+z/j3wvMKKRfaR/g6z4m2pjVgYWvs16XQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4J5ms0b5T92K5e3aqS3QnpJLPniON3BwxEDq4o/7a3Y5S5iJinjcIDDJ59zwqvFtNV8e6syWJ+ro3YhjVoZOpAi7GyJXSMrGQvLVQYtCGoEOBtQdPfYjpLRydxAuOLPfx7lVGjbickXG3VKpKKooxzomIta7EmruADnPX3Ac1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RizIsVRn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724348323; x=1724953123; i=w_armin@gmx.de;
	bh=p+rLNIe3IFZaI1uPLVO7BH8uG2A2z2pX0gRWi9vzxtI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RizIsVRnqSGOP4CrUAabyQPm/orUbdR10+RbdRf4QgaP84hXqiqR1x6F5K48pxnw
	 6eg9v4RGsPOK2BC0PaBej0il4pjuNDojwaZ+D222VdHZj/Ge0PRMTCN50jOTXhuVa
	 x0AeS5Qe+GUqMIbrngHiKr8hh09D0zyaRKec7kCyw9SVUOUPZxXjEgzUUErnrgHDc
	 lvfgHDyrE1P7582E03rgVisXqOh5E6m7UnwC0+EVDyIweMfrSTzTRHSE7ivWqhZ5E
	 7lzXPQX6ozoVaAP6FOO45v9L3HXlv4A6tVQL05D3AbFe9DQg4ED0dUDk1bi2rPWwf
	 eGOmukUbHZ5wsNcZTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MFsYx-1suc281Oj1-00FKjd; Thu, 22 Aug 2024 19:38:43 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	jlee@suse.com,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	matan@svgalib.org,
	coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] hwmon: (hp-wmi-sensors) Check if WMI event data exists
Date: Thu, 22 Aug 2024 19:38:07 +0200
Message-Id: <20240822173810.11090-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822173810.11090-1-W_Armin@gmx.de>
References: <20240822173810.11090-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nWWC9iET8W1EJA8cU22SEbP5jfzKDDVIdMDAd5lSRWfBkA/qQ3O
 odDk6FfvB3pU24zvLpEcO7V8Y2UQs48vTf0HhjlNgFCEOuU7IXWE2kS9D3Lptxg6F7a7NpK
 zn8ImxdlHc46NX2xtyQfCj4YX3K+w81/2T/VtiyL036+Q4muU3k6wKbFUdd78CCGIx4rpE5
 Nz4LqfS4gcn5e0mkKIz8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uqwifykSEpk=;Fhe+LbB+XJYhYBfzcaNqYoW4hN6
 wdXJWiDteVUmNPx9anmg9JSOJZDo5DRS79vooiK6xX9ddY80Mt235OfK8jefRDdpxaNiuqwj7
 sDRMxAMVfjqyV1CJr47H3t/c63BKtMCX6pEvj2ZKNA7gvmzGjmQ3ULpZVqOToaEuWIozNBFto
 mU5JeCVy3UhupnQIy6TDvR/IBli/EWadInbzhQ/a27KLxpCLNvT2ImP68LvATYZGI+9TDqjFX
 ez1o4XuQKeOMHh/I9yo6Pp6gJ7V+aXgRqhV5QU3srW2x/InJZ/1LCCYr2f0CUXHtxOb+cm4Av
 jicf6ApLad7W0Tysax1Vr9XOGUWVkjxlAso973RbrhxlhacBLBHWeIYNru9Kb1nBxAhIbqwBR
 Ps5tSJtLLCbMtViG0yd4ba9Ou3a6J/Qlm9s0ajqvzKRhHXlJWHH+TnfcSsY7XCZ0xaW/PuXAq
 qJh+A1lanW7iUC8+lvvjDD9Ohum1AusW5tPUf+taRRzDl1khTS4VIC2H0Rm4ef8pAV962IPRo
 7hSutwsJxH6LBeM0AkE3aib2x50SWPrMLCQnxvaAG7YPTGsfj2CytgYckF5gwRdgoRY//rhs5
 aALQGUyNw68tKgh4Fa/kp4QMGYmERAwiWgLZL75gPXVHyke7uxDZN6Q2SPggPPbrlcadUR6ch
 VBENRXLVzLDt1bSlBLIWIhq98ZuClhtODcp3TS68kFsWigkbg2z/moXY06J5Bff+jIcGnysN2
 Y3jB7qilJaUi23T2B9o50OY1oDuruEfAPM2Z7ytsY0xowiPTxI89CYkdZBNnctPF+xID1IfoH
 gi7SJe5vs8pVIudtwevvaJ0A==

The BIOS can choose to return no event data in response to a
WMI event, so the ACPI object passed to the WMI notify handler
can be NULL.

Check for such a situation and ignore the event in such a case.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/hp-wmi-sensors.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors=
.c
index 6892518d537c..d6bdad26feb1 100644
=2D-- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -1628,6 +1628,9 @@ static void hp_wmi_notify(union acpi_object *wobj, v=
oid *context)
 	 * HPBIOS_BIOSEvent instance.
 	 */

+	if (!wobj)
+		return;
+
 	mutex_lock(&state->lock);

 	err =3D populate_event_from_wobj(dev, &event, wobj);
=2D-
2.39.2


