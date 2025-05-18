Return-Path: <linux-acpi+bounces-13787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295DABB159
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 20:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E48176043
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 18:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F4421E0AC;
	Sun, 18 May 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BgovVZB9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABB21D5A9;
	Sun, 18 May 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747594284; cv=none; b=dVRdsI6mk6OXyPMkvg2IJ67njc2AGa2NjFBZr0GKQAUj1ENmm7Jc5PaWoLfDeEB7lXwLUZOwIk5ByrH36lx0rkaEKMdirpfw2GtyVqNUbtyfHDeJ9Du3V4NJHutd34kWvgVZgMd6STzkZ6vU9mkTLV6lNubm3xMxkC8H74TaXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747594284; c=relaxed/simple;
	bh=3H7Gb+VXvFPtnBexmAEVWMFrIfU5x5+ju2pmvM5lfDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVzSDC1X+XDbz0ys3L2tLn3FDm9zdO7AApGe0foK6sxi779hmHf8p5Ktw1sJ7HClCxyRGSXnURrS7cG5VqUY+meCOeNeslBMvbGGJ0JipBEwuBSWXiwcZ+kcHlnEhYt712XhB4kjPKskk/OmNjWid5YLxDr4EImVvAAB85IEQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BgovVZB9; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747594276; x=1748199076; i=w_armin@gmx.de;
	bh=3X1f1GIebQhlCyPUGnySg4TmlISmhZLZP7n2Nj92Wk8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BgovVZB986xjNkiSnXT1tACn+/TXyp0i18yAU/f2pBrhz2MTS5FG/motbgFyJtFZ
	 ARlak9k0FYQ71YzKiyg7rgaX1kOqMd0vaeLrpOig6P9Ocf0QiOaQ+rCO6ns7jH/hU
	 l7WUCMdylAtmE5a6/SSZSPA+ZG+JNbCbZxWWJFHv629I3+6SyNw/Os6Uh2HggQAsC
	 /rZxOnxGQZWbj2I7h2R3Zq3l8Rs3ZyGeQmOoJ/xALrjRpp/VhGY3WwZ0pTVCajeRI
	 dmT+W6KDF37wndqaiq9xu1Ype8/AXkSmiN5ysAGlhVbgaseRaRfCOU7SnVDUy/hZ/
	 T7XRrwiwdS/EezjMuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N7zBR-1v32cy33GV-016LKa; Sun, 18 May 2025 20:51:16 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: j@jannau.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI: bus: Bail out if acpi_kobj registration fails
Date: Sun, 18 May 2025 20:51:11 +0200
Message-Id: <20250518185111.3560-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518185111.3560-1-W_Armin@gmx.de>
References: <20250518185111.3560-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yM8IX6bmTOaTr+lBHZ6j30bM5lBkA+3paZlHtBSDkSZbO8RrQoY
 6O1J7+6fEwuUwRwk19HnsRvzzAq/xlOSs67t/e2wSfB70LM5qoX77wO6pKX0Pl+pnYHt6KE
 elszqymqEi16nsRnvcH9+X6TPLAnVHNqIygrv0hpU4ABlIjEenLCUZ8dbY5vk+YPx29OtLj
 4RwWOSFdrrUUEVIFHf7KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GtcHEW5uQDM=;yA+TTtzlmCxzruB5EWOYKu2KR27
 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

The ACPI sysfs code will fail to initialize if acpi_kobj is NULL,
together with some ACPI drivers. Follow the other firmware subsystems
and bail out if the kobject cannot be registered.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 058910af82bc..c2ab2783303f 100644
=2D-- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1446,8 +1446,10 @@ static int __init acpi_init(void)
 	}
=20
 	acpi_kobj =3D kobject_create_and_add("acpi", firmware_kobj);
-	if (!acpi_kobj)
-		pr_debug("%s: kset create error\n", __func__);
+	if (!acpi_kobj) {
+		pr_err("Failed to register kobject\n");
+		return -ENOMEM;
+	}
=20
 	init_prmt();
 	acpi_init_pcc();
=2D-=20
2.39.5


