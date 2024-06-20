Return-Path: <linux-acpi+bounces-6558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BE49111ED
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 21:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604C5281759
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5A1B5828;
	Thu, 20 Jun 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XxTpuznq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311791B4C49;
	Thu, 20 Jun 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910869; cv=none; b=PNV4pnv5gdeDQ6rB2hU1/ZjHVFLTc57fDIDsaOLhosraq8aj2nG78LkoXubdSkBQZj2o0ASSObniw4/Fr+kBxA9iY2cRtFzQ+xFjevfYjlIsIlMrHlerntx5q0p7BBt1PgbHMZ9NHxYlRZr6zLsCzdeT6JqAXSNrP1N20H2H5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910869; c=relaxed/simple;
	bh=oM7d2nU/1EXglGqyMknsqP4KzMVjfNITvBaD0xtbb8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FSSGUWdjXpIOmkB5tG0jHhXkNWu6Yh/Ms7qA6VzQ2ek91bTYG1FbBHECiLveTd7nNZdecgHbq0UE688Zc7qgvG3z9b9MwO/ZOc8rA9KM2UkBaFhacVjQtFe0AotjWA07QNlmsTTnbkB1ywNKCse77kiM/g3sStU2yqnGaeZktmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XxTpuznq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718910856; x=1719515656; i=w_armin@gmx.de;
	bh=JfxDuAxw0I5rokPnnN/NN9/gOvD5EFn1E9laPeck6iA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XxTpuznqa5s0SpQ6YdBrvZNwCXRJ0edFeG7RwA4nafWEyqJXBNYwkwFHqkAwFph/
	 obu4vTPFY+7Qo8UXInbPMrj96MAUMv7WH+7KynWZbaU6jWpmgpfI3EtAqC0iGv7tB
	 R6/iC0NBkzpWYJe/A+3dBrppWvzsVla1nGnwu66kc6DXtUyEZ/Znr8eFMdKXi77bu
	 +xt7LGs4mr+Swymo1EOxUvTy59CZERil76zkUyBO9n3ndytFj8qd11eeWXYQwZGYP
	 y9QhxcX50jwPqpUX5rCcdjiU6Z6DT0uJoGV+4O4YWpCBzUpj4V+Bq1MYzUKtq/GeN
	 ytkbdoU/jbWr0NIakw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N8XTv-1sP43t1c9p-015xmJ; Thu, 20 Jun 2024 21:14:16 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ACPI: battery: Add support for charge limiting state
Date: Thu, 20 Jun 2024 21:14:09 +0200
Message-Id: <20240620191410.3646-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uNBDOBDXPCELTkGamOlx2L0j/W2Zhplj2lD9/D7v5T+apEJnnw9
 YiM8dfeyyR6Sy2iqGvBwBDR6TNNFBsC9VaQzIPF0Zi5MqlrWxVwPMPuZuRC8nQgDl6lfsIT
 NNaneKZl8AKNkuZEFKyFzA3bTq9rBVXFdlx/onmHI+b7i3oAv8ZBdY2ucgGs31HLhjlPCCZ
 eV4atUc4q9u9vxLvvUQpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1ivwSHmpePc=;uSM9rr41Wuw5kjzAoyyV5tk2mIl
 i3jkEV278EZxI7Tk/3ljPtMJcjPoU7q2SD0TKmrBG8zaCd1wn9zF183BELhNv0Vz6fxEa1Op0
 CYjwyMDqZHupFczhdiADcP3WdB53f9HVAK0KB+USScSkLgiu1AGKwkoHNnhLvXxK6K0vaNcsZ
 A8iThkF8WUgig558RbKPTTVjpE4yyI5xeuJ8m5wxTj/BvHcenpIuXOFPuhmIZAETe+JbVjZyY
 kdVion2B/yeZ+WS2V2FVwbyh1s9sXNLNvioudWhER+U7rEqykfYIHoJll5px93LumYyvalSNo
 b6b4eAt5FMXefwAdhc1WQaf9LcUuXwTvLBJxDVMmk+MToV0W9eRkYanJbW/YAune218sx7M3w
 UyTwWk5eBSckWg2GFCz8zjLJ62pYXFWo2gC3d8UVVmSG+sudcgEBjyaDxaVHF6WPfRl2NyheG
 /ss80HzssXQwewBtvvvm4QzyloC5TNoD9KaORUWWFYYKO7xMg0avbO33Z0vEV9kqMsTSa1Wel
 wb0JtzFQhnBIRS1/ulhAjNtrKVtMQzBqLiDPgmUUv8zfMxoLhiYpMagXzvDQCoc5Buzr6FgvH
 jDhA3MuPWGLufg+nCVMyiOsYRArwG52PSBbF107eEPGxEkM3igcCkaprQVTZv+huO+fSOVK/Y
 YSw1InfHXFjx9mRga1WvahMB06QO7rCfD7/3H4ht8+hLQxPIn4J/gyFGXLRkdumLXtayoU7kh
 nEAPyxyGRIMZOmvO0O2EHYiwveoCWIc7U+2D+KnQ6UnaZ/nQmLJ/1XtzCA2dRL6V4tefU69Qy
 1dWpymJu7A6bbYvJ5cBYL7zeMf8Q3zp1OitpB8c7FIj0g=

The ACPI specification says that bit 3 inside the battery state
signals that the battery is in charge limiting state. In this state,
the platform limits the battery from reaching its full capacity, the
exact limit is platform-specific.

This might explain why a number of batteries reported a "Unknown"
battery state in the past when using platform-specific interfaces to
stop battery charging at a user defined level.

Unfortunately not all platforms set this bit in such cases, so
"non-charging" is still the default state when the battery is neither
charging, discharging or full.

Tested on a Lenovo Ideapad S145-14IWL.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index d289b98a2cca..9ba2191a96d6 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -38,9 +38,10 @@
 /* Battery power unit: 0 means mW, 1 means mA */
 #define ACPI_BATTERY_POWER_UNIT_MA	1

-#define ACPI_BATTERY_STATE_DISCHARGING	0x1
-#define ACPI_BATTERY_STATE_CHARGING	0x2
-#define ACPI_BATTERY_STATE_CRITICAL	0x4
+#define ACPI_BATTERY_STATE_DISCHARGING		0x1
+#define ACPI_BATTERY_STATE_CHARGING		0x2
+#define ACPI_BATTERY_STATE_CRITICAL		0x4
+#define ACPI_BATTERY_STATE_CHARGE_LIMITING	0x8

 #define MAX_STRING_LENGTH	64

@@ -155,7 +156,7 @@ static int acpi_battery_get_state(struct acpi_battery =
*battery);

 static int acpi_battery_is_charged(struct acpi_battery *battery)
 {
-	/* charging, discharging or critical low */
+	/* charging, discharging, critical low or charge limited */
 	if (battery->state !=3D 0)
 		return 0;

@@ -215,6 +216,8 @@ static int acpi_battery_get_property(struct power_supp=
ly *psy,
 			val->intval =3D acpi_battery_handle_discharging(battery);
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
 			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
+		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
+			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else if (acpi_battery_is_charged(battery))
 			val->intval =3D POWER_SUPPLY_STATUS_FULL;
 		else
=2D-
2.39.2


