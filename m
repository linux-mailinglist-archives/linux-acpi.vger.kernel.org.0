Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2646034E56A
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 12:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhC3K1G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 06:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230248AbhC3K0g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Mar 2021 06:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617099996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lxROx2o/6DRRnp+9MXEaFMDAzKSz1bzyaU05jsWz6Zw=;
        b=cK73bh5yhuFo5U98kaJGIaXwvU/k94k2VCjKHJ2idOKGiYwarv1cM6BJT6AQ/36Qg1f8Hl
        wH6ajcOcK3y54OhwrmuaGSTqKDEyanvjQ5C/wEiofFKdbLkFDqjE4Ag9q+PoFj9XFErH3e
        MtPJkIbUg+I9o9RPq8hhuZtib8rffaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-ePKY2B8kOpGd90nq2jDdhw-1; Tue, 30 Mar 2021 06:26:34 -0400
X-MC-Unique: ePKY2B8kOpGd90nq2jDdhw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F9FE801817;
        Tue, 30 Mar 2021 10:26:33 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0E456E707;
        Tue, 30 Mar 2021 10:26:31 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: processor: Fix build when !CONFIG_HOTPLUG_CPU
Date:   Tue, 30 Mar 2021 12:26:30 +0200
Message-Id: <20210330102630.264398-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kernel test robot reports build breakage with commit 5f5e49e999ac
("ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()") when
!CONFIG_HOTPLUG_CPU/!CONFIG_SMP. wakeup_cpu0() is defined under
CONFIG_SMP and start_cpu0() under CONFIG_HOTPLUG_CPU which, in its turn,
depend on CONFIG_SMP. Add #ifdef CONFIG_HOTPLUG_CPU to the block, this
should be sufficient.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5f5e49e999ac ("ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f0c73f658880..0925b1477230 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -539,7 +539,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 		} else
 			return -ENODEV;
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
 		/* If NMI wants to wake up CPU0, start CPU0. */
 		if (wakeup_cpu0())
 			start_cpu0();
-- 
2.30.2

