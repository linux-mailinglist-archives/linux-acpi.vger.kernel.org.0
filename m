Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF26228B571
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Oct 2020 15:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgJLNFC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Oct 2020 09:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgJLNFB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2020 09:05:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8DEC0613D0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2020 06:04:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so19134987wre.4
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2020 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mw5Em4aE3qEp++OcHAGqsS3uc6sy84K+Ohs00nPdE7I=;
        b=CexAZa9Btkkcut/3kpTdGNWCqscJAlQb/ILDHx+AnB65z+dA0B3XvhoLLg4uNg+Fml
         yDOdlPOSI3YVhibnaUJMfRCqzI3DHUwBOTBJ9miOM6aN+pmRrxeQegswE6FJbKh6iBuv
         yoms3la/avTrTyVbOZOFVAeRQxO2LdHyb8zd4fYpqfRWJo37xjoqJ4h0udaT7/Yh/oMM
         6tRYDaNciHTlXhl25cZ6d/dahY/fgINrUjRBzG6NkQ9X48x5RYLrrDbrazNQ0BvYLPOP
         mPXXLJqCFtu7ZTjsALDpca/lPPpKJAU6elitu5/WVlbWV+x1gOrs5SJF79Ty1PT7OTIq
         9NBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mw5Em4aE3qEp++OcHAGqsS3uc6sy84K+Ohs00nPdE7I=;
        b=kiRTxBbC03qoyoLrJ/B6j2Jpl5zKpocTJ3kNuV/Q0KJU2IlWSS8g9aCn025WjWV8CP
         +gpwsBBe9UG/Qtjm+KB5TYQA+rrvrjImVIBvW7pck87203gIspmrNgR/BeZYqU3V4wd4
         pwwyi8FNCNbv1Q+xC2A8ODhI6DPDgBFB+PUtmZ1JQ0lDtaZ8zuHC+JepnJd6msv299Ea
         gcrAhtFBNliYoKXh0c5DgmTjyNKXR8gZ/ASh53CADMXo2I4KQm/OjkkA9xeCO3nm27KP
         EvWN1QAt/Dqfv+KvjmAsNuM2i5Vg9vJCG/AmJdhNqb39J22oQ/C5rt02+IAHm/K1b5/s
         aPGQ==
X-Gm-Message-State: AOAM530Yu4x9KiiIBQDv3kYJpqOW2uOrcy25aufvSn2MX8WXIk95IY7g
        c7ZN60tfrL/VH5jz6uqu6sw8noIIuYhFIxyySiOUCclIlgIKOJfmHepMopiRoKBxQGiDldlbxPh
        bKUXWRHx/8jiKv1qVLumm+jtiSc3N3PvqVSW8GL7PtEFoQkmabkg1A/IwcKV3eyYvXWctbLwvRA
        Y=
X-Google-Smtp-Source: ABdhPJx6ftcFXux6jevC/Yb/ZbzeVoptGmVfabIIbydCRoiSguSjrVKLawswHofb/TfwsVyxiY8IAQ==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr29159037wrv.369.1602507890618;
        Mon, 12 Oct 2020 06:04:50 -0700 (PDT)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id y10sm19209877wrq.73.2020.10.12.06.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:04:48 -0700 (PDT)
From:   Jamie Iles <jamie@nuviainc.com>
To:     linux-acpi@vger.kernel.org
Cc:     Jamie Iles <jamie@nuviainc.com>, Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCHv2] ACPI: debug: don't allow debugging when ACPI is disabled
Date:   Mon, 12 Oct 2020 14:04:46 +0100
Message-Id: <20201012130446.57325-1-jamie@nuviainc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009152116.35184-1-jamie@nuviainc.com>
References: <20201009152116.35184-1-jamie@nuviainc.com>
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

This is because acpi_debugger.lock has not been initialized as
acpi_debugger_init() is not called when ACPI is disabled.  Fail module
loading to avoid this and any subsequent problems that might arise by
trying to debug AML when ACPI is disabled.

Fixes: 8cfb0cdf07e2 ("ACPI / debugger: Add IO interface to access debugger functionalities")
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
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

