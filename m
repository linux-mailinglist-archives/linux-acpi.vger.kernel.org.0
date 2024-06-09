Return-Path: <linux-acpi+bounces-6277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2929014C9
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 09:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BCBB20B3C
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D913AD8;
	Sun,  9 Jun 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qSvZ+Rjt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9B1B94F;
	Sun,  9 Jun 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918041; cv=none; b=QlIVOkQfyIgA1Ci+ofgmiUdTLhCp1rKnz9x30RoVzeA0CUo6zQOSpV/xj4V5N6mdHzECm38WQvpzJ0DKxwvSUYR0+2cNixkYU/m+yRmIkrWEPP1/Yf+fmZPu96Zu+tntERLrJg8hf7Xt84OrFyI/OCXP0QY5ZErl+YRVmn+mKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918041; c=relaxed/simple;
	bh=YGPaK2ty3iBDd99SXk57m9Av56ArzbA+yUMUKB0P5Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcHTzORsjCh+vZ9WfHoOiv5y9uqoiGtX6+auDJsQnDAiHQ2dCNnYXWvlkzGFGUB8JcIf9kZz0v5qScg3AVxASnKAN43eCISipPWv/ifRGk1t81x/GDMeek/DAOOaKK3sbBLDNNj7Z46ZXMQ6rjwQzYuej0+os/S9TuWw+f3FrSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qSvZ+Rjt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717918035;
	bh=YGPaK2ty3iBDd99SXk57m9Av56ArzbA+yUMUKB0P5Tw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qSvZ+RjtSjMJgljIt8K1CmrtxZNjZnDsX385dI+fmnkMplux6Iof8ku4/j/OzHsD3
	 qHKrQMuPrb5UsN3MPpHdXwQ106glXsc/RQ7uv2NGAg0SMbji44cZRoYje5d3JblFGR
	 NUvmKgk/e6qBMBRZ41bosK2mT0bMUaySUb4b/osA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Jun 2024 09:27:12 +0200
Subject: [PATCH 1/5] ACPI: AC: constify powersupply properties
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240609-acpi-battery-cleanup-v1-1-344517bdca73@weissschuh.net>
References: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
In-Reply-To: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717918035; l=583;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YGPaK2ty3iBDd99SXk57m9Av56ArzbA+yUMUKB0P5Tw=;
 b=vxRtPe6Mh2CMvsigAcdubidfoU9BAsg0tWsyUi2DHVlv8FqNavnLrRm3dP/Eo3jOngNusELVY
 gq/eIEw34g1APlHuOR4Or+1ociquwNvDU7moZ/uo4wmqdXBJNY6ifwU
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The array is never modified, make it const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/ac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 09a87fa222c7..eaa70b23dd0b 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -112,7 +112,7 @@ static int get_ac_property(struct power_supply *psy,
 	return 0;
 }
 
-static enum power_supply_property ac_props[] = {
+static const enum power_supply_property ac_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 

-- 
2.45.2


