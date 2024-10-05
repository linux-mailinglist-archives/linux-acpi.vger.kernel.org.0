Return-Path: <linux-acpi+bounces-8569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B79915C5
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 12:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A219B23779
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC33156875;
	Sat,  5 Oct 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DQo7haTZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6914600C;
	Sat,  5 Oct 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122731; cv=none; b=Fh7uyjyQWfqtKy+IdMfsossTr9BdwhQ8oMY07nMOv0imxuwu9kil2Y85VBhPGifUI8eunyALYK7NHX9aIV62xkKdelp/CkpsJTq4zweXtaXwaXFyY3I0AJBC/kb3ARW0lZ+Epeo6PgEEk33uH7TnFOAMwF8c4sep8pB5FhdZyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122731; c=relaxed/simple;
	bh=iVn9zkMkqlm7S5h5JRqhUrYnlB6s71UZJiFr3ZeXgCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKVhDrRVBTjWZjCHNVl3BX+415XDjiNjCdhWBRESICaLnHln9Nf98wd9KHoKsbd1TzNlKsK4y+QSGNy2QE2QP2N0hpzUcrbclGyEVVoTAuacoBmabE1ePNwk03qk3R8s6r4m9c0n2j9ErqmRTVE8KfH7/X5tja+je9IwTzxlkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DQo7haTZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122727;
	bh=iVn9zkMkqlm7S5h5JRqhUrYnlB6s71UZJiFr3ZeXgCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DQo7haTZNrDFyCZdNEQ2m9cbXikgBe1NkRRveOdLqxB0AYoQSNdbsSQMyr2bTfaNd
	 /INj6TS5swooVTBrDDQqXmo9+QFE9EUdFPd/CyX3W5dRq4ONwzDwMgikUg3jrUPOvr
	 29QOEVxXcmFQUfLWfcUW8jeK86Xdpi+Omj27BFLo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:05:10 +0200
Subject: [PATCH 8/8] power: supply: core: remove
 {,devm_}power_supply_register_no_ws()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-no-wakeup-source-v1-8-1d62bf9bcb1d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122726; l=5742;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iVn9zkMkqlm7S5h5JRqhUrYnlB6s71UZJiFr3ZeXgCk=;
 b=zG7LJNwygoALWccpB6SUz7CPwxNuIRXMEyaMZBFMz6fMCuifyaCI+ppfL2i98I7Sh2N52k9vi
 Q9gofR2fQ8PCJ+Ok9kf8CCS/m898xzK9M/YdBUrIOW+WQ6qi4C2kYBU
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The same functionality is available through
power_supply_config::no_wakeup_source, which is more idiomatic.
All users of the old API have been converted.

Also remove the argument "ws" from __power_supply_register(),
as it is now always "true".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_core.c | 71 ++------------------------------
 include/linux/power_supply.h             |  8 ----
 2 files changed, 4 insertions(+), 75 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 5b5a3abca0b554d809054026f8cf32b2d18a3362..650da0d1331f87a9682f92084b937ed879105b39 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1342,8 +1342,7 @@ static void psy_unregister_thermal(struct power_supply *psy)
 static struct power_supply *__must_check
 __power_supply_register(struct device *parent,
 				   const struct power_supply_desc *desc,
-				   const struct power_supply_config *cfg,
-				   bool ws)
+				   const struct power_supply_config *cfg)
 {
 	struct device *dev;
 	struct power_supply *psy;
@@ -1410,10 +1409,7 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto device_add_failed;
 
-	if (cfg && cfg->no_wakeup_source)
-		ws = false;
-
-	rc = device_init_wakeup(dev, ws);
+	rc = device_init_wakeup(dev, cfg ? !cfg->no_wakeup_source : true);
 	if (rc)
 		goto wakeup_init_failed;
 
@@ -1479,33 +1475,10 @@ struct power_supply *__must_check power_supply_register(struct device *parent,
 		const struct power_supply_desc *desc,
 		const struct power_supply_config *cfg)
 {
-	return __power_supply_register(parent, desc, cfg, true);
+	return __power_supply_register(parent, desc, cfg);
 }
 EXPORT_SYMBOL_GPL(power_supply_register);
 
-/**
- * power_supply_register_no_ws() - Register new non-waking-source power supply
- * @parent:	Device to be a parent of power supply's device, usually
- *		the device which probe function calls this
- * @desc:	Description of power supply, must be valid through whole
- *		lifetime of this power supply
- * @cfg:	Run-time specific configuration accessed during registering,
- *		may be NULL
- *
- * Return: A pointer to newly allocated power_supply on success
- * or ERR_PTR otherwise.
- * Use power_supply_unregister() on returned power_supply pointer to release
- * resources.
- */
-struct power_supply *__must_check
-power_supply_register_no_ws(struct device *parent,
-		const struct power_supply_desc *desc,
-		const struct power_supply_config *cfg)
-{
-	return __power_supply_register(parent, desc, cfg, false);
-}
-EXPORT_SYMBOL_GPL(power_supply_register_no_ws);
-
 static void devm_power_supply_release(struct device *dev, void *res)
 {
 	struct power_supply **psy = res;
@@ -1538,7 +1511,7 @@ devm_power_supply_register(struct device *parent,
 
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
-	psy = __power_supply_register(parent, desc, cfg, true);
+	psy = __power_supply_register(parent, desc, cfg);
 	if (IS_ERR(psy)) {
 		devres_free(ptr);
 	} else {
@@ -1549,42 +1522,6 @@ devm_power_supply_register(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(devm_power_supply_register);
 
-/**
- * devm_power_supply_register_no_ws() - Register managed non-waking-source power supply
- * @parent:	Device to be a parent of power supply's device, usually
- *		the device which probe function calls this
- * @desc:	Description of power supply, must be valid through whole
- *		lifetime of this power supply
- * @cfg:	Run-time specific configuration accessed during registering,
- *		may be NULL
- *
- * Return: A pointer to newly allocated power_supply on success
- * or ERR_PTR otherwise.
- * The returned power_supply pointer will be automatically unregistered
- * on driver detach.
- */
-struct power_supply *__must_check
-devm_power_supply_register_no_ws(struct device *parent,
-		const struct power_supply_desc *desc,
-		const struct power_supply_config *cfg)
-{
-	struct power_supply **ptr, *psy;
-
-	ptr = devres_alloc(devm_power_supply_release, sizeof(*ptr), GFP_KERNEL);
-
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-	psy = __power_supply_register(parent, desc, cfg, false);
-	if (IS_ERR(psy)) {
-		devres_free(ptr);
-	} else {
-		*ptr = psy;
-		devres_add(parent, ptr);
-	}
-	return psy;
-}
-EXPORT_SYMBOL_GPL(devm_power_supply_register_no_ws);
-
 /**
  * power_supply_unregister() - Remove this power supply from system
  * @psy:	Pointer to power supply to unregister
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 412646e055d79ff23346a99c4485e594363857ed..6562d52151f62fadfefa718483b954067d088875 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -874,17 +874,9 @@ power_supply_register(struct device *parent,
 				 const struct power_supply_desc *desc,
 				 const struct power_supply_config *cfg);
 extern struct power_supply *__must_check
-power_supply_register_no_ws(struct device *parent,
-				 const struct power_supply_desc *desc,
-				 const struct power_supply_config *cfg);
-extern struct power_supply *__must_check
 devm_power_supply_register(struct device *parent,
 				 const struct power_supply_desc *desc,
 				 const struct power_supply_config *cfg);
-extern struct power_supply *__must_check
-devm_power_supply_register_no_ws(struct device *parent,
-				 const struct power_supply_desc *desc,
-				 const struct power_supply_config *cfg);
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 

-- 
2.46.2


