Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A24288C74
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Oct 2020 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbgJIPV2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387664AbgJIPV1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2020 11:21:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F5C0613D2
        for <linux-acpi@vger.kernel.org>; Fri,  9 Oct 2020 08:21:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so10218233wmf.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Oct 2020 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wuMwzFJGiXNbyxMe2gMBhOKs5AMVo2Pqd2QKlrNB/ws=;
        b=m6L8rjVsYldLQQsqSwx1guiHcKxE1+rI0zc7BiY0y3fDMXQPGBKbWcG4ldfwISLnrw
         Mg9DO+d43pejyWbsDcjNGp2sfcoXGT7m1GCXudRt/ulzzuj/KPTkH8AOTVI6WwVN1IwF
         2BllAXSQV6UO3JqXDzBs1aC55ZBtYzY+e7J6INQ+A+40sp4EZf9G6YY559LaF9kaLenB
         9KUFy6I0Krz+RrbC3tfX3BUC0+ty/NjIoNvdBoUkaudJflXQ4Rei0Puzs13Iddo47lFj
         PHi6+wj7+5guyJamFAjG827Tucf+iRHz2TpOwj9/nvht/k2ALgq/sc4lrf/ftETckVLv
         e+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wuMwzFJGiXNbyxMe2gMBhOKs5AMVo2Pqd2QKlrNB/ws=;
        b=BV9dGRJ7LQHlkzRS6eETpLorBPouLsmVBbUyxH3FAyLN5jpdSFAVdXSAN0H3k5zQ24
         OFm6/Jl1XQ0MRB51YaPHYJEgBHS2MBQrtARQIEl5RYQkCykX5qr9qYZwifKQTjVR8yi2
         y+02yDr0EQpLQXoZuoA7ONs98sqBwFCy5nL4vPmiAqWzX2DD0A0l6sgmVS8q1vD/92xQ
         R4BABNHTvwq0/XLN2tOhoZZG2U8dqJcRtI2c72ArW3r3iR69owc+swW15MPDq7ltUWwE
         4jKQOTdp+m1ISAsKz7Kg5PG3fUVT8ZWAZ0tmZrSzDtr0jR7Dqp1wawNI3kJmVj7QSCl+
         6B2A==
X-Gm-Message-State: AOAM532D/GLt+PD+AEqO1YmIP4DtSloUYGZS5ViNu7nJi3tJEJ+W97jM
        lIsQdTEEJi9Ihs5Ryygx8jk0azOu0VsZ+zR6/J4jCZI7VUnbaRWDO+ceaozMQyAF5EtBWqanJkX
        T48BwA9b0OmIngVskcZ7HF+VxJklkthn0JWRxdenmUMSFg/JyFdK7SFzVVE0OQmy0ErKD2GduT6
        Y=
X-Google-Smtp-Source: ABdhPJy8G3LWj+h4qV5r/F3/ksrgPLhUT2yDAVuFxAM/Vntrz27MDOlKhZWBJomnQYaqi5EujfzbJw==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr15569681wmi.73.1602256885472;
        Fri, 09 Oct 2020 08:21:25 -0700 (PDT)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id g139sm12648666wme.2.2020.10.09.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:21:24 -0700 (PDT)
From:   Jamie Iles <jamie@nuviainc.com>
To:     linux-acpi@vger.kernel.org
Cc:     Jamie Iles <jamie@nuviainc.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI: debug: don't allow debugging when ACPI is disabled
Date:   Fri,  9 Oct 2020 16:21:16 +0100
Message-Id: <20201009152116.35184-1-jamie@nuviainc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If ACPI is disabled then loading the acpi_dbg module will result in the
following splat when lock debugging is enabled.

  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
  WARNING: CPU: 0 PID: 1 at kernel/locking/mutex.c:938 __mutex_lock+0xa10/0x1290
  Kernel panic - not syncing: panic_on_warn set ...
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc8+ #103
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   dump_backtrace+0x0/0x4d8
   show_stack+0x34/0x48
   dump_stack+0x174/0x1f8
   panic+0x360/0x7a0
   __warn+0x244/0x2ec
   report_bug+0x240/0x398
   bug_handler+0x50/0xc0
   call_break_hook+0x160/0x1d8
   brk_handler+0x30/0xc0
   do_debug_exception+0x184/0x340
   el1_dbg+0x48/0xb0
   el1_sync_handler+0x170/0x1c8
   el1_sync+0x80/0x100
   __mutex_lock+0xa10/0x1290
   mutex_lock_nested+0x6c/0xc0
   acpi_register_debugger+0x40/0x88
   acpi_aml_init+0xc4/0x114
   do_one_initcall+0x24c/0xb10
   kernel_init_freeable+0x690/0x728
   kernel_init+0x20/0x1e8
   ret_from_fork+0x10/0x18

Fail module loading to avoid this and any subsequent problems that might
arise by trying to debug AML when ACPI is disabled.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Jamie Iles <jamie@nuviainc.com>
---
 drivers/acpi/acpi_dbg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index 6041974c7627..fb7290338593 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -749,6 +749,9 @@ static int __init acpi_aml_init(void)
 {
 	int ret;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	/* Initialize AML IO interface */
 	mutex_init(&acpi_aml_io.lock);
 	init_waitqueue_head(&acpi_aml_io.wait);
-- 
2.25.1

