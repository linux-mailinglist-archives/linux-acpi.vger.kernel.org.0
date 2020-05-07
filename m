Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B621C93C4
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEGPJH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 11:09:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:51959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgEGPJG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 11:09:06 -0400
IronPort-SDR: gS1L6o4TKnqL34qvH0708YlAerJyLAN5izssj4p92lZ6FoJVJjYjKGDSS5g3/fiD8vdJGY/uWT
 5YYFfw+h+bDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 08:09:05 -0700
IronPort-SDR: QC+4mudJ9wfcqdNd0xGussco6cO6WWj0JFCpTHA8voeqeFU9tklzAMCAFiyXnmomrdpqwOANda
 zMqM74xOhS2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="370143308"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 08:09:03 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 1/4] usb: typec: Add typec_find_orientation()
Date:   Thu,  7 May 2020 18:08:57 +0300
Message-Id: <20200507150900.12102-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Function that converts orientation string into orientation
value.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c | 36 ++++++++++++++++++++++++------------
 include/linux/usb/typec.h |  1 +
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 8d894bdff77d..c9234748537a 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -917,6 +917,12 @@ EXPORT_SYMBOL_GPL(typec_unregister_cable);
 /* ------------------------------------------------------------------------- */
 /* USB Type-C ports */
 
+static const char * const typec_orientations[] = {
+	[TYPEC_ORIENTATION_NONE]	= "unknown",
+	[TYPEC_ORIENTATION_NORMAL]	= "normal",
+	[TYPEC_ORIENTATION_REVERSE]	= "reverse",
+};
+
 static const char * const typec_roles[] = {
 	[TYPEC_SINK]	= "sink",
 	[TYPEC_SOURCE]	= "source",
@@ -1248,18 +1254,9 @@ static ssize_t orientation_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct typec_port *p = to_typec_port(dev);
-	enum typec_orientation orientation = typec_get_orientation(p);
-
-	switch (orientation) {
-	case TYPEC_ORIENTATION_NORMAL:
-		return sprintf(buf, "%s\n", "normal");
-	case TYPEC_ORIENTATION_REVERSE:
-		return sprintf(buf, "%s\n", "reverse");
-	case TYPEC_ORIENTATION_NONE:
-	default:
-		return sprintf(buf, "%s\n", "unknown");
-	}
+	struct typec_port *port = to_typec_port(dev);
+
+	return sprintf(buf, "%s\n", typec_orientations[port->orientation]);
 }
 static DEVICE_ATTR_RO(orientation);
 
@@ -1451,6 +1448,21 @@ void typec_set_pwr_opmode(struct typec_port *port,
 }
 EXPORT_SYMBOL_GPL(typec_set_pwr_opmode);
 
+/**
+ * typec_find_orientation - Convert orientation string to enum typec_orientation
+ * @name: Orientation string
+ *
+ * This routine is used to find the typec_orientation by its string name @name.
+ *
+ * Returns the orientation value on success, otherwise negative error code.
+ */
+int typec_find_orientation(const char *name)
+{
+	return match_string(typec_orientations, ARRAY_SIZE(typec_orientations),
+			    name);
+}
+EXPORT_SYMBOL_GPL(typec_find_orientation);
+
 /**
  * typec_find_port_power_role - Get the typec port power capability
  * @name: port power capability string
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index b00a2642a9cd..5daa1c49761c 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -254,6 +254,7 @@ int typec_set_mode(struct typec_port *port, int mode);
 
 void *typec_get_drvdata(struct typec_port *port);
 
+int typec_find_orientation(const char *name);
 int typec_find_port_power_role(const char *name);
 int typec_find_power_role(const char *name);
 int typec_find_port_data_role(const char *name);
-- 
2.26.2

