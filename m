Return-Path: <linux-acpi+bounces-9045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F52F9B311E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 13:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D1128241B
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F41DA0EB;
	Mon, 28 Oct 2024 12:57:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919831CCECE;
	Mon, 28 Oct 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120258; cv=none; b=koeohSqAQEvMMCUmnK2fst+dWfIsBnvZcfVtBelqCAIM5Yjklp/pOd9hMenPLxmCNh3yN0a+mR56d8PSXALJgXXfCj614awQEf8KSZPrCTjvh+WKLqMOwFmSnVNlwnlf1rNr/1VdLEp9YGAXMUUllS6aMABneNJNjrCxte0T9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120258; c=relaxed/simple;
	bh=R037N4ZBxlVFy9i4zvajlGa76uC952UqlgLrQAsvyds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JL1crFqCgeGWQN+Cv/LzAv1bM+9xoV1TcbCs4mgvVSRayv7phHDqtKkCH9U7fYzLKFjXPKpKeGI6ynmXibZuA6kppU9NmpkmXelYsb8iDMbzTyV1R1QhC8GnfnH6AE/gCQn4fLD6lgXo6Rj6v4N83E2UYRnwtmPNBZIa9Q7rSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9292C497;
	Mon, 28 Oct 2024 05:58:04 -0700 (PDT)
Received: from e126645.nice.arm.com (e126645.nice.Arm.com [10.34.111.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 026303F66E;
	Mon, 28 Oct 2024 05:57:32 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2] ACPI: CPPC: Make rmw_lock a raw_spin_lock
Date: Mon, 28 Oct 2024 13:56:56 +0100
Message-Id: <20241028125657.1271512-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following BUG was triggered. sugov_update_shared() locks a
raw_spinlock while cpc_write() locks a spinlock. To have a correct
wait-type order, update rmw_lock to a raw_spinlock.

Also save irq state.

=============================
[ BUG: Invalid wait context ]
6.12.0-rc2-XXX #406 Not tainted
-----------------------------
kworker/1:1/62 is trying to lock:
ffffff8801593030 (&cpc_ptr->rmw_lock){+.+.}-{3:3}, at: cpc_write+0xcc/0x370
other info that might help us debug this:
context-{5:5}
2 locks held by kworker/1:1/62:
  #0: ffffff897ef5ec98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2c/0x50
  #1: ffffff880154e238 (&sg_policy->update_lock){....}-{2:2}, at: sugov_update_shared+0x3c/0x280
stack backtrace:
CPU: 1 UID: 0 PID: 62 Comm: kworker/1:1 Not tainted 6.12.0-rc2-g9654bd3e8806 #406
Workqueue:  0x0 (events)
Call trace:
  dump_backtrace+0xa4/0x130
  show_stack+0x20/0x38
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x28
  __lock_acquire+0x480/0x1ad8
  lock_acquire+0x114/0x310
  _raw_spin_lock+0x50/0x70
  cpc_write+0xcc/0x370
  cppc_set_perf+0xa0/0x3a8
  cppc_cpufreq_fast_switch+0x40/0xc0
  cpufreq_driver_fast_switch+0x4c/0x218
  sugov_update_shared+0x234/0x280
  update_load_avg+0x6ec/0x7b8
  dequeue_entities+0x108/0x830
  dequeue_task_fair+0x58/0x408
  __schedule+0x4f0/0x1070
  schedule+0x54/0x130
  worker_thread+0xc0/0x2e8
  kthread+0x130/0x148
  ret_from_fork+0x10/0x20

Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---

Notes:
    v2:
    - Do the actual changes.

 drivers/acpi/cppc_acpi.c | 9 +++++----
 include/acpi/cppc_acpi.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c3fc2c05d868..1a40f0514eaa 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -867,7 +867,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
-	spin_lock_init(&cpc_ptr->rmw_lock);
+	raw_spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
@@ -1087,6 +1087,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 	struct cpc_desc *cpc_desc;
+	unsigned long flags;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1126,7 +1127,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			return -ENODEV;
 		}
 
-		spin_lock(&cpc_desc->rmw_lock);
+		raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
 		switch (size) {
 		case 8:
 			prev_val = readb_relaxed(vaddr);
@@ -1141,7 +1142,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			prev_val = readq_relaxed(vaddr);
 			break;
 		default:
-			spin_unlock(&cpc_desc->rmw_lock);
+			raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 			return -EFAULT;
 		}
 		val = MASK_VAL_WRITE(reg, prev_val, val);
@@ -1174,7 +1175,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	}
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		spin_unlock(&cpc_desc->rmw_lock);
+		raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 
 	return ret_val;
 }
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 76e44e102780..62d368bcd9ec 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -65,7 +65,7 @@ struct cpc_desc {
 	int write_cmd_status;
 	int write_cmd_id;
 	/* Lock used for RMW operations in cpc_write() */
-	spinlock_t rmw_lock;
+	raw_spinlock_t rmw_lock;
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
-- 
2.25.1


