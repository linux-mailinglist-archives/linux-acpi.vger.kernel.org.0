Return-Path: <linux-acpi+bounces-10494-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA42EA080B1
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 20:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8AC188C12E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822631FCD13;
	Thu,  9 Jan 2025 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrwUYS87"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFA1FBCB9;
	Thu,  9 Jan 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451749; cv=none; b=CzRM9TZdk+4DuoEtaw+UAVfgUDxKfNyms0Itb2sbEw32qQrJbBalJCRGtL5HxTyGV6WQGV1QudfS31r7mQiaRwXo6E63z4L7j8bAYRWLljpMivbd38BuVBP2mBZyaEdAEVi+n4dlYVB+twXKlPMiLuR+mzvTpjhEMEusQEt/UtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451749; c=relaxed/simple;
	bh=SReleW9OsRRKN79QlIuTYUST58IFqSH13JU+BxJdkEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekR49y4LCCZXsUpBUn8IQ0V5+jwzR5tRdzZWL5y4rrRJG7N2eDEIYWHIccPBoKPLsdvJ+s+EW49DJA5JqwVHVeEX8faRlut0cX9zuj1AJ/Kz7so5iXXyUYt8RGfVyNPrfem+gblYR15IGKCydE3u8ZmkHzDkMzyBKNFamwAFFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrwUYS87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D723BC4CED2;
	Thu,  9 Jan 2025 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736451748;
	bh=SReleW9OsRRKN79QlIuTYUST58IFqSH13JU+BxJdkEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OrwUYS87AQz8wE7C4sGt7YKR7y77qF0I+bgiaIDXF6rIcJmmI0mUuRhUaMcwFeeBE
	 PxfL5RfQ6XYL3+mbcYeuqgTPBghf2duV0w5RQww3/JsMDvHntIykV3HuMw93CS8aQ4
	 AoQX+JWJ2tt8+HA+vdCKHu54+JSSVg6BwQ8mXjhF/MRA9S09bocXpPzRLcSUB/h7Cm
	 7Cg8OJp+UqlH+Bae0G2ZIc5zsOha3b8vRae5D6E9AZVuH+YKtgOoA+ACnGMN02LykG
	 ycYlQW0Bmq7z/IyRm8GYeFo4rQBGk3a5BIHD5wY3QtZFgfkCp56LpMpRY+Tnaq8W0d
	 4YicIGj/epVSA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 09 Jan 2025 13:42:06 -0600
Subject: [PATCH 2/2] of: Warn when of_property_read_bool() is used on
 non-boolean properties
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-dt-type-warnings-v1-2-0150e32e716c@kernel.org>
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

The use of of_property_read_bool() for non-boolean properties is
deprecated. The primary use of it was to test property presence, but
that has been replaced in favor of of_property_present(). With those
uses now fixed, add a warning to discourage new ones.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/property.c | 26 ++++++++++++++++++++++++++
 include/linux/of.h    | 25 +++++++------------------
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 1b46be88cc0498fcbe74e7b988f22a86245c366e..9a6d84d19ff371def8bedc009bb6ab488458a29b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -31,6 +31,32 @@
 
 #include "of_private.h"
 
+/**
+ * of_property_read_bool - Find a property
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ *
+ * Search for a boolean property in a device node. Usage on non-boolean
+ * property types is deprecated.
+ *
+ * Return: true if the property exists false otherwise.
+ */
+bool of_property_read_bool(const struct device_node *np, const char *propname)
+{
+	struct property *prop = of_find_property(np, propname, NULL);
+
+	/*
+	 * Boolean properties should not have a value. Testing for property
+	 * presence should either use of_property_present() or just read the
+	 * property value and check the returned error code.
+	 */
+	if (prop && prop->length)
+		pr_warn("%pOF: Read of boolean property '%s' with a value.\n", np, propname);
+
+	return prop ? true : false;
+}
+EXPORT_SYMBOL(of_property_read_bool);
+
 /**
  * of_graph_is_present() - check graph's presence
  * @node: pointer to device_node containing graph port
diff --git a/include/linux/of.h b/include/linux/of.h
index 1cb4eb7fc2eded2246c697c3bcaf1b85d43108ab..0cdd58ff0a4190724309ba1eddbac51b188b6136 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -311,6 +311,7 @@ extern struct device_node *of_find_node_with_property(
 extern struct property *of_find_property(const struct device_node *np,
 					 const char *name,
 					 int *lenp);
+extern bool of_property_read_bool(const struct device_node *np, const char *propname);
 extern int of_property_count_elems_of_size(const struct device_node *np,
 				const char *propname, int elem_size);
 extern int of_property_read_u32_index(const struct device_node *np,
@@ -615,6 +616,12 @@ static inline struct device_node *of_find_compatible_node(
 	return NULL;
 }
 
+static inline bool of_property_read_bool(const struct device_node *np,
+					const char *propname)
+{
+	return false;
+}
+
 static inline int of_property_count_elems_of_size(const struct device_node *np,
 			const char *propname, int elem_size)
 {
@@ -1242,24 +1249,6 @@ static inline int of_property_read_string_index(const struct device_node *np,
 	return rc < 0 ? rc : 0;
 }
 
-/**
- * of_property_read_bool - Find a property
- * @np:		device node from which the property value is to be read.
- * @propname:	name of the property to be searched.
- *
- * Search for a boolean property in a device node. Usage on non-boolean
- * property types is deprecated.
- *
- * Return: true if the property exists false otherwise.
- */
-static inline bool of_property_read_bool(const struct device_node *np,
-					 const char *propname)
-{
-	const struct property *prop = of_find_property(np, propname, NULL);
-
-	return prop ? true : false;
-}
-
 /**
  * of_property_present - Test if a property is present in a node
  * @np:		device node to search for the property.

-- 
2.45.2


