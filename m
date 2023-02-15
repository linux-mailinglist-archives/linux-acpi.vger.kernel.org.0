Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA339698651
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Feb 2023 21:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBOUt2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Feb 2023 15:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBOUsR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Feb 2023 15:48:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C923D917;
        Wed, 15 Feb 2023 12:47:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E0761D77;
        Wed, 15 Feb 2023 20:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E31C433EF;
        Wed, 15 Feb 2023 20:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676494030;
        bh=GQ08yFHf4pHxSA9s+q7OB5AMq+IQQ7ZJNCksR+Sqv0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnOoN45Iw7VB/kN2ZX4RujDmMzcLrK2JR3lxibPZ9Yt8MlwhM/ht3ADbWNrgiYI/Q
         NghADhHrlE4+cD0AJd1n8EDlpdAX0m0Wg22O/CCeedEv6FyM1k9So9VlI39LIWZQCw
         X/R7JrwzP9ebdcdbIH9rNp6BKRSUoSsZVE6DgJ//i6GOsjQQfAu/PElQPVmeRbi7aW
         8kqPvBqrduNO0GSfYTAiP37uHvxpVShftp0iiOjmLlQ4bgxSGmW5z/PQ+qbUBCc16s
         LryqwJH4II2vjPsU0e5pIZNMKEIwu6SPk1mGccDKrOmydbH1o5dX8Bpy7i+RBgUx5o
         KX9BXT/xmD7DQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, dave.jiang@intel.com,
        ira.weiny@intel.com, rafael@kernel.org, nvdimm@lists.linux.dev,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/4] ACPI: NFIT: fix a potential deadlock during NFIT teardown
Date:   Wed, 15 Feb 2023 15:47:06 -0500
Message-Id: <20230215204708.2761432-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215204708.2761432-1-sashal@kernel.org>
References: <20230215204708.2761432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Vishal Verma <vishal.l.verma@intel.com>

[ Upstream commit fb6df4366f86dd252bfa3049edffa52d17e7b895 ]

Lockdep reports that acpi_nfit_shutdown() may deadlock against an
opportune acpi_nfit_scrub(). acpi_nfit_scrub () is run from inside a
'work' and therefore has already acquired workqueue-internal locks. It
also acquiires acpi_desc->init_mutex. acpi_nfit_shutdown() first
acquires init_mutex, and was subsequently attempting to cancel any
pending workqueue items. This reversed locking order causes a potential
deadlock:

    ======================================================
    WARNING: possible circular locking dependency detected
    6.2.0-rc3 #116 Tainted: G           O     N
    ------------------------------------------------------
    libndctl/1958 is trying to acquire lock:
    ffff888129b461c0 ((work_completion)(&(&acpi_desc->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0x43/0x450

    but task is already holding lock:
    ffff888129b460e8 (&acpi_desc->init_mutex){+.+.}-{3:3}, at: acpi_nfit_shutdown+0x87/0xd0 [nfit]

    which lock already depends on the new lock.

    ...

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(&acpi_desc->init_mutex);
                                  lock((work_completion)(&(&acpi_desc->dwork)->work));
                                  lock(&acpi_desc->init_mutex);
     lock((work_completion)(&(&acpi_desc->dwork)->work));

    *** DEADLOCK ***

Since the workqueue manipulation is protected by its own internal locking,
the cancellation of pending work doesn't need to be done under
acpi_desc->init_mutex. Move cancel_delayed_work_sync() outside the
init_mutex to fix the deadlock. Any work that starts after
acpi_nfit_shutdown() drops the lock will see ARS_CANCEL, and the
cancel_delayed_work_sync() will safely flush it out.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Link: https://lore.kernel.org/r/20230112-acpi_nfit_lockdep-v1-1-660be4dd10be@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 58a756ca14d85..c2863eec0f241 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3442,8 +3442,8 @@ void acpi_nfit_shutdown(void *data)
 
 	mutex_lock(&acpi_desc->init_mutex);
 	set_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
-	cancel_delayed_work_sync(&acpi_desc->dwork);
 	mutex_unlock(&acpi_desc->init_mutex);
+	cancel_delayed_work_sync(&acpi_desc->dwork);
 
 	/*
 	 * Bounce the nvdimm bus lock to make sure any in-flight
-- 
2.39.0

