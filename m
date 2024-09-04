Return-Path: <linux-acpi+bounces-8138-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044596B28F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 09:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E341C21D67
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22CB1482F6;
	Wed,  4 Sep 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="S6I3oXxT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F165146A7A;
	Wed,  4 Sep 2024 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433991; cv=none; b=d1/aU59CjmlkzlluzeTQ88kU+wKLj70o/d03b2TAbh1TO59pPjkrDWu3DPdrjQx1j5Adm5wpWhxeMoxbO7IFWb/mvubf7h1KIa7MGjOxE4pjHA927Mu3tdQomXE0N7j+kDIwOwnsa/UJb4VbiTmGCOP7XEhK1FbsJB1rvdX+ML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433991; c=relaxed/simple;
	bh=Lo47J8vVQ9sY5GjhyJ305oT5BSxprDB45/xE/NvMdkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/8uQPGd53K8jNNzIolI9LWdLQzI9dOIGFDG5n5ccNGm/XP2f+jPM18qrgufWW/gFP56NNUm0uzOY4vci71vbeCrxdM6S8DVL3jpcFSIt14bNboBOlEStSQRjUYPM7HMYkVH5hjoKWbo7ysD97O1wGOn7LUabxN6+Pd6axeLPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=S6I3oXxT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725433984;
	bh=Lo47J8vVQ9sY5GjhyJ305oT5BSxprDB45/xE/NvMdkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S6I3oXxTI18FFedKFIAKA3+Hk2i9CXtkIJvo1ui7c9DJ0KQam+rJ05thAA1befqEK
	 l+XmqR4pDV/m9725/FdEkf5wnbMmdOQz+1I2DoZz5MJNGxYhvn4PSuvHpMnuVtNzuA
	 2MqBdHYdX0BIafDykWJPEIAbowjmorRlQls5hGp8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 09:12:52 +0200
Subject: [PATCH 1/5] ACPI: battery: check result of register_pm_notifier()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-acpi-battery-cleanups-v1-1-a3bf74f22d40@weissschuh.net>
References: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
In-Reply-To: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725433984; l=734;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Lo47J8vVQ9sY5GjhyJ305oT5BSxprDB45/xE/NvMdkc=;
 b=EpNdWKvlWwX5uqCpIxeels1V8/9XfN7uAEPnC+J+cdbkuKz6oyvlBmtRYtTqb9UjnTgZlj3pZ
 bygupYUKVvVDC/3DnbOnwkBxlLaHRgkPevTdOfs/AnkmF4xBlKYLmLp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This function call can fail, check for that.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index da3a879d638a..677618eb38bf 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1235,7 +1235,9 @@ static int acpi_battery_add(struct acpi_device *device)
 		device->status.battery_present ? "present" : "absent");
 
 	battery->pm_nb.notifier_call = battery_notify;
-	register_pm_notifier(&battery->pm_nb);
+	result = register_pm_notifier(&battery->pm_nb);
+	if (result)
+		goto fail;
 
 	device_init_wakeup(&device->dev, 1);
 

-- 
2.46.0


