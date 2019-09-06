Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C2AB065
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 03:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391953AbfIFBvT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 21:51:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38270 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbfIFBvS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 21:51:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id 7so3663191oip.5;
        Thu, 05 Sep 2019 18:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26NmWxoSiKiaWbVOpt4jWAHx5xteNn77h0vhjItrDwY=;
        b=ok9kYFE7zKccBGuLRmP6PpsmxMY2zFXvsw5yEeaEtRTxGzItpBNduNmXiuox+antxH
         E+obq0pphDHbQwBacAG/8YfQ9BdmvKU76k41wjAAMr6Vc8fktf3uFPPi1WNq7yk3xO9S
         fSlR/nX3Z50IiAqKnEFAuyZkkOBblvRZj9JC7KIP/w61wIOtbkU/vtDJ2eGId551sFpN
         1xaZrPu4vtU2VGea1Fnvy24p9LUoEJiYco6XrzGhepYumZ01WTrhjvRDRFrPio5+loOR
         Dwd9bYhF6/saMLnfaBbyv+22zB53GWQgyTDG3z9q7vNZ9S95kYgfxLpQSUt886dq+HbK
         5rTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26NmWxoSiKiaWbVOpt4jWAHx5xteNn77h0vhjItrDwY=;
        b=ZpYqnouSk41//wXznyFhW9RD7Kjix25cJzQ0e3Ly3icv/TOTo1Ly1m/DnV5cIT21bX
         5V0ucswlHEBKVK/0aLk5nu6uNVXLgul+8eeKR646/AmHdMk9qYKXKeIRywviZxpXkxcI
         kP051YKBTy0CnT05V/D8x1BDLyeeGR+vjy7qTu2Rinx8JsqydecjyO+pCIkr56qec3Wi
         bUrwXyRp0S/NvFOlj3rx25Rj8CcKTJTn3k2Xr5fz4AqHh1E2em3/2l11WVXNyKCHf03P
         JHT8sETOJU6tM+0WMNfOsfltk5nACfZBGj8EKBvwRpaGZl3YXkfet7jTRtG6nSrDP/+5
         nbEA==
X-Gm-Message-State: APjAAAW6ICjCsWpCUQl/2oEyIfSzUbTAKhZIeRRGzkhTZYvYFRTpnzqn
        3H5sJQDkSzoE5BURiDNPCpI=
X-Google-Smtp-Source: APXvYqwq9M6jAkuAegB6jm1+EJoarGebXUdSfpVRNZb+bsBUQg0zXw/xb0ZZATSyml+omaA0TDae6Q==
X-Received: by 2002:aca:30c1:: with SMTP id w184mr5256322oiw.61.1567734678019;
        Thu, 05 Sep 2019 18:51:18 -0700 (PDT)
Received: from chip-MS-7B92.austin.rr.com ([2605:6000:f350:3e00:fc3b:b63b:919f:ceef])
        by smtp.gmail.com with ESMTPSA id e1sm1324097otj.48.2019.09.05.18.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 18:51:17 -0700 (PDT)
From:   Charles Hyde <chip.programmer@gmail.com>
To:     Oliver Neukum <oliver@neukum.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org,
        chip.programmer@gmail.com
Subject: [PATCH v3 1/3] net: cdc_ncm: add get/set ethernet address functions
Date:   Thu,  5 Sep 2019 20:51:13 -0500
Message-Id: <20190906015115.12796-2-chip.programmer@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906015115.12796-1-chip.programmer@gmail.com>
References: <20190906015115.12796-1-chip.programmer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch adds support for pushing a MAC address out to USB based
ethernet controllers driven by cdc_ncm.  With this change, ifconfig can
now set the device's MAC address.  For example, the Dell Universal Dock
D6000 is driven by cdc_ncm.  The D6000 can now have its MAC address set
by ifconfig, as it can be done in Windows.  This was tested with a D6000
using ifconfig on an x86 based chromebook, where iproute2 is not
available.

Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>
Cc: chip.programmer@gmail.com
Cc: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/net/usb/cdc_ncm.c | 74 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 50c05d0f44cb..85093579612f 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -750,6 +750,78 @@ int cdc_ncm_change_mtu(struct net_device *net, int new_mtu)
 }
 EXPORT_SYMBOL_GPL(cdc_ncm_change_mtu);
 
+/* Provide method to get MAC address from the USB device's ethernet controller.
+ * If the device supports CDC_GET_ADDRESS, we should receive just six bytes.
+ * Otherwise, use the prior method by asking for the descriptor.
+ */
+static int cdc_ncm_get_ethernet_address(struct usbnet *dev,
+					struct cdc_ncm_ctx *ctx)
+{
+	int ret;
+	char *buf;
+
+	buf = kmalloc(ETH_ALEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = usbnet_read_cmd(dev, USB_CDC_GET_NET_ADDRESS,
+			      USB_DIR_IN | USB_TYPE_CLASS
+			      | USB_RECIP_INTERFACE, 0,
+			      USB_REQ_SET_ADDRESS, buf, ETH_ALEN);
+	if (ret == ETH_ALEN) {
+		memcpy(dev->net->dev_addr, buf, ETH_ALEN);
+		ret = 0;	/* success */
+	} else {
+		ret = usbnet_get_ethernet_addr(dev,
+					       ctx->ether_desc->iMACAddress);
+	}
+	kfree(buf);
+	return ret;
+}
+
+/* Provide method to push MAC address to the USB device's ethernet controller.
+ * If the device does not support CDC_SET_ADDRESS, there is no harm and we
+ * proceed as before.
+ */
+static int cdc_ncm_set_ethernet_address(struct usbnet *dev,
+					struct sockaddr *addr)
+{
+	int ret;
+	char *buf;
+
+	buf = kmalloc(ETH_ALEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy(buf, addr->sa_data, ETH_ALEN);
+	ret = usbnet_write_cmd(dev, USB_CDC_SET_NET_ADDRESS,
+			       USB_DIR_OUT | USB_TYPE_CLASS
+			       | USB_RECIP_INTERFACE, 0,
+			       USB_REQ_SET_ADDRESS, buf, ETH_ALEN);
+	if (ret == ETH_ALEN)
+		ret = 0;	/* success */
+	else if (ret < 0)
+		dev_dbg(&dev->udev->dev, "bad MAC address put, %d\n", ret);
+
+	kfree(buf);
+	return ret;
+}
+
+/* Provide method to push MAC address to the USB device's ethernet controller.
+ */
+int cdc_ncm_set_mac_addr(struct net_device *net, void *p)
+{
+	struct usbnet *dev = netdev_priv(net);
+
+	/* Try to push the MAC address out to the device.  Ignore any errors,
+	 * to be compatible with prior versions of this source.
+	 */
+	cdc_ncm_set_ethernet_address(dev, (struct sockaddr *)p);
+
+	return eth_mac_addr(net, p);
+}
+EXPORT_SYMBOL_GPL(cdc_ncm_set_mac_addr);
+
 static const struct net_device_ops cdc_ncm_netdev_ops = {
 	.ndo_open	     = usbnet_open,
 	.ndo_stop	     = usbnet_stop,
@@ -757,7 +829,7 @@ static const struct net_device_ops cdc_ncm_netdev_ops = {
 	.ndo_tx_timeout	     = usbnet_tx_timeout,
 	.ndo_get_stats64     = usbnet_get_stats64,
 	.ndo_change_mtu	     = cdc_ncm_change_mtu,
-	.ndo_set_mac_address = eth_mac_addr,
+	.ndo_set_mac_address = cdc_ncm_set_mac_addr,
 	.ndo_validate_addr   = eth_validate_addr,
 };
 
-- 
2.20.1

