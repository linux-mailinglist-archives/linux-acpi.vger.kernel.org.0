Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB259B36
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2019 14:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfF1Map (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jun 2019 08:30:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfF1Mao (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jun 2019 08:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3U5YF3xQh+S36YR0v52vw6kYXLIHMHgDOgr+vXVq2+g=; b=dCsKIK9u+Ckb2ZK3dWXuawb317
        vhUfkryiDkUDvvVgbPlo1ljfy3QC+8DgdmwFJ01Mskjwvd8nbcEXI4s7FtJl3LC+cMZ4knFdyHEtr
        9uJhwh6aWt+jZjIG1M07LKYuHjtA0h8tKG4DlZLDYSxw77iO8SKrl1W2UVb93Syde95hkO8X15ZyR
        Vws41hMk6idyjYqZEI11+LFHu1NC78F8b7Evst5mz20YZjriR2rhR5ZlSrNbnYobbDnsw9N2vVZU3
        X5jwYMqx0LCMXOhGEeW09Ac1o0f+B1p+txh+WeEs79FQiTzp4cUC0l7SvSC+6SccXUHRqNHbm5D8L
        rJ+e71/w==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1W-00054q-0t; Fri, 28 Jun 2019 12:30:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005U2-VA; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 39/39] docs: gpio: add sysfs interface to the admin-guide
Date:   Fri, 28 Jun 2019 09:30:32 -0300
Message-Id: <1ecff14ec37c0c434f003d93c4b86b1cd3dac834.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While this is stated as obsoleted, the sysfs interface described
there is still valid, and belongs to the admin-guide.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/obsolete/sysfs-gpio             | 2 +-
 Documentation/{ => admin-guide}/gpio/index.rst    | 2 +-
 Documentation/{ => admin-guide}/gpio/sysfs.rst    | 0
 Documentation/admin-guide/index.rst               | 1 +
 Documentation/firmware-guide/acpi/enumeration.rst | 2 +-
 Documentation/translations/zh_CN/gpio.txt         | 4 ++--
 MAINTAINERS                                       | 2 +-
 7 files changed, 7 insertions(+), 6 deletions(-)
 rename Documentation/{ => admin-guide}/gpio/index.rst (78%)
 rename Documentation/{ => admin-guide}/gpio/sysfs.rst (100%)

diff --git a/Documentation/ABI/obsolete/sysfs-gpio b/Documentation/ABI/obsolete/sysfs-gpio
index 40d41ea1a3f5..e0d4e5e2dd90 100644
--- a/Documentation/ABI/obsolete/sysfs-gpio
+++ b/Documentation/ABI/obsolete/sysfs-gpio
@@ -11,7 +11,7 @@ Description:
   Kernel code may export it for complete or partial access.
 
   GPIOs are identified as they are inside the kernel, using integers in
-  the range 0..INT_MAX.  See Documentation/gpio for more information.
+  the range 0..INT_MAX.  See Documentation/admin-guide/gpio for more information.
 
     /sys/class/gpio
 	/export ... asks the kernel to export a GPIO to userspace
diff --git a/Documentation/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
similarity index 78%
rename from Documentation/gpio/index.rst
rename to Documentation/admin-guide/gpio/index.rst
index 09a4a553f434..a244ba4e87d5 100644
--- a/Documentation/gpio/index.rst
+++ b/Documentation/admin-guide/gpio/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ====
 gpio
diff --git a/Documentation/gpio/sysfs.rst b/Documentation/admin-guide/gpio/sysfs.rst
similarity index 100%
rename from Documentation/gpio/sysfs.rst
rename to Documentation/admin-guide/gpio/sysfs.rst
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 2c20607e90cd..367097abec78 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -90,6 +90,7 @@ configure specific aspects of kernel behavior to your liking.
    cputopology
    device-mapper/index
    efi-stub
+   gpio/index
    highuid
    hw_random
    iostats
diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 1252617b520f..0a72b6321f5f 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -316,7 +316,7 @@ specifies the path to the controller. In order to use these GPIOs in Linux
 we need to translate them to the corresponding Linux GPIO descriptors.
 
 There is a standard GPIO API for that and is documented in
-Documentation/gpio/.
+Documentation/admin-guide/gpio/.
 
 In the above example we can get the corresponding two GPIO descriptors with
 a code like this::
diff --git a/Documentation/translations/zh_CN/gpio.txt b/Documentation/translations/zh_CN/gpio.txt
index 4cb1ba8b8fed..a23ee14fc927 100644
--- a/Documentation/translations/zh_CN/gpio.txt
+++ b/Documentation/translations/zh_CN/gpio.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/gpio
+Chinese translated version of Documentation/admin-guide/gpio
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -10,7 +10,7 @@ Maintainer: Grant Likely <grant.likely@secretlab.ca>
 		Linus Walleij <linus.walleij@linaro.org>
 Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
 ---------------------------------------------------------------------
-Documentation/gpio 的中文翻译
+Documentation/admin-guide/gpio 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
diff --git a/MAINTAINERS b/MAINTAINERS
index cda68bbd9d1c..a49698b3becd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6812,7 +6812,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/
 F:	Documentation/driver-api/gpio/
-F:	Documentation/gpio/
+F:	Documentation/admin-guide/gpio/
 F:	Documentation/ABI/testing/gpio-cdev
 F:	Documentation/ABI/obsolete/sysfs-gpio
 F:	drivers/gpio/
-- 
2.21.0

