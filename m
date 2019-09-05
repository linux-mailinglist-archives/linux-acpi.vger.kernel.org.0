Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0500AAAD83
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2019 23:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390779AbfIEVBt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 17:01:49 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:62396 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728685AbfIEVBt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 17:01:49 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85KxinH004022;
        Thu, 5 Sep 2019 17:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=6X7C8GAjMT0zROIOgLRJnIZ7aFpr4Xi+/Rygf9BSUS8=;
 b=Zw7hBUit3g0gDp2ZfXqMpRK/MhvmuDqLfmOXDJ1dhP+kYRfl8W7nq84olc1jT6qRwp0e
 GDNwQfjjPOhSh+GZQGpIRwYst2rXm3UW8Xjfo7S9A5LNbk8CykILzT9xT+cfrxxd/hbh
 LbpjeHCO2YVXVIuBoMSrhipZ3p9PRcr2jWinkLY17CL7N3npzn5WLdtgN4HXF24U1qSq
 V/5IcjUWS2Ay7tsTiYip9aegaIyiSGsRfBdnteg3eGGNTYLPgty85ZkSPvR159qKFkbx
 bLu2Vt1GpCTiMpKAL7XZi9ORzQ9p7UVXotlTmAmZ3Tm8r8VAFuIOitXlgodrY2Nnusdv yA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2uqkf8ydna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 17:01:47 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85KwFCv007017;
        Thu, 5 Sep 2019 17:01:46 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2utx7h4k89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 17:01:46 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="371172696"
From:   <Charles.Hyde@dellteam.com>
To:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Topic: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Index: AQHVZC0XfVLJKGIqRUqUbVm4+zFbpw==
Date:   Thu, 5 Sep 2019 21:01:44 +0000
Message-ID: <1567717304186.90134@Dellteam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.49.166]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_08:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050196
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909050196
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This change adds support to cdc_ncm for ACPI MAC address pass through=0A=
functionality that also exists in the Realtek r8152 driver.  This is in=0A=
support of Dell's Universal Dock D6000, to give it the same feature=0A=
capability as is currently available in Windows and advertized on Dell's=0A=
product web site.=0A=
=0A=
Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>=0A=
Cc: Mario Limonciello <mario.limonciello@dell.com>=0A=
Cc: chip.programmer@gmail.com=0A=
Cc: Oliver Neukum <oliver@neukum.org>=0A=
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>=0A=
Cc: Len Brown <lenb@kernel.org>=0A=
Cc: linux-usb@vger.kernel.org=0A=
Cc: linux-acpi@vger.kernel.org=0A=
---=0A=
 drivers/net/usb/cdc_ncm.c | 74 +++++++++++++++++++++++++++++++++------=0A=
 1 file changed, 64 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c=0A=
index 85093579612f..e0152d44f5af 100644=0A=
--- a/drivers/net/usb/cdc_ncm.c=0A=
+++ b/drivers/net/usb/cdc_ncm.c=0A=
@@ -52,6 +52,7 @@=0A=
 #include <linux/usb/usbnet.h>=0A=
 #include <linux/usb/cdc.h>=0A=
 #include <linux/usb/cdc_ncm.h>=0A=
+#include <acpi/acpi_mac_passthru.h>=0A=
 =0A=
 #if IS_ENABLED(CONFIG_USB_NET_CDC_MBIM)=0A=
 static bool prefer_mbim =3D true;=0A=
@@ -833,6 +834,45 @@ static const struct net_device_ops cdc_ncm_netdev_ops =
=3D {=0A=
 	.ndo_validate_addr   =3D eth_validate_addr,=0A=
 };=0A=
 =0A=
+static int get_ethernet_addr(struct usb_interface *intf)=0A=
+{=0A=
+	struct sockaddr sa;=0A=
+	struct usbnet *dev =3D usb_get_intfdata(intf);=0A=
+	struct cdc_ncm_ctx *ctx;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	if (!dev)=0A=
+		return 0;=0A=
+=0A=
+	ctx =3D (struct cdc_ncm_ctx *)dev->data[0];=0A=
+	if (!ctx->ether_desc)=0A=
+		return 0;=0A=
+=0A=
+	ret =3D cdc_ncm_get_ethernet_address(dev, ctx);=0A=
+	if (ret) {=0A=
+		dev_dbg(&intf->dev, "failed to get mac address\n");=0A=
+		return ret;=0A=
+	}=0A=
+=0A=
+	/* Check for a Dell Universal Dock D6000 before checking if ACPI=0A=
+	 * supports MAC address pass through.=0A=
+	 */=0A=
+	if (strstr(dev->udev->product, "D6000")) {=0A=
+		sa.sa_family =3D dev->net->type;=0A=
+		if (get_acpi_mac_passthru(sa.sa_data)) {=0A=
+			if (!memcmp(dev->net->dev_addr, sa.sa_data,=0A=
+				    ETH_ALEN)) {=0A=
+				if (!cdc_ncm_set_ethernet_address(dev, &sa))=0A=
+					memcpy(dev->net->dev_addr, sa.sa_data,=0A=
+					       ETH_ALEN);=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8=
 data_altsetting, int drvflags)=0A=
 {=0A=
 	struct cdc_ncm_ctx *ctx;=0A=
@@ -983,14 +1023,8 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct us=
b_interface *intf, u8 data_=0A=
 	usb_set_intfdata(ctx->data, dev);=0A=
 	usb_set_intfdata(ctx->control, dev);=0A=
 =0A=
-	if (ctx->ether_desc) {=0A=
-		temp =3D usbnet_get_ethernet_addr(dev, ctx->ether_desc->iMACAddress);=0A=
-		if (temp) {=0A=
-			dev_dbg(&intf->dev, "failed to get mac address\n");=0A=
-			goto error2;=0A=
-		}=0A=
-		dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);=0A=
-	}=0A=
+	if (get_ethernet_addr(intf))=0A=
+		goto error2;=0A=
 =0A=
 	/* finish setting up the device specific data */=0A=
 	cdc_ncm_setup(dev);=0A=
@@ -1716,6 +1750,25 @@ static void cdc_ncm_status(struct usbnet *dev, struc=
t urb *urb)=0A=
 	}=0A=
 }=0A=
 =0A=
+static int cdc_ncm_resume(struct usb_interface *intf)=0A=
+{=0A=
+	int ret;=0A=
+=0A=
+	ret =3D usbnet_resume(intf);=0A=
+	if (ret =3D=3D 0)=0A=
+		get_ethernet_addr(intf);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int cdc_ncm_post_reset(struct usb_interface *intf)=0A=
+{=0A=
+	/* reset the MAC address in case of policy change */=0A=
+	get_ethernet_addr(intf);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct driver_info cdc_ncm_info =3D {=0A=
 	.description =3D "CDC NCM",=0A=
 	.flags =3D FLAG_POINTTOPOINT | FLAG_NO_SETINT | FLAG_MULTI_PACKET=0A=
@@ -1848,8 +1901,9 @@ static struct usb_driver cdc_ncm_driver =3D {=0A=
 	.probe =3D usbnet_probe,=0A=
 	.disconnect =3D usbnet_disconnect,=0A=
 	.suspend =3D usbnet_suspend,=0A=
-	.resume =3D usbnet_resume,=0A=
-	.reset_resume =3D	usbnet_resume,=0A=
+	.resume =3D cdc_ncm_resume,=0A=
+	.reset_resume =3D	cdc_ncm_resume,=0A=
+	.post_reset =3D cdc_ncm_post_reset,=0A=
 	.supports_autosuspend =3D 1,=0A=
 	.disable_hub_initiated_lpm =3D 1,=0A=
 };=0A=
-- =0A=
2.20.1=0A=
