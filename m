Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B82646BC
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 15:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfGJNGI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 09:06:08 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50147 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfGJNGH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jul 2019 09:06:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MiakT-1iNqtO0ZXD-00fl0x; Wed, 10 Jul 2019 15:05:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] acpi: blacklist: fix clang warning for unused dmi table
Date:   Wed, 10 Jul 2019 15:05:43 +0200
Message-Id: <20190710130555.1829974-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TmvFT3BGlOgpGE2mtyEuTZ8x+od2j9ySy54G1qqhRB0bbL6N4mO
 AuvRIBUOyxgyarVUUyZUjwOYiGbyzwb1XGM707MnAPDE3U/qOrenx4d9UgKtTlHAymlBBLM
 TT3LthCTFxVUTaLHM9IkNb5yzyxOPm8vqKF0I7oX2xtQECEzVXZJRKiTJ3GminbeyMUAreG
 uuGaRw1YeIbwPsP9a0psw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6H605534wpk=:pqhQ41ZMeC+ODWYjzWhZbL
 r/dyLemTAKDB+b1qxzol/EwkB9IAmA93rly9NRpHPN84zd/S5vrrrq3kFLRVaFYq+cptvNbtY
 cBdARv3WCTtgiXAryiCfg0OT9gJMrM8VnQQPsEI4yaQpfe/URDo4is8y9/hToOAu0FcV2t/3A
 zAFUApIlUFjyQfqdFk/+eefKly4Kp9hIutl6OUTlZvPZ8KVw/ItrFVvndZ3Xc7nY8gT7PNzwI
 KxVEo9TgsujwORHUOU8oJQPLOJ4fsR7UtzlYtwScaifBF+cv8k/7JdRgWmf3OKvEkLYS5n+CS
 Z7ItWoP9cWAIKoJHhs0GVuupu2pDD+xKxkIKE3BCBol7U/UFQv9ksxoycPICw9sLZSAhMlqmA
 iKP2rTgFbbeqSUSx5bUvaB4NIY1ElIn+t0HDF6A7g+aDS5WH1qofqzDNaaV0EBQ/31/RdETK6
 U4jrxPT9SbUjcL7mLoSr9Scu7ukJXaIHUwYNEbS1xRRXa56e6dZxOz8Pk30VSqlEwuLXGd2L7
 bgow5B59atChisWJ3jeIFTty8s9wiad38SeR2Kb+Xdz0grXfSn0MUKaZqEXkZdg0We3tywA3n
 B90FPQDaGBkABVXzE3LxZOWejitRJtERRI0wbTo3YWWG/l25bUwYG+Xr6/6mtep9HO8iz/tBS
 IM/9NXYzvRa8vKtQTVk4Ts0CA0ZGwMw8UEuRsJ3oT+NEuoC4I0Wx52r2i2/onB27Njczi+Sno
 P4xwsOUnTkjU+hNgOtmKnkP0/aoZGBX+5nVnnA==
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When CONFIG_DMI is disabled, we only have a tentative declaration,
which causes a warning from clang:

drivers/acpi/blacklist.c:20:35: error: tentative array definition assumed to have one element [-Werror]
static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;

As the variable is not actually used here, hide it entirely
in an #ifdef to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/blacklist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index ad2c565f5cbe..a86a770c9b79 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -17,7 +17,9 @@
 
 #include "internal.h"
 
+#ifdef CONFIG_DMI
 static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;
+#endif
 
 /*
  * POLICY: If *anything* doesn't work, put it on the blacklist.
@@ -61,7 +63,9 @@ int __init acpi_blacklisted(void)
 	}
 
 	(void)early_acpi_osi_init();
+#ifdef CONFIG_DMI
 	dmi_check_system(acpi_rev_dmi_table);
+#endif
 
 	return blacklisted;
 }
-- 
2.20.0

