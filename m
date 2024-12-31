Return-Path: <linux-acpi+bounces-10340-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540829FF0B9
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802533A2A52
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DDA19D06E;
	Tue, 31 Dec 2024 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.com header.i=gazo11@mail.com header.b="DohU6D5w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342892A1BA;
	Tue, 31 Dec 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735663323; cv=none; b=KENHZLjtq1G415/MtINBmlK1RGVa948EdUuWYTVfI/KX/ROkIESeK6o2BGxIk2E81hUrybflI9zqFjbwJA2Lr66ZjDWRVULlnXVPg22kWVbsxHoIpA7VA5qQCdKJnGEJpq3WRQmob7tuofUaH7oM5Onjb1PrBdf80ZGh6cuMIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735663323; c=relaxed/simple;
	bh=tzWjlGkq0gvv9aqRqZiW/06I+/RYgL7A+f2Hu+T1A28=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=aQ0nHm+pRo0abax8OoTA6IPipTTOjALrs7m2TsdOCDeU6DbQwyx+ev/O4OSE9OdE5pAZgEZrwAjLdwfgY2M6Kf+wKma8Lwlz8kEQ3vKnpUldPDfFygVUDjMLioF1WlpEnPmkEoszt7KIbmqvh6Ln/ZEiaKvUaf6WucqWIt/0Q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com; spf=pass smtp.mailfrom=mail.com; dkim=pass (2048-bit key) header.d=mail.com header.i=gazo11@mail.com header.b=DohU6D5w; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.com;
	s=s1089575; t=1735663320; x=1736268120; i=gazo11@mail.com;
	bh=VJkllFDb8o0ZOMglI2QhDJ5H1vp8AkF7zlhrTyhiq9A=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DohU6D5w0P8UThMHMwPb4KCEEjmZa+w4JBibpq516cI2cum8h6t1w32y411UgIN1
	 JzNuWFGf4sgBcr0htNSgiuRx/KkT25Wqq9mHhihBl0UL7kj7OAKNJRf1Jt+5bdvJX
	 RXwnLMPdoix0SDGzrg7nPkdQjPpH5yUpEY2Yqt+9HkKlzDOoH81gQo8TIG99WhnBp
	 i7Zb0wrAVrl8nxTs5tPGZwzuGd01Bbfv41PI9Q6J8F4gyjg476cUAeDPnoOXPRFwY
	 66unkcO1AAoBrTvMuE0iODXyei7L5ZHzcaLdglT8rEef+HZ6nHqFWXS13owrhPTQB
	 U9+DruT2dtA1N2X1og==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [77.137.74.199] ([77.137.74.199]) by web-mail.mail.com
 (3c-app-mailcom-lxa11.server.lan [10.76.45.12]) (via HTTP); Tue, 31 Dec
 2024 17:42:00 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-1df112bc-962a-4f4e-96cd-f4089374378e-1735663320199@3c-app-mailcom-lxa11>
From: Gustavo Azor <gazo11@mail.com>
To: hdegoede@redhat.com
Cc: stable@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: [PATCH] ACPI: resource: Add Asus Vivobook X1504VAP to
 irq1_level_low_skip_override[]
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Dec 2024 17:42:00 +0100
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:PV+Go9yvBLIqXkHr6SjDJZvhOTr/mvxXs5rwzWXtKOQ94SXNG8IViou9bG2rOBc5VPVJW
 p/oe5y5NPfBAyiIlkudVBC4pGmEi+W6pkiQsyeixJq7RGHgGY9ez+5aJUidxz3IQjqwvV5nL1bjx
 WDHLNpP40rX/VyEHmyn4ad2E1C1BFyWCW2+vNONbWGhiT+y+mhgWTV+pCUxhU33s0QAjHUmIerPy
 mpwJBrr6uSzOJqewPtDqCXG8IeHvb6i0XOmPsZa588qsXDdZhjzFrLc2FjXvWl5pM5xQMWaBhbxA
 6I=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XOxAtwagxgo=;bR/AGJZ4/B9EfpdpAo5uVLouzQn
 ABo8HpGvAt8baAy6zDKmeMrNNDSwtdpXrBGZ+70i4WZleVjJf4qj4fOmS6i2085l68EXdB9VZ
 NhhkqFIdMniZChUCIR4Juf0ohLKy8QWwgS1y5gIRgizRX/tcaVYX85VzSPqx6GKa9pe/c0NDB
 v+mca3m0I/1BsZFm79UKKYAWnjwuNEyKTBMjeB3QAJHK/Kpj2ODGjOdf0XBWsVEPGURJy50Ex
 ngbWnJfDN212uLX5sIKFKLhrxpcqgWoOGKATlfZQdrV3C33NS5uL5r6sO8ijo2p6zGR1pIlQw
 9PdW3HRwLsxkodEbFfwoYxJMB9lj2Ck1SFGbCaT5O6rgX7NFEdl0PaYuu4ePWUkItsG8t7+fJ
 fi4IsKD33vq72QmnJgRqjyo4PzDRO1hXV/4u5btzWFu2cy2MjzWev+RC3MpJuWkTzC3K7gxjT
 6BFbJj41AMgbW6RLEjB9AJZfCyLQfXQ78259afeHfXOKt31ywih5DHg2KV8be+SGUK6ZFZjPz
 Qnn6RRz/4vrzNujrqsniU97omqGjnBh2fVRj5udIf+cN1Lk1JMrxvaHeVXg8JhGprWFMOW4Mt
 m0ETgBzXzKhHjYN9hY14h1E4KzBje0ezs1Qr2TGVCzZxseHu9Mi+CbIMTVsw6P+AaZJuSQqrA
 k9N3Pa6P7HHc4OhWVIVn5OPCDvu0yZ2U2siWC7kW98lD8VU/VY9sK2YowwpSbg/cOZyojMVDg
 l9lHgCh4BXOj+DxVZKaLDvUoaTl/k39WDZu35kLEJOIZpT/OjkYzulIem3AQII6uBBy2yatbN
 2L+rTvCN8pFYUxYMQVMxLuU1aGvPkScnzjLfqqkITnJ2EyGcw4Holy7Yme/+6BFszx8qM6ilZ
 fbmOMWaNrASCnBuggUHF0C54Yf+M7jtTWBkA=


Estimated people:
=C2=A0
I can confirm what the next patch works:
=C2=A0
diff --git a/drivers/acpi/resource=2Ec b/drivers/acpi/resource=2Ec
index 821867de43be=2E=2Eab4c0e0b6b8e 100644
--- a/drivers/acpi/resource=2Ec
+++ b/drivers/acpi/resource=2Ec
@@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip=
_override[] =3D {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1504VAP */
+		=2Ematches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC=2E"),
+			DMI_MATCH(DMI_BOARD_NAME, "X1504VAP"),
+		},
+	},
 	{
 		/* Asus Vivobook X1704VAP */
 		=2Ematches =3D {
--=20
2=2E47=2E1

I did all the steps in the tutorial https://docs=2Efedoraproject=2Eorg/en-=
US/quick-docs/kernel-testing-patches/ and the keyboard Asus Vivobook X1504V=
AP is working fine!!
Please include the patch in future kernels=2E
Thank you very much=2E


