Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBA3243D7
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Feb 2021 19:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBXSh6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Feb 2021 13:37:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59938 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhBXSh5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Feb 2021 13:37:57 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 4a655fdd08b609bf; Wed, 24 Feb 2021 19:37:14 +0100
Received: from kreacher.localnet (89-64-80-80.dynamic.chello.pl [89.64.80.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 00E18661E2A;
        Wed, 24 Feb 2021 19:37:12 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v1] ACPI: processor: idle: Drop extra prefix from pr_notice()
Date:   Wed, 24 Feb 2021 19:37:12 +0100
Message-ID: <1888725.8kdNXL6VX8@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevudefgfeguedtjedvhfetveegleduveeuvedvjeekleefhfduhfefheekffefveenucfkphepkeelrdeigedrkedtrdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrkedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhhrghnjhhunheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop "ACPI: " from the pr_noitice() instance in
acpi_processor_cstate_first_run_checks(), because pr_fmt() causes
that prefix to be added to the message already.

Reported-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -780,8 +780,8 @@ static inline void acpi_processor_cstate
 	dmi_check_system(processor_power_dmi_table);
 	max_cstate = acpi_processor_cstate_check(max_cstate);
 	if (max_cstate < ACPI_C_STATES_MAX)
-		pr_notice("ACPI: processor limited to max C-state %d\n",
-			  max_cstate);
+		pr_notice("processor limited to max C-state %d\n", max_cstate);
+
 	first_run++;
 
 	if (nocst)



