Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDCCA3E85
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 21:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfH3Ti6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Aug 2019 15:38:58 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:37112 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727246AbfH3Ti6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Aug 2019 15:38:58 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7UJYttx011662;
        Fri, 30 Aug 2019 15:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=44wTjuXSWMXNrwjFUFwYXstyHmykGsnhGtwggTvTdew=;
 b=s6XPNWvMcNQRT/oIaPDEEBApTKsWhkkkITSG3SJLMIRtO8VU13/ecXdr13kzM7dheUqw
 t/BkAz+GKsJvNVviJ2tGZIq2PUwng04Po2kpNMISA7EVwyHsFydBZ+eyPifSoLRxoQfb
 lX0vuny05bJ60JozjkM3PonenN+awy7ZSYsMNJM1duD5/OLTdYLkYf6U/4GtQbUTO3AG
 fGJ5sLNT40gzwnHNUsXlc1jmSwNuxU5lrET+aOZTNkLloWgx4QQb8g5nx/lhxqqV7u+O
 a37nNGniybJlgT/TZTyV4iyN54RyoTnnNjLnmFLotI3RN39l6Xsgjy0ZuRGhUKou8n8P eA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2uk2xjcyjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 15:38:56 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7UJbhaS076744;
        Fri, 30 Aug 2019 15:38:56 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 2up6pcxvh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 15:38:56 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="850370706"
From:   <Charles.Hyde@dellteam.com>
To:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <nic_swsd@realtek.com>, <Mario.Limonciello@dell.com>
Subject: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Topic: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Index: AQHVX2qOXZfzpNrp7kuN2ddtBmn+Zg==
Date:   Fri, 30 Aug 2019 19:38:54 +0000
Message-ID: <b24465a706744d99a7c1682f05a24784@AUSX13MPS307.AMER.DELL.COM>
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908300185
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908300184
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
Cc: Oliver Neukum <oliver@neukum.org>=0A=
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>=0A=
Cc: Len Brown <lenb@kernel.org>=0A=
Cc: linux-usb@vger.kernel.org=0A=
Cc: linux-acpi@vger.kernel.org=0A=
---=0A=
 drivers/net/usb/cdc_ncm.c | 67 +++++++++++++++++++++++++++++++++++++--=0A=
 1 file changed, 64 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c=0A=
index 85093579612f..11a04dc2298d 100644=0A=
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
@@ -984,11 +985,30 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct us=
b_interface *intf, u8 data_=0A=
 	usb_set_intfdata(ctx->control, dev);=0A=
 =0A=
 	if (ctx->ether_desc) {=0A=
-		temp =3D usbnet_get_ethernet_addr(dev, ctx->ether_desc->iMACAddress);=0A=
+		struct sockaddr sa;=0A=
+=0A=
+		temp =3D cdc_ncm_get_ethernet_address(dev, ctx);=0A=
 		if (temp) {=0A=
 			dev_dbg(&intf->dev, "failed to get mac address\n");=0A=
 			goto error2;=0A=
 		}=0A=
+=0A=
+		/* Check for a Dell Universal Dock D6000 before checking if=0A=
+		 * ACPI supports MAC address pass through.=0A=
+		 */=0A=
+		if (!strstr(dev->udev->product, "D6000"))=0A=
+			goto skip_acpi_mapt_in_bind;=0A=
+=0A=
+		if (get_acpi_mac_passthru(sa.sa_data) !=3D 0)=0A=
+			goto skip_acpi_mapt_in_bind;=0A=
+=0A=
+		if (memcmp(dev->net->dev_addr, sa.sa_data, ETH_ALEN) =3D=3D 0)=0A=
+			goto skip_acpi_mapt_in_bind;=0A=
+=0A=
+		if (cdc_ncm_set_ethernet_address(dev, &sa) =3D=3D 0)=0A=
+			memcpy(dev->net->dev_addr, sa.sa_data, ETH_ALEN);=0A=
+=0A=
+skip_acpi_mapt_in_bind:=0A=
 		dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);=0A=
 	}=0A=
 =0A=
@@ -1716,6 +1736,47 @@ static void cdc_ncm_status(struct usbnet *dev, struc=
t urb *urb)=0A=
 	}=0A=
 }=0A=
 =0A=
+static int cdc_ncm_resume(struct usb_interface *intf)=0A=
+{=0A=
+	struct usbnet *dev =3D usb_get_intfdata(intf);=0A=
+	struct cdc_ncm_ctx *ctx =3D (struct cdc_ncm_ctx *)dev->data[0];=0A=
+	int ret;=0A=
+=0A=
+	ret =3D usbnet_resume(intf);=0A=
+	if (ret !=3D 0)=0A=
+		goto error2;=0A=
+=0A=
+	if (ctx->ether_desc) {=0A=
+		struct sockaddr sa;=0A=
+=0A=
+		if (cdc_ncm_get_ethernet_address(dev, ctx)) {=0A=
+			dev_dbg(&intf->dev, "failed to get mac address\n");=0A=
+			goto error2;=0A=
+		}=0A=
+=0A=
+		/* Check for a Dell Universal Dock D6000 before checking if=0A=
+		 * ACPI supports MAC address pass through.=0A=
+		 */=0A=
+		if (!strstr(dev->udev->product, "D6000"))=0A=
+			goto skip_acpi_mapt_in_resume;=0A=
+=0A=
+		if (get_acpi_mac_passthru(sa.sa_data) !=3D 0)=0A=
+			goto skip_acpi_mapt_in_resume;=0A=
+=0A=
+		if (memcmp(dev->net->dev_addr, sa.sa_data, ETH_ALEN) =3D=3D 0)=0A=
+			goto skip_acpi_mapt_in_resume;=0A=
+=0A=
+		if (cdc_ncm_set_ethernet_address(dev, &sa) =3D=3D 0)=0A=
+			memcpy(dev->net->dev_addr, sa.sa_data, ETH_ALEN);=0A=
+=0A=
+skip_acpi_mapt_in_resume:=0A=
+		dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);=0A=
+	}=0A=
+=0A=
+error2:=0A=
+	return ret;=0A=
+}=0A=
+=0A=
 static const struct driver_info cdc_ncm_info =3D {=0A=
 	.description =3D "CDC NCM",=0A=
 	.flags =3D FLAG_POINTTOPOINT | FLAG_NO_SETINT | FLAG_MULTI_PACKET=0A=
@@ -1848,8 +1909,8 @@ static struct usb_driver cdc_ncm_driver =3D {=0A=
 	.probe =3D usbnet_probe,=0A=
 	.disconnect =3D usbnet_disconnect,=0A=
 	.suspend =3D usbnet_suspend,=0A=
-	.resume =3D usbnet_resume,=0A=
-	.reset_resume =3D	usbnet_resume,=0A=
+	.resume =3D cdc_ncm_resume,=0A=
+	.reset_resume =3D	cdc_ncm_resume,=0A=
 	.supports_autosuspend =3D 1,=0A=
 	.disable_hub_initiated_lpm =3D 1,=0A=
 };=0A=
-- =0A=
2.20.1=0A=
