Return-Path: <linux-acpi+bounces-10495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D47A080B4
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 20:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CE8188BC35
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857BF1FCF68;
	Thu,  9 Jan 2025 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV2rBhyc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D491FBEB6;
	Thu,  9 Jan 2025 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451749; cv=none; b=TDEqWIz2tOmwTAiWP6pqjFlzkVEgGYQbp89nKk0qkgNwyfHScBmgL5wlzIPiBL9HcxexjM7JDWj/aPbKtqpiVUMwue2InnYw4U/qiYRvL5O+IqVKG5mYtLHnie1A3DvKxM2iIFuu7wHNarokBEJeFxO4z95myZvRzy/wnhzJyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451749; c=relaxed/simple;
	bh=P/AFLAXb4hWHF03R6Fsf5TTOyTk6z5nmszrgJp/DJ/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/Q7Kd9cm3lJ55rwwpCfNWqr5a1nHLHEvJBjs3rsYsmz+WVGKXwUkqdfUi7vI851Pc0KLSsTVjylDmmJwoB5vdV3IR10fBEfmjRlbRA2LwRt27nuTYYJhVJE3bQsFyWvSqbGaBkqmJp+paoYiI/2TPmAUusd7Y/6SzMPiO/O8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV2rBhyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB335C4CEDF;
	Thu,  9 Jan 2025 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736451746;
	bh=P/AFLAXb4hWHF03R6Fsf5TTOyTk6z5nmszrgJp/DJ/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SV2rBhyc9VwDbFJE9nxDTTjdaE8xFN8SQwaKnX0B6HRzKx0gXzQ+Qfv0GXbrTsBh4
	 w2l5m8+yL+Jths1S0RjlAc7ezYgtaaKPSXSqI7ZSYgoWcZVzqwVkblFbeueYJtvmW6
	 suW3/0gSmTXwtA1WpYWeP5iLxlClwlG9fZZX5/RvAm6vfZlXn85mqLfGEIZaOqZuTd
	 90/X8VV5HopK139ozVaEWKl78dwFOVXtG5tkLsplrvnD5/v/ZISJ69aFs9dP21GRQ9
	 ndwqug2+Tz+jepiGzNVoWPJqzGdxLsQTG3AcpbHAj/ccD7yNQJ9AKsPZRmQar2JG4T
	 3a7mhFtepbvAQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 09 Jan 2025 13:42:05 -0600
Subject: [PATCH 1/2] device property: Split property reading bool and
 presence test ops
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-dt-type-warnings-v1-1-0150e32e716c@kernel.org>
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
In-Reply-To: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

The fwnode/device property API currently implement
(fwnode|device)_property_read_bool() with (fwnode|device)_property_present().
That does not allow having different behavior depending on the backend.

Specifically, the usage of (fwnode|device)_property_read_bool() on
non-boolean properties is deprecated on DT. In order to add a warning
on this deprecated use, these 2 APIs need separate ops for the backend.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/acpi/property.c  |  1 +
 drivers/base/property.c  | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/base/swnode.c    |  1 +
 drivers/of/property.c    |  7 +++++++
 include/linux/fwnode.h   |  3 +++
 include/linux/of.h       |  4 +++-
 include/linux/property.h | 15 +++------------
 7 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 80a52a4e66dd167e70c80a164a89beb8c834ae13..8c53959ee31e700004de098bdab21dec118cf111 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1656,6 +1656,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
 			acpi_fwnode_device_dma_supported,		\
 		.device_get_dma_attr = acpi_fwnode_device_get_dma_attr,	\
 		.property_present = acpi_fwnode_property_present,	\
+		.property_read_bool = acpi_fwnode_property_present,	\
 		.property_read_int_array =				\
 			acpi_fwnode_property_read_int_array,		\
 		.property_read_string_array =				\
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 837d77e3af2bd5bf655e6fa0f64c10a05b361b90..c1392743df9c3f6c554f093f4efae3ea1ad1fdf2 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -70,6 +70,44 @@ bool fwnode_property_present(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
+/**
+ * device_property_read_bool - Return the value for a boolean property of a device
+ * @dev: Device whose property is being checked
+ * @propname: Name of the property
+ *
+ * Return if property @propname is true or false in the device firmware description.
+ *
+ * Return: true if property @propname is present. Otherwise, returns false.
+ */
+bool device_property_read_bool(const struct device *dev, const char *propname)
+{
+	return fwnode_property_read_bool(dev_fwnode(dev), propname);
+}
+EXPORT_SYMBOL_GPL(device_property_read_bool);
+
+/**
+ * fwnode_property_read_bool - Return the value for a boolean property of a firmware node
+ * @fwnode: Firmware node whose property to check
+ * @propname: Name of the property
+ *
+ * Return if property @propname is true or false in the firmware description.
+ */
+bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
+			     const char *propname)
+{
+	bool ret;
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
+
+	ret = fwnode_call_bool_op(fwnode, property_read_bool, propname);
+	if (ret)
+		return ret;
+
+	return fwnode_call_bool_op(fwnode->secondary, property_read_bool, propname);
+}
+EXPORT_SYMBOL_GPL(fwnode_property_read_bool);
+
 /**
  * device_property_read_u8_array - return a u8 array property of a device
  * @dev: Device to get the property of
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index eb6eb25b343bafaa9c03f881b98a528305fa6093..b1726a3515f6fbe13c2186af1f74479263798e42 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -677,6 +677,7 @@ static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
 	.put = software_node_put,
 	.property_present = software_node_property_present,
+	.property_read_bool = software_node_property_present,
 	.property_read_int_array = software_node_read_int_array,
 	.property_read_string_array = software_node_read_string_array,
 	.get_name = software_node_get_name,
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 519bf9229e613906547b57d8c68e7b8558eff327..1b46be88cc0498fcbe74e7b988f22a86245c366e 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -965,6 +965,12 @@ of_fwnode_device_get_dma_attr(const struct fwnode_handle *fwnode)
 
 static bool of_fwnode_property_present(const struct fwnode_handle *fwnode,
 				       const char *propname)
+{
+	return of_property_present(to_of_node(fwnode), propname);
+}
+
+static bool of_fwnode_property_read_bool(const struct fwnode_handle *fwnode,
+					 const char *propname)
 {
 	return of_property_read_bool(to_of_node(fwnode), propname);
 }
@@ -1562,6 +1568,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.device_dma_supported = of_fwnode_device_dma_supported,
 	.device_get_dma_attr = of_fwnode_device_get_dma_attr,
 	.property_present = of_fwnode_property_present,
+	.property_read_bool = of_fwnode_property_read_bool,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
 	.get_name = of_fwnode_get_name,
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0d79070c5a70f21e9d73751941f28cefb244950d..0731994b9d7c832cae8a30063f3a64194e4f19aa 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -112,6 +112,7 @@ struct fwnode_reference_args {
  * @device_is_available: Return true if the device is available.
  * @device_get_match_data: Return the device driver match data.
  * @property_present: Return true if a property is present.
+ * @property_read_bool: Return a boolean property value.
  * @property_read_int_array: Read an array of integer properties. Return zero on
  *			     success, a negative error code otherwise.
  * @property_read_string_array: Read an array of string properties. Return zero
@@ -141,6 +142,8 @@ struct fwnode_operations {
 	(*device_get_dma_attr)(const struct fwnode_handle *fwnode);
 	bool (*property_present)(const struct fwnode_handle *fwnode,
 				 const char *propname);
+	bool (*property_read_bool)(const struct fwnode_handle *fwnode,
+				   const char *propname);
 	int (*property_read_int_array)(const struct fwnode_handle *fwnode,
 				       const char *propname,
 				       unsigned int elem_size, void *val,
diff --git a/include/linux/of.h b/include/linux/of.h
index f921786cb8ac782286ed5ff4425a35668204d050..1cb4eb7fc2eded2246c697c3bcaf1b85d43108ab 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1271,7 +1271,9 @@ static inline bool of_property_read_bool(const struct device_node *np,
  */
 static inline bool of_property_present(const struct device_node *np, const char *propname)
 {
-	return of_property_read_bool(np, propname);
+	struct property *prop = of_find_property(np, propname, NULL);
+
+	return prop ? true : false;
 }
 
 /**
diff --git a/include/linux/property.h b/include/linux/property.h
index 61fc20e5f81f8da992aa021996ddf68ef3eff0ed..e214ecd241eb4e6d9e0873d094f2c956bbf66c34 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -37,6 +37,7 @@ struct fwnode_handle *__dev_fwnode(struct device *dev);
 		 struct device *: __dev_fwnode)(dev)
 
 bool device_property_present(const struct device *dev, const char *propname);
+bool device_property_read_bool(const struct device *dev, const char *propname);
 int device_property_read_u8_array(const struct device *dev, const char *propname,
 				  u8 *val, size_t nval);
 int device_property_read_u16_array(const struct device *dev, const char *propname,
@@ -54,6 +55,8 @@ int device_property_match_string(const struct device *dev,
 
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
 			     const char *propname);
+bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
+			     const char *propname);
 int fwnode_property_read_u8_array(const struct fwnode_handle *fwnode,
 				  const char *propname, u8 *val,
 				  size_t nval);
@@ -207,12 +210,6 @@ int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
 unsigned int device_get_child_node_count(const struct device *dev);
 
-static inline bool device_property_read_bool(const struct device *dev,
-					     const char *propname)
-{
-	return device_property_present(dev, propname);
-}
-
 static inline int device_property_read_u8(const struct device *dev,
 					  const char *propname, u8 *val)
 {
@@ -263,12 +260,6 @@ static inline int device_property_string_array_count(const struct device *dev,
 	return device_property_read_string_array(dev, propname, NULL, 0);
 }
 
-static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
-					     const char *propname)
-{
-	return fwnode_property_present(fwnode, propname);
-}
-
 static inline int fwnode_property_read_u8(const struct fwnode_handle *fwnode,
 					  const char *propname, u8 *val)
 {

-- 
2.45.2


