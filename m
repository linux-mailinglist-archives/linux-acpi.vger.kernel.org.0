Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB030FE8
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfEaOQO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 10:16:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:8345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfEaOQN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 10:16:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:16:12 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 07:16:10 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 10/16] usb: typec: Registering real device entries for the muxes
Date:   Fri, 31 May 2019 17:15:41 +0300
Message-Id: <20190531141547.22728-11-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Registering real device entries (struct device) for the mode
muxes as well as for the orientation switches.

The Type-C mux code was deliberately attempting to avoid
creation of separate device entries for the orientation
switch and the mode switch (alternate modes) because they
are not physical devices. They are functions of a single
physical multiplexer/demultiplexer switch device.

Unfortunately because of the dependency we still have on the
underlying mux device driver, we had to put in hacks like
the one in the commit 3e3b81965cbf ("usb: typec: mux: Take
care of driver module reference counting") to make sure the
driver does not disappear from underneath us. Even with
those hacks we were still left with a potential NUll pointer
dereference scenario, so just creating the device entries,
and letting the core take care of the dependencies. No more
hacks needed.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c |   4 +-
 drivers/usb/typec/bus.h                  |  15 ++
 drivers/usb/typec/class.c                |  17 +-
 drivers/usb/typec/mux.c                  | 238 ++++++++++++++++-------
 drivers/usb/typec/mux/pi3usb30532.c      |  46 +++--
 include/linux/usb/typec_mux.h            |  62 +++---
 6 files changed, 259 insertions(+), 123 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 6fa3cced6f8e..657b8d61554c 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -173,10 +173,10 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	}
 
 	data->connections[0].endpoint[0] = "port0";
-	data->connections[0].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
 	data->connections[0].id = "orientation-switch";
 	data->connections[1].endpoint[0] = "port0";
-	data->connections[1].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[1].endpoint[1] = "i2c-pi3usb30532-mux";
 	data->connections[1].id = "mode-switch";
 	data->connections[2].endpoint[0] = "i2c-fusb302";
 	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
index db40e61d8b72..0c9661c96473 100644
--- a/drivers/usb/typec/bus.h
+++ b/drivers/usb/typec/bus.h
@@ -35,4 +35,19 @@ extern const struct device_type typec_port_dev_type;
 #define is_typec_altmode(_dev_) (_dev_->type == &typec_altmode_dev_type)
 #define is_typec_port(_dev_) (_dev_->type == &typec_port_dev_type)
 
+extern struct class typec_mux_class;
+
+struct typec_switch {
+	struct device dev;
+	typec_switch_set_fn_t set;
+};
+
+struct typec_mux {
+	struct device dev;
+	typec_mux_set_fn_t set;
+};
+
+#define to_typec_switch(_dev_) container_of(_dev_, struct typec_switch, dev)
+#define to_typec_mux(_dev_) container_of(_dev_, struct typec_mux, dev)
+
 #endif /* __USB_TYPEC_ALTMODE_H__ */
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 2eb623841847..a18285a990a8 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1646,13 +1646,25 @@ static int __init typec_init(void)
 	if (ret)
 		return ret;
 
+	ret = class_register(&typec_mux_class);
+	if (ret)
+		goto err_unregister_bus;
+
 	typec_class = class_create(THIS_MODULE, "typec");
 	if (IS_ERR(typec_class)) {
-		bus_unregister(&typec_bus);
-		return PTR_ERR(typec_class);
+		ret = PTR_ERR(typec_class);
+		goto err_unregister_mux_class;
 	}
 
 	return 0;
+
+err_unregister_mux_class:
+	class_unregister(&typec_mux_class);
+
+err_unregister_bus:
+	bus_unregister(&typec_bus);
+
+	return ret;
 }
 subsys_initcall(typec_init);
 
@@ -1661,6 +1673,7 @@ static void __exit typec_exit(void)
 	class_destroy(typec_class);
 	ida_destroy(&typec_index_ida);
 	bus_unregister(&typec_bus);
+	class_unregister(&typec_mux_class);
 }
 module_exit(typec_exit);
 
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 2ce54f3fc79c..61b7bc58dd81 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -15,35 +15,47 @@
 #include <linux/slab.h>
 #include <linux/usb/typec_mux.h>
 
-static DEFINE_MUTEX(switch_lock);
-static DEFINE_MUTEX(mux_lock);
-static LIST_HEAD(switch_list);
-static LIST_HEAD(mux_list);
+#include "bus.h"
+
+static int name_match(struct device *dev, const void *name)
+{
+	return !strcmp((const char *)name, dev_name(dev));
+}
+
+static bool dev_name_ends_with(struct device *dev, const char *suffix)
+{
+	const char *name = dev_name(dev);
+	const int name_len = strlen(name);
+	const int suffix_len = strlen(suffix);
+
+	if (suffix_len > name_len)
+		return false;
+
+	return strcmp(name + (name_len - suffix_len), suffix) == 0;
+}
+
+static int switch_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-switch");
+}
 
 static void *typec_switch_match(struct device_connection *con, int ep,
 				void *data)
 {
-	struct typec_switch *sw;
-
-	if (!con->fwnode) {
-		list_for_each_entry(sw, &switch_list, entry)
-			if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
-				return sw;
-		return ERR_PTR(-EPROBE_DEFER);
-	}
+	struct device *dev;
 
-	/*
-	 * With OF graph the mux node must have a boolean device property named
-	 * "orientation-switch".
-	 */
-	if (con->id && !fwnode_property_present(con->fwnode, con->id))
-		return NULL;
+	if (con->fwnode) {
+		if (con->id && !fwnode_property_present(con->fwnode, con->id))
+			return NULL;
 
-	list_for_each_entry(sw, &switch_list, entry)
-		if (dev_fwnode(sw->dev) == con->fwnode)
-			return sw;
+		dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
+					switch_fwnode_match);
+	} else {
+		dev = class_find_device(&typec_mux_class, NULL,
+					con->endpoint[ep], name_match);
+	}
 
-	return con->id ? ERR_PTR(-EPROBE_DEFER) : NULL;
+	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
 /**
@@ -59,14 +71,10 @@ struct typec_switch *typec_switch_get(struct device *dev)
 {
 	struct typec_switch *sw;
 
-	mutex_lock(&switch_lock);
 	sw = device_connection_find_match(dev, "orientation-switch", NULL,
 					  typec_switch_match);
-	if (!IS_ERR_OR_NULL(sw)) {
-		WARN_ON(!try_module_get(sw->dev->driver->owner));
-		get_device(sw->dev);
-	}
-	mutex_unlock(&switch_lock);
+	if (!IS_ERR_OR_NULL(sw))
+		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
 
 	return sw;
 }
@@ -81,28 +89,64 @@ EXPORT_SYMBOL_GPL(typec_switch_get);
 void typec_switch_put(struct typec_switch *sw)
 {
 	if (!IS_ERR_OR_NULL(sw)) {
-		module_put(sw->dev->driver->owner);
-		put_device(sw->dev);
+		module_put(sw->dev.parent->driver->owner);
+		put_device(&sw->dev);
 	}
 }
 EXPORT_SYMBOL_GPL(typec_switch_put);
 
+static void typec_switch_release(struct device *dev)
+{
+	kfree(to_typec_switch(dev));
+}
+
+static const struct device_type typec_switch_dev_type = {
+	.name = "orientation_switch",
+	.release = typec_switch_release,
+};
+
 /**
  * typec_switch_register - Register USB Type-C orientation switch
- * @sw: USB Type-C orientation switch
+ * @parent: Parent device
+ * @desc: Orientation switch description
  *
  * This function registers a switch that can be used for routing the correct
  * data pairs depending on the cable plug orientation from the USB Type-C
  * connector to the USB controllers. USB Type-C plugs can be inserted
  * right-side-up or upside-down.
  */
-int typec_switch_register(struct typec_switch *sw)
+struct typec_switch *
+typec_switch_register(struct device *parent,
+		      const struct typec_switch_desc *desc)
 {
-	mutex_lock(&switch_lock);
-	list_add_tail(&sw->entry, &switch_list);
-	mutex_unlock(&switch_lock);
+	struct typec_switch *sw;
+	int ret;
+
+	if (!desc || !desc->set)
+		return ERR_PTR(-EINVAL);
+
+	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
+	if (!sw)
+		return ERR_PTR(-ENOMEM);
 
-	return 0;
+	sw->set = desc->set;
+
+	device_initialize(&sw->dev);
+	sw->dev.parent = parent;
+	sw->dev.fwnode = desc->fwnode;
+	sw->dev.class = &typec_mux_class;
+	sw->dev.type = &typec_switch_dev_type;
+	sw->dev.driver_data = desc->drvdata;
+	dev_set_name(&sw->dev, "%s-switch", dev_name(parent));
+
+	ret = device_add(&sw->dev);
+	if (ret) {
+		dev_err(parent, "failed to register switch (%d)\n", ret);
+		put_device(&sw->dev);
+		return ERR_PTR(ret);
+	}
+
+	return sw;
 }
 EXPORT_SYMBOL_GPL(typec_switch_register);
 
@@ -114,28 +158,44 @@ EXPORT_SYMBOL_GPL(typec_switch_register);
  */
 void typec_switch_unregister(struct typec_switch *sw)
 {
-	mutex_lock(&switch_lock);
-	list_del(&sw->entry);
-	mutex_unlock(&switch_lock);
+	if (!IS_ERR_OR_NULL(sw))
+		device_unregister(&sw->dev);
 }
 EXPORT_SYMBOL_GPL(typec_switch_unregister);
 
+void typec_switch_set_drvdata(struct typec_switch *sw, void *data)
+{
+	dev_set_drvdata(&sw->dev, data);
+}
+EXPORT_SYMBOL_GPL(typec_switch_set_drvdata);
+
+void *typec_switch_get_drvdata(struct typec_switch *sw)
+{
+	return dev_get_drvdata(&sw->dev);
+}
+EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
+
 /* ------------------------------------------------------------------------- */
 
+static int mux_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-mux");
+}
+
 static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 {
 	const struct typec_altmode_desc *desc = data;
-	struct typec_mux *mux;
-	int nval;
+	struct device *dev;
 	bool match;
+	int nval;
 	u16 *val;
 	int i;
 
 	if (!con->fwnode) {
-		list_for_each_entry(mux, &mux_list, entry)
-			if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
-				return mux;
-		return ERR_PTR(-EPROBE_DEFER);
+		dev = class_find_device(&typec_mux_class, NULL,
+					con->endpoint[ep], name_match);
+
+		return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 	}
 
 	/*
@@ -180,11 +240,10 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 	return NULL;
 
 find_mux:
-	list_for_each_entry(mux, &mux_list, entry)
-		if (dev_fwnode(mux->dev) == con->fwnode)
-			return mux;
+	dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
+				mux_fwnode_match);
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
 /**
@@ -202,14 +261,10 @@ struct typec_mux *typec_mux_get(struct device *dev,
 {
 	struct typec_mux *mux;
 
-	mutex_lock(&mux_lock);
 	mux = device_connection_find_match(dev, "mode-switch", (void *)desc,
 					   typec_mux_match);
-	if (!IS_ERR_OR_NULL(mux)) {
-		WARN_ON(!try_module_get(mux->dev->driver->owner));
-		get_device(mux->dev);
-	}
-	mutex_unlock(&mux_lock);
+	if (!IS_ERR_OR_NULL(mux))
+		WARN_ON(!try_module_get(mux->dev.parent->driver->owner));
 
 	return mux;
 }
@@ -224,28 +279,63 @@ EXPORT_SYMBOL_GPL(typec_mux_get);
 void typec_mux_put(struct typec_mux *mux)
 {
 	if (!IS_ERR_OR_NULL(mux)) {
-		module_put(mux->dev->driver->owner);
-		put_device(mux->dev);
+		module_put(mux->dev.parent->driver->owner);
+		put_device(&mux->dev);
 	}
 }
 EXPORT_SYMBOL_GPL(typec_mux_put);
 
+static void typec_mux_release(struct device *dev)
+{
+	kfree(to_typec_mux(dev));
+}
+
+static const struct device_type typec_mux_dev_type = {
+	.name = "mode_switch",
+	.release = typec_mux_release,
+};
+
 /**
  * typec_mux_register - Register Multiplexer routing USB Type-C pins
- * @mux: USB Type-C Connector Multiplexer/DeMultiplexer
+ * @parent: Parent device
+ * @desc: Multiplexer description
  *
  * USB Type-C connectors can be used for alternate modes of operation besides
  * USB when Accessory/Alternate Modes are supported. With some of those modes,
  * the pins on the connector need to be reconfigured. This function registers
  * multiplexer switches routing the pins on the connector.
  */
-int typec_mux_register(struct typec_mux *mux)
+struct typec_mux *
+typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
 {
-	mutex_lock(&mux_lock);
-	list_add_tail(&mux->entry, &mux_list);
-	mutex_unlock(&mux_lock);
+	struct typec_mux *mux;
+	int ret;
+
+	if (!desc || !desc->set)
+		return ERR_PTR(-EINVAL);
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	mux->set = desc->set;
+
+	device_initialize(&mux->dev);
+	mux->dev.parent = parent;
+	mux->dev.fwnode = desc->fwnode;
+	mux->dev.class = &typec_mux_class;
+	mux->dev.type = &typec_mux_dev_type;
+	mux->dev.driver_data = desc->drvdata;
+	dev_set_name(&mux->dev, "%s-mux", dev_name(parent));
+
+	ret = device_add(&mux->dev);
+	if (ret) {
+		dev_err(parent, "failed to register mux (%d)\n", ret);
+		put_device(&mux->dev);
+		return ERR_PTR(ret);
+	}
 
-	return 0;
+	return mux;
 }
 EXPORT_SYMBOL_GPL(typec_mux_register);
 
@@ -257,8 +347,24 @@ EXPORT_SYMBOL_GPL(typec_mux_register);
  */
 void typec_mux_unregister(struct typec_mux *mux)
 {
-	mutex_lock(&mux_lock);
-	list_del(&mux->entry);
-	mutex_unlock(&mux_lock);
+	if (!IS_ERR_OR_NULL(mux))
+		device_unregister(&mux->dev);
 }
 EXPORT_SYMBOL_GPL(typec_mux_unregister);
+
+void typec_mux_set_drvdata(struct typec_mux *mux, void *data)
+{
+	dev_set_drvdata(&mux->dev, data);
+}
+EXPORT_SYMBOL_GPL(typec_mux_set_drvdata);
+
+void *typec_mux_get_drvdata(struct typec_mux *mux)
+{
+	return dev_get_drvdata(&mux->dev);
+}
+EXPORT_SYMBOL_GPL(typec_mux_get_drvdata);
+
+struct class typec_mux_class = {
+	.name = "typec_mux",
+	.owner = THIS_MODULE,
+};
diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
index 9294e85fd34b..5585b109095b 100644
--- a/drivers/usb/typec/mux/pi3usb30532.c
+++ b/drivers/usb/typec/mux/pi3usb30532.c
@@ -23,8 +23,8 @@
 struct pi3usb30532 {
 	struct i2c_client *client;
 	struct mutex lock; /* protects the cached conf register */
-	struct typec_switch sw;
-	struct typec_mux mux;
+	struct typec_switch *sw;
+	struct typec_mux *mux;
 	u8 conf;
 };
 
@@ -48,7 +48,7 @@ static int pi3usb30532_set_conf(struct pi3usb30532 *pi, u8 new_conf)
 static int pi3usb30532_sw_set(struct typec_switch *sw,
 			      enum typec_orientation orientation)
 {
-	struct pi3usb30532 *pi = container_of(sw, struct pi3usb30532, sw);
+	struct pi3usb30532 *pi = typec_switch_get_drvdata(sw);
 	u8 new_conf;
 	int ret;
 
@@ -75,7 +75,7 @@ static int pi3usb30532_sw_set(struct typec_switch *sw,
 
 static int pi3usb30532_mux_set(struct typec_mux *mux, int state)
 {
-	struct pi3usb30532 *pi = container_of(mux, struct pi3usb30532, mux);
+	struct pi3usb30532 *pi = typec_mux_get_drvdata(mux);
 	u8 new_conf;
 	int ret;
 
@@ -113,6 +113,8 @@ static int pi3usb30532_mux_set(struct typec_mux *mux, int state)
 static int pi3usb30532_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct typec_switch_desc sw_desc;
+	struct typec_mux_desc mux_desc;
 	struct pi3usb30532 *pi;
 	int ret;
 
@@ -121,10 +123,6 @@ static int pi3usb30532_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	pi->client = client;
-	pi->sw.dev = dev;
-	pi->sw.set = pi3usb30532_sw_set;
-	pi->mux.dev = dev;
-	pi->mux.set = pi3usb30532_mux_set;
 	mutex_init(&pi->lock);
 
 	ret = i2c_smbus_read_byte_data(client, PI3USB30532_CONF);
@@ -134,17 +132,27 @@ static int pi3usb30532_probe(struct i2c_client *client)
 	}
 	pi->conf = ret;
 
-	ret = typec_switch_register(&pi->sw);
-	if (ret) {
-		dev_err(dev, "Error registering typec switch: %d\n", ret);
-		return ret;
+	sw_desc.drvdata = pi;
+	sw_desc.fwnode = dev->fwnode;
+	sw_desc.set = pi3usb30532_sw_set;
+
+	pi->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(pi->sw)) {
+		dev_err(dev, "Error registering typec switch: %ld\n",
+			PTR_ERR(pi->sw));
+		return PTR_ERR(pi->sw);
 	}
 
-	ret = typec_mux_register(&pi->mux);
-	if (ret) {
-		typec_switch_unregister(&pi->sw);
-		dev_err(dev, "Error registering typec mux: %d\n", ret);
-		return ret;
+	mux_desc.drvdata = pi;
+	mux_desc.fwnode = dev->fwnode;
+	mux_desc.set = pi3usb30532_mux_set;
+
+	pi->mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(pi->mux)) {
+		typec_switch_unregister(pi->sw);
+		dev_err(dev, "Error registering typec mux: %ld\n",
+			PTR_ERR(pi->mux));
+		return PTR_ERR(pi->mux);
 	}
 
 	i2c_set_clientdata(client, pi);
@@ -155,8 +163,8 @@ static int pi3usb30532_remove(struct i2c_client *client)
 {
 	struct pi3usb30532 *pi = i2c_get_clientdata(client);
 
-	typec_mux_unregister(&pi->mux);
-	typec_switch_unregister(&pi->sw);
+	typec_mux_unregister(pi->mux);
+	typec_switch_unregister(pi->sw);
 	return 0;
 }
 
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 43f40685e53c..873ace5b0cf8 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -3,54 +3,48 @@
 #ifndef __USB_TYPEC_MUX
 #define __USB_TYPEC_MUX
 
-#include <linux/list.h>
 #include <linux/usb/typec.h>
 
 struct device;
+struct typec_mux;
+struct typec_switch;
+struct fwnode_handle;
 
-/**
- * struct typec_switch - USB Type-C cable orientation switch
- * @dev: Switch device
- * @entry: List entry
- * @set: Callback to the driver for setting the orientation
- *
- * USB Type-C pin flipper switch routing the correct data pairs from the
- * connector to the USB controller depending on the orientation of the cable
- * plug.
- */
-struct typec_switch {
-	struct device *dev;
-	struct list_head entry;
-
-	int (*set)(struct typec_switch *sw, enum typec_orientation orientation);
-};
+typedef int (*typec_switch_set_fn_t)(struct typec_switch *sw,
+				     enum typec_orientation orientation);
 
-/**
- * struct typec_switch - USB Type-C connector pin mux
- * @dev: Mux device
- * @entry: List entry
- * @set: Callback to the driver for setting the state of the mux
- *
- * Pin Multiplexer/DeMultiplexer switch routing the USB Type-C connector pins to
- * different components depending on the requested mode of operation. Used with
- * Accessory/Alternate modes.
- */
-struct typec_mux {
-	struct device *dev;
-	struct list_head entry;
-
-	int (*set)(struct typec_mux *mux, int state);
+struct typec_switch_desc {
+	struct fwnode_handle *fwnode;
+	typec_switch_set_fn_t set;
+	void *drvdata;
 };
 
 struct typec_switch *typec_switch_get(struct device *dev);
 void typec_switch_put(struct typec_switch *sw);
-int typec_switch_register(struct typec_switch *sw);
+struct typec_switch *
+typec_switch_register(struct device *parent,
+		      const struct typec_switch_desc *desc);
 void typec_switch_unregister(struct typec_switch *sw);
 
+void typec_switch_set_drvdata(struct typec_switch *sw, void *data);
+void *typec_switch_get_drvdata(struct typec_switch *sw);
+
+typedef int (*typec_mux_set_fn_t)(struct typec_mux *mux, int state);
+
+struct typec_mux_desc {
+	struct fwnode_handle *fwnode;
+	typec_mux_set_fn_t set;
+	void *drvdata;
+};
+
 struct typec_mux *
 typec_mux_get(struct device *dev, const struct typec_altmode_desc *desc);
 void typec_mux_put(struct typec_mux *mux);
-int typec_mux_register(struct typec_mux *mux);
+struct typec_mux *
+typec_mux_register(struct device *parent, const struct typec_mux_desc *desc);
 void typec_mux_unregister(struct typec_mux *mux);
 
+void typec_mux_set_drvdata(struct typec_mux *mux, void *data);
+void *typec_mux_get_drvdata(struct typec_mux *mux);
+
 #endif /* __USB_TYPEC_MUX */
-- 
2.20.1

