Return-Path: <linux-acpi+bounces-7144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D4942005
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3086F1C2339E
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC091AA3DD;
	Tue, 30 Jul 2024 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dl0WFUu5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866751482F3;
	Tue, 30 Jul 2024 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365514; cv=none; b=eMMz6lAcE+F6821iTGnpFjWx8JShiQUSWIF6xa1u/i2VAxCf1OGm3hOXAtBNcIwFr98YJwvTb8sPtNgpKSmyffI/t9JYgmilokNgfpFpeG8UNfd+5lnSrRxP+1AvuwTE19FHLECLcAWpxuI2mnOQZx2ZrSB9XaeXeR/6vbAXOfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365514; c=relaxed/simple;
	bh=023Azlu1DI442Ymcg7kgk1I0rNVmUPxN4UuHlX4xVqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LE0IhU4gzmIBAZNQj0O33cRr1STJkSe+0hiYVUtF1ytbD2jWX5DArndgS91HmLQOzL6EN1UTZXr74ttAEcs7eMUiLxGmhq2hCp0GUQJ7gY0rGk/qy5eb7gDtPfrQKKFju6WxJYI9SHu1SzW+iCzIRa3F/niCb/i3Wfe81mtODrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dl0WFUu5 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id a883f994f995aa59; Tue, 30 Jul 2024 20:51:50 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E356B956ED0;
	Tue, 30 Jul 2024 20:51:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722365510;
	bh=023Azlu1DI442Ymcg7kgk1I0rNVmUPxN4UuHlX4xVqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dl0WFUu5aAhMh02l+PaQ1TmqkgVQvvFu5I5Ey13zfldej6N7bqNeaz4wVyk/9ahru
	 8XF5mvg82HpCUhpficsBfK0R7BOSmNcJkZoG4DEUnwIIkwulHuDnBtzivJxH6VoO1E
	 2ptK/w9wJ2lgzVGxV22dBho6RMILhUvDHirLxNf+BXDooYFE/6rRW8oyHT3MUHkKiM
	 ESx3cj7qUP/8RzQuFKoJVO/cf42jLeCAhT08Niv1lHMcRBv/4Lu1CSPZhPKdzE/J83
	 ruZqAWinjTJB5gWQou5KlBWIYsDbXMDfFbuZh2DpZfWdZ+aS6frOJgfPJ5Dt83czpP
	 t2ns/fOTKd0kQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Subject:
 [PATCH v1 11/17] thermal: imx: Use the .should_bind() thermal zone callback
Date: Tue, 30 Jul 2024 20:31:07 +0200
Message-ID: <7860434.lvqk35OSZv@rjwysocki.net>
In-Reply-To: <1922131.tdWV9SEqCh@rjwysocki.net>
References: <1922131.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
 pdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshdrhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggv
X-DCC--Metrics: v370.home.net.pl 1024; Body=50 Fuz1=50 Fuz2=50

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the imx_thermal driver use the .should_bind() thermal zone callback
to provide the thermal core with the information on whether or not to
bind the given cooling device to the given trip point in the given
thermal zone.  If it returns 'true', the thermal core will bind the
cooling device to the trip and the corresponding unbinding will be
taken care of automatically by the core on the removal of the involved
thermal zone or cooling device.

In the imx_thermal case, it only needs to return 'true' for the passive
trip point and it will match any cooling device passed to it, in
analogy with the old-style imx_bind() callback function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch only depends on patch [09/17].

---
 drivers/thermal/imx_thermal.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/imx_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/imx_thermal.c
+++ linux-pm/drivers/thermal/imx_thermal.c
@@ -353,24 +353,16 @@ static int imx_set_trip_temp(struct ther
 	return 0;
 }
 
-static int imx_bind(struct thermal_zone_device *tz,
-		    struct thermal_cooling_device *cdev)
+static bool imx_should_bind(struct thermal_zone_device *tz,
+			    const struct thermal_trip *trip,
+			    struct thermal_cooling_device *cdev,
+			    struct cooling_spec *c)
 {
-	return thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
-						THERMAL_NO_LIMIT,
-						THERMAL_NO_LIMIT,
-						THERMAL_WEIGHT_DEFAULT);
-}
-
-static int imx_unbind(struct thermal_zone_device *tz,
-		      struct thermal_cooling_device *cdev)
-{
-	return thermal_zone_unbind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev);
+	return trip->type == THERMAL_TRIP_PASSIVE;
 }
 
 static struct thermal_zone_device_ops imx_tz_ops = {
-	.bind = imx_bind,
-	.unbind = imx_unbind,
+	.should_bind = imx_should_bind,
 	.get_temp = imx_get_temp,
 	.change_mode = imx_change_mode,
 	.set_trip_temp = imx_set_trip_temp,




