Return-Path: <linux-acpi+bounces-8364-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800E897E059
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 08:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CE11F20F67
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675AC192B84;
	Sun, 22 Sep 2024 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ILyw8A3w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F15194082;
	Sun, 22 Sep 2024 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726987256; cv=none; b=SgnumTXjI4tdvgwehQWPqaP0C3IdG2/MsTNHgvftnGOdrk+Cuak3YmUYwrcL+D8AWRWrhfRtgPl2xLkMCi4HH7EpfPp47jNglOeLfiDgkho83SSkrHWuerP+Mdacyx2dJ3sCvt5kmchDF3hcWnnDw94PWocQb7mq4y63W81bTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726987256; c=relaxed/simple;
	bh=ZUtwmKv0+8uzyC3LpsSYhaN7w1pqqTA2l9pOhf0ogMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=naeiPlSB+iyh+oGOJaRE02B5s93V6sj+u/9XOpd2+bkCtMr+PJmhcCs/4i+EtvPlsay+lNy4Tc+LOVxaa/nDo1zawukwItKuTkfMThcAVu1oGXMH19GV0GZJff296+j3zL66t3uvrJ4N2TQmnGB/0XeQ1+xwWo6M6JZS8zHj/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ILyw8A3w; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726987240; x=1727592040; i=w_armin@gmx.de;
	bh=KA+0oXdhhScvc3Uq9mWyMMg/fCnFPW3cMzJuenHO3C8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ILyw8A3wX2JegSPJDiMWGL8s/sOo0tJ+nionQKqu7+4HWMB+jSUBeONISQbsLSkv
	 aVBvRg8tKDwn/aElqy/A8owy6w46gHeVo6jSu8t8tecktmeZ6tnUiX5guQ3Z41RZ8
	 5vUF/URRBUKrLZEeM+QMnFGT8f307iczI0pUIpjDQo2cFkk5vUie8kpNRcFJW45cK
	 Hhbw8TpUUrhDQERUivMO+4HALDrimt3M/biJ1GhasMDENt0CbaBESXo6IIhVTOd6L
	 mhlPZ+OCzS3xLxGXOq25VrIMpn9PDls/K5rXOteCxUdYb+SrqGck8N44DWLRyOIjx
	 zJ+2+U9OFEFBSPrDMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MMGRA-1sZ5EE1E0M-00UWoE; Sun, 22 Sep 2024 08:40:40 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: mjg59@srcf.ucam.org,
	pali@kernel.org,
	dilinger@queued.net
Cc: rafael@kernel.org,
	lenb@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86: dell-laptop: Do not fail when encountering unsupported batteries
Date: Sun, 22 Sep 2024 08:40:26 +0200
Message-Id: <20240922064026.496422-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240922064026.496422-1-W_Armin@gmx.de>
References: <20240922064026.496422-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1F99vtVdLm3Y/R4dwTNJzHeGgcAJvTjNtUzR/QMq1SsAcdFCtgA
 uKQWkkwKpW817fQzd+JCICWZsxTv1+fc8bsPTTnRgCoOp2IBmZ7N+oD3gWd9NRYVz8VUxIW
 G2Y9bmVLuEwU9SmgMo9MyaZjhsD5y8OHw8PTV37VPxeQ8Yy+c30jBXDxE8UN+Ty8gv7SAjx
 bU1YfKzQYNg+pdUJUcObQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jB/2nP6lybY=;GDf+aqYEXDqm7YWL9S9NZ78AIRW
 xNwywZ0HdxwjOi8RVjgc/tvyU1bNWpVmbsjDQUlINho0MYwWMoERin34ArT94kWrb0sU9CYXI
 RtwQx2f9dr/3RE1Ei6zMaM2unnZwBoY3220tlJyKn7tzv9p04oZE+CGr2AvJRA0mbVsa/+yqX
 1f6mY+D8i4bh1wKj8KfrhPunGZaEC/KZRedaMQZzu08azOFEhDPzq/Vq/5ke7DtQcABLGJPpx
 elEvstRySOZi72dYVUor0q4Fep2wproU9hOTXxkXUCX6/ZoujMp4k07/RyBmfWiCwUyJGF3Xr
 2t8rSUP1S5KqONzfvNe3MLy0e/9qJ6NsnG147Kq/1ntIAzx7w0hFtMXY7JyfkEic8QWFBOJut
 V/ZJcZDaqNmVGz8gWMy+kYoBc7SDwjVWzLx5fHdQo0xO+HlCXKT4HZMCmY/uliBTJ0nvo8jCe
 a7YSknKdkLP0JhAbJHH/NOwfRzdxAcZDn1h3la2IHMMf4od2mcnrVpG0svIJa0VmTou3OQG9V
 3OkyLVh/aWUFKHj6fqqwvMs6uyvytLC/LjQMBBnHUuIb7MJE8zmGMiij1nQhV4p9FPOHGHj0a
 ZcfikwAhhdTlKrnKCVej9vVEqCjy9RHlEhGcGCupz8g4E/8fL+WKSR9HYrf0vlle9dWW/70LR
 Xhzx4VJX8r0v/9sR/LrvT3oIuGusT4OOhn+BW+UHUV+HDFlpn55+doH9+ngfCWajliHV35gmJ
 jLTXHvNJ+Er6QFjqdlXkONgS715ulShtCPT3jNHt4BsjLPmiPK2SQm53C/Ab1m0t2pcjOCpLc
 WAm9/ITG8ODz1cDBRi7ICyug==

If the battery hook encounters a unsupported battery, it will
return an error. This in turn will cause the battery driver to
automatically unregister the battery hook.

On machines with multiple batteries however, this will prevent
the battery hook from handling the primary battery, since it will
always get unregistered upon encountering one of the unsupported
batteries.

Fix this by simply ignoring unsupported batteries.

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


