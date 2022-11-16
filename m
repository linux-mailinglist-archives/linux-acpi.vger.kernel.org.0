Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE062B42A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Nov 2022 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiKPHth (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Nov 2022 02:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiKPHtg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2022 02:49:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53F7E13D21
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2022 23:49:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A1AA13D5;
        Tue, 15 Nov 2022 23:49:41 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8018D3F73B;
        Tue, 15 Nov 2022 23:49:34 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/5] ACPI: Bunch of fixes to silence missing prototype warnings
Date:   Wed, 16 Nov 2022 07:49:25 +0000
Message-Id: <20221116074930.3292121-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Initially I thought of bundling all in one patch, but I see you have
different branches for different sub-components, I split them. You can
squash them as needed.

Also I have marked all reported by LKP though it was just 3/5 as that
triggered to post these fixes :).

Regards,
Sudeep

Sudeep Holla (5):
  ACPI: APEI: Silence missing prototype warnings
  ACPI: processor_idle: Silence missing prototype warnings
  ACPI: FFH: Silence missing prototype warnings
  ACPI: PM: Silence missing prototype warning
  ACPI: processor: Silence missing prototype warnings

 drivers/acpi/apei/apei-base.c |  1 +
 include/acpi/processor.h      | 10 ++++++++++
 include/linux/acpi.h          |  6 ++++++
 3 files changed, 17 insertions(+)

-- 
2.38.1

