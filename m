Return-Path: <linux-acpi+bounces-9957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8879E5FAE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5AF16C0EA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 20:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26991C07C0;
	Thu,  5 Dec 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NzWJ7uIz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0EE1B4123;
	Thu,  5 Dec 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733431650; cv=none; b=ZnmqWh4g9kuu0BA6vkzN5JXbTxLNuj+YTHwaFfiMA5sVqW85sbjCnQYK3/ZrDrGpU7ZBcP6Pl9Z/PEf120/dqQjTe2VFkycGh6STihUMh32mvutF5eYD91xbUsCBZQ9r57b0DlkZXm6HzTxl925MSSt2He1OsBYmy6yG753e2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733431650; c=relaxed/simple;
	bh=u5aND4+bmYLeegxlwVhwulMeUQLI6UQhFWuN0Ipz++Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJCWdo03V99ia6dAatNcPQUTLuHmfrNhU+qvbKBQqOI+QyIsoINSPIHID2QBV8dqMbJFyT48Md+r5HXMl9+OY+rdRwA5+XpPCKNSIPkj4wal2ZU+XPbmizHbR4dGtY8CaL2uGgUz9vLy0TGZMNhL1/7JmYHJ0Zepa+Np9oTM82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NzWJ7uIz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733431639;
	bh=u5aND4+bmYLeegxlwVhwulMeUQLI6UQhFWuN0Ipz++Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NzWJ7uIzGl5K2d6FT2DHBLQKbZl9u9l9/4jYl6KbxEvyhtaODD8jQW1NueEG2jzPM
	 yKdB8PmobykPcbez6qx16V+ybB9elHqvhfFLoEYyZfQpXP3i4I9zPW7M8JwM4xjEFj
	 0tkZe8sAfFU5wQ6ASXzhGWMNoKsrSwjOJzm8JOTA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 05 Dec 2024 21:46:37 +0100
Subject: [PATCH v5 3/4] power: supply: test-power: implement a power supply
 extension
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-power-supply-extensions-v5-3-f0f996db4347@weissschuh.net>
References: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
In-Reply-To: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733431638; l=5423;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=u5aND4+bmYLeegxlwVhwulMeUQLI6UQhFWuN0Ipz++Y=;
 b=3d1a0ClYPsrF756j0asmMRqi8KoJBQQntAPdwQzs27RZBeAjlwqC7wINhPqW7YosTcw0pQKYl
 raB87fC3MqQB9cmlfLGlvpZuudOBLdaQGBVdKArZ7LJWLytKI3oRNWa
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Allow easy testing of the new power supply extension functionality.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/test_power.c | 111 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 442ceb7795e1d84e34da2801d228d53fb67e08d9..1e15d3d192ef4040839aa9740b06f5ab78b6b6d3 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -37,6 +37,7 @@ static int battery_charge_counter	= -1000;
 static int battery_current		= -1600;
 static enum power_supply_charge_behaviour battery_charge_behaviour =
 	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+static bool battery_hook;
 
 static bool module_initialized;
 
@@ -238,6 +239,85 @@ static const struct power_supply_config test_power_configs[] = {
 	},
 };
 
+static int power_supply_ext_manufacture_year = 1234;
+static int power_supply_ext_temp_max = 1000;
+static const enum power_supply_property power_supply_ext_props[] = {
+	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
+	POWER_SUPPLY_PROP_TEMP_MAX,
+};
+
+static int power_supply_ext_get_property(struct power_supply *psy,
+					 const struct power_supply_ext *ext,
+					 void *ext_data,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		val->intval = power_supply_ext_manufacture_year;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		val->intval = power_supply_ext_temp_max;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int power_supply_ext_set_property(struct power_supply *psy,
+					 const struct power_supply_ext *ext,
+					 void *ext_data,
+					 enum power_supply_property psp,
+					 const union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		power_supply_ext_manufacture_year = val->intval;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		power_supply_ext_temp_max = val->intval;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int power_supply_ext_property_is_writeable(struct power_supply *psy,
+						  const struct power_supply_ext *ext,
+						  void *ext_data,
+						  enum power_supply_property psp)
+{
+	return true;
+}
+
+static const struct power_supply_ext power_supply_ext = {
+	.properties = power_supply_ext_props,
+	.num_properties = ARRAY_SIZE(power_supply_ext_props),
+	.get_property = power_supply_ext_get_property,
+	.set_property = power_supply_ext_set_property,
+	.property_is_writeable = power_supply_ext_property_is_writeable,
+};
+
+static void test_battery_configure_battery_hook(bool enable)
+{
+	struct power_supply *psy;
+
+	psy = test_power_supplies[TEST_BATTERY];
+
+	if (enable) {
+		if (power_supply_register_extension(psy, &power_supply_ext, NULL)) {
+			pr_err("registering battery extension failed\n");
+			return;
+		}
+	} else {
+		power_supply_unregister_extension(psy, &power_supply_ext);
+	}
+
+	battery_hook = enable;
+}
+
 static int __init test_power_init(void)
 {
 	int i;
@@ -258,6 +338,8 @@ static int __init test_power_init(void)
 		}
 	}
 
+	test_battery_configure_battery_hook(true);
+
 	module_initialized = true;
 	return 0;
 failed:
@@ -524,6 +606,26 @@ static int param_set_battery_current(const char *key,
 
 #define param_get_battery_current param_get_int
 
+static int param_set_battery_hook(const char *key,
+				  const struct kernel_param *kp)
+{
+	bool old_battery_hook;
+	int ret;
+
+	old_battery_hook = battery_hook;
+
+	ret = param_set_bool(key, kp);
+	if (ret)
+		return ret;
+
+	if (old_battery_hook != battery_hook)
+		test_battery_configure_battery_hook(battery_hook);
+
+	return 0;
+}
+
+#define param_get_battery_hook param_get_bool
+
 static const struct kernel_param_ops param_ops_ac_online = {
 	.set = param_set_ac_online,
 	.get = param_get_ac_online,
@@ -574,6 +676,11 @@ static const struct kernel_param_ops param_ops_battery_current = {
 	.get = param_get_battery_current,
 };
 
+static const struct kernel_param_ops param_ops_battery_hook = {
+	.set = param_set_battery_hook,
+	.get = param_get_battery_hook,
+};
+
 #define param_check_ac_online(name, p) __param_check(name, p, void);
 #define param_check_usb_online(name, p) __param_check(name, p, void);
 #define param_check_battery_status(name, p) __param_check(name, p, void);
@@ -584,6 +691,7 @@ static const struct kernel_param_ops param_ops_battery_current = {
 #define param_check_battery_voltage(name, p) __param_check(name, p, void);
 #define param_check_battery_charge_counter(name, p) __param_check(name, p, void);
 #define param_check_battery_current(name, p) __param_check(name, p, void);
+#define param_check_battery_hook(name, p) __param_check(name, p, void);
 
 
 module_param(ac_online, ac_online, 0644);
@@ -621,6 +729,9 @@ MODULE_PARM_DESC(battery_charge_counter,
 module_param(battery_current, battery_current, 0644);
 MODULE_PARM_DESC(battery_current, "battery current (milliampere)");
 
+module_param(battery_hook, battery_hook, 0644);
+MODULE_PARM_DESC(battery_hook, "battery hook");
+
 MODULE_DESCRIPTION("Power supply driver for testing");
 MODULE_AUTHOR("Anton Vorontsov <cbouatmailru@gmail.com>");
 MODULE_LICENSE("GPL");

-- 
2.47.1


