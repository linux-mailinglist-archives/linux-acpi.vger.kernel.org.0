Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA5229FE35
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 08:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJ3HHW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 03:07:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58384 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3HHW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 03:07:22 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kYOVI-0007fV-84; Fri, 30 Oct 2020 07:07:17 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com
Cc:     hdegoede@redhat.com, linux-acpi@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Petr Mladek <pmladek@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PM / reboot: Use S5 for reboot
Date:   Fri, 30 Oct 2020 15:06:57 +0800
Message-Id: <20201030070659.16948-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After reboot, it's not possible to use hotkeys to enter BIOS setup and
boot menu on some HP laptops.

BIOS folks identified the root cause is the missing _PTS call, and BIOS
is expecting _PTS to do proper reset.

Using S5 for reboot is default behavior under Windows, "A full shutdown
(S5) occurs when a system restart is requested" [1], so let's do the
same here.

[1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-states

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index e7b78d5ae1ab..7e5aa1f78693 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -244,6 +244,8 @@ void migrate_to_reboot_cpu(void)
 void kernel_restart(char *cmd)
 {
 	kernel_restart_prepare(cmd);
+	if (pm_power_off_prepare)
+		pm_power_off_prepare();
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	if (!cmd)
-- 
2.17.1

