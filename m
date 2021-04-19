Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3F363E3E
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Apr 2021 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhDSJIa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 05:08:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51839 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhDSJI3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2021 05:08:29 -0400
Received: from 36-229-230-199.dynamic-ip.hinet.net ([36.229.230.199] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lYPsr-0002tJ-Mg; Mon, 19 Apr 2021 09:07:58 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rjw@rjwysocki.net
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI: PM: s2idle: Invoke _PTS for s2idle
Date:   Mon, 19 Apr 2021 17:07:50 +0800
Message-Id: <20210419090750.1272562-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

HP EliteBook 840 G8 reboots on s2idle resume, and HP EliteBook 845 G8
wakes up immediately on s2idle. Both are caused by the XMM7360 WWAN PCI
card.

There's a WWAN specific method to really turn off the WWAN via EC:
    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
    ...
        If (CondRefOf (\_SB.PCI0.GP12.PTS))
        {
            \_SB.PCI0.GP12.PTS (Arg0)
        }
    ...
    }

    Scope (_SB.PCI0.GP12)
    {
    ...
        Method (PTS, 1, Serialized)
        {
            If (^^LPCB.EC0.ECRG)
            {
                If ((PDID == 0xFFFF))
                {
                    Return (Zero)
                }

                POFF ()
                SGIO (WWBR, One)
                Sleep (0x1E)
                Acquire (^^LPCB.EC0.ECMX, 0xFFFF)
                ^^LPCB.EC0.WWP = One
                Release (^^LPCB.EC0.ECMX)
                Sleep (0x01F4)
            }

            Return (Zero)
        }
    ...
    }

So let's also invok _PTS for s2idle.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/sleep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 09fd13757b65..7e84b4b09919 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -698,6 +698,7 @@ int acpi_s2idle_prepare(void)
 	}
 
 	acpi_enable_wakeup_devices(ACPI_STATE_S0);
+	acpi_enter_sleep_state_prep(ACPI_STATE_S0);
 
 	/* Change the configuration of GPEs to avoid spurious wakeup. */
 	acpi_enable_all_wakeup_gpes();
-- 
2.30.2

