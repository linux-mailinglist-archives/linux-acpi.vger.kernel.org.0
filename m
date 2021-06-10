Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C993A25A8
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 09:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhFJHnx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 03:43:53 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5477 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHnx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 03:43:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0wpJ69GFzZfyS;
        Thu, 10 Jun 2021 15:39:04 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:41:55 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 15:41:54 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiaosong2@huawei.com>
Subject: [PATCH -next] ACPI: fix doc warnings
Date:   Thu, 10 Jun 2021 15:48:12 +0800
Message-ID: <20210610074812.57973-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix gcc W=1 warnings:
drivers/acpi/cppc_acpi.c:1356: warning: Function parameter or member 'cpu_num' not described in 'cppc_get_transition_latency'
drivers/acpi/cppc_acpi.c:573: warning: Function parameter or member 'pcc_ss_id' not described in 'pcc_data_alloc'
drivers/acpi/dock.c:388: warning: Function parameter or member 'ds' not described in 'handle_eject_request'
drivers/acpi/dock.c:388: warning: Function parameter or member 'event' not described in 'handle_eject_request'
drivers/acpi/sleep.c:496: warning: Function parameter or member 'acpi_state' not described in 'acpi_pm_start'
drivers/acpi/sleep.c:536: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin'
drivers/acpi/sleep.c:663: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin_old'
drivers/acpi/sleep.c:956: warning: Function parameter or member 'stage' not described in 'acpi_hibernation_begin_old'

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 2 ++
 drivers/acpi/dock.c      | 2 ++
 drivers/acpi/sleep.c     | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a4d4eebba1da..611938f2c132 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -561,6 +561,7 @@ bool __weak cpc_ffh_supported(void)
 
 /**
  * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
+ * @pcc_ss_id: pcc subspace id.
  *
  * Check and allocate the cppc_pcc_data memory.
  * In some processor configurations it is possible that same subspace
@@ -1346,6 +1347,7 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
 
 /**
  * cppc_get_transition_latency - returns frequency transition latency in ns
+ * @cpu: CPU for which to get transition latency.
  *
  * ACPI CPPC does not explicitly specify how a platform can specify the
  * transition latency for performance change requests. The closest we have
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 7cf92158008f..6c0fb5c9b938 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -380,6 +380,8 @@ static int dock_in_progress(struct dock_station *ds)
 
 /**
  * handle_eject_request - handle an undock request checking for error conditions
+ * @ds: the dock station.
+ * @event: Event code.
  *
  * Check to make sure the dock device is still present, then undock and
  * hotremove all the devices that may need removing.
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index aaea10d39201..95521a8b49fc 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -491,6 +491,7 @@ static void acpi_pm_finish(void)
 
 /**
  * acpi_pm_start - Start system PM transition.
+ * @acpi_state: Power state value.
  */
 static void acpi_pm_start(u32 acpi_state)
 {
@@ -531,6 +532,7 @@ static u32 acpi_suspend_states[] = {
 /**
  *	acpi_suspend_begin - Set the target system sleep state to the state
  *		associated with given @pm_state, if supported.
+ *	@pm_state: pm suspend state.
  */
 static int acpi_suspend_begin(suspend_state_t pm_state)
 {
@@ -658,6 +660,7 @@ static const struct platform_suspend_ops acpi_suspend_ops = {
  *		state associated with given @pm_state, if supported, and
  *		execute the _PTS control method.  This function is used if the
  *		pre-ACPI 2.0 suspend ordering has been requested.
+ *	@pm_state: pm suspend state.
  */
 static int acpi_suspend_begin_old(suspend_state_t pm_state)
 {
@@ -951,6 +954,7 @@ static const struct platform_hibernation_ops acpi_hibernation_ops = {
  *		ACPI_STATE_S4 and execute the _PTS control method.  This
  *		function is used if the pre-ACPI 2.0 suspend ordering has been
  *		requested.
+ *	@stage: pm event massage
  */
 static int acpi_hibernation_begin_old(pm_message_t stage)
 {
-- 
2.25.4

