Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F319C04F
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2019 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfHXVPd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Aug 2019 17:15:33 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:10790 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726842AbfHXVPd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 24 Aug 2019 17:15:33 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NMJetA024336;
        Fri, 23 Aug 2019 18:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=S530TSXB1b7in2tC1rIW4402DQ6CfD8IkeFwgVFdqZk=;
 b=UvpNifvCbX2Bju6HpNDB1xICv/Od6hQq6nypmvXMzdwgzgrvTxhUY0gHsftLy3N1CKEi
 jFNw7cNGpBJbLlqupYWv1An+YExMhkIS/5uwOn1mZsPujIgrRJCizybgs2u1Shn8ZtC4
 yYZTcYtLjS4Rpy4UfLRzkoFDP7P6q0Ywbht39yk59zYRa5HagmWeNbPjaZmr2wYUY79a
 chhpO6/JIvH1+d+4cMzs54QUHl1GBPLxurLhK7WLvx5dBlI3NzGR0WAU+z18xqiIJ9JG
 7btuuMtG6x16WMcuGQjoDkQQqu/TX/BE6rMp4wOH2iB66ptIVw7DuXqtGkk9T73ZrLqf OQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2ujkjdh827-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 18:29:32 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NMMlOO141297;
        Fri, 23 Aug 2019 18:29:31 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2ujpcgj48e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 18:29:31 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="451621596"
From:   <Charles.Hyde@dellteam.com>
To:     <linux-usb@vger.kernel.org>
CC:     <Mario.Limonciello@dell.com>, <oliver@neukum.org>,
        <nic_swsd@realtek.com>, <linux-acpi@vger.kernel.org>
Subject: [RFC 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Topic: [RFC 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
Thread-Index: AQHVWgI6a2vXAMyG+kOESam1zqb5Vg==
Date:   Fri, 23 Aug 2019 22:29:29 +0000
Message-ID: <6db7de30d5584018adf169638e956626@AUSX13MPS303.AMER.DELL.COM>
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
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
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

This change adds support to cdc_ncm for ACPI MAC address pass through=0A=
functionality that also exists in the Realtek r8152 driver.  This is in=0A=
support of Dell's Universal Dock D6000, to give it the same feature=0A=
capability as is currently available in Windows and advertized on Dell's=0A=
product web site.=0A=
=0A=
Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>=0A=
Cc: Mario Limonciello <mario.limonciello@dell.com>=0A=
Cc: Oliver Neukum <oliver@neukum.org>=0A=
Cc: linux-usb@vger.kernel.org=0A=
---=0A=
 drivers/net/usb/cdc_ncm.c | 47 ++++++++++++++++++++++++++++++++++++---=0A=
 1 file changed, 44 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c=0A=
index 6fbe88fd7896..6f138ec3f362 100644=0A=
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
@@ -984,11 +985,20 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct us=
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
+		if (get_acpi_mac_passthru(&intf->dev, &sa) =3D=3D 0) {=0A=
+			if (memcmp(dev->net->dev_addr, sa.sa_data, ETH_ALEN) !=3D 0) {=0A=
+				if (cdc_ncm_set_ethernet_address(dev, &sa) =3D=3D 0) {=0A=
+					memcpy(dev->net->dev_addr, sa.sa_data, ETH_ALEN);=0A=
+				}=0A=
+			}=0A=
+		}=0A=
 		dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);=0A=
 	}=0A=
 =0A=
@@ -1716,6 +1726,37 @@ static void cdc_ncm_status(struct usbnet *dev, struc=
t urb *urb)=0A=
 	}=0A=
 }=0A=
 =0A=
+static int cdc_ncm_resume (struct usb_interface *intf)=0A=
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
+		if (get_acpi_mac_passthru(&intf->dev, &sa) =3D=3D 0) {=0A=
+			if (memcmp(dev->net->dev_addr, sa.sa_data, ETH_ALEN) !=3D 0) {=0A=
+				if (cdc_ncm_set_ethernet_address(dev, &sa) =3D=3D 0) {=0A=
+					memcpy(dev->net->dev_addr, sa.sa_data, ETH_ALEN);=0A=
+				}=0A=
+			}=0A=
+		}=0A=
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
@@ -1848,8 +1889,8 @@ static struct usb_driver cdc_ncm_driver =3D {=0A=
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
