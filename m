Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E628AB067
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 03:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391957AbfIFBvU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 21:51:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35512 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbfIFBvU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 21:51:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so3677195oii.2;
        Thu, 05 Sep 2019 18:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Blz0RsqZUJGPnoU5SLMqR+GSHgrZhAdK1utmIqTpw3k=;
        b=P6mEvECwpni7oWvOJiUXPy7LfC1HtqxRYKAsFsGgCFxKGgk1ldbSkIvqF/QmWAWHbT
         T5qmIt3GfQ5p+oU+ZqvkVdv0z10d3QiiGEeidKav9eJwaSBlHCBoaj36ftolyIJjp9bA
         nGg7hNH8udQOMUUXlUy8F2tF+LQv2frl2Kg3Y5Aed5ncJrtcDNW390YNwMGfRGor5YvH
         vHGNf5RqiIuk8Ah6UhZMvPk98jx3OIUbu1rJL1sE6FSe2StBI/aeGeJaOuEht91LHN1E
         ZuLx5hWrlcEdFHnzVLFfmjjZVRAyV7xwddr7w17MIq1eZo3uVvllWwHlcIHrGWhcoWEU
         FM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Blz0RsqZUJGPnoU5SLMqR+GSHgrZhAdK1utmIqTpw3k=;
        b=JlFA0A2xDRD4nayjHXeo9MvJxMijG2VN1RzmNQ48WnZfhBLqNSyqpfEYFrkoT2sEhJ
         Y/nD5umGTEFfX8ORT8m3agoXzc1t4KQ/eixgIJExwTdy9GsiZlG2tf+yzdAwNMf+Cw4d
         20z62/i6WACA9Z6QPSebdeEDQHU/3PnSUF18xrO53Fiws8ywdcj+I0DffWHcYqHEt3Ur
         d5uGNjEw4Qm1H+6JtI+o75A/3lATwRM5HntbYPIGZ6LdSD2VLXQc3YyRT+rrEqxgLfh6
         o5gNxmsGfg1tQ7+GB89uwKw2k2lmYNxWtcvl3UdgFF9hQ5Ui1OKmCd41q0RcNUjgCTk5
         FVqg==
X-Gm-Message-State: APjAAAUvgQ6N4073CbDqkbq2vO2W1pbie852UnkXj6e8euFqJwIVU0ha
        vNF8lqN19WG5tOugNyP/hEAhHwAM1kc=
X-Google-Smtp-Source: APXvYqyqTVS0rxUPkCy3L5eSnfqnu4WkNXzRftrk30U4w6EH2gNQO7KtqzuJmpYdgfjWKfZlisL4Vg==
X-Received: by 2002:aca:b70b:: with SMTP id h11mr5338236oif.107.1567734678928;
        Thu, 05 Sep 2019 18:51:18 -0700 (PDT)
Received: from chip-MS-7B92.austin.rr.com ([2605:6000:f350:3e00:fc3b:b63b:919f:ceef])
        by smtp.gmail.com with ESMTPSA id e1sm1324097otj.48.2019.09.05.18.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 18:51:18 -0700 (PDT)
From:   Charles Hyde <chip.programmer@gmail.com>
To:     Oliver Neukum <oliver@neukum.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org,
        chip.programmer@gmail.com
Subject: [PATCH v3 2/3] ACPI: move ACPI functionality out of r8152 driver
Date:   Thu,  5 Sep 2019 20:51:14 -0500
Message-Id: <20190906015115.12796-3-chip.programmer@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906015115.12796-1-chip.programmer@gmail.com>
References: <20190906015115.12796-1-chip.programmer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This change moves ACPI functionality out of the Realtek r8152 driver to
its own source and header file, making it available to other drivers as
needed now and into the future.  At the time this ACPI snippet was
introduced in 2016, only the Realtek driver made use of it in support of
Dell's enterprise IT policy efforts.  There comes now a need for this
same support in a different driver, also in support of Dell's enterprise
IT policy efforts.

Signed-off-by: Charles Hyde <charles.hyde@dellteam.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>
Cc: chip.programmer@gmail.com
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/Makefile            |  1 +
 drivers/acpi/acpi_mac_passthru.c | 63 ++++++++++++++++++++++++++++++++
 drivers/net/usb/r8152.c          | 44 ++--------------------
 include/acpi/acpi_mac_passthru.h | 27 ++++++++++++++
 4 files changed, 95 insertions(+), 40 deletions(-)
 create mode 100644 drivers/acpi/acpi_mac_passthru.c
 create mode 100644 include/acpi/acpi_mac_passthru.h

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..6bc2748f0e00 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -66,6 +66,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
 acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
 
 # These are (potentially) separate modules
+acpi-y				+= acpi_mac_passthru.o
 
 # IPMI may be used by other drivers, so it has to initialise before them
 obj-$(CONFIG_ACPI_IPMI)		+= acpi_ipmi.o
diff --git a/drivers/acpi/acpi_mac_passthru.c b/drivers/acpi/acpi_mac_passthru.c
new file mode 100644
index 000000000000..37d7e2388c0b
--- /dev/null
+++ b/drivers/acpi/acpi_mac_passthru.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * acpi_mac_passthru.c - ACPI MAC address pass through driver
+ *
+ *  Copyright (c) 2019 Dell Technology. All rights reserved.
+ *
+ * Search for MAC Address Pass Through information, and return the MAC address
+ * found.  This is set through enterprise policy settings, and expected to be
+ * read by ethernet drivers that have software programmable MAC addresses.
+ * Failure to find the needed information results in -ENODEV.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <acpi/acpi_mac_passthru.h>
+#include <linux/etherdevice.h>
+
+ACPI_MODULE_NAME("mapt");
+
+MODULE_AUTHOR("Charles Hyde");
+MODULE_DESCRIPTION("ACPI MAPT Driver");
+MODULE_LICENSE("GPL");
+
+int get_acpi_mac_passthru(char *macAddress)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	int ret = -EINVAL;
+	unsigned char buf[6];
+
+	/* returns _AUXMAC_#AABBCCDDEEFF# */
+	status = acpi_evaluate_object(NULL, "\\_SB.AMAC", NULL, &buffer);
+	obj = (union acpi_object *)buffer.pointer;
+	if (!ACPI_SUCCESS(status))
+		return -ENODEV;
+	if (obj->type != ACPI_TYPE_BUFFER || obj->string.length != 0x17) {
+		acpi_info("Invalid buffer for pass-thru MAC addr: (%d, %d)\n",
+			  obj->type, obj->string.length);
+		goto amacout;
+	}
+	if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) != 0 ||
+	    strncmp(obj->string.pointer + 0x15, "#", 1) != 0) {
+		acpi_info("Invalid header when reading pass-thru MAC addr\n");
+		goto amacout;
+	}
+	ret = hex2bin(buf, obj->string.pointer + 9, 6);
+	if (!(ret == 0 && is_valid_ether_addr(buf))) {
+		acpi_info("Invalid MAC for pass-thru MAC addr: %d, %pM\n",
+			  ret, buf);
+		ret = -EINVAL;
+		goto amacout;
+	}
+	memcpy(macAddress, buf, 6);
+	acpi_info("Pass-thru MAC addr %pM\n", macAddress);
+
+amacout:
+	kfree(obj);
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(get_acpi_mac_passthru);
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 04137ac373b0..6b9de6ae6524 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -23,6 +23,7 @@
 #include <linux/usb/cdc.h>
 #include <linux/suspend.h>
 #include <linux/acpi.h>
+#include <acpi/acpi_mac_passthru.h>
 
 /* Information for net-next */
 #define NETNEXT_VERSION		"09"
@@ -1178,12 +1179,7 @@ static int rtl8152_set_mac_address(struct net_device *netdev, void *p)
  */
 static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 {
-	acpi_status status;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	int ret = -EINVAL;
 	u32 ocp_data;
-	unsigned char buf[6];
 
 	/* test for -AD variant of RTL8153 */
 	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
@@ -1204,39 +1200,7 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 			return -ENODEV;
 		}
 	}
-
-	/* returns _AUXMAC_#AABBCCDDEEFF# */
-	status = acpi_evaluate_object(NULL, "\\_SB.AMAC", NULL, &buffer);
-	obj = (union acpi_object *)buffer.pointer;
-	if (!ACPI_SUCCESS(status))
-		return -ENODEV;
-	if (obj->type != ACPI_TYPE_BUFFER || obj->string.length != 0x17) {
-		netif_warn(tp, probe, tp->netdev,
-			   "Invalid buffer for pass-thru MAC addr: (%d, %d)\n",
-			   obj->type, obj->string.length);
-		goto amacout;
-	}
-	if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) != 0 ||
-	    strncmp(obj->string.pointer + 0x15, "#", 1) != 0) {
-		netif_warn(tp, probe, tp->netdev,
-			   "Invalid header when reading pass-thru MAC addr\n");
-		goto amacout;
-	}
-	ret = hex2bin(buf, obj->string.pointer + 9, 6);
-	if (!(ret == 0 && is_valid_ether_addr(buf))) {
-		netif_warn(tp, probe, tp->netdev,
-			   "Invalid MAC for pass-thru MAC addr: %d, %pM\n",
-			   ret, buf);
-		ret = -EINVAL;
-		goto amacout;
-	}
-	memcpy(sa->sa_data, buf, 6);
-	netif_info(tp, probe, tp->netdev,
-		   "Using pass-thru MAC addr %pM\n", sa->sa_data);
-
-amacout:
-	kfree(obj);
-	return ret;
+	return get_acpi_mac_passthru(sa->sa_data);
 }
 
 static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
@@ -4311,10 +4275,10 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	if (!tp)
 		return 0;
 
-	/* reset the MAC adddress in case of policy change */
+	/* reset the MAC address in case of policy change */
 	if (determine_ethernet_addr(tp, &sa) >= 0) {
 		rtnl_lock();
-		dev_set_mac_address (tp->netdev, &sa, NULL);
+		dev_set_mac_address(tp->netdev, &sa, NULL);
 		rtnl_unlock();
 	}
 
diff --git a/include/acpi/acpi_mac_passthru.h b/include/acpi/acpi_mac_passthru.h
new file mode 100644
index 000000000000..79c7a2d1062e
--- /dev/null
+++ b/include/acpi/acpi_mac_passthru.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * acpi_mac_passthru.h - ACPI MAC address pass through driver
+ *
+ *  Copyright (c) 2019 Dell Technology. All rights reserved.
+ *
+ * Search for MAC Address Pass Through information, and return the MAC address
+ * found.  This is set through enterprise policy settings, and expected to be
+ * read by ethernet drivers that have software programmable MAC addresses.
+ * Failure to find the needed information results in -ENODEV.
+ */
+
+#include <linux/module.h>
+#include <linux/acpi.h>
+
+#ifdef CONFIG_ACPI
+
+int get_acpi_mac_passthru(char *macAddress);
+
+#else
+
+static inline int get_acpi_mac_passthru(char *macAddress)
+{
+	return -ENODEV;
+}
+
+#endif
-- 
2.20.1

