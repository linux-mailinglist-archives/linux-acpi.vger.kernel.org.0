Return-Path: <linux-acpi+bounces-8525-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C9F98C7A1
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 23:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D38285974
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 21:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998CD1CF296;
	Tue,  1 Oct 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CDk6aw15"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F721CEE89;
	Tue,  1 Oct 2024 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818143; cv=none; b=Xyeh2wKw1TF4VE2DFD5LhrlqLrQ+2KZklGz2HSl6863RZW5ruRZlBK83vF3o6uCJrjhB0S/7E9EaTRXNYxCKaihTYK0fFHWraXooVOMUvALeHzygqZ2YNyVFCff7I5qFjx+APbGnaPuHG9mPNvdZj3tYZ2Equuv1gVVhlu3Md6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818143; c=relaxed/simple;
	bh=E3ikZX/J9p7T+xtBjvUT5zEquGjOrUzgmRmz6mEQDAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmhFxiLXhXXaC+5YVxjE9wgyR43BXuZ8W3GdeEt1nP4HkV0fQaofw57bHx4C1tgByiERFFLDZGh1QdcH/1l6MBln/N3qni5O4xnQsn8ysj+05XFC6Jh/KxZGlIBb5GndftlDYtBEReQcqlK/sj2XyMBD+kqmQgiRByUAe6kutAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CDk6aw15; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727818127; x=1728422927; i=w_armin@gmx.de;
	bh=aU2UjlqRMRf3Xmr3GhmFWSRSgp7A5bWPS5sVfd5PE5A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CDk6aw151asrltm8pjpVN18xY+Hbw8n/OSVegBVRMmqAHNxlyXSsI9wtk83QKico
	 cI88NE9kIFHvUyqaTTQc2Zm82MNz8CB+2AxmOrzKpq0wNJHDl5oW62QKebGVDjmme
	 sFHABIGBXL9IUa3v/dFZDizbHBS6RoJIdG5FAdxYadky2fcAB6vvxQMSLtEK8Ju5y
	 6T0Gu7BjYP7tIBGlXgxH6QSFxfDGc6UQLSfCC2bJx6TvQWPUO53DUmQuAC/xqoyDN
	 8uxiQYsNy6s2gzjMFbBexn6XNorKZD2nactxbdXm7M8EW5tL/x5QgnXXiWmZaZ6aZ
	 GAZFE0RYCfy3Y8FxQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Ma24y-1sPliV00IO-00RHYD; Tue, 01 Oct 2024 23:28:47 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org,
	dilinger@queued.net
Cc: rafael@kernel.org,
	lenb@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 3/3] platform/x86: dell-laptop: Do not fail when encountering unsupported batteries
Date: Tue,  1 Oct 2024 23:28:35 +0200
Message-Id: <20241001212835.341788-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001212835.341788-1-W_Armin@gmx.de>
References: <20241001212835.341788-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:14mEFumuCpmjAAMGTsp3PWmCbDT0sHWRQ/kjJkVIvHsVtObARcq
 ulQ8I4IMQ5jId6AYhPWvhhNi5zYfIlpB/rSaeDjwOd1Uro8mV1Ds6Den92us3aYHnWM7k53
 ieMZm3lLUzQnEB32T6PcEdq3rzBL8cybofll13jJE+cm9syDREX0G1+86EEajVZymDPm3b+
 LNQ7NTwxb2bpoX126P45g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Kf5BdmY/Uo=;oWIcQ/9Vwys9hgaqnKN6IWZ5vaw
 tCUEtGb1gbntm+e9HhjWFn8A/PIEnTVYBPIW6vcFIb+ojY2vsdsybha8b/UrfyDaUbE4pD3YW
 Pa25+/0fRAtdrt+YqSSioXZTEcCNWusAIBYT5ovs+whwzz5rp6PhM/Hr3BXX3/Aq6GOnnYVNX
 QnOF/ZaBcomKCywZxcRo/v7EE4JlQVG6LosZhymZ5OwuBFnQnFK4cK3g2TdgV8SsCVeKr0EVB
 4GfDLaxQgODOfs4cVVt9alcwgZwPpKji0wr75QQO6dCsvQ0kVyyT/Lt39ZYKzbTlfjUZZ/Zbq
 8MWHapEzJwZGAMtRkRC0TbbVZOOi6nEf9oN3+V0r2FTlXiiJLLC6RuyxtbWQuvjgYwhQ9jQO1
 ht2VDb/5NNzk3mFVQ9+tzUKVnDpGfHxWIHsL8NBLPSGyb47sQMZgKr8DQpIYMEt+sGXKwlmD7
 HACAXFEjJLt8d4T5FvX/fyciEANeUJozwPUsbnWaUKgOhi7zm287ou5vCsV5U23+n1lSDqjJG
 sIhfMq8pg+ONwkPPao9z9OcwVwIPsryfEs+vw3E5esZrDom7iQ1XxX43mgp2L7NlB5IVIBSth
 2dABElLe6OROBhUO6vRM/ey75bXbCdvhUw6vuVwDSzVrL8NmBB0KpLzM6Akj2PC6DWfXterls
 IIs44OKp3QtKZgbDlTxbX459MWfNv8DHeWLm80lJBkS+1vmlROhAiQTDJ7PIKa/jAqMne5ztu
 qvv1mKpNfJEX3tnH0gMqoSmaYY3l2HaLQebk+8bABZv+Qj33BhG8xUsy7CrlCCJ5eSwmVhKpq
 vpKu8EcjDNwZfwQRKhRURBlQ==

If the battery hook encounters a unsupported battery, it will
return an error. This in turn will cause the battery driver to
automatically unregister the battery hook.

On machines with multiple batteries however, this will prevent
the battery hook from handling the primary battery, since it will
always get unregistered upon encountering one of the unsupported
batteries.

Fix this by simply ignoring unsupported batteries.

Reviewed-by: Pali Roh=C3=A1r <pali@kernel.org>
Fixes: ab58016c68cc ("platform/x86:dell-laptop: Add knobs to change batter=
y charge settings")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-laptop.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x8=
6/dell/dell-laptop.c
index a3cd0505f282..5671bd0deee7 100644
=2D-- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -2391,12 +2391,18 @@ static struct attribute *dell_battery_attrs[] =3D =
{
 };
 ATTRIBUTE_GROUPS(dell_battery);

+static bool dell_battery_supported(struct power_supply *battery)
+{
+	/* We currently only support the primary battery */
+	return strcmp(battery->desc->name, "BAT0") =3D=3D 0;
+}
+
 static int dell_battery_add(struct power_supply *battery,
 		struct acpi_battery_hook *hook)
 {
-	/* this currently only supports the primary battery */
-	if (strcmp(battery->desc->name, "BAT0") !=3D 0)
-		return -ENODEV;
+	/* Return 0 instead of an error to avoid being unloaded */
+	if (!dell_battery_supported(battery))
+		return 0;

 	return device_add_groups(&battery->dev, dell_battery_groups);
 }
@@ -2404,6 +2410,9 @@ static int dell_battery_add(struct power_supply *bat=
tery,
 static int dell_battery_remove(struct power_supply *battery,
 		struct acpi_battery_hook *hook)
 {
+	if (!dell_battery_supported(battery))
+		return 0;
+
 	device_remove_groups(&battery->dev, dell_battery_groups);
 	return 0;
 }
=2D-
2.39.5


