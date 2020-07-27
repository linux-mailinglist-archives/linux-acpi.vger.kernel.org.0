Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C612822E905
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jul 2020 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgG0JaL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 05:30:11 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40116 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgG0JaK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Jul 2020 05:30:10 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxOMWCnh5fqSYBAA--.683S2;
        Mon, 27 Jul 2020 17:29:40 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Ning Sun <ning.sun@intel.com>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        tboot-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] ACPI: Use valid link of ACPI specification
Date:   Mon, 27 Jul 2020 17:29:38 +0800
Message-Id: <1595842178-20351-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxOMWCnh5fqSYBAA--.683S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1fuF13Wr47ZrWrtry5urg_yoW8KFWrpF
        s5KryIk34xtr1Uua18Cw17WFy5W3Z7uFW7Kr48Cw18uF4UWryvqF1akFyYya4UJr4fCFW0
        qrZ7tF1Uu3WI9rJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        Uq38nUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently, acpi.info is an invalid link to access ACPI specification,
the new valid link is https://uefi.org/specifications.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/hwmon/acpi_power_meter.rst      | 2 +-
 drivers/acpi/Kconfig                          | 3 +--
 include/linux/tboot.h                         | 2 +-
 tools/power/cpupower/man/cpupower-idle-info.1 | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/acpi_power_meter.rst b/Documentation/hwmon/acpi_power_meter.rst
index 4a0941a..8628c11 100644
--- a/Documentation/hwmon/acpi_power_meter.rst
+++ b/Documentation/hwmon/acpi_power_meter.rst
@@ -9,7 +9,7 @@ Supported systems:
 
     Prefix: 'power_meter'
 
-    Datasheet: http://acpi.info/, section 10.4.
+    Datasheet: https://uefi.org/specifications, section 10.4.
 
 Author: Darrick J. Wong
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ce2730d..7428cd2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -40,8 +40,7 @@ menuconfig ACPI
 	  the UEFI Forum and any UEFI member can join the ASWG and contribute
 	  to the ACPI specification.
 	  The specification is available at:
-	  <http://www.acpi.info>
-	  <http://www.uefi.org/acpi/specs>
+	  <https://uefi.org/specifications>
 
 if ACPI
 
diff --git a/include/linux/tboot.h b/include/linux/tboot.h
index c7e4247..5146d25 100644
--- a/include/linux/tboot.h
+++ b/include/linux/tboot.h
@@ -44,7 +44,7 @@ struct tboot_acpi_generic_address {
 
 /*
  * combines Sx info from FADT and FACS tables per ACPI 2.0+ spec
- * (http://www.acpi.info/)
+ * (https://uefi.org/specifications)
  */
 struct tboot_acpi_sleep_info {
 	struct tboot_acpi_generic_address pm1a_cnt_blk;
diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
index 80a1311..20b6345 100644
--- a/tools/power/cpupower/man/cpupower-idle-info.1
+++ b/tools/power/cpupower/man/cpupower-idle-info.1
@@ -75,7 +75,7 @@ By default only values of core zero are displayed. How to display settings of
 other cores is described in the cpupower(1) manpage in the \-\-cpu option
 section.
 .SH REFERENCES
-http://www.acpi.info/spec.htm
+https://uefi.org/specifications
 .SH "FILES"
 .nf
 \fI/sys/devices/system/cpu/cpu*/cpuidle/state*\fP
-- 
2.1.0

