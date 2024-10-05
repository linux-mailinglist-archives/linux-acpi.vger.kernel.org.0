Return-Path: <linux-acpi+bounces-8568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF669915C2
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 12:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1121C219DF
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74C155C9A;
	Sat,  5 Oct 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nAqi6hga"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291D146593;
	Sat,  5 Oct 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122731; cv=none; b=PAgVYjtmL3ci2un147/XYz1+53nbMKbuWQK6/i6imO1EFZoPexKoEODKQoANIgaanyQWXr0YMks+HlzAHOF9imSxsK/ugfwPw0Pp4qdIYop39SK4wTgMJ18s5epHt0mh5vd+82wT4jdHvpgHAfJ0p5gOipBjA+6SBBnvso//bPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122731; c=relaxed/simple;
	bh=ijS07aEByhrA+n6K2twDkykEXtvnzQLVfRKUwwjEGxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQRV9gNG3xaa+X1IRfsN3oyCktV2J0PIJMLKxnGfZZ8Z9nIt2rvMg5k4MQrJ+F0rVgmZ3QeRleVK+yPbaL3rgixB+tmjObASWZxJZpaELAtuN5uCK9iQu3m/1EyqMPCBedmfmY+plcjEbkNgaENvMRYaUWdZ1CagKOt1KRIQCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nAqi6hga; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122726;
	bh=ijS07aEByhrA+n6K2twDkykEXtvnzQLVfRKUwwjEGxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nAqi6hgaITg2oVn3L69qa4x8PokHo/GV4BGerq3Sq2QzM6tK+v1Hbt2ZmnwaM5IRN
	 Uanm6jjFelNc7parev+EuGS/ilA8rjiOqgoPhDzdEo54UpHsbmvV6R3jvH606KPWFL
	 jWgDMdxxmGbKWBsAbbUBdvBiti4mzbQIVBEmlxlY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:05:03 +0200
Subject: [PATCH 1/8] power: supply: core: add wakeup source inhibit by
 power_supply_config
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-no-wakeup-source-v1-1-1d62bf9bcb1d@weissschuh.net>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, chrome-platform@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122726; l=1549;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ijS07aEByhrA+n6K2twDkykEXtvnzQLVfRKUwwjEGxk=;
 b=q1QrO+VM8DvVjekwT7aC6UoANhEktHr2rCBQ2IWIzfHShh+XuAtDiqWE1UL1A315Btf9A60vj
 Zz+I35sESEKCI3pwKsn3QaCz+LneOPNLH3vCxsfjGfde6hm2Hkq1QbD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To inhibit wakeup users currently have to use dedicated functions to
register the power supply: {,devm_}power_supply_register_no_ws().
This is inconsistent to other runtime settings which can be configured
through struct power_supply_config.
It's also not obvious what _no_ws() is meant to mean.

Extend power_supply_config to also be able to inhibit the wakeup source.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 3 +++
 include/linux/power_supply.h             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 49534458a9f7d3f6d7c01bd91fa1bb6ed23bc7ad..5b5a3abca0b554d809054026f8cf32b2d18a3362 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1410,6 +1410,9 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto device_add_failed;
 
+	if (cfg && cfg->no_wakeup_source)
+		ws = false;
+
 	rc = device_init_wakeup(dev, ws);
 	if (rc)
 		goto wakeup_init_failed;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 910d407ebe6323aaf4b31f0081f2cdd4be43a9fa..412646e055d79ff23346a99c4485e594363857ed 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -236,6 +236,8 @@ struct power_supply_config {
 
 	char **supplied_to;
 	size_t num_supplicants;
+
+	bool no_wakeup_source;
 };
 
 /* Description of power supply */

-- 
2.46.2


