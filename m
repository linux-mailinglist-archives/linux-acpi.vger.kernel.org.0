Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DC2455CBB
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 14:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhKRNgX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 08:36:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54764 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhKRNgW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 08:36:22 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 1066e3b864c68c92; Thu, 18 Nov 2021 14:33:21 +0100
Received: from kreacher.localnet (unknown [213.134.175.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6449566AB00;
        Thu, 18 Nov 2021 14:33:20 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ACPI: CPPC: Add NULL pointer check to cppc_get_perf()
Date:   Thu, 18 Nov 2021 14:33:19 +0100
Message-ID: <2611837.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.214
X-CLIENT-HOSTNAME: 213.134.175.214
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeigdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrddujeehrddvudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrvddugedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthht
 ohepkhgrihdrhhgvnhhgrdhfvghnghestggrnhhonhhitggrlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Check cpc_desc against NULL in cppc_get_perf(), so it doesn't crash
down the road if cpc_desc is NULL.

Fixes: 0654cf05d17b ("ACPI: CPPC: Introduce cppc_get_nominal_perf()")
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 5.15+ <stable@vger.kernel.org> # 5.15+
---
 drivers/acpi/cppc_acpi.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/drivers/acpi/cppc_acpi.c
===================================================================
--- linux-pm.orig/drivers/acpi/cppc_acpi.c
+++ linux-pm/drivers/acpi/cppc_acpi.c
@@ -1000,6 +1000,11 @@ static int cppc_get_perf(int cpunum, enu
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *reg = &cpc_desc->cpc_regs[reg_idx];
 
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
+		return -ENODEV;
+	}
+
 	if (CPC_IN_PCC(reg)) {
 		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 		struct cppc_pcc_data *pcc_ss_data = NULL;



