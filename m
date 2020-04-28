Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65671BCF40
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Apr 2020 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgD1V6b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Apr 2020 17:58:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgD1V6b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2020 17:58:31 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M433w-1jTYEw1kga-00087w; Tue, 28 Apr 2020 23:58:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: avoid uninialized-variable warning
Date:   Tue, 28 Apr 2020 23:55:57 +0200
Message-Id: <20200428215804.48481-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UioHM7Mj+0Eo0lESm9cPbfkNKElkE5FMMWyONEoJUL+MKkYiYil
 oFmRQoS00WIFOIRokjNgrOqfgyz+XZriPo4zilWeliotO9S216I/cUxqpEmo2dh5CZGDKCS
 9U9ZGSAOV5LRyV+xcupEmhAsnbvLiU+fUCaM1Ky1ouQVgw2NeL6Jxhwk2V4XGc3/PVefbyE
 C/tpE041GA1fONZ4EGXEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cvniJsNKSy0=:5TtgRtaldRNY5gEaxEUgyV
 TsLJswhqx9Rrt16rpyK+XAOskon0V4l9A5tlxioAw3pOJ0NukBjJqdEMwc+sqTo3s+wxvoSh5
 wZ8mireBKdITbU+2gXsXjqtmDmg6lTkvtf4k3Pk8Zd/V4k3k5Ne1i8JZdtAiVK9XdWwjZ8EhA
 Hy/4QfZkmnLK5sLJKOZ0ee6RI2a2vRPnkgzQth9cf9aaAii6EtNY3tdrAp0oWihzADADePcol
 DyFrn6EwEyBlzawwvT3di6zIY7qsaLZ6Y62RgNiuDvwb0mX1cIKrz/ZYZ3ZO2B0MQ5qMyNqku
 R0+4dcEhmzA3SRDEejgpErvQeUQf/K7yl33TcmaiGmR2jiU5A16IKrH/FHHtOKvZYYKYGqvzb
 bHIfWeRtFSzlPmQxFJ6ACepqCV+SgvMi20+fjlWhYo8claiKAqq6REucizeCPN6AiYIsZflLw
 oS/LnV3g7dw1oHCAstVwigFpFZAH7xLMkB0EMj+6FmwLfzaMaQ+6iN4PmVnqnmb/+Fud77XPO
 pOnjWYUwgwY64tVx6rHSTGIsF/tacQkbdiwAy47jT/n4pCnWRdXDh11A4TKAJmGjQRxyk2iR9
 wYuE32CYEeA1nLYrJOAuVhRlH5Dx27esK/X7F/wOQnaHJVBkT0z11+OqucfP6WSCGvyhD80Xi
 8v13g8uGsC8W1NNpidgz2b30o6AS7Mu4OzzaaDE0Y2tb2EvcY71W+B5TVv/2sV1JHNFb53kmm
 ymyNn76swXp5C3NXGyajcLdb8xkP5W9fbCFpwjjKikABlKvItV1sMFnNDK/S8LnK/2UPHQPth
 MllxHZHqBfzknC7kbWgeHH6rof/qredVGu9j/ZJdO3n0QM8YLw=
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Older compilers like gcc-4.8 produce a bogus warning here

In file included from include/linux/compiler_types.h:68:0,
                 from <command-line>:0:
drivers/acpi/property.c: In function 'acpi_data_prop_read':
include/linux/compiler-gcc.h:75:45: error: 'obj' may be used uninitialized in this function [-Werror=maybe-uninitialized]
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                             ^
drivers/acpi/property.c:934:27: note: 'obj' was declared here
  const union acpi_object *obj;
                           ^

Ensure the output is always initialized even when returning an error
to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/property.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e601c4511a8b..3aa71daeb0b4 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -587,8 +587,10 @@ static int acpi_data_get_property_array(const struct acpi_device_data *data,
 	int ret, i;
 
 	ret = acpi_data_get_property(data, name, ACPI_TYPE_PACKAGE, &prop);
-	if (ret)
+	if (ret && obj) {
+		*obj = NULL;
 		return ret;
+	}
 
 	if (type != ACPI_TYPE_ANY) {
 		/* Check that all elements are of correct type. */
-- 
2.26.0

