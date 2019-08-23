Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BCA9B891
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2019 00:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfHWW2b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Aug 2019 18:28:31 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:58216 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727370AbfHWW21 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Aug 2019 18:28:27 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NMJWWW031775;
        Fri, 23 Aug 2019 18:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=+DSeAv18ky6dsAVbGLZZBh5nxsQn5QSjOtdXZONH7kQ=;
 b=jJe9mrBK24KLRvtqtw8b5ObvhnDFYykCNXzFf9UHnu2jHaq9ew0xqIVy5XNJFAr4GkYC
 fSH2melRj/eU4mlb18LI6GO5MzA59iB85IsObCqiW5UUBGDLbfhFkunWUlyZQY1NKZUU
 mOQSsXhpM4RaWBtmKy6upeJ3jcYDd4Jpb3QN/NOMiV0XH/mECKe9zzwSGv3sYsFX1pje
 btWoeX3uXDVghxfyCV3GqvIuo6WxSKTvNIsOt6VpTVrA+G9nqXj5ci3BhDFIE5ilRGYj
 7cvFxPoX5ZKKqJzktV8yw7c2kBIUaDk9gS2XMmDubVCm3uDXSu8CtstSv+18iXvWlxMg BA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2ujfchad9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 18:28:26 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NMMp9L096938;
        Fri, 23 Aug 2019 18:28:26 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 2ujm4b3x60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 18:28:26 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="847527142"
From:   <Charles.Hyde@dellteam.com>
To:     <linux-acpi@vger.kernel.org>
CC:     <Mario.Limonciello@dell.com>, <oliver@neukum.org>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>
Subject: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Topic: [RFC 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Index: AQHVWgITZZ4dwXs8CES9WUAD0zcVmA==
Date:   Fri, 23 Aug 2019 22:28:24 +0000
Message-ID: <b84b32cb144f4ba8918ee2406e69275a@AUSX13MPS303.AMER.DELL.COM>
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

This change moves ACPI functionality out of the Realtek r8152 driver to=0A=
its own source and header file, making it available to other drivers as=0A=
needed now and into the future.  At the time this ACPI snippet was=0A=
introduced in 2016, only the Realtek driver made use of it in support of=0A=
Dell's enterprise IT policy efforts.  There comes now a need for this=0A=
same support in a different driver, also in support of Dell's enterprise=0A=
IT policy efforts.=0A=
=0A=
Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>=0A=
Cc: Mario Limonciello <mario.limonciello@dell.com>=0A=
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>=0A=
Cc: linux-usb@vger.kernel.org=0A=
Cc: linux-acpi@vger.kernel.org=0A=
---=0A=
 drivers/net/usb/r8152.c          | 44 +++--------------------=0A=
 include/acpi/acpi_mac_passthru.h | 16 +++++++++=0A=
 lib/Makefile                     |  3 +-=0A=
 lib/acpi_mac_passthru.c          | 61 ++++++++++++++++++++++++++++++++=0A=
 4 files changed, 83 insertions(+), 41 deletions(-)=0A=
 create mode 100644 include/acpi/acpi_mac_passthru.h=0A=
 create mode 100644 lib/acpi_mac_passthru.c=0A=
=0A=
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c=0A=
index 0cc03a9ff545..b1dba3400b74 100644=0A=
--- a/drivers/net/usb/r8152.c=0A=
+++ b/drivers/net/usb/r8152.c=0A=
@@ -23,6 +23,7 @@=0A=
 #include <linux/usb/cdc.h>=0A=
 #include <linux/suspend.h>=0A=
 #include <linux/acpi.h>=0A=
+#include <acpi/acpi_mac_passthru.h>=0A=
 =0A=
 /* Information for net-next */=0A=
 #define NETNEXT_VERSION		"09"=0A=
@@ -1175,12 +1176,7 @@ static int rtl8152_set_mac_address(struct net_device=
 *netdev, void *p)=0A=
  */=0A=
 static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr=
 *sa)=0A=
 {=0A=
-	acpi_status status;=0A=
-	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };=0A=
-	union acpi_object *obj;=0A=
-	int ret =3D -EINVAL;=0A=
 	u32 ocp_data;=0A=
-	unsigned char buf[6];=0A=
 =0A=
 	/* test for -AD variant of RTL8153 */=0A=
 	ocp_data =3D ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);=0A=
@@ -1201,39 +1197,7 @@ static int vendor_mac_passthru_addr_read(struct r815=
2 *tp, struct sockaddr *sa)=0A=
 			return -ENODEV;=0A=
 		}=0A=
 	}=0A=
-=0A=
-	/* returns _AUXMAC_#AABBCCDDEEFF# */=0A=
-	status =3D acpi_evaluate_object(NULL, "\\_SB.AMAC", NULL, &buffer);=0A=
-	obj =3D (union acpi_object *)buffer.pointer;=0A=
-	if (!ACPI_SUCCESS(status))=0A=
-		return -ENODEV;=0A=
-	if (obj->type !=3D ACPI_TYPE_BUFFER || obj->string.length !=3D 0x17) {=0A=
-		netif_warn(tp, probe, tp->netdev,=0A=
-			   "Invalid buffer for pass-thru MAC addr: (%d, %d)\n",=0A=
-			   obj->type, obj->string.length);=0A=
-		goto amacout;=0A=
-	}=0A=
-	if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) !=3D 0 ||=0A=
-	    strncmp(obj->string.pointer + 0x15, "#", 1) !=3D 0) {=0A=
-		netif_warn(tp, probe, tp->netdev,=0A=
-			   "Invalid header when reading pass-thru MAC addr\n");=0A=
-		goto amacout;=0A=
-	}=0A=
-	ret =3D hex2bin(buf, obj->string.pointer + 9, 6);=0A=
-	if (!(ret =3D=3D 0 && is_valid_ether_addr(buf))) {=0A=
-		netif_warn(tp, probe, tp->netdev,=0A=
-			   "Invalid MAC for pass-thru MAC addr: %d, %pM\n",=0A=
-			   ret, buf);=0A=
-		ret =3D -EINVAL;=0A=
-		goto amacout;=0A=
-	}=0A=
-	memcpy(sa->sa_data, buf, 6);=0A=
-	netif_info(tp, probe, tp->netdev,=0A=
-		   "Using pass-thru MAC addr %pM\n", sa->sa_data);=0A=
-=0A=
-amacout:=0A=
-	kfree(obj);=0A=
-	return ret;=0A=
+	return get_acpi_mac_passthru(&tp->intf->dev, sa);=0A=
 }=0A=
 =0A=
 static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)=
=0A=
@@ -4309,10 +4273,10 @@ static int rtl8152_post_reset(struct usb_interface =
*intf)=0A=
 	if (!tp)=0A=
 		return 0;=0A=
 =0A=
-	/* reset the MAC adddress in case of policy change */=0A=
+	/* reset the MAC address in case of policy change */=0A=
 	if (determine_ethernet_addr(tp, &sa) >=3D 0) {=0A=
 		rtnl_lock();=0A=
-		dev_set_mac_address (tp->netdev, &sa, NULL);=0A=
+		dev_set_mac_address(tp->netdev, &sa, NULL);=0A=
 		rtnl_unlock();=0A=
 	}=0A=
 =0A=
diff --git a/include/acpi/acpi_mac_passthru.h b/include/acpi/acpi_mac_passt=
hru.h=0A=
new file mode 100644=0A=
index 000000000000..fb2b114c2765=0A=
--- /dev/null=0A=
+++ b/include/acpi/acpi_mac_passthru.h=0A=
@@ -0,0 +1,16 @@=0A=
+/*=0A=
+ *  Copyright (c) 2019 Dell Technology. All rights reserved.=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or=0A=
+ * modify it under the terms of the GNU General Public License=0A=
+ * version 2 as published by the Free Software Foundation.=0A=
+ *=0A=
+ */=0A=
+=0A=
+#include <linux/module.h>=0A=
+#include <linux/device.h>=0A=
+#include <linux/acpi.h>=0A=
+#include <linux/socket.h>=0A=
+=0A=
+int get_acpi_mac_passthru(struct device *dev, struct sockaddr *sa);=0A=
+=0A=
diff --git a/lib/Makefile b/lib/Makefile=0A=
index 29c02a924973..a902bec0ac65 100644=0A=
--- a/lib/Makefile=0A=
+++ b/lib/Makefile=0A=
@@ -35,7 +35,8 @@ lib-y :=3D ctype.o string.o vsprintf.o cmdline.o \=0A=
 	 flex_proportions.o ratelimit.o show_mem.o \=0A=
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \=0A=
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \=0A=
-	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o=0A=
+	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \=0A=
+	 acpi_mac_passthru.o=0A=
 =0A=
 lib-$(CONFIG_PRINTK) +=3D dump_stack.o=0A=
 lib-$(CONFIG_MMU) +=3D ioremap.o=0A=
diff --git a/lib/acpi_mac_passthru.c b/lib/acpi_mac_passthru.c=0A=
new file mode 100644=0A=
index 000000000000..832596433592=0A=
--- /dev/null=0A=
+++ b/lib/acpi_mac_passthru.c=0A=
@@ -0,0 +1,61 @@=0A=
+/*=0A=
+ *  Copyright (c) 2019 Dell Technology. All rights reserved.=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or=0A=
+ * modify it under the terms of the GNU General Public License=0A=
+ * version 2 as published by the Free Software Foundation.=0A=
+ *=0A=
+ */=0A=
+=0A=
+#include <acpi/acpi_mac_passthru.h>=0A=
+#include <linux/etherdevice.h>=0A=
+=0A=
+int get_acpi_mac_passthru(struct device *dev, struct sockaddr *sa)=0A=
+{=0A=
+#ifdef CONFIG_ACPI=0A=
+	acpi_status status;=0A=
+	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };=0A=
+	union acpi_object *obj;=0A=
+	int ret =3D -EINVAL;=0A=
+	unsigned char buf[6];=0A=
+=0A=
+	/* returns _AUXMAC_#AABBCCDDEEFF# */=0A=
+	status =3D acpi_evaluate_object(NULL, "\\_SB.AMAC", NULL, &buffer);=0A=
+	obj =3D (union acpi_object *)buffer.pointer;=0A=
+	if (!ACPI_SUCCESS(status))=0A=
+		return -ENODEV;=0A=
+	if (obj->type !=3D ACPI_TYPE_BUFFER || obj->string.length !=3D 0x17) {=0A=
+		dev_warn(dev,=0A=
+			 "Invalid buffer for pass-thru MAC addr: (%d, %d)\n",=0A=
+			 obj->type, obj->string.length);=0A=
+		goto amacout;=0A=
+	}=0A=
+	if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) !=3D 0 ||=0A=
+	    strncmp(obj->string.pointer + 0x15, "#", 1) !=3D 0) {=0A=
+		dev_warn(dev,=0A=
+			 "Invalid header when reading pass-thru MAC addr\n");=0A=
+		goto amacout;=0A=
+	}=0A=
+	ret =3D hex2bin(buf, obj->string.pointer + 9, 6);=0A=
+	if (!(ret =3D=3D 0 && is_valid_ether_addr(buf))) {=0A=
+		dev_warn(dev,=0A=
+			 "Invalid MAC for pass-thru MAC addr: %d, %pM\n",=0A=
+			 ret, buf);=0A=
+		ret =3D -EINVAL;=0A=
+		goto amacout;=0A=
+	}=0A=
+	memcpy(sa->sa_data, buf, 6);=0A=
+	dev_info(dev, "Pass-thru MAC addr %pM\n", sa->sa_data);=0A=
+=0A=
+amacout:=0A=
+	kfree(obj);=0A=
+	return ret;=0A=
+=0A=
+#else	/* !CONFIG_ACPI */=0A=
+	(void)dev;=0A=
+	(void)sa;=0A=
+=0A=
+	return -ENODEV;=0A=
+#endif=0A=
+}=0A=
+EXPORT_SYMBOL_GPL(get_acpi_mac_passthru);=0A=
-- =0A=
2.20.1=0A=
