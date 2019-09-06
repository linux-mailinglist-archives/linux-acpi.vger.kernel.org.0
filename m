Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FF1AB05B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 03:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfIFBsd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 21:48:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33598 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404265AbfIFBsc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 21:48:32 -0400
Received: by mail-oi1-f193.google.com with SMTP id e12so3393570oie.0;
        Thu, 05 Sep 2019 18:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pc2qf7AeZ9RoEwSW/YkMIVCjt1/OmpGYgpPofnisPMY=;
        b=a/eF3PtkXvYa2y3CMVLbARNH1odGvX+xdDUytPfsR1xPe2Qn9hCwnVeIHd8glJlDNq
         ny9oZiv+dqWpmtUkIBFgPRGwBbDWmyuSsH2BBG5/ns81dZeCRGBRVVuoLIJLHr7xbAcC
         fVcTAO9O2BiS79R0DaCTV9pLTSWHOXSd4Tivc8WuFqbRyQDeay2PN3IqDYVqd4OfylI+
         1zfiMZwv1hLC8QxkVstSKSdrbA+0N5wmuELdqWC3AqPa+OFTw4dhJT7cueaG7G2psUKI
         G/sTUnct4QcjiikoHi1jRK3ubHIbXzVfMUOF8F8mwqXJLZMIErg6ShDO3apP1phnalWx
         s7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pc2qf7AeZ9RoEwSW/YkMIVCjt1/OmpGYgpPofnisPMY=;
        b=PIQGL0Y3xxRs62mxriKm2XZAyTNEcaVb3vedsxcumrDGQZQJ9ARClOvsUHxMQzVvjG
         FS3hrOijDoP4ZNzrOlPAydMGFttQkmGfhVlJub32fJja/EuX2jzxa/rC/M0qopW4ZwZh
         QcGG/jgIVrM7BcbO9e6WysxE+op4UVy6LZRMKhj2WtXHEn2s7cCTGlm6rvB4iNXMloU2
         MCt59X54Qt+2G7C9xfwcrsHTeINuNPtHfeQ5Ui0y3MMoQpUmsM9pHgJXnvVX34+rACaK
         r/Tfultxu8OT4qNNJ9KlMRCxTDekvB0TlvcgOSC4pELOWQYwZse/psgLWfGuHHL1tNlX
         2TXA==
X-Gm-Message-State: APjAAAVsEQFzLJ5i+J+vDL6UPdN0KTjFqi8/MxARVAJMmpVPqQJt2ZGO
        wvGzGugyEdohjjywkpqVf6wfg+SM0CY=
X-Google-Smtp-Source: APXvYqz+t4UN/E5UDO5mWbUwG46Gyxmofk/WnAjCO32gVZ2+Z0Zwwa+V1Pr3AJRZFloZ+d31VeibKA==
X-Received: by 2002:aca:4890:: with SMTP id v138mr5269506oia.57.1567734511804;
        Thu, 05 Sep 2019 18:48:31 -0700 (PDT)
Received: from chip-MS-7B92.austin.rr.com ([2605:6000:f350:3e00:fc3b:b63b:919f:ceef])
        by smtp.gmail.com with ESMTPSA id b11sm1010049oib.3.2019.09.05.18.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 18:48:31 -0700 (PDT)
From:   Charles Hyde <chip.programmer@gmail.com>
To:     Charles Hyde <chip.programmer@gmail.com>
Cc:     Charles Hyde <charles.hyde@dellteam.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Oliver Neukum <oliver@neukum.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 3/3] net: cdc_ncm: Add ACPI MAC address pass through functionality
Date:   Thu,  5 Sep 2019 20:48:27 -0500
Message-Id: <20190906014827.12666-4-chip.programmer@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906014827.12666-1-chip.programmer@gmail.com>
References: <20190906014827.12666-1-chip.programmer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This change adds support to cdc_ncm for ACPI MAC address pass through
functionality that also exists in the Realtek r8152 driver.  This is in
support of Dell's Universal Dock D6000, to give it the same feature
capability as is currently available in Windows and advertized on Dell's
product web site.

Today's v3 patch series includes a function named get_ethernet_addr()
which replaces two instances where the same code snippet was located in
teh previous patch series.  I also created a post reset function to set
the MAC address, if there exists an ACPI MAC address pass through (MAPT)
method.  Oliver Neukum had requested a post reset function for this
purpose.

Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>
Cc: chip.programmer@gmail.com
Cc: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
---
 drivers/net/usb/cdc_ncm.c | 74 +++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 85093579612f..e0152d44f5af 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -52,6 +52,7 @@
 #include <linux/usb/usbnet.h>
 #include <linux/usb/cdc.h>
 #include <linux/usb/cdc_ncm.h>
+#include <acpi/acpi_mac_passthru.h>
 
 #if IS_ENABLED(CONFIG_USB_NET_CDC_MBIM)
 static bool prefer_mbim = true;
@@ -833,6 +834,45 @@ static const struct net_device_ops cdc_ncm_netdev_ops = {
 	.ndo_validate_addr   = eth_validate_addr,
 };
 
+static int get_ethernet_addr(struct usb_interface *intf)
+{
+	struct sockaddr sa;
+	struct usbnet *dev = usb_get_intfdata(intf);
+	struct cdc_ncm_ctx *ctx;
+	int ret = 0;
+
+	if (!dev)
+		return 0;
+
+	ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	if (!ctx->ether_desc)
+		return 0;
+
+	ret = cdc_ncm_get_ethernet_address(dev, ctx);
+	if (ret) {
+		dev_dbg(&intf->dev, "failed to get mac address\n");
+		return ret;
+	}
+
+	/* Check for a Dell Universal Dock D6000 before checking if ACPI
+	 * supports MAC address pass through.
+	 */
+	if (strstr(dev->udev->product, "D6000")) {
+		sa.sa_family = dev->net->type;
+		if (get_acpi_mac_passthru(sa.sa_data)) {
+			if (!memcmp(dev->net->dev_addr, sa.sa_data,
+				    ETH_ALEN)) {
+				if (!cdc_ncm_set_ethernet_address(dev, &sa))
+					memcpy(dev->net->dev_addr, sa.sa_data,
+					       ETH_ALEN);
+			}
+		}
+	}
+	dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);
+
+	return 0;
+}
+
 int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_altsetting, int drvflags)
 {
 	struct cdc_ncm_ctx *ctx;
@@ -983,14 +1023,8 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	usb_set_intfdata(ctx->data, dev);
 	usb_set_intfdata(ctx->control, dev);
 
-	if (ctx->ether_desc) {
-		temp = usbnet_get_ethernet_addr(dev, ctx->ether_desc->iMACAddress);
-		if (temp) {
-			dev_dbg(&intf->dev, "failed to get mac address\n");
-			goto error2;
-		}
-		dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);
-	}
+	if (get_ethernet_addr(intf))
+		goto error2;
 
 	/* finish setting up the device specific data */
 	cdc_ncm_setup(dev);
@@ -1716,6 +1750,25 @@ static void cdc_ncm_status(struct usbnet *dev, struct urb *urb)
 	}
 }
 
+static int cdc_ncm_resume(struct usb_interface *intf)
+{
+	int ret;
+
+	ret = usbnet_resume(intf);
+	if (ret == 0)
+		get_ethernet_addr(intf);
+
+	return ret;
+}
+
+static int cdc_ncm_post_reset(struct usb_interface *intf)
+{
+	/* reset the MAC address in case of policy change */
+	get_ethernet_addr(intf);
+
+	return 0;
+}
+
 static const struct driver_info cdc_ncm_info = {
 	.description = "CDC NCM",
 	.flags = FLAG_POINTTOPOINT | FLAG_NO_SETINT | FLAG_MULTI_PACKET
@@ -1848,8 +1901,9 @@ static struct usb_driver cdc_ncm_driver = {
 	.probe = usbnet_probe,
 	.disconnect = usbnet_disconnect,
 	.suspend = usbnet_suspend,
-	.resume = usbnet_resume,
-	.reset_resume =	usbnet_resume,
+	.resume = cdc_ncm_resume,
+	.reset_resume =	cdc_ncm_resume,
+	.post_reset = cdc_ncm_post_reset,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 };
-- 
2.20.1

