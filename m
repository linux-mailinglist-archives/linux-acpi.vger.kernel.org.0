Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC040F938
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Sep 2021 15:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244913AbhIQNfe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Sep 2021 09:35:34 -0400
Received: from foss.arm.com ([217.140.110.172]:53256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240873AbhIQNfa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Sep 2021 09:35:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D789F1063;
        Fri, 17 Sep 2021 06:34:07 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2A913F719;
        Fri, 17 Sep 2021 06:34:06 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH v2 01/14] mailbox: pcc: Fix kernel doc warnings
Date:   Fri, 17 Sep 2021 14:33:44 +0100
Message-Id: <20210917133357.1911092-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917133357.1911092-1-sudeep.holla@arm.com>
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kernel doc validation script is unhappy and complains with the below set
of warnings.

  |  drivers/mailbox/pcc.c:179: warning: Function parameter or member 'irq'
  |	not described in 'pcc_mbox_irq'
  |  drivers/mailbox/pcc.c:179: warning: Function parameter or member 'p'
  |	not described in 'pcc_mbox_irq'
  |  drivers/mailbox/pcc.c:378: warning: expecting prototype for
  |	parse_pcc_subspaces(). Prototype was for parse_pcc_subspace() instead

Fix it.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 0296558f9e22..23391e224a68 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -174,6 +174,10 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
 
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
+ * @irq:	interrupt number
+ * @p: data/cookie passed from the caller to identify the channel
+ *
+ * Returns: IRQ_HANDLED if interrupt is handled or IRQ_NONE if not
  */
 static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
@@ -364,7 +368,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
 };
 
 /**
- * parse_pcc_subspaces -- Count PCC subspaces defined
+ * parse_pcc_subspace - Count PCC subspaces defined
  * @header: Pointer to the ACPI subtable header under the PCCT.
  * @end: End of subtable entry.
  *
-- 
2.25.1

