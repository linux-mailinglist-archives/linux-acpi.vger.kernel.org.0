Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D5A1CCD46
	for <lists+linux-acpi@lfdr.de>; Sun, 10 May 2020 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgEJTaZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 May 2020 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgEJTaZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 May 2020 15:30:25 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268BC061A0C
        for <linux-acpi@vger.kernel.org>; Sun, 10 May 2020 12:30:25 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l17so1916372qvm.12
        for <linux-acpi@vger.kernel.org>; Sun, 10 May 2020 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mXwZ5xEMacGLAGAT+hxUPz7o/gx/ASvU7vsUpQBpy3c=;
        b=XUoDFznFaPfqCl2BoC5ySwRvOwJYLBlXmiBEmSdcosG433unOWfJizFt04Ny0vkLTc
         nUVPAOvrCFc/or9Y47Scr9LjpfaXwdjOZe6Drmw05Q4hsPT58QQkBKy049Oa8Gk1Q94G
         pLTYMzBcwIAR3/l2WWY3HnkAIeNZX+HEj0X9HeSmMpgzVgyqfkgO35zg2M2TJXhpIKyR
         VGJ6Bq94ktdL/EMHY7q6B3WwX84n6j9O3JkHMC5elRNDjtvPZ+5oNk7Fb2oKqUjXDtKS
         wIh5hYbq0CtmVv/BijQBo7cjigboj9NLtPgvfzdW0S0f7e4P0e3hrT1rPYw9+Gr+m6q8
         gmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mXwZ5xEMacGLAGAT+hxUPz7o/gx/ASvU7vsUpQBpy3c=;
        b=EBO/LdlhCOGPwQfUsQqFIrHI505xneB7Q18q7mL6XQA1kX+hAuo6czOu/Uwkq6ypVO
         9LMXzVhjp4OFISlcoYonS7NTUaEUoP7AsFzpn+RDIZrRORADRWuTLQF5azyZ/ld5X/jE
         FRi0acbuInVmIgeqDEiKI4ao5diriVz0j+ad7Hw9UgGfc64RTeLLXA0inKVo0voyVkD8
         nlzNYPVRADVI2o9cZX2MxWOnDJumVkuTICaRobxxGln1Xm303AuO6T0Txk2pjBwkMySX
         cs8eti1O2bAMxlSQxtq9jcCI1ZYDWg/hMvtGA8PdgGnrWV8TDE7oNhJBcGGEWr7Ri0rm
         UZAw==
X-Gm-Message-State: AGi0PuZKR2Cqt6kEB1UxipKRLgAAPelQtxwc91nL2qVgmZHsxCpfB6Op
        yUVT5HPfrdsRw78lEJwEuRcNDEry5MmO
X-Google-Smtp-Source: APiQypJcwkKf5yk+n7t76FpvDZg+C1Ze5SkZY2UCjpjO5wjduNmknOO1OFYfb69P6qufqGoYYeTo79hlFIW4
X-Received: by 2002:ad4:4b6b:: with SMTP id m11mr12237295qvx.130.1589139024298;
 Sun, 10 May 2020 12:30:24 -0700 (PDT)
Date:   Sun, 10 May 2020 20:30:16 +0100
Message-Id: <20200510193016.100818-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] ACPI: Delete unused proc filename macros
From:   Pascal Terjan <pterjan@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Those were used to create files in /proc/acpi long ago
and were missed when that code was deleted.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
 drivers/acpi/button.c   | 1 -
 drivers/acpi/ec.c       | 1 -
 drivers/acpi/pci_link.c | 2 --
 drivers/acpi/power.c    | 2 --
 drivers/acpi/sbs.c      | 3 ---
 5 files changed, 9 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 78cfc70cb320..3c35e57dd854 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -24,7 +24,6 @@
 #define PREFIX "ACPI: "
 
 #define ACPI_BUTTON_CLASS		"button"
-#define ACPI_BUTTON_FILE_INFO		"info"
 #define ACPI_BUTTON_FILE_STATE		"state"
 #define ACPI_BUTTON_TYPE_UNKNOWN	0x00
 #define ACPI_BUTTON_NOTIFY_STATUS	0x80
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b4c0152e92aa..8535bea2f4e3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -34,7 +34,6 @@
 
 #define ACPI_EC_CLASS			"embedded_controller"
 #define ACPI_EC_DEVICE_NAME		"Embedded Controller"
-#define ACPI_EC_FILE_INFO		"info"
 
 /* EC status register */
 #define ACPI_EC_FLAG_OBF	0x01	/* Output buffer full */
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index ed3d2182cf2c..606da5d77ad3 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -31,8 +31,6 @@
 ACPI_MODULE_NAME("pci_link");
 #define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
 #define ACPI_PCI_LINK_DEVICE_NAME	"PCI Interrupt Link"
-#define ACPI_PCI_LINK_FILE_INFO		"info"
-#define ACPI_PCI_LINK_FILE_STATUS	"state"
 #define ACPI_PCI_LINK_MAX_POSSIBLE	16
 
 static int acpi_pci_link_add(struct acpi_device *device,
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index fe1e7bc91a5e..837b875d075e 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -36,8 +36,6 @@
 ACPI_MODULE_NAME("power");
 #define ACPI_POWER_CLASS		"power_resource"
 #define ACPI_POWER_DEVICE_NAME		"Power Resource"
-#define ACPI_POWER_FILE_INFO		"info"
-#define ACPI_POWER_FILE_STATUS		"state"
 #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 6e88224f60f0..f158b8c30113 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -28,9 +28,6 @@
 #define ACPI_SBS_CLASS			"sbs"
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_SBS_DEVICE_NAME		"Smart Battery System"
-#define ACPI_SBS_FILE_INFO		"info"
-#define ACPI_SBS_FILE_STATE		"state"
-#define ACPI_SBS_FILE_ALARM		"alarm"
 #define ACPI_BATTERY_DIR_NAME		"BAT%i"
 #define ACPI_AC_DIR_NAME		"AC0"
 
-- 
2.26.2.645.ge9eca65c58-goog

