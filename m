Return-Path: <linux-acpi+bounces-6292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF73902613
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C841F21295
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3336A146D54;
	Mon, 10 Jun 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nsjg4LyK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A1140369;
	Mon, 10 Jun 2024 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034733; cv=none; b=Y6AaR/fYk8oIZTCGf4Ci+X3yoCMM16xnzTLret/owqfPiaeij4Y/pMhrOcD325E1+KWUqTfXSPciNstNwe7T80GyJjvF5Vlsg5kSGEh4Ne3MIUQYIBqWRY0eIxskHEjTpyD5i2p0E7ElwfGYDHX2iejU9hXsxIHZxaQdc/JYEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034733; c=relaxed/simple;
	bh=NatyLyXKs+yiNs5bqnJFSpWedM0tJl5oqRKJgtwhQqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pze5Ia9XRa+HutxWX7ip14BHzbk2kpVKO+mXofZjA01QtZuZ9sjV9GwkUnLHhvli6qmCfTkURJzzXSTtyrLWyxeW4fvKsrgfTuRyY7TYYMaClYTnkRu1IMFd7xCs873AuO2GFc8AfzzskJE/fqXA+oRhBzAOF3hVRhJLT/Zelw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nsjg4LyK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718034727;
	bh=NatyLyXKs+yiNs5bqnJFSpWedM0tJl5oqRKJgtwhQqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nsjg4LyKjaVzriGrJXecnHSN97iyV6q59o0zQjnttCQ/hLw5q6yk6AkBkrNBEgRyv
	 SOZjPElYfP4jxQdTqGijWqPyVxuht6pEFY6GJwPOibJguJ/IgttqxwjWhS5zKAB7dH
	 e9b2j5+3Kk5p//0t2T2sisHEI0aOZZmZGXSqkd9Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 10 Jun 2024 17:51:09 +0200
Subject: [PATCH v3 4/5] power: supply: add ChromeOS EC based charge control
 driver
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240610-cros_ec-charge-control-v3-4-135e37252094@weissschuh.net>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
In-Reply-To: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Matt Hartley <matt.hartley@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718034726; l=13956;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=NatyLyXKs+yiNs5bqnJFSpWedM0tJl5oqRKJgtwhQqM=;
 b=pyMNckCXdUqr/3JkwDcFJcn4gln4nA/jprQJEILnrgHz95OMDn21Q7nJNLWO9e7QWkC/G+4fb
 ma2ezMiLlMLCnz5AtyL4Af41PLNlrcNbSZwmxpEDHxfoqtOjnMeBgvA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The ChromeOS Embedded Controller implements a command to control charge
thresholds and behaviour.

Use it to implement the standard Linux charge_control_start_threshold,
charge_control_end_threshold and charge_behaviour sysfs UAPIs.

The driver is designed to be probed via the cros_ec mfd device.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS                                |   6 +
 drivers/power/supply/Kconfig               |  12 +
 drivers/power/supply/Makefile              |   1 +
 drivers/power/supply/cros_charge-control.c | 337 +++++++++++++++++++++++++++++
 4 files changed, 356 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4e6aad46668..8101cd0df305 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5135,6 +5135,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
 F:	sound/soc/codecs/cros_ec_codec.*
 
+CHROMEOS EC CHARGE CONTROL
+M:	Thomas Weißschuh <thomas@weissschuh.net>
+S:	Maintained
+F:	drivers/power/supply/cros_charge-control.c
+
 CHROMEOS EC HARDWARE MONITORING
 M:	Thomas Weißschuh <thomas@weissschuh.net>
 L:	chrome-platform@lists.linux.dev
@@ -5148,6 +5153,7 @@ M:	Benson Leung <bleung@chromium.org>
 R:	Guenter Roeck <groeck@chromium.org>
 L:	chrome-platform@lists.linux.dev
 S:	Maintained
+F:	drivers/power/supply/cros_charge-control.c
 F:	drivers/power/supply/cros_usbpd-charger.c
 N:	cros_ec
 N:	cros-ec
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..f6321a42aa53 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -860,6 +860,18 @@ config CHARGER_CROS_PCHG
 	  the peripheral charge ports from the EC and converts that into
 	  power_supply properties.
 
+config CHARGER_CROS_CONTROL
+	tristate "ChromeOS EC based charge control"
+	depends on MFD_CROS_EC_DEV
+	depends on ACPI_BATTERY
+	default MFD_CROS_EC_DEV
+	help
+	  Say Y here to enable ChromeOS EC based battery charge control.
+	  This driver can manage charge thresholds and behaviour.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called cros_charge-control.
+
 config CHARGER_SC2731
 	tristate "Spreadtrum SC2731 charger driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..31ca6653a564 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
 obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
 obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
 obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
+obj-$(CONFIG_CHARGER_CROS_CONTROL)	+= cros_charge-control.o
 obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
new file mode 100644
index 000000000000..056346850c6d
--- /dev/null
+++ b/drivers/power/supply/cros_charge-control.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  ChromeOS EC driver for charge control
+ *
+ *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
+ */
+#include <acpi/battery.h>
+#include <linux/container_of.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#define DRV_NAME	"cros-charge-control"
+
+#define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
+					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)   | \
+					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
+
+enum CROS_CHCTL_ATTR {
+	CROS_CHCTL_ATTR_START_THRESHOLD,
+	CROS_CHCTL_ATTR_END_THRESHOLD,
+	CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR,
+
+	_CROS_CHCTL_ATTR_COUNT,
+};
+
+/*
+ * Semantics of data *returned* from the EC API and Linux sysfs differ
+ * slightly, also the v1 API can not return any data.
+ * To match the expected sysfs API, data is never read back from the EC but
+ * cached in the driver.
+ *
+ * Changes to the EC bypassing the driver will not be reflected in sysfs.
+ * Any change to "charge_behaviour" will synchronize the EC with the driver state.
+ */
+
+struct cros_chctl_priv {
+	struct cros_ec_device *cros_ec;
+	struct acpi_battery_hook battery_hook;
+	struct power_supply *hooked_battery;
+	u8 cmd_version;
+
+	/* The callbacks need to access this priv structure.
+	 * As neither the struct device nor power_supply are under the drivers
+	 * control, embed the attributes within priv to use with container_of().
+	 */
+	struct device_attribute device_attrs[_CROS_CHCTL_ATTR_COUNT];
+	struct attribute *attributes[_CROS_CHCTL_ATTR_COUNT];
+	struct attribute_group group;
+
+	enum power_supply_charge_behaviour current_behaviour;
+	u8 current_start_threshold, current_end_threshold;
+};
+
+static int cros_chctl_send_charge_control_cmd(struct cros_ec_device *cros_ec,
+					      u8 cmd_version, struct ec_params_charge_control *req)
+{
+	static const u8 outsizes[] = {
+		[1] = offsetof(struct ec_params_charge_control, cmd),
+		[2] = sizeof(struct ec_params_charge_control),
+		[3] = sizeof(struct ec_params_charge_control),
+	};
+
+	struct {
+		struct cros_ec_command msg;
+		union {
+			struct ec_params_charge_control req;
+			struct ec_response_charge_control resp;
+		} __packed data;
+	} __packed buf = {
+		.msg = {
+			.command = EC_CMD_CHARGE_CONTROL,
+			.version = cmd_version,
+			.insize  = 0,
+			.outsize = outsizes[cmd_version],
+		},
+		.data.req = *req,
+	};
+
+	return cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
+}
+
+static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
+{
+	struct ec_params_charge_control req = { };
+
+	req.cmd = EC_CHARGE_CONTROL_CMD_SET;
+
+	switch (priv->current_behaviour) {
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+		req.mode = CHARGE_CONTROL_NORMAL;
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+		req.mode = CHARGE_CONTROL_IDLE;
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
+		req.mode = CHARGE_CONTROL_DISCHARGE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (priv->current_behaviour == POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO &&
+	    !(priv->current_start_threshold == 0 && priv->current_end_threshold == 100)) {
+		req.sustain_soc.lower = priv->current_start_threshold;
+		req.sustain_soc.upper = priv->current_end_threshold;
+	} else {
+		/* Disable charging limits */
+		req.sustain_soc.lower = -1;
+		req.sustain_soc.upper = -1;
+	}
+
+	return cros_chctl_send_charge_control_cmd(priv->cros_ec, priv->cmd_version, &req);
+}
+
+static struct cros_chctl_priv *cros_chctl_attr_to_priv(struct attribute *attr,
+						       enum CROS_CHCTL_ATTR idx)
+{
+	struct device_attribute *dev_attr = container_of(attr, struct device_attribute, attr);
+
+	return container_of(dev_attr, struct cros_chctl_priv, device_attrs[idx]);
+}
+
+static ssize_t cros_chctl_store_threshold(struct device *dev, struct cros_chctl_priv *priv,
+					  int is_end_threshold, const char *buf, size_t count)
+{
+	int ret, val;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+	if (val < 0 || val > 100)
+		return -EINVAL;
+
+	if (is_end_threshold) {
+		if (val <= priv->current_start_threshold)
+			return -EINVAL;
+		priv->current_end_threshold = val;
+	} else {
+		if (val >= priv->current_end_threshold)
+			return -EINVAL;
+		priv->current_start_threshold = val;
+	}
+
+	if (priv->current_behaviour == POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) {
+		ret = cros_chctl_configure_ec(priv);
+		if (ret < 0)
+			return ret;
+	}
+
+	return count;
+}
+
+static ssize_t charge_control_start_threshold_show(struct device *dev,
+						   struct device_attribute *attr,
+						   char *buf)
+{
+	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
+							       CROS_CHCTL_ATTR_START_THRESHOLD);
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_start_threshold);
+}
+
+static ssize_t charge_control_start_threshold_store(struct device *dev,
+						    struct device_attribute *attr,
+						    const char *buf, size_t count)
+{
+	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
+							       CROS_CHCTL_ATTR_START_THRESHOLD);
+
+	return cros_chctl_store_threshold(dev, priv, 0, buf, count);
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev, struct device_attribute *attr,
+						 char *buf)
+{
+	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
+							       CROS_CHCTL_ATTR_END_THRESHOLD);
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_end_threshold);
+}
+
+static ssize_t charge_control_end_threshold_store(struct device *dev, struct device_attribute *attr,
+						  const char *buf, size_t count)
+{
+	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
+							       CROS_CHCTL_ATTR_END_THRESHOLD);
+
+	return cros_chctl_store_threshold(dev, priv, 1, buf, count);
+}
+
+static ssize_t charge_behaviour_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
+							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
+
+	return power_supply_charge_behaviour_show(dev, EC_CHARGE_CONTROL_BEHAVIOURS,
+						  priv->current_behaviour, buf);
+}
+
+static ssize_t charge_behaviour_store(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
+							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
+	enum power_supply_charge_behaviour behaviour;
+	int ret;
+
+	behaviour = power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEHAVIOURS, buf);
+	if (behaviour < 0)
+		return behaviour;
+
+	priv->current_behaviour = behaviour;
+
+	ret = cros_chctl_configure_ec(priv);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static umode_t cros_chtl_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(attr, n);
+
+	if (priv->cmd_version < 2) {
+		if (n == CROS_CHCTL_ATTR_START_THRESHOLD)
+			return 0;
+		if (n == CROS_CHCTL_ATTR_END_THRESHOLD)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static int cros_chctl_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	struct cros_chctl_priv *priv = container_of(hook, struct cros_chctl_priv, battery_hook);
+
+	if (priv->hooked_battery)
+		return 0;
+
+	priv->hooked_battery = battery;
+	return device_add_group(&battery->dev, &priv->group);
+}
+
+static int cros_chctl_remove_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	struct cros_chctl_priv *priv = container_of(hook, struct cros_chctl_priv, battery_hook);
+
+	if (priv->hooked_battery == battery) {
+		device_remove_group(&battery->dev, &priv->group);
+		priv->hooked_battery = NULL;
+	}
+
+	return 0;
+}
+
+static int cros_chctl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
+	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
+	struct cros_chctl_priv *priv;
+	size_t i;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = cros_ec_cmd_versions(cros_ec, EC_CMD_CHARGE_CONTROL);
+	if (ret < 0)
+		return ret;
+	else if (ret & EC_VER_MASK(3))
+		priv->cmd_version = 3;
+	else if (ret & EC_VER_MASK(2))
+		priv->cmd_version = 2;
+	else if (ret & EC_VER_MASK(1))
+		priv->cmd_version = 1;
+	else
+		return -ENODEV;
+
+	dev_dbg(dev, "Command version: %u\n", (unsigned int)priv->cmd_version);
+
+	priv->cros_ec = cros_ec;
+	priv->device_attrs[CROS_CHCTL_ATTR_START_THRESHOLD] =
+		(struct device_attribute)__ATTR_RW(charge_control_start_threshold);
+	priv->device_attrs[CROS_CHCTL_ATTR_END_THRESHOLD] =
+		(struct device_attribute)__ATTR_RW(charge_control_end_threshold);
+	priv->device_attrs[CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR] =
+		(struct device_attribute)__ATTR_RW(charge_behaviour);
+	for (i = 0; i < _CROS_CHCTL_ATTR_COUNT; i++) {
+		sysfs_attr_init(&priv->device_attrs[i].attr);
+		priv->attributes[i] = &priv->device_attrs[i].attr;
+	}
+	priv->attributes[_CROS_CHCTL_ATTR_COUNT] = NULL;
+	priv->group.is_visible = cros_chtl_attr_is_visible;
+	priv->group.attrs = priv->attributes;
+
+	priv->battery_hook.name = dev_name(dev),
+	priv->battery_hook.add_battery = cros_chctl_add_battery,
+	priv->battery_hook.remove_battery = cros_chctl_remove_battery,
+
+	priv->current_behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+	priv->current_start_threshold = 0;
+	priv->current_end_threshold = 100;
+
+	/* Bring EC into well-known state */
+	ret = cros_chctl_configure_ec(priv);
+	if (ret == -EOPNOTSUPP)
+		return -ENODEV;
+	else if (ret < 0)
+		return ret;
+
+	return devm_battery_hook_register(dev, &priv->battery_hook);
+}
+
+static const struct platform_device_id cros_chctl_id[] = {
+	{ DRV_NAME, 0 },
+	{ }
+};
+
+static struct platform_driver cros_chctl_driver = {
+	.driver.name	= DRV_NAME,
+	.probe		= cros_chctl_probe,
+	.id_table	= cros_chctl_id,
+};
+module_platform_driver(cros_chctl_driver);
+
+MODULE_DEVICE_TABLE(platform, cros_chctl_id);
+MODULE_DESCRIPTION("ChromeOS EC charge control");
+MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
+MODULE_LICENSE("GPL");

-- 
2.45.2


