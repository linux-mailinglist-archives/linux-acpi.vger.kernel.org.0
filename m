Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF364AAD89
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2019 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391639AbfIEVCH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 17:02:07 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:7330 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728685AbfIEVCH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 17:02:07 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85KxjZs012115;
        Thu, 5 Sep 2019 17:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dellteam.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=ZEB9L9FxhfyEPunMIhpeDlWfAjXTgDM2L/cH2PQSeYk=;
 b=GhSSM0B1aU8qPpXku4M+/D36YwETylM5g4fAko03pQPJs6b09tJRO9MXk80xCmpJbelu
 inhUNQP+EM624XX9wAdDWp0edgvc+vrui6uE0Zz0Rs9xtar84JgKF4OjJhoS6l0+IWO+
 yF9ffdQIGbCa4Hk1X9Tob7wkDeEumNKMKEeNi/4Ca9+paPHRYYcTMGsQkYjI42oXue8e
 gBeA+HREQq/Me3rthjXpSnjcDpd1msiXXLhk/ZfNFzuimRK1R1iz3wEYUec3Ddvk1pab
 XIx97AnQQ2jBgrvFoYdRq1XFcTSQycVRRPm7oRJzv8Fo0vtflZN7OvYFKb13NDjJx3O9 sw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2uqhyuyxq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 17:02:05 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85KwDgJ006952;
        Thu, 5 Sep 2019 17:02:04 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2utx7h4kep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 17:02:04 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="456761808"
From:   <Charles.Hyde@dellteam.com>
To:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Topic: [PATCH 2/3] ACPI: move ACPI functionality out of r8152 driver
Thread-Index: AQHVZCz3pp4uS7jzjEy/0FL0nXi89Q==
Date:   Thu, 5 Sep 2019 21:02:02 +0000
Message-ID: <1567717322197.863@Dellteam.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050196
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
Cc: chip.programmer@gmail.com=0A=
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>=0A=
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>=0A=
Cc: Len Brown <lenb@kernel.org>=0A=
Cc: linux-usb@vger.kernel.org=0A=
Cc: linux-acpi@vger.kernel.org=0A=
---=0A=
 drivers/acpi/Makefile            |  1 +=0A=
 drivers/acpi/acpi_mac_passthru.c | 63 ++++++++++++++++++++++++++++++++=0A=
 drivers/net/usb/r8152.c          | 44 ++--------------------=0A=
 include/acpi/acpi_mac_passthru.h | 29 +++++++++++++++=0A=
 4 files changed, 97 insertions(+), 40 deletions(-)=0A=
 create mode 100644 drivers/acpi/acpi_mac_passthru.c=0A=
 create mode 100644 include/acpi/acpi_mac_passthru.h=0A=
=0A=
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile=0A=
index 5d361e4e3405..6bc2748f0e00 100644=0A=
--- a/drivers/acpi/Makefile=0A=
+++ b/drivers/acpi/Makefile=0A=
@@ -66,6 +66,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)	+=3D acpi_watchdog.o=0A=
 acpi-$(CONFIG_ACPI_ADXL)	+=3D acpi_adxl.o=0A=
 =0A=
 # These are (potentially) separate modules=0A=
+acpi-y				+=3D acpi_mac_passthru.o=0A=
 =0A=
 # IPMI may be used by other drivers, so it has to initialise before them=
=0A=
 obj-$(CONFIG_ACPI_IPMI)		+=3D acpi_ipmi.o=0A=
diff --git a/drivers/acpi/acpi_mac_passthru.c b/drivers/acpi/acpi_mac_passt=
hru.c=0A=
new file mode 100644=0A=
index 000000000000..37d7e2388c0b=0A=
--- /dev/null=0A=
+++ b/drivers/acpi/acpi_mac_passthru.c=0A=
@@ -0,0 +1,63 @@=0A=
+// SPDX-License-Identifier: GPL-2.0-or-later=0A=
+/*=0A=
+ * acpi_mac_passthru.c - ACPI MAC address pass through driver=0A=
+ *=0A=
+ *  Copyright (c) 2019 Dell Technology. All rights reserved.=0A=
+ *=0A=
+ * Search for MAC Address Pass Through information, and return the MAC add=
ress=0A=
+ * found.  This is set through enterprise policy settings, and expected to=
 be=0A=
+ * read by ethernet drivers that have software programmable MAC addresses.=
=0A=
+ * Failure to find the needed information results in -ENODEV.=0A=
+ */=0A=
+=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/acpi.h>=0A=
+#include <acpi/acpi_mac_passthru.h>=0A=
+#include <linux/etherdevice.h>=0A=
+=0A=
+ACPI_MODULE_NAME("mapt");=0A=
+=0A=
+MODULE_AUTHOR("Charles Hyde");=0A=
+MODULE_DESCRIPTION("ACPI MAPT Driver");=0A=
+MODULE_LICENSE("GPL");=0A=
+=0A=
+int get_acpi_mac_passthru(char *macAddress)=0A=
+{=0A=
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
+		acpi_info("Invalid buffer for pass-thru MAC addr: (%d, %d)\n",=0A=
+			  obj->type, obj->string.length);=0A=
+		goto amacout;=0A=
+	}=0A=
+	if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) !=3D 0 ||=0A=
+	    strncmp(obj->string.pointer + 0x15, "#", 1) !=3D 0) {=0A=
+		acpi_info("Invalid header when reading pass-thru MAC addr\n");=0A=
+		goto amacout;=0A=
+	}=0A=
+	ret =3D hex2bin(buf, obj->string.pointer + 9, 6);=0A=
+	if (!(ret =3D=3D 0 && is_valid_ether_addr(buf))) {=0A=
+		acpi_info("Invalid MAC for pass-thru MAC addr: %d, %pM\n",=0A=
+			  ret, buf);=0A=
+		ret =3D -EINVAL;=0A=
+		goto amacout;=0A=
+	}=0A=
+	memcpy(macAddress, buf, 6);=0A=
+	acpi_info("Pass-thru MAC addr %pM\n", macAddress);=0A=
+=0A=
+amacout:=0A=
+	kfree(obj);=0A=
+	return ret;=0A=
+=0A=
+}=0A=
+EXPORT_SYMBOL_GPL(get_acpi_mac_passthru);=0A=
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c=0A=
index 04137ac373b0..6b9de6ae6524 100644=0A=
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
@@ -1178,12 +1179,7 @@ static int rtl8152_set_mac_address(struct net_device=
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
@@ -1204,39 +1200,7 @@ static int vendor_mac_passthru_addr_read(struct r815=
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
+	return get_acpi_mac_passthru(sa->sa_data);=0A=
 }=0A=
 =0A=
 static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)=
=0A=
@@ -4311,10 +4275,10 @@ static int rtl8152_post_reset(struct usb_interface =
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
index 000000000000..9da3d5b399ac=0A=
--- /dev/null=0A=
+++ b/include/acpi/acpi_mac_passthru.h=0A=
@@ -0,0 +1,29 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
+/*=0A=
+ * acpi_mac_passthru.h - ACPI MAC address pass through driver=0A=
+ *=0A=
+ *  Copyright (c) 2019 Dell Technology. All rights reserved.=0A=
+ *=0A=
+ * Search for MAC Address Pass Through information, and return the MAC add=
ress=0A=
+ * found.  This is set through enterprise policy settings, and expected to=
 be=0A=
+ * read by ethernet drivers that have software programmable MAC addresses.=
=0A=
+ * Failure to find the needed information results in -ENODEV.=0A=
+ */=0A=
+=0A=
+#include <linux/module.h>=0A=
+#include <linux/acpi.h>=0A=
+//#include <linux/device.h>=0A=
+//#include <linux/socket.h>=0A=
+=0A=
+#ifdef CONFIG_ACPI=0A=
+=0A=
+int get_acpi_mac_passthru(char *macAddress);=0A=
+=0A=
+#else=0A=
+=0A=
+static inline int get_acpi_mac_passthru(char *macAddress)=0A=
+{=0A=
+	return -ENODEV;=0A=
+}=0A=
+=0A=
+#endif=0A=
-- =0A=
2.20.1=0A=
