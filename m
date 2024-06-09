Return-Path: <linux-acpi+bounces-6279-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD399014CD
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 09:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047EDB20D30
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 07:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC561CA80;
	Sun,  9 Jun 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LnlR9jpB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC217997;
	Sun,  9 Jun 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918041; cv=none; b=k6/K20b7QML5MX2UB06osxKDwEzEUWTHfIsDnF46e6C9NtNFJMEarNIU3AZEimj0YLLsRi1N3TRfjL59K7UhpiQ2D/31KN3rXQh6OqBn9jcqAgCq5x2CaPnpVKBH/8iLg3+APOjKR5u74SxTxIHyU2qhsQl6/q1vAPQq4eDH6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918041; c=relaxed/simple;
	bh=RJZgnCB5BUCDv22+RPw4ZAtNO1sIx6+p/3RbQvlhnWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rO6oB9frkvmb1DXgPccXSFEwtZInjBxF9GOmROmlEhKPBRrV1PKzXr5EbixN8iL6o4h0eZCXPPPCr80sgM9EnwCigvOx26vtIrtrrjWAb6sUgRTI9VJX4qhy4MMzP/CAj//fXFBQl8LZ3KyU/Uoj8s8hr/Lu60GkuimxpfMeCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LnlR9jpB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717918035;
	bh=RJZgnCB5BUCDv22+RPw4ZAtNO1sIx6+p/3RbQvlhnWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LnlR9jpBQkNjBNVbOqnzzg1QcyeODyClP98zajH9iop3yd4v81XjLVaffExACQWww
	 fLvzIQvDchYk8p7PibGOJDpkSYX9i6ZTok119Po3VmU74MrydbaHcPDYdMvD9/t3iv
	 FT41UFIR88PLrYJWI7PjuJXbP3GlIwxYrYGLo7Os=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Jun 2024 09:27:14 +0200
Subject: [PATCH 3/5] ACPI: battery: constify powersupply properties
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240609-acpi-battery-cleanup-v1-3-344517bdca73@weissschuh.net>
References: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
In-Reply-To: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717918035; l=1841;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=RJZgnCB5BUCDv22+RPw4ZAtNO1sIx6+p/3RbQvlhnWs=;
 b=P4wUdzdC2tWG0jbHRMuRKjRLTtMm1Ac9HwtTuXg+7G0CROrZy2CZ090nUUBru8n4VJR88RPh2
 riqFeGR8a3ZBImDfQ+rueWzfmOa7Q928VXzv9iQfDJT22IKOVjAGTkr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The arrays are never modified, make them const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b379401ff1c2..984236b95dff 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -308,7 +308,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static enum power_supply_property charge_battery_props[] = {
+static const enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -326,7 +326,7 @@ static enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
-static enum power_supply_property charge_battery_full_cap_broken_props[] = {
+static const enum power_supply_property charge_battery_full_cap_broken_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -340,7 +340,7 @@ static enum power_supply_property charge_battery_full_cap_broken_props[] = {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
-static enum power_supply_property energy_battery_props[] = {
+static const enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -358,7 +358,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
-static enum power_supply_property energy_battery_full_cap_broken_props[] = {
+static const enum power_supply_property energy_battery_full_cap_broken_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,

-- 
2.45.2


