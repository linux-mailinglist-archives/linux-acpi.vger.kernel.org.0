Return-Path: <linux-acpi+bounces-19626-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC37CC7784
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 13:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E061F301029F
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663D63164D6;
	Wed, 17 Dec 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VSHXLGl/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D6313E2F
	for <linux-acpi@vger.kernel.org>; Wed, 17 Dec 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765972926; cv=none; b=NIFGZ1HaYkB6VI68TvbdOkOM/XZezU390JsZm+ZJ3PcpEfGf81uOQD4epFo75fRePDS5k61h3XrnxfANWDuRKQ00ahaeu4mtm0ux+r+CEHE8iuCBFtrd75B7/dJO2W1BujVyrBZJLxp89cVdAoq39nhijlqukeOSz5iXNKYLEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765972926; c=relaxed/simple;
	bh=8GyF7YDaQPe51UBzhsW5j+a+kF+47fTpcqJ9od5cgtw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2rytmfJOZH8S5/TWnGkN0iWk5jQxYI4TveSv1Kn1CaDgBAOlxijGwQa3IvF2j3eoeDgxhujewizlAvIwj/b26bkfsBL+syqIX41n2idpm5ZkT+AO7F74bxOjkVxD/5DTOp1RK5TnWe6RsGHRUPDAdPEKqpqMCo+fHMdi36AkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VSHXLGl/; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1765972915; x=1766232115;
	bh=8GyF7YDaQPe51UBzhsW5j+a+kF+47fTpcqJ9od5cgtw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VSHXLGl/ACYsYoQ2/lf8EEaHuIw2Rtwp9qoVnaG7gEXhjI0JZu9ZZO73YSNyoPaMz
	 DwtUExF3UMMqVJbOyFzpqyH6rRcnm4KjJzUR09kDubwt0k/9cNS9ftRtbXT0kPftx5
	 Cv5fzDzDk9UKrYNvz0IBrH38daiXN1kN/vF/zWDKvUzykohd0RskjjXOmXTfs5hDBL
	 R24h8sX6sXktvtcJ2gQCD5MuaB/N1PRc0pNFEE0jkm4I9bGe/b6mCjXvGVtSFRGRxw
	 rXW5mEjZrEzav8AvUxyFSyj43SY6jxfAy3+YHS5NgJ3wh7qqUazNn34SCxA5U46qG5
	 CQhF+9CcEbsDQ==
Date: Wed, 17 Dec 2025 12:01:52 +0000
To: Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: francesco.lauritano1@protonmail.com
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Francesco Lauritano <francesco.lauritano1@protonmail.com>
Subject: [PATCH] gpiolib: acpi: Disable edge events on boot on ASUS ROG Strix G16 G614PP
Message-ID: <20251217120146.51321-1-francesco.lauritano1@protonmail.com>
In-Reply-To: <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com> <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
Feedback-ID: 66654272:user:proton
X-Pm-Message-ID: d4bf165738a203d71d7c7edc4aa5b456e875c602
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Francesco Lauritano <francesco.lauritano1@protonmail.com>

On the ASUS ROG Strix G16 G614PP (2025), the kernel can stall for ~36
seconds during late init in acpi_gpio_handle_deferred_request_irqs().

Booting with gpiolib_acpi.run_edge_events_on_boot=3D0 avoids the stall and
restores normal boot times.

Add a DMI quirk to disable edge events on boot by default on this model.

Link: https://lore.kernel.org/platform-driver-x86/6iFCwGH2vssb7NRUTWGpkubGM=
NbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hz=
PguTa0s=3D@protonmail.com/

Tested-by: Francesco Lauritano <francesco.lauritano1@protonmail.com>
Signed-off-by: Francesco Lauritano <francesco.lauritano1@protonmail.com>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi=
-quirks.c
index a0116f004..763dd3cbd 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -370,6 +370,22 @@ static const struct dmi_system_id gpiolib_acpi_quirks[=
] __initconst =3D {
 =09=09=09.ignore_wake =3D "ASCP1A00:00@8",
 =09=09},
 =09},
+=09{
+=09=09/*
+=09=09 * The ASUS ROG Strix G16 (2025) has a buggy ACPI GPIO configuration
+=09=09 * causing acpi_gpio_handle_deferred_request_irqs() to stall for
+=09=09 * ~36 seconds during boot.
+=09=09 *
+=09=09 * Found in BIOS G614PP.307.
+=09=09 */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "ROG Strix G16 G614PP_G614PP"),
+=09=09},
+=09=09.driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
+=09=09=09.no_edge_events_on_boot =3D true,
+=09=09},
+=09},
 =09{
 =09=09/*
 =09=09 * Spurious wakeups, likely from touchpad controller
--=20
2.52.0



