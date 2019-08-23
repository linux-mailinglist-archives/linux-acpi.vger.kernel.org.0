Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42E9B88C
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2019 00:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406248AbfHWW0z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Aug 2019 18:26:55 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:38356 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405013AbfHWW0z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Aug 2019 18:26:55 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NMJeh4004841;
        Fri, 23 Aug 2019 18:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=7gMZFh1TyursWUfiAs4S1fY2F3NM079yg/GuJ41dDN4=;
 b=ITxv++Y42doXjUppUYctui4nQEBctDkf4n4Njd7JM0KZ/I4MLsWjtocrU035M+izsy12
 tSNf/U5GmaxChQCsSmp37ZX4/xRMysMLv53fdUccdepf0aTKETCU/7u+VUQ/G65AX/Fd
 RpvbRym9glmF0BWzdnCAKYQwpNBmW0aMFjPKWVfm0ReVpRCPlYCBslHdOzHCMGuizkdC
 x3+NAING2m/TFjXEBTmG9gMipb8iB1kpXBUeSVa6/RaotrEgIVf1PVR7fHYTRBpLv9kx
 /6KXQHR5AWqHg84XusrhW22LRuE7sdTz6ZucQ1Uaxry06hUIFkWYj+ob7fJgt72vYPGX MQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2ujpp5rery-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 18:26:53 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NMMmxa092166;
        Fri, 23 Aug 2019 18:26:52 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 2uey0usasq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 18:26:52 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="412379909"
From:   <Charles.Hyde@dellteam.com>
To:     <linux-usb@vger.kernel.org>
CC:     <Mario.Limonciello@dell.com>, <oliver@neukum.org>,
        <nic_swsd@realtek.com>, <linux-acpi@vger.kernel.org>
Subject: [RFC 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Topic: [RFC 1/3] net: cdc_ncm: add get/set ethernet address functions
Thread-Index: AQHVWgHa61WkHsDV5EiVn1+4CW4xcg==
Date:   Fri, 23 Aug 2019 22:26:49 +0000
Message-ID: <d3971424f9ee4b689b762721f671746a@AUSX13MPS303.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.49.166]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230211
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908230211
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
index 50c05d0f44cb..6fbe88fd7896 100644=0A=
--- a/drivers/net/usb/cdc_ncm.c=0A=
+++ b/drivers/net/usb/cdc_ncm.c=0A=
@@ -750,6 +750,78 @@ int cdc_ncm_change_mtu(struct net_device *net, int new=
_mtu)=0A=
 }=0A=
 EXPORT_SYMBOL_GPL(cdc_ncm_change_mtu);=0A=
 =0A=
+/* Provide method to get MAC address from the USB device's ethernet contro=
ller.=0A=
+ * If the device supports CDC_GET_ADDRESS, then we should receive just six=
 bytes.=0A=
+ * Otherwise, use the prior method by asking for the descriptor.=0A=
+ */=0A=
+static int cdc_ncm_get_ethernet_address(struct usbnet *dev, struct cdc_ncm=
_ctx *ctx)=0A=
+{=0A=
+	int ret;=0A=
+	char * buf;=0A=
+=0A=
+	buf =3D kmalloc(ETH_ALEN, GFP_KERNEL);=0A=
+	if (!buf)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	ret =3D usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),=0A=
+			USB_CDC_GET_NET_ADDRESS,=0A=
+			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,=0A=
+			0, USB_REQ_SET_ADDRESS, buf, ETH_ALEN,=0A=
+			USB_CTRL_GET_TIMEOUT);=0A=
+	if (ret =3D=3D ETH_ALEN) {=0A=
+		memcpy(dev->net->dev_addr, buf, ETH_ALEN);=0A=
+		ret =3D 0;	/* success */=0A=
+	} else {=0A=
+		ret =3D usbnet_get_ethernet_addr(dev, ctx->ether_desc->iMACAddress);=0A=
+	}=0A=
+	kfree(buf);=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+/* Provide method to push MAC address to the USB device's ethernet control=
ler.=0A=
+ * If the device does not support CDC_SET_ADDRESS, then there is no harm a=
nd=0A=
+ * we proceed as before.=0A=
+ */=0A=
+static int cdc_ncm_set_ethernet_address(struct usbnet *dev, struct sockadd=
r *addr)=0A=
+{=0A=
+	int ret;=0A=
+	char * buf;=0A=
+=0A=
+	buf =3D kmalloc(ETH_ALEN, GFP_KERNEL);=0A=
+	if (!buf)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	memcpy(buf, addr->sa_data, ETH_ALEN);=0A=
+	ret =3D usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),=0A=
+			USB_CDC_SET_NET_ADDRESS,=0A=
+			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,=0A=
+			0, USB_REQ_SET_ADDRESS, buf, ETH_ALEN,=0A=
+			USB_CTRL_GET_TIMEOUT);=0A=
+	if (ret =3D=3D ETH_ALEN)=0A=
+		ret =3D 0;	/* success */=0A=
+	else if (ret < 0) {=0A=
+		dev_dbg(&dev->udev->dev, "bad MAC address put, %d\n", ret);=0A=
+	}=0A=
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
+	/*=0A=
+	 * Try to push the MAC address out to the device.  Ignore any errors,=0A=
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
