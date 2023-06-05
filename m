Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596397223A5
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jun 2023 12:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjFEKgH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 06:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjFEKfq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 06:35:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE76D103
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 03:35:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1429ED75;
        Mon,  5 Jun 2023 03:36:26 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E91D03F793;
        Mon,  5 Jun 2023 03:35:39 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH] ACPI: FFH: Drop the inclusion of linux/arm-smccc.h
Date:   Mon,  5 Jun 2023 11:35:36 +0100
Message-Id: <20230605103536.2427428-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The inclusion of linux/arm-smccc.h in acpi_ffh is unnecessary and can
be even termed wrong. It is needed in the arm64 architecture callback
implementation and probably is the leftover from the missed cleanup of
the initial implementation.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/acpi_ffh.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpi_ffh.c b/drivers/acpi/acpi_ffh.c
index 19aff808bbb8..8d5126963dc7 100644
--- a/drivers/acpi/acpi_ffh.c
+++ b/drivers/acpi/acpi_ffh.c
@@ -9,8 +9,6 @@
 #include <linux/idr.h>
 #include <linux/io.h>
 
-#include <linux/arm-smccc.h>
-
 static struct acpi_ffh_info ffh_ctx;
 
 int __weak acpi_ffh_address_space_arch_setup(void *handler_ctxt,
-- 
2.40.1

