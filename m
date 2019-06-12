Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB541F4E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2019 10:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfFLIgl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jun 2019 04:36:41 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:43446 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfFLIgk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2019 04:36:40 -0400
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 5473B4D07F;
        Wed, 12 Jun 2019 10:36:38 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nv@vosn.de
Subject: [PATCH v2 2/3] PWM framework: add support referencing PWMs from ACPI
Date:   Wed, 12 Jun 2019 10:36:07 +0200
Message-Id: <68c51a7af257b5c6d4f7d1b95b181b920132a64d.1560327219.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In analogy to referencing a GPIO using the "gpios" property from ACPI,
support referencing a PWM using the "pwms" property.

ACPI entries must look like
 Package () {"pwms", Package ()
     { <PWM device reference>, <PWM index>, <PWM period> [, <PWM flags>]}}

In contrast to the DT implementation, only _one_ PWM entry in the "pwms"
property is supported. As a consequence "pwm-names"-property and
con_id lookup aren't supported.

Support for ACPI is added via the firmware-node framework which is an
abstraction layer on top of ACPI/DT. To keep this patch clean, DT and
ACPI paths are kept separate. The firmware-node framework could be used
to unify both paths in a future patch.

To support leds-pwm driver, an additional method devm_fwnode_pwm_get()
which supports both ACPI and DT configuration is exported.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/pwm/core.c  | 113 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h |   9 ++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 275b5f399a1a..5fed419d0833 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2011-2012 Avionic Design GmbH
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/pwm.h>
 #include <linux/radix-tree.h>
@@ -700,6 +701,76 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 }
 EXPORT_SYMBOL_GPL(of_pwm_get);
 
+static struct pwm_chip *device_to_pwmchip(struct device *dev)
+{
+	struct pwm_chip *chip;
+
+	mutex_lock(&pwm_lock);
+
+	list_for_each_entry(chip, &pwm_chips, list) {
+		struct acpi_device *adev = ACPI_COMPANION(chip->dev);
+
+		if ((chip->dev == dev) || (adev && &adev->dev == dev)) {
+			mutex_unlock(&pwm_lock);
+			return chip;
+		}
+	}
+
+	mutex_unlock(&pwm_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * acpi_pwm_get() - request a PWM via parsing "pwms" property in ACPI
+ * @fwnode: firmware node to get the "pwm" property from
+ *
+ * Returns the PWM device parsed from the fwnode and index specified in the
+ * "pwms" property or a negative error-code on failure.
+ * Values parsed from the device tree are stored in the returned PWM device
+ * object.
+ *
+ * This is analogous to of_pwm_get() except con_id is not yet supported.
+ * ACPI entries must look like
+ * Package () {"pwms", Package ()
+ *     { <PWM device reference>, <PWM index>, <PWM period> [, <PWM flags>]}}
+ *
+ * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
+ * error code on failure.
+ */
+static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
+{
+	struct fwnode_reference_args args;
+	struct pwm_chip *chip;
+	struct pwm_device *pwm = ERR_PTR(-ENODEV);
+	int ret;
+
+	memset(&args, 0, sizeof(args));
+	ret = __acpi_node_get_property_reference(fwnode, "pwms", 0, 3, &args);
+
+	if (!to_acpi_device_node(args.fwnode))
+		return ERR_PTR(-EINVAL);
+
+	if (args.nargs < 2)
+		return ERR_PTR(-EPROTO);
+
+	chip = device_to_pwmchip(&to_acpi_device_node(args.fwnode)->dev);
+	if (IS_ERR(chip))
+		return ERR_CAST(chip);
+
+	pwm = pwm_request_from_chip(chip, args.args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.period = args.args[1];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+
+	if (args.nargs > 2 && args.args[2] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+	return pwm;
+}
+
 /**
  * pwm_add_table() - register PWM device consumers
  * @table: array of consumers to register
@@ -763,6 +834,10 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
 		return of_pwm_get(dev->of_node, con_id);
 
+	/* then lookup via ACPI */
+	if (dev && is_acpi_node(dev->fwnode))
+		return acpi_pwm_get(dev->fwnode);
+
 	/*
 	 * We look up the provider in the static table typically provided by
 	 * board setup code. We first try to lookup the consumer device by
@@ -942,6 +1017,44 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(devm_of_pwm_get);
 
+/**
+ * devm_fwnode_pwm_get() - request a resource managed PWM from firmware node
+ * @dev: device for PWM consumer
+ * @fwnode: firmware node to get the PWM from
+ * @con_id: consumer name
+ *
+ * Returns the PWM device parsed from the firmware node. See of_pwm_get() and
+ * acpi_pwm_get() for a detailed description.
+ *
+ * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
+ * error code on failure.
+ */
+struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
+				       struct fwnode_handle *fwnode,
+				       const char *con_id)
+{
+	struct pwm_device **ptr, *pwm = ERR_PTR(-ENODEV);
+
+	ptr = devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	if (is_of_node(fwnode))
+		pwm = of_pwm_get(to_of_node(fwnode), con_id);
+	else if (is_acpi_node(fwnode))
+		pwm = acpi_pwm_get(fwnode);
+
+	if (!IS_ERR(pwm)) {
+		*ptr = pwm;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(devm_fwnode_pwm_get);
+
 static int devm_pwm_match(struct device *dev, void *res, void *data)
 {
 	struct pwm_device **p = res;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index eaa5c6e3fc9f..1a635916cdfb 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -411,6 +411,9 @@ void pwm_put(struct pwm_device *pwm);
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 				   const char *con_id);
+struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
+				       struct fwnode_handle *fwnode,
+				       const char *con_id);
 void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
 #else
 static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
@@ -516,6 +519,12 @@ static inline struct pwm_device *devm_of_pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct pwm_device *devm_fwnode_pwm_get(
+	struct device *dev, struct fwnode_handle *fwnode, const char *con_id)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
 {
 }
-- 
2.17.1

