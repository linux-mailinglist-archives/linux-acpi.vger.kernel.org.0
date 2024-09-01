Return-Path: <linux-acpi+bounces-8031-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A263C967448
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 05:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8801A1C20FEC
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90F9364AB;
	Sun,  1 Sep 2024 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="N/N4Mevv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5581859;
	Sun,  1 Sep 2024 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725160313; cv=none; b=S6gDIKSNjcSCMOnnFSjebc7N9gNwOeb4ul62a7+M/vQVx8PwIYQx91HXZvv8OVKCS17n3iqHFBOLPp4jVatavj1ctqiAzqB53kV+cB41YkHGhy7ODudn60MsldUS+LUcRBbH6zei03cTT466xN8xzrUIu/XtoicpigK/UkIN0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725160313; c=relaxed/simple;
	bh=LaWnLcIk1vTrMitnfrliOw3wapLo5uNal6+HwDyS28Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JAnd4ZvZhwqzHpoL73cdYd9U6BxoIoV3CMa/F9aLeZ43h+JwkbCaDvSC2vPdNeAdoZ/6kZFddszJ2jlCbQwJR7W/qBWEeFpsRtRe4DgGYtlhm/EufQJn91XaxOXB8jjZf549kZLwU1PrgNAF/nziD9tI0gd04Gp28D/pbLyTjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=N/N4Mevv; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725160278; x=1725765078; i=w_armin@gmx.de;
	bh=HaMEaXJFD8xYVLL10ruRknx3YqoN4wteHeuS95v5VCM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N/N4MevvYeQPfj8J9/BonHdUEFh0caKwztdWVPZAKu5CT+m1fs2em81S8tRm8zQH
	 YOxb1er1yfXsY8NL7KGidN3TMlYBpBl+IkOE7RTfWFV/n1IWTeJ32/eEh2rplhfc+
	 +WcngBHaiwIYfQS1/IwQfJFppo34sgkpckQmNSaZyJJDjzaX6/NLcP8RQwhy0648b
	 RuRsHKG0jkxOt+GGugK8OnJc8z+zbi3NRU3TPxKNi9epK6vY2clHeH56KM4cswKdB
	 b0XiCCEKBdN9fL1CVYJrWQqxHLTdD159IGke6wtJYKBZXQyyKLzf2SW+w1i0vpwLk
	 B+PSbf3+I8AQ/dOMBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MzyuS-1rpjDE2pny-00vRz1; Sun, 01 Sep 2024 05:11:18 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	jlee@suse.com,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	matan@svgalib.org,
	coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux@roeck-us.net,
	jdelvare@suse.com,
	rafael@kernel.org,
	lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] hwmon: (hp-wmi-sensors) Check if WMI event data exists
Date: Sun,  1 Sep 2024 05:10:51 +0200
Message-Id: <20240901031055.3030-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901031055.3030-1-W_Armin@gmx.de>
References: <20240901031055.3030-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AFzmpbJ2ccVyaKPAj1+Xleq+wmdPWlx81//HtZhXUAN/lTl5LtL
 XWQ1jZp9xo3PqYiMveuojcf7bZOcjN3jbWFaTpEkfP8SmrXxBB5B0dDapA7Hq6LBGSRXPtX
 k6PdcZ1Y7hQ4jVmb6PQFNGqfiQC3X6tPWGHE2/hrtfeg/6ODd0Z3vA1OqVuYwC4PJOzeCGM
 q6ueVqQhHF+JUsfMKkMuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Uf6QCbIxWIo=;Pde6K+/Tt38u/em6ZDLfM9jfDnw
 KUGouCupjstAiQxUTnDO7k/K5DzOjYokltgEQtD4I40bJh7oSMWkR4f3AALjWo4FrAtzzwr7E
 bEJP+qCq9kf4k2wKaiXoZJHUZx6qS60YYWV85LBLHusK3CNV5EAde2O+WOWLJQ2NHxwmmNI5l
 HGJ8QNuj03xO6bgE1idc3M+gv/sSPvrrsuBhL/S0SfKyfL6FAEB3zi8VDMlegorzkNovXz7tz
 BQKcDERZrfXypKcoe3VFvq6jXzyBzffFHfr4xAxXuDRVC4iWvOYa8UUDaV+qv/4CT1EBK5skr
 vhxxg4aw2vjLAEkxMmVovS2LknTx/0dpZC9sVMUcMDD2sU0yeGEBx/nV0vqbm+vS/8IFdbXND
 fF7iRjJs1YiBfQWwFdGkSPpsb7Qwuyl9jtNPF3dNWN1tFuq8i1yYefY3rcRo7pVI1YZonQC3u
 QTEbYbh9R5dPUYx9KayUXQLY4c1quR88RkcvYHvH8c+WaUorv+fqAyZlAr/Q81RxCjM3AI00V
 wM5a9p2lpuKjZqj4ZP/PluQCkEqguwmpM6HU7UatYozp+iDjpzrd3YIKQKOt5baQqqPExyk9n
 yjDHgPWXUSv8f9362rFPR7SlkXwLgHE0B+XuGFjZJyOEZURJnp0Fvps1BUHxxWCyPPviusBwj
 st6/1YabnYzpgPxnxrF+uyJlns93PAlDRJ6UvM1rHxiL0um90mUhThj/YLwdgUlmEkGAJKKJ0
 /OaxLOtqKH0FpNWuGHBhUuLt8rrbml2FwhsHoIk9BUYuEssNFuUsBSNvMH35FCknbXy9yB92s
 2ieZfTPzRQLgDQwdVyBAEabQ==

The BIOS can choose to return no event data in response to a
WMI event, so the ACPI object passed to the WMI notify handler
can be NULL.

Check for such a situation and ignore the event in such a case.

Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/hp-wmi-sensors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors=
.c
index b5325d0e72b9..dfa1d6926dea 100644
=2D-- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -1637,6 +1637,8 @@ static void hp_wmi_notify(u32 value, void *context)
 		goto out_unlock;

 	wobj =3D out.pointer;
+	if (!wobj)
+		goto out_unlock;

 	err =3D populate_event_from_wobj(dev, &event, wobj);
 	if (err) {
=2D-
2.39.2


