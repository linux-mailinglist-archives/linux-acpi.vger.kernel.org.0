Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914D5437013
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 04:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhJVCjQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Oct 2021 22:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhJVCjO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Oct 2021 22:39:14 -0400
X-Greylist: delayed 2171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Oct 2021 19:36:57 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B2C061764
        for <linux-acpi@vger.kernel.org>; Thu, 21 Oct 2021 19:36:57 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id AE5E572B;
        Thu, 21 Oct 2021 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1634868046;
        bh=2efYL9rwju5SdZ2gZO9Y+iw53j+3OthU+D9Ued9171A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTLcZyfB+o23zCieIixIk1iW6+CXajFlgYvk05xm6r1pcsOB3pmRsMCV71ZWfrEgS
         TfjbvVP5tlYDrYgv1hZIuIYw5QFffzYmZp35cfj/s+QelYfZ2PBZt6wxNGrkPv2WS1
         qCOJbwjPa+skQ+phlmsd1hqHnkxdl1TXK1JgKTxg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/5] device property: add fwnode_device_is_reserved()
Date:   Thu, 21 Oct 2021 19:00:29 -0700
Message-Id: <20211022020032.26980-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022020032.26980-1-zev@bewilderbeest.net>
References: <20211022020032.26980-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is the fwnode API corresponding to of_device_is_reserved(), which
indicates that a device exists but may not be immediately accessible.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/base/property.c  | 16 ++++++++++++++++
 include/linux/fwnode.h   |  2 ++
 include/linux/property.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 453918eb7390..7b70cb04531c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -845,6 +845,22 @@ bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_device_is_available);
 
+/**
+ * fwnode_device_is_reserved - check if a device is reserved for use
+ * @fwnode: Pointer to the fwnode of the device.
+ *
+ * For fwnode node types that don't implement the .device_is_reserved()
+ * operation, this function returns false.
+ */
+bool fwnode_device_is_reserved(const struct fwnode_handle *fwnode)
+{
+	if (!fwnode_has_op(fwnode, device_is_reserved))
+		return false;
+
+	return fwnode_call_bool_op(fwnode, device_is_reserved);
+}
+EXPORT_SYMBOL_GPL(fwnode_device_is_reserved);
+
 /**
  * device_get_child_node_count - return the number of child nodes for device
  * @dev: Device to cound the child nodes for
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9f4ad719bfe3..1a9aefbe12f1 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -86,6 +86,7 @@ struct fwnode_reference_args {
  * @get: Get a reference to an fwnode.
  * @put: Put a reference to an fwnode.
  * @device_is_available: Return true if the device is available.
+ * @device_is_reserved: Return true if the device is reserved.
  * @device_get_match_data: Return the device driver match data.
  * @property_present: Return true if a property is present.
  * @property_read_int_array: Read an array of integer properties. Return zero on
@@ -110,6 +111,7 @@ struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
 	bool (*device_is_available)(const struct fwnode_handle *fwnode);
+	bool (*device_is_reserved)(const struct fwnode_handle *fwnode);
 	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
 					     const struct device *dev);
 	bool (*property_present)(const struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index 357513a977e5..455b022fa612 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -50,6 +50,7 @@ int device_property_match_string(struct device *dev,
 				 const char *propname, const char *string);
 
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
+bool fwnode_device_is_reserved(const struct fwnode_handle *fwnode);
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
 			     const char *propname);
 int fwnode_property_read_u8_array(const struct fwnode_handle *fwnode,
-- 
2.33.1

