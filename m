Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B8A3BC0BD
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhGEPhU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 11:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233210AbhGEPgM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jul 2021 11:36:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E2DF619A5;
        Mon,  5 Jul 2021 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625499117;
        bh=xgmsrfGkC+gkkkdJMrsvG1N/yAnLc31sKa/2Km/fPgI=;
        h=From:To:Cc:Subject:Date:From;
        b=Toqx1chJtieGCZSV7IwWeaFKf62jz5DDUiqhvxIWtbgl6Vutj+BIgwN1/BcajJ3n5
         6uSM3iCj/86hsH62PM1mUiRlvdhyicXbbE6zBW6nZ45TBAyOVYn/qsRNMGDS3WSIu/
         ntQ1P/7adjjn6YuunQFmKxUiqSRqE3ZY8AHjQMlnuxJ44G71qvnA5egU1x0QFqTzZ1
         0I8FxktW6L1o0oXfxXRhZXbYApexI4sII0mZV31Dqey/h064HOCq/tcK7PAWYYZv1E
         a/i1uOJpF5sgYGQMwRzjFa0Gg0vVHUbD/1ou8Bfbj/C+mxS2FcWgzvlaiq0DhQQH9/
         mcda/XNj+bniA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 1/9] ACPI: processor idle: Fix up C-state latency if not ordered
Date:   Mon,  5 Jul 2021 11:31:47 -0400
Message-Id: <20210705153155.1522423-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 65ea8f2c6e230bdf71fed0137cf9e9d1b307db32 ]

Generally, the C-state latency is provided by the _CST method or
FADT, but some OEM platforms using AMD Picasso, Renoir, Van Gogh,
and Cezanne set the C2 latency greater than C3's which causes the
C2 state to be skipped.

That will block the core entering PC6, which prevents S0ix working
properly on Linux systems.

In other operating systems, the latency values are not validated and
this does not cause problems by skipping states.

To avoid this issue on Linux, detect when latencies are not an
arithmetic progression and sort them.

Link: https://gitlab.freedesktop.org/agd5f/linux/-/commit/026d186e4592c1ee9c1cb44295912d0294508725
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1230#note_712174
Suggested-by: Prike Liang <Prike.Liang@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/processor_idle.c | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2237d3f24f0e..8242e16f57c6 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -29,6 +29,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/sched.h>       /* need_resched() */
+#include <linux/sort.h>
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
@@ -538,10 +539,37 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	return;
 }
 
+static int acpi_cst_latency_cmp(const void *a, const void *b)
+{
+	const struct acpi_processor_cx *x = a, *y = b;
+
+	if (!(x->valid && y->valid))
+		return 0;
+	if (x->latency > y->latency)
+		return 1;
+	if (x->latency < y->latency)
+		return -1;
+	return 0;
+}
+static void acpi_cst_latency_swap(void *a, void *b, int n)
+{
+	struct acpi_processor_cx *x = a, *y = b;
+	u32 tmp;
+
+	if (!(x->valid && y->valid))
+		return;
+	tmp = x->latency;
+	x->latency = y->latency;
+	y->latency = tmp;
+}
+
 static int acpi_processor_power_verify(struct acpi_processor *pr)
 {
 	unsigned int i;
 	unsigned int working = 0;
+	unsigned int last_latency = 0;
+	unsigned int last_type = 0;
+	bool buggy_latency = false;
 
 	pr->power.timer_broadcast_on_state = INT_MAX;
 
@@ -565,12 +593,24 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 		}
 		if (!cx->valid)
 			continue;
+		if (cx->type >= last_type && cx->latency < last_latency)
+			buggy_latency = true;
+		last_latency = cx->latency;
+		last_type = cx->type;
 
 		lapic_timer_check_state(i, pr, cx);
 		tsc_check_state(cx->type);
 		working++;
 	}
 
+	if (buggy_latency) {
+		pr_notice("FW issue: working around C-state latencies out of order\n");
+		sort(&pr->power.states[1], max_cstate,
+		     sizeof(struct acpi_processor_cx),
+		     acpi_cst_latency_cmp,
+		     acpi_cst_latency_swap);
+	}
+
 	lapic_timer_propagate_broadcast(pr);
 
 	return (working);
-- 
2.30.2

