Return-Path: <linux-acpi+bounces-6281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AC9014CF
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 09:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822FF1C21111
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D6D1CD3C;
	Sun,  9 Jun 2024 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="o2vTTYa/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230591B28D;
	Sun,  9 Jun 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918042; cv=none; b=DTNbFbp7knIqMLeWNtnyB9FMMIg+VJrgtiHWO8vzIHJgZLaUvEmn1eH3UOeOKaZm4ZAvK0qgNJnqHShhbW1EIfJREdafRBjCIG90Zo6E++9jbicp29CeJEDorlvhPgVWQlUf5CgoE/QrYuoJp0HOG3ELdTm/Qaz5tzmkLVa7Gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918042; c=relaxed/simple;
	bh=n1WQcr0Jjs8K54pWJ570AATvW6C/bMm/V7v5t/VuBkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdxS4mcnLsVrjLEOsf/FVj6BkmhkbOpS1MUgj/sCw4xF+ca9jCySkHtvf6AbsqUxJc6xSZDQ/3Rwww2GQWuozKO7n/aSRTqiWCnTflvRGTlPwElzAjBCg+wBkyz5tyqGRc4oHXdyMvKumDlu0zqERM6OnwSyOqJRnf1dhvQddJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=o2vTTYa/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717918035;
	bh=n1WQcr0Jjs8K54pWJ570AATvW6C/bMm/V7v5t/VuBkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o2vTTYa/52GfwDIH50bo5k56LhILhUQZSaJcau3u0IwZMqnCNwzTQFQILPKMokNS0
	 tz0ZOWTYzz3V5w2t4Pv7yxOIoJFmQOpZLjflPgserUW3sGgA2vNXCPBqnvU9tvBrsL
	 aMvH+HUlkuA85AgpD0IqSPjNBJ1OAB+cvUn7wY7o=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Jun 2024 09:27:15 +0200
Subject: [PATCH 4/5] ACPI: battery: use sysfs_emit over sprintf
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240609-acpi-battery-cleanup-v1-4-344517bdca73@weissschuh.net>
References: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
In-Reply-To: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717918035; l=770;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=n1WQcr0Jjs8K54pWJ570AATvW6C/bMm/V7v5t/VuBkM=;
 b=X2WU9aZZtK2pcr/wgLdCSvmY+kM+VWNyNxvaxbW1JmfNI+WIBFdfdTXNF6HALMSrEv2Oqft3J
 SGIrh7Z6uVKCoHHhTQPP92w45mr+gvZFXv2ewccYpeN04fbA0iyPHOh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

sysfs_emit validates assumptions made by sysfs and is the correct
mechanism to format data for sysfs.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 984236b95dff..5f47bd58aff3 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -661,7 +661,7 @@ static ssize_t acpi_battery_alarm_show(struct device *dev,
 {
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
 
-	return sprintf(buf, "%d\n", battery->alarm * 1000);
+	return sysfs_emit(buf, "%d\n", battery->alarm * 1000);
 }
 
 static ssize_t acpi_battery_alarm_store(struct device *dev,

-- 
2.45.2


