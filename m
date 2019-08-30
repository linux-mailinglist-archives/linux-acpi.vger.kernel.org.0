Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C06A3E80
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 21:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfH3ThJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 15:37:09 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:26112 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727888AbfH3ThJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 15:37:09 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7UJYoOn020120;
        Fri, 30 Aug 2019 15:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=SG7/ZrIxFNnyczseg+qZx3HwfoDHJQCk+Vr/FKcBrIs=;
 b=pjcL+i8RxwOWE5Uubj5zBI7luK0SE5ug6bks0efm7wvCjzc2aYsCyO7BzYY//egbZmto
 q7Vvy1wOXBYiEXeY7hflvkQoB1NMNU0C/bHtzSgu99gvg472tr209xFHFrdYCFdR96OK
 ZEe2dJylRWUwiY4yZ62YD/KhPTOZiOOWZqrqbnu3wyE/Pdq75Va0WxzxsiOJ6meZ7BxP
 Q0HwB01ODCUhvYTS4+YGZW5GRIt6pckdfej24UgQMbp3b3kw8NkaR62sPtWQXxN2bynG
 Esym+0oDdWlml3hRByjs/uNt4rVnHqw7XTjsfqWoHH+3w/IlHttl4x1Bx+ynXuOTOQ/C Zg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2uk2r5vmgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 15:37:08 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7UJX18c021191;
        Fri, 30 Aug 2019 15:37:08 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2upx0ujq1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 15:37:08 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="368171689"
From:   <Charles.Hyde@dellteam.com>
To:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <nic_swsd@realtek.com>, <Mario.Limonciello@dell.com>
Subject: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Topic: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Index: AQHVX2pN6giiJ6/FU06nVjUMk0ut4w==
Date:   Fri, 30 Aug 2019 19:37:05 +0000
Message-ID: <5cee0eb405f2492b8086d8684f1c75ca@AUSX13MPS307.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.90.68]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-30_07:2019-08-29,2019-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908300184
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908300184
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch adds support for pushing a MAC address out to USB based=0A=
ethernet controllers driven by cdc_ncm.  With this change, ifconfig can=0A=
now set the device's MAC address.  For example, the Dell Universal Dock=0A=
D6000 is driven by cdc_ncm.  The D6000 can now have its MAC address set=0A=
by ifconfig, as it can be done in Windows.  This was tested with a D6000=0A=
using ifconfig on an x86 based chromebook, where iproute2 is not=0A=
available.=0A=
=0A=
Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>=0A=
Cc: Mario Limonciello <mario.limonciello@dell.com>=0A=
Cc: Oliver Neukum <oliver@neukum.org>=0A=
Cc: linux-usb@vger.kernel.org=0A=
---=0A=
 drivers/net/usb/cdc_ncm.c | 74 ++++++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 73 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c=0A=
index 50c05d0f44cb..85093579612f 100644=0A=
--- a/drivers/net/usb/cdc_ncm.c=0A=
+++ b/drivers/net/usb/cdc_ncm.c=0A=
@@ -750,6 +750,78 @@ int cdc_ncm_change_mtu(struct net_device *net, int new=
_mtu)=0A=
 }=0A=
 EXPORT_SYMBOL_GPL(cdc_ncm_change_mtu);=0A=
 =0A=
+/* Provide method to get MAC address from the USB device's ethernet contro=
ller.=0A=
+ * If the device supports CDC_GET_ADDRESS, we should receive just six byte=
s.=0A=
+ * Otherwise, use the prior method by asking for the descriptor.=0A=
+ */=0A=
+static int cdc_ncm_get_ethernet_address(struct usbnet *dev,=0A=
+					struct cdc_ncm_ctx *ctx)=0A=
+{=0A=
+	int ret;=0A=
+	char *buf;=0A=
+=0A=
+	buf =3D kmalloc(ETH_ALEN, GFP_KERNEL);=0A=
+	if (!buf)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	ret =3D usbnet_read_cmd(dev, USB_CDC_GET_NET_ADDRESS,=0A=
+			      USB_DIR_IN | USB_TYPE_CLASS=0A=
+			      | USB_RECIP_INTERFACE, 0,=0A=
+			      USB_REQ_SET_ADDRESS, buf, ETH_ALEN);=0A=
+	if (ret =3D=3D ETH_ALEN) {=0A=
+		memcpy(dev->net->dev_addr, buf, ETH_ALEN);=0A=
+		ret =3D 0;	/* success */=0A=
+	} else {=0A=
+		ret =3D usbnet_get_ethernet_addr(dev,=0A=
+					       ctx->ether_desc->iMACAddress);=0A=
+	}=0A=
+	kfree(buf);=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+/* Provide method to push MAC address to the USB device's ethernet control=
ler.=0A=
+ * If the device does not support CDC_SET_ADDRESS, there is no harm and we=
=0A=
+ * proceed as before.=0A=
+ */=0A=
+static int cdc_ncm_set_ethernet_address(struct usbnet *dev,=0A=
+					struct sockaddr *addr)=0A=
+{=0A=
+	int ret;=0A=
+	char *buf;=0A=
+=0A=
+	buf =3D kmalloc(ETH_ALEN, GFP_KERNEL);=0A=
+	if (!buf)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	memcpy(buf, addr->sa_data, ETH_ALEN);=0A=
+	ret =3D usbnet_write_cmd(dev, USB_CDC_SET_NET_ADDRESS,=0A=
+			       USB_DIR_OUT | USB_TYPE_CLASS=0A=
+			       | USB_RECIP_INTERFACE, 0,=0A=
+			       USB_REQ_SET_ADDRESS, buf, ETH_ALEN);=0A=
+	if (ret =3D=3D ETH_ALEN)=0A=
+		ret =3D 0;	/* success */=0A=
+	else if (ret < 0)=0A=
+		dev_dbg(&dev->udev->dev, "bad MAC address put, %d\n", ret);=0A=
+=0A=
+	kfree(buf);=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+/* Provide method to push MAC address to the USB device's ethernet control=
ler.=0A=
+ */=0A=
+int cdc_ncm_set_mac_addr(struct net_device *net, void *p)=0A=
+{=0A=
+	struct usbnet *dev =3D netdev_priv(net);=0A=
+=0A=
+	/* Try to push the MAC address out to the device.  Ignore any errors,=0A=
+	 * to be compatible with prior versions of this source.=0A=
+	 */=0A=
+	cdc_ncm_set_ethernet_address(dev, (struct sockaddr *)p);=0A=
+=0A=
+	return eth_mac_addr(net, p);=0A=
+}=0A=
+EXPORT_SYMBOL_GPL(cdc_ncm_set_mac_addr);=0A=
+=0A=
 static const struct net_device_ops cdc_ncm_netdev_ops =3D {=0A=
 	.ndo_open	     =3D usbnet_open,=0A=
 	.ndo_stop	     =3D usbnet_stop,=0A=
@@ -757,7 +829,7 @@ static const struct net_device_ops cdc_ncm_netdev_ops =
=3D {=0A=
 	.ndo_tx_timeout	     =3D usbnet_tx_timeout,=0A=
 	.ndo_get_stats64     =3D usbnet_get_stats64,=0A=
 	.ndo_change_mtu	     =3D cdc_ncm_change_mtu,=0A=
-	.ndo_set_mac_address =3D eth_mac_addr,=0A=
+	.ndo_set_mac_address =3D cdc_ncm_set_mac_addr,=0A=
 	.ndo_validate_addr   =3D eth_validate_addr,=0A=
 };=0A=
 =0A=
-- =0A=
2.20.1=0A=
