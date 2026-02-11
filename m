Return-Path: <linux-acpi+bounces-20932-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF0vIK52jGk6ogAAu9opvQ
	(envelope-from <linux-acpi+bounces-20932-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:31:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178321243C7
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D43CC30162A2
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 12:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B234219FC;
	Wed, 11 Feb 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFlFwU/i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7D3207;
	Wed, 11 Feb 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813099; cv=none; b=dWlU5GNUK06Gqgh4tzcyOXjnbkof47oP77gtCCme3rmZXVYBq7NzuxGtEu5qgBBOLsCpDMHq4UrFKghr8r2uYah6Dh4pmARyqH9ygB4J+od173Bmx9QeKQEakR0TSgTuxLUQnpEVX82jWb3UiYV+Do0la5d+D4DnEXbfYpz5lbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813099; c=relaxed/simple;
	bh=SDCjvHPoW3LHwRCJAqQbBv25bM9dKzNqDYoB9f0uios=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE/mJh+en48L8VhCrhwsvR1dbREYlibAjMi5IzwGayZH2/EG0h1BTG0ethKbul085t2kQwiHSgA2WEwIqzlY38JPCtGDv2i5EXjB8c5ieLecrN3GhzskwHQNrk0db7bDeQH58zNB2gKtgzaqhUYiPcNne4MwdVhuQGrYSJsBpCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFlFwU/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F872C19421;
	Wed, 11 Feb 2026 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813099;
	bh=SDCjvHPoW3LHwRCJAqQbBv25bM9dKzNqDYoB9f0uios=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFlFwU/iay7eRagnXJsmaiFy5mdqvcWf9lDpxNsm20SOoYItb1Mqr5M7KE0mPVy+7
	 GPEPV6GmO12dCjva6mg0tppV++ABLXt1vMiXW/hoaqpLwQ7hRvxGipCrI60eJ/cfN7
	 S0KW4kMXxlHh9iSnU33xV2xnhJz3n0mruPMHLmbDjDe674vLOV4Kx6qqsMV7KOOI4n
	 vnG10GHbB7MD1JsqhG+Y3OyW3Df8qXgk/n876FqeHUN0JtkLQwsDQa0lFWp5izyAqB
	 jRluzgZkmAPo/aT/zhY2avx1SUEGDMM7uYZW5QnXwicrYm1uew7VxaUgmG4vNwt4WC
	 G0tZlKrEbZ85A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yicong Yang <yang.yicong@picoheart.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.19] ACPI: scan: Use async schedule function in acpi_scan_clear_dep_fn()
Date: Wed, 11 Feb 2026 07:30:22 -0500
Message-ID: <20260211123112.1330287-12-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211123112.1330287-1-sashal@kernel.org>
References: <20260211123112.1330287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20932-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 178321243C7
X-Rspamd-Action: no action

From: Yicong Yang <yang.yicong@picoheart.com>

[ Upstream commit 7cf28b3797a81b616bb7eb3e90cf131afc452919 ]

The device object rescan in acpi_scan_clear_dep_fn() is scheduled on a
system workqueue which is not guaranteed to be finished before entering
userspace. This may cause some key devices to be missing when userspace
init task tries to find them. Two issues observed on RISCV platforms:

 - Kernel panic due to userspace init cannot have an opened
   console.

   The console device scanning is queued by acpi_scan_clear_dep_queue()
   and not finished by the time userspace init process running, thus by
   the time userspace init runs, no console is present.

 - Entering rescue shell due to the lack of root devices (PCIe nvme in
   our case).

   Same reason as above, the PCIe host bridge scanning is queued on
   a system workqueue and finished after init process runs.

The reason is because both devices (console, PCIe host bridge) depend on
riscv-aplic irqchip to serve their interrupts (console's wired interrupt
and PCI's INTx interrupts). In order to keep the dependency, these
devices are scanned and created after initializing riscv-aplic. The
riscv-aplic is initialized in device_initcall() and a device scan work
is queued via acpi_scan_clear_dep_queue(), which is close to the time
userspace init process is run. Since system_dfl_wq is used in
acpi_scan_clear_dep_queue() with no synchronization, the issues will
happen if userspace init runs before these devices are ready.

The solution is to wait for the queued work to complete before entering
userspace init. One possible way would be to use a dedicated workqueue
instead of system_dfl_wq, and explicitly flush it somewhere in the
initcall stage before entering userspace. Another way is to use
async_schedule_dev_nocall() for scanning these devices. It's designed
for asynchronous initialization and will work in the same way as before
because it's using a dedicated unbound workqueue as well, but the kernel
init code calls async_synchronize_full() right before entering userspace
init which will wait for the work to complete.

Compared to a dedicated workqueue, the second approach is simpler
because the async schedule framework takes care of all of the details.
The ACPI code only needs to focus on its job. A dedicated workqueue for
this could also be redundant because some platforms don't need
acpi_scan_clear_dep_queue() for their device scanning.

Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
[ rjw: Subject adjustment, changelog edits ]
Link: https://patch.msgid.link/20260128132848.93638-1-yang.yicong@picoheart.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Detailed Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit fixes two concrete, severe boot failures on RISC-V platforms
with ACPI:

1. **Kernel panic** - userspace init cannot open a console because the
   console device hasn't been scanned yet. The device scan work was
   queued via `acpi_scan_clear_dep_queue()` to `system_dfl_wq` (or
   `system_unbound_wq` in stable) and hasn't completed by the time
   userspace init runs.

2. **Boot failure into rescue shell** - root device (PCIe NVMe via PCIe
   host bridge) is missing for the same reason: the scan work is still
   queued and not completed.

Both are caused by a race: the deferred device scan (queued by
`acpi_scan_clear_dep_queue()`) is scheduled on a system workqueue with
**no synchronization barrier** before userspace init starts. Devices
that depend on RISC-V APLIC (interrupt controller) are scanned
asynchronously after APLIC initialization in `device_initcall()`, and if
init runs before the workqueue work completes, critical devices are
missing.

The commit message is well-written by both the author (Yicong Yang) and
was reviewed/edited by the ACPI maintainer (Rafael J. Wysocki), who
signed it off.

### 2. CODE CHANGE ANALYSIS

The change is **small and surgical** (~30 net lines removed):

**Before (old code):**
- A `struct acpi_scan_clear_dep_work` wraps `work_struct` + `acpi_device
  *`
- `acpi_scan_clear_dep_fn()` is a `work_struct` callback that calls
  `acpi_bus_attach()` under `acpi_scan_lock`, then releases the device
  reference and frees the wrapper
- `acpi_scan_clear_dep_queue()` allocates the wrapper via `kmalloc()`,
  initializes the work, and queues it on
  `system_dfl_wq`/`system_unbound_wq`

**After (new code):**
- `acpi_scan_clear_dep_fn()` signature changes to `(void *dev,
  async_cookie_t cookie)` - an `async_func_t` callback
- It uses `to_acpi_device(dev)` directly instead of `container_of` on a
  wrapper struct
- `acpi_scan_clear_dep_queue()` calls `async_schedule_dev_nocall()`
  instead of `queue_work()`
- The `struct acpi_scan_clear_dep_work` wrapper is removed entirely
- No more `kmalloc()` for the wrapper (the async framework handles its
  own allocation internally)

**Why this fixes the bug:** `async_schedule_dev_nocall()` schedules work
on the async framework's dedicated domain (`async_dfl_domain`). The
critical property is that `kernel_init()` in `init/main.c` calls
`async_synchronize_full()` **before** entering userspace (before
`run_init_process()`):

```1569:1642:init/main.c
static int __ref kernel_init(void *unused)
{
        // ...
        kernel_init_freeable();
        /* need to finish all async __init code before freeing the
memory */
        async_synchronize_full();
        // ...
        // <userspace init happens after this point>
```

This guarantees all async-scheduled work (including the device scans)
completes before userspace init starts. The old
`queue_work(system_unbound_wq, ...)` had no such synchronization
barrier.

**Reference counting correctness:** The reference counting is preserved
identically:
- On success: `acpi_scan_clear_dep_fn()` releases the reference via
  `acpi_dev_put(adev)`
- On failure: `acpi_scan_clear_dep_queue()` returns `false`, and the
  caller `acpi_scan_clear_dep()` releases the reference via
  `acpi_dev_put(adev)`

### 3. CLASSIFICATION

This is a **real bug fix** for a **race condition** that causes **kernel
panics and boot failures**. It is not a feature, cleanup, or
optimization.

### 4. SCOPE AND RISK ASSESSMENT

- **Files changed:** 1 (`drivers/acpi/scan.c`)
- **Net lines:** Reduced - removes the wrapper struct, simplifies both
  functions
- **Subsystem:** ACPI scan, a core subsystem
- **Risk:** LOW. The change replaces one deferred scheduling mechanism
  (workqueue) with another (async framework) that has the specific
  property of being synchronized before userspace init. The functional
  behavior of the callback is identical. The async framework is well-
  established and already used extensively in the kernel for device
  probing.
- **Could this break something?** Very unlikely. The
  `async_schedule_dev_nocall()` function uses an unbound workqueue
  internally just like the old code, with the added benefit of the
  synchronization barrier. The only behavior change is that work is
  guaranteed to complete before userspace init, which is strictly
  desirable.

### 5. USER IMPACT

- **Severity:** CRITICAL - kernel panics and inability to boot
- **Affected platforms:** Primarily RISC-V ACPI platforms right now, but
  the underlying race could affect any platform using
  `acpi_dev_clear_dependencies()` (Intel camera IVSC, INT3472, Surface
  devices, ACPI EC, PCI link, GPIO, I2C - 18 different callers)
- **Who benefits:** RISC-V ACPI users are the primary beneficiaries.
  Other platforms could theoretically hit this race too under heavy load
  at boot time, though it's most likely on RISC-V where interrupt
  controller dependency chains are deeper.

### 6. DEPENDENCY CHECK

- **`async_schedule_dev_nocall()`:** Already backported to all active
  stable trees (6.1.y, 6.6.y, 6.12.y) - verified by checking commit
  history
- **`acpi_scan_clear_dep_queue()` / `acpi_scan_clear_dep_fn()`:**
  Present in all active stable trees (introduced before v5.17)
- **`#include <linux/async.h>`:** The new header include is the only
  other change needed
- **Backport adjustment:** Stable trees (6.1.y through 6.14.y) use
  `system_unbound_wq` instead of `system_dfl_wq`, but since the commit
  removes the `queue_work()` call entirely, the diff will need a trivial
  context adjustment (the old `queue_work(system_unbound_wq, ...)` line
  vs `queue_work(system_dfl_wq, ...)`)
- **RISC-V ACPI dependency IDs:** The RSCV0001/RSCV0002 entries are in
  6.12.y but not in 6.6.y or 6.1.y. However, the fix is still valid for
  older trees because the same race exists for Intel camera/IVSC/PCI-
  link devices that use this code path

### 7. STABILITY INDICATORS

- Authored by Yicong Yang (kernel contributor)
- Reviewed and edited by Rafael J. Wysocki (ACPI maintainer, signed off)
- The approach was explicitly chosen over a dedicated workqueue because
  it leverages the existing async synchronization framework which "takes
  care of all the details"
- Real-world tested (the bug was observed on actual RISC-V hardware)

### CONCLUSION

This commit fixes a **critical race condition** causing **kernel panics
and boot failures**. The fix is:
- **Small and surgical** (single file, removes complexity)
- **Obviously correct** (leverages the well-established async
  synchronization barrier before userspace init)
- **Self-contained** (no dependencies beyond `async_schedule_dev_nocall`
  which already exists in all stable trees)
- **Low risk** (functionally equivalent deferred execution, just with
  proper synchronization)
- **High impact** (prevents kernel panics and boot failures on RISC-V
  ACPI platforms; potentially prevents similar races on other platforms
  using the same code path)

The only minor concern is the trivial context difference
(`system_unbound_wq` vs `system_dfl_wq`) for backport to pre-6.19 stable
trees, which requires a trivial adaptation of the diff context but does
not affect the logic (the line is removed, not modified).

**YES**

 drivers/acpi/scan.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 416d87f9bd107..b78f6be2f9468 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
+#include <linux/async.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -2360,46 +2361,34 @@ static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *da
 	return 0;
 }
 
-struct acpi_scan_clear_dep_work {
-	struct work_struct work;
-	struct acpi_device *adev;
-};
-
-static void acpi_scan_clear_dep_fn(struct work_struct *work)
+static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
 {
-	struct acpi_scan_clear_dep_work *cdw;
-
-	cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
+	struct acpi_device *adev = to_acpi_device(dev);
 
 	acpi_scan_lock_acquire();
-	acpi_bus_attach(cdw->adev, (void *)true);
+	acpi_bus_attach(adev, (void *)true);
 	acpi_scan_lock_release();
 
-	acpi_dev_put(cdw->adev);
-	kfree(cdw);
+	acpi_dev_put(adev);
 }
 
 static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
 {
-	struct acpi_scan_clear_dep_work *cdw;
-
 	if (adev->dep_unmet)
 		return false;
 
-	cdw = kmalloc(sizeof(*cdw), GFP_KERNEL);
-	if (!cdw)
-		return false;
-
-	cdw->adev = adev;
-	INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
 	/*
-	 * Since the work function may block on the lock until the entire
-	 * initial enumeration of devices is complete, put it into the unbound
-	 * workqueue.
+	 * Async schedule the deferred acpi_scan_clear_dep_fn() since:
+	 * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
+	 *   be acquired under acpi_dep_list_lock (held here)
+	 * - the deferred work at boot stage is ensured to be finished
+	 *   before userspace init task by the async_synchronize_full()
+	 *   barrier
+	 *
+	 * Use _nocall variant since it'll return on failure instead of
+	 * run the function synchronously.
 	 */
-	queue_work(system_dfl_wq, &cdw->work);
-
-	return true;
+	return async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev);
 }
 
 static void acpi_scan_delete_dep_data(struct acpi_dep_data *dep)
-- 
2.51.0


