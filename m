Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24E6576723
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jul 2022 21:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiGOTIe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 15:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGOTIe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 15:08:34 -0400
X-Greylist: delayed 1802 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 12:08:31 PDT
Received: from smtp.umanwizard.com (smtp.umanwizard.com [54.203.248.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24FC948E94
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 12:08:30 -0700 (PDT)
X-Fes-Received-For: linux-acpi@vger.kernel.org
X-Fes-Received-From: brennan@umanwizard.com
Received: From [10.10.1.216] ([173.205.212.102]) By umanwizard.com ; 15 Jul 2022 18:38:23+0000
Message-ID: <7d5bd8b6-15ba-a99c-349e-cfbd94942239@umanwizard.com>
Date:   Fri, 15 Jul 2022 14:38:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Brennan Vincent <brennan@umanwizard.com>
Subject: [PATCH] Expose ACPI battery "measurement accuracy" property to sysfs.
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Fes-Encrypted: true
X-Fes-Ehlo-Domain: [10.10.1.216]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This property, expressed in thousands of a percent,
reports how accurate the device claims its
capacity metrics to be. It may be useful for battery
monitoring tools.
---
 drivers/acpi/battery.c                    | 7 +++++++
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 306513fec1e1..933f3de4dd67 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -300,6 +300,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		val->strval = battery->serial_number;
 		break;
+	case POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY:
+		val->intval = battery->measurement_accuracy;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -322,6 +325,7 @@ static enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
 };

 static enum power_supply_property charge_battery_full_cap_broken_props[] = {
@@ -336,6 +340,7 @@ static enum power_supply_property charge_battery_full_cap_broken_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
 };

 static enum power_supply_property energy_battery_props[] = {
@@ -354,6 +359,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
 };

 static enum power_supply_property energy_battery_full_cap_broken_props[] = {
@@ -368,6 +374,7 @@ static enum power_supply_property energy_battery_full_cap_broken_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
 };

 /* Battery Management */
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 4239591e1522..844dbd61295f 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -220,6 +220,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
+	POWER_SUPPLY_ATTR(MEASUREMENT_ACCURACY),
 };

 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index cb380c1d9459..4c48ee26f1b5 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -174,6 +174,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
 };

 enum power_supply_type {
--
2.34.1
