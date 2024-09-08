Return-Path: <linux-acpi+bounces-8201-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171B970522
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Sep 2024 07:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87ED1F21EF4
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Sep 2024 05:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F4E364D6;
	Sun,  8 Sep 2024 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="dAdVZNkL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2kMpNDn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC41114;
	Sun,  8 Sep 2024 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725773778; cv=none; b=M4mSmwSriWfyr2ay6oRtQQmFb6Jn0FW+Ro505UrVrw3Fwej4RfDlxqCnerBuHUbsELG+A5Ly4HhGHDEsk1rjXkMlNbLmURcveQ5E+rvaxGvbA3LhEK4fCFk0wdkzAL5AP386Lkhd/UoAMJ/qUYFZxTcFv9fF0UR0YMFNHEvKQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725773778; c=relaxed/simple;
	bh=rpRYgTdMHGGe2A8iAOqjp0QcTLymtWVdC4fe6olEdZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKAZ9WZTTMZoU+v4C/3I/ZAPC961CNn6asYqMhxKjXeaw+u2LIASLijj3bYGS9dmJaaHS/oYmBQsqhIJTVLYLrs7YQwcQt6VpFSgnwMbVQXbtAn0w+5bmfkZpcQZY/6Q0yVV9ZJRQIUiL5sssUUNnuwnV7Javrr4l/p1e7uIjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=dAdVZNkL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M2kMpNDn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 07004138012C;
	Sun,  8 Sep 2024 01:36:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 08 Sep 2024 01:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1725773775; x=1725860175; bh=i3s05PCH2bZCBIKhbs5xm
	5yHX2bnfCNCLNbQjYfnB4o=; b=dAdVZNkL0GHKYWliZV1Y1n27+qfAlbzmJt53d
	k+Xby79C1NNQISEKIJo0FyQNWQy2Sjl2P4lpQ+rrNWRED/l6LgrljmawvsPlLy5p
	ylzSLj8ppCUyDkbH+CFK6TdLcnlH0KC1CiJrMfgdzVVL2NU4Fjs2d0rSuAEBUOzf
	lK2y4h6kjvVB4uqWC4PGS7ZeaE/UyQI98K4QvTicwhGfjHdWiJEoUcopbApsG9Hz
	3BI5TIrRXUYrI2iF7L9BpTkLf8tWrN6zU0od9ZbrXPWgM8g21H6xaMxmIG0btrXg
	vTHtVVD8rHf+hVe556wpYClVwLAssNE0mOgYDG3pJMsCJdSdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725773775; x=1725860175; bh=i3s05PCH2bZCBIKhbs5xm5yHX2bn
	fCNCLNbQjYfnB4o=; b=M2kMpNDnvF/HJyI3Ri2MSRoNcfOEVXBJPGUp1AYWsuBJ
	i3HL3A1Rb3JVPIKtKbNAApPNigwgcwoaBhqvMMbPNvc0yiaaS8p5R5jOJpHYRcI4
	fuursr2g3jnNq7rfetWim1zT4SyAFO4nEs35omgDjxU7H/dbKsEBV1mTMHfZ2+1w
	RC1epFReDVqAznkLyRWn0Zo5Q3UEbn1xkTlN+xeepcReg9ZrmVeJI14w26eejAbD
	dZmPDeg59sztK7K5jwjxjvFECebOxcNJjGbvOg8oBS9p4sIwawTkGEDGj9P6jxpR
	VsDuav79Osj2dhVEmEzpsuJv20SLveR7rv0xZtJoyw==
X-ME-Sender: <xms:zjfdZnalC-3hFxvYTy0F4iCHNofnmdSbkhshbT5fcFbaxYV7EYfpHw>
    <xme:zjfdZmaTW4kR7E_Mfm7cCV7XRNxcntDV9p-E3CUmamJ3sVvioK31mPZJg3NbwlNkE
    Etq6adRktzT9zX-LwU>
X-ME-Received: <xmr:zjfdZp--0w9J8CRgpFL6uJhb_7M5ctKHL4BCy49zNaCTR0RUo-lqyMkPD8VIMus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdf
    uceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnheptdehkeeige
    eggfelkeeufeefjeduvdejveduvdehtdegveeftdeugeetvdeltdejnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    uhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:zjfdZtpv4tvoQcAEvZ8eT8SHpYa2wAGZilnv7HQPLQLWywp-bFVFww>
    <xmx:zjfdZipAI3V129CzwwxgcVoWoEAR891TYZ0kc0Lq-K7F0v9kP9bUqw>
    <xmx:zjfdZjSqRp-gXK3OJcswxrEUUlcMdwMyWir-N2VAqLnzcdhKKbPYxQ>
    <xmx:zjfdZqrBjsAg5Gk-thLymVEZL-4CBEcB5JpVmvAx6BOpp-z0Qew__g>
    <xmx:zjfdZrkbM2WQPu9dEROPGl704pFxllsRZuTCJoPnztHYRkd1LwmNSi5F>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 01:36:12 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	lenb@kernel.org,
	rafael@kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ACPI: PM: Quirk ASUS ROG M16 to default to S3 sleep
Date: Sun,  8 Sep 2024 17:36:07 +1200
Message-ID: <20240908053607.4213-1-luke@ljones.dev>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 2023 ASUS ROG Zephyrus M16 can suffer from quite a variety of events
causing wakeup from s2idle sleep. The events may come from the EC being
noisey, from the MMC reader, from the AniMe matrix display on some models
or from AC events.

Defaulting to S3 sleep prevents all these wakeup issues.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/acpi/sleep.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 889f1c1a1fa9..c8ee8e42b0f6 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -351,6 +351,20 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "1025C"),
 		},
 	},
+	/*
+	 * The ASUS ROG M16 from 2023 has many events which wake it from s2idle
+	 * resulting in excessive battery drain and risk of laptop overheating,
+	 * these events can be caused by the MMC or  y AniMe display if installed.
+	 * The match is valid for all of the GU604V<x> range.
+	 */
+	{
+	.callback = init_default_s3,
+	.ident = "ASUS ROG Zephyrus M16 (2023)",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus M16 GU604V"),
+		},
+	},
 	/*
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=189431
 	 * Lenovo G50-45 is a platform later than 2012, but needs nvs memory
-- 
2.46.0


