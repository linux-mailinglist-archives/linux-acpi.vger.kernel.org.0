Return-Path: <linux-acpi+bounces-6278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09039014CA
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 09:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35151C210B8
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 07:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75A1C2A8;
	Sun,  9 Jun 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PwavMIqt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300118C3D;
	Sun,  9 Jun 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918041; cv=none; b=OE1aybK3b68RLPw6+sKmRmHUwGInIAC+ZrCbGO+NL5VLSaRZwcnDd7zOIdPP9pL2EHr2+dKnfRxmMoDeqn+Y62xsEKJEXuV+WzSDrVECWl4yLDs+QfFjgOmMUlN6wakTFkMRxhyIjCHchlGJNKsbIVmIMGtxqeNlsAoIk5o0BzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918041; c=relaxed/simple;
	bh=9X9E0iPzjMX5HXPIZVXXhzNHMsBF2nq1d13kKi6GrZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLocO8qIsM0Ke1H85LZwOdGYCTXEuXRBUavt+UdYV2kbi4rZRPkwBJkc9Ssernbkc0MUHG7oALc55IhH1EA+Pwrzyi7RX5bm8pstEUj2t7ZoKq8OvQvPefWDmXl0rfp/nLA0S9AxT45QQlAslxMcrROX3iFqCiiBgvSK96CnPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PwavMIqt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717918035;
	bh=9X9E0iPzjMX5HXPIZVXXhzNHMsBF2nq1d13kKi6GrZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PwavMIqtPyB328UWGLX7Ga2bMGPkKqkD/DHR8DeYW1128Dzohc9JHLvw+2ErmBAZ5
	 LNPLzVq+d1qaI6HN3rCqIWKi//STYTKvPZDqOQwg5Ib/MxXrsvDbnUJ6R4niOdU2Ln
	 2igEvZGX2DhQnPc4a91784vjDSg5V5ySEdpPxvTw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Jun 2024 09:27:13 +0200
Subject: [PATCH 2/5] ACPI: SBS: constify powersupply properties
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240609-acpi-battery-cleanup-v1-2-344517bdca73@weissschuh.net>
References: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
In-Reply-To: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717918035; l=1215;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9X9E0iPzjMX5HXPIZVXXhzNHMsBF2nq1d13kKi6GrZo=;
 b=3EAwR4Ckbm989qU4jNHQMG4Ws6kMJaRPp23/innoYxEMDXJv2YffoDLEUFAvV5OiGZjlokp7U
 zVI+WwB+Rd2BZ8h4VxwXZXb5ontQ2KusUlp21aUNC7sw2EOj3by+3AR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The arrays are never modified, make them const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/sbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index dc8164b182dc..3d81ce3103c6 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -241,11 +241,11 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static enum power_supply_property sbs_ac_props[] = {
+static const enum power_supply_property sbs_ac_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
-static enum power_supply_property sbs_charge_battery_props[] = {
+static const enum power_supply_property sbs_charge_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -263,7 +263,7 @@ static enum power_supply_property sbs_charge_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_property sbs_energy_battery_props[] = {
+static const enum power_supply_property sbs_energy_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,

-- 
2.45.2


