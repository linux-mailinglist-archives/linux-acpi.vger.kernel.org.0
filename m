Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1412C5651EA
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jul 2022 12:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiGDKQr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jul 2022 06:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiGDKQV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2022 06:16:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B71BDEB2;
        Mon,  4 Jul 2022 03:16:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90F36D6E;
        Mon,  4 Jul 2022 03:16:17 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 643F03F792;
        Mon,  4 Jul 2022 03:16:15 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, conor.dooley@microchip.com,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: [PATCH v6 01/21] ACPI: PPTT: Use table offset as fw_token instead of virtual address
Date:   Mon,  4 Jul 2022 11:15:45 +0100
Message-Id: <20220704101605.1318280-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220704101605.1318280-1-sudeep.holla@arm.com>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is need to use the cache sharing information quite early during
the boot before the secondary cores are up and running. The permanent
memory map for all the ACPI tables(via acpi_permanent_mmap) is turned
on in acpi_early_init() which is quite late for the above requirement.

As a result there is possibility that the ACPI PPTT gets mapped to
different virtual addresses. In such scenarios, using virtual address as
fw_token before the acpi_permanent_mmap is enabled results in different
fw_token for the same cache entity and hence wrong cache sharing
information will be deduced based on the same.

Instead of using virtual address, just use the table offset as the
unique firmware token for the caches. The same offset is used as
ACPI identifiers if the firmware has not set a valid one for other
entries in the ACPI PPTT.

Cc: linux-acpi@vger.kernel.org
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/pptt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 701f61c01359..763f021d45e6 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -437,7 +437,8 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 		pr_debug("found = %p %p\n", found_cache, cpu_node);
 		if (found_cache)
 			update_cache_properties(this_leaf, found_cache,
-			                        cpu_node, table->revision);
+						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
+						table->revision);
 
 		index++;
 	}
-- 
2.37.0

