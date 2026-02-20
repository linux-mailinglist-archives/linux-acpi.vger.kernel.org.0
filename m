Return-Path: <linux-acpi+bounces-21024-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGHwLO1kmGmJHgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21024-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:43:09 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F00167EBA
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C147300250A
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A6C346FC3;
	Fri, 20 Feb 2026 13:43:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945CC346FAD;
	Fri, 20 Feb 2026 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594984; cv=none; b=b3iqrO0R4IuwfpFEEjM+bxEz30RFvZdDW4EkZzfrmgFEzDldBjYCBy0nD1XzqpYYpwHeRLa88efTDbvMxPCTd1xr1DHdlk+/30NxGiG103wb33qXlYA7QzI/mrFnP49yZejobK2WZaBaySYedoap6JEBmsNPKII+T05qEhzuSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594984; c=relaxed/simple;
	bh=rIqhmOaJPC6ldzKO1+omesFaj8L6jL61D6yCSn5XJq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bK90qIwGnta7YNipOZC3tRqeMLejW/m9ejpiUSe3IKfTO53hEr0JGjILo3OJmRo4CcTytRtVxTGwhcD+0IE2pumS1Pnd4qJLJwcy5ad71vQMPruicaRFLY1KSweC//6cmC0H47st9cKNIIi3d78GDIpObAxtPd5ouBrWexV83OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5411165C;
	Fri, 20 Feb 2026 05:42:55 -0800 (PST)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672B83F7D8;
	Fri, 20 Feb 2026 05:43:00 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 20 Feb 2026 13:42:23 +0000
Subject: [PATCH v2 05/11] ACPI: APEI: GHES: move estatus cache helpers
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-5-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Dmitry.Lamerov@arm.com, 
 catalin.marinas@arm.com, bp@alien8.de, robh@kernel.org, rafael@kernel.org, 
 will@kernel.org, conor@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, krzk+dt@kernel.org, Michael.Zhao2@arm.com, 
 tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771594970; l=11319;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=rIqhmOaJPC6ldzKO1+omesFaj8L6jL61D6yCSn5XJq8=;
 b=Af3JUMOUIuJUhLckxoWqh2WmYaS6RfdOoNCSlEqP2/91P/jvpjxfKhO6y8idB0TG9jO17Wu6L
 sTH6PUUxO+9AJNG0B2UDp1C1OPwUuM7FvOMSQ0wmYDoWNqE6YeWsxRt
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21024-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahmed.tiba@arm.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.926];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8F00167EBA
X-Rspamd-Action: no action

Relocate the estatus cache allocation and lookup helpers from ghes.c into
ghes_cper.c. This code move keeps the logic intact while making the cache
implementation available to forthcoming users.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 138 +----------------------------------------
 drivers/acpi/apei/ghes_cper.c | 140 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes_cper.h      |   6 ++
 3 files changed, 147 insertions(+), 137 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d562c98bff19..8a9b4dda3748 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -113,10 +113,7 @@ static DEFINE_MUTEX(ghes_devs_mutex);
  */
 static DEFINE_SPINLOCK(ghes_notify_lock_irq);
 
-static struct gen_pool *ghes_estatus_pool;
-
-static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
-static atomic_t ghes_estatus_cache_alloced;
+struct gen_pool *ghes_estatus_pool;
 
 int ghes_estatus_pool_init(unsigned int num_ghes)
 {
@@ -715,139 +712,6 @@ static int ghes_print_estatus(const char *pfx,
 	return 0;
 }
 
-/*
- * GHES error status reporting throttle, to report more kinds of
- * errors, instead of just most frequently occurred errors.
- */
-static int ghes_estatus_cached(struct acpi_hest_generic_status *estatus)
-{
-	u32 len;
-	int i, cached = 0;
-	unsigned long long now;
-	struct ghes_estatus_cache *cache;
-	struct acpi_hest_generic_status *cache_estatus;
-
-	len = cper_estatus_len(estatus);
-	rcu_read_lock();
-	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
-		cache = rcu_dereference(ghes_estatus_caches[i]);
-		if (cache == NULL)
-			continue;
-		if (len != cache->estatus_len)
-			continue;
-		cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
-		if (memcmp(estatus, cache_estatus, len))
-			continue;
-		atomic_inc(&cache->count);
-		now = sched_clock();
-		if (now - cache->time_in < GHES_ESTATUS_IN_CACHE_MAX_NSEC)
-			cached = 1;
-		break;
-	}
-	rcu_read_unlock();
-	return cached;
-}
-
-static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
-	struct acpi_hest_generic *generic,
-	struct acpi_hest_generic_status *estatus)
-{
-	int alloced;
-	u32 len, cache_len;
-	struct ghes_estatus_cache *cache;
-	struct acpi_hest_generic_status *cache_estatus;
-
-	alloced = atomic_add_return(1, &ghes_estatus_cache_alloced);
-	if (alloced > GHES_ESTATUS_CACHE_ALLOCED_MAX) {
-		atomic_dec(&ghes_estatus_cache_alloced);
-		return NULL;
-	}
-	len = cper_estatus_len(estatus);
-	cache_len = GHES_ESTATUS_CACHE_LEN(len);
-	cache = (void *)gen_pool_alloc(ghes_estatus_pool, cache_len);
-	if (!cache) {
-		atomic_dec(&ghes_estatus_cache_alloced);
-		return NULL;
-	}
-	cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
-	memcpy(cache_estatus, estatus, len);
-	cache->estatus_len = len;
-	atomic_set(&cache->count, 0);
-	cache->generic = generic;
-	cache->time_in = sched_clock();
-	return cache;
-}
-
-static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
-{
-	struct ghes_estatus_cache *cache;
-	u32 len;
-
-	cache = container_of(head, struct ghes_estatus_cache, rcu);
-	len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
-	len = GHES_ESTATUS_CACHE_LEN(len);
-	gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
-	atomic_dec(&ghes_estatus_cache_alloced);
-}
-
-static void
-ghes_estatus_cache_add(struct acpi_hest_generic *generic,
-		       struct acpi_hest_generic_status *estatus)
-{
-	unsigned long long now, duration, period, max_period = 0;
-	struct ghes_estatus_cache *cache, *new_cache;
-	struct ghes_estatus_cache __rcu *victim;
-	int i, slot = -1, count;
-
-	new_cache = ghes_estatus_cache_alloc(generic, estatus);
-	if (!new_cache)
-		return;
-
-	rcu_read_lock();
-	now = sched_clock();
-	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
-		cache = rcu_dereference(ghes_estatus_caches[i]);
-		if (cache == NULL) {
-			slot = i;
-			break;
-		}
-		duration = now - cache->time_in;
-		if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
-			slot = i;
-			break;
-		}
-		count = atomic_read(&cache->count);
-		period = duration;
-		do_div(period, (count + 1));
-		if (period > max_period) {
-			max_period = period;
-			slot = i;
-		}
-	}
-	rcu_read_unlock();
-
-	if (slot != -1) {
-		/*
-		 * Use release semantics to ensure that ghes_estatus_cached()
-		 * running on another CPU will see the updated cache fields if
-		 * it can see the new value of the pointer.
-		 */
-		victim = xchg_release(&ghes_estatus_caches[slot],
-				      RCU_INITIALIZER(new_cache));
-
-		/*
-		 * At this point, victim may point to a cached item different
-		 * from the one based on which we selected the slot. Instead of
-		 * going to the loop again to pick another slot, let's just
-		 * drop the other item anyway: this may cause a false cache
-		 * miss later on, but that won't cause any problems.
-		 */
-		if (victim)
-			call_rcu(&unrcu_pointer(victim)->rcu,
-				 ghes_estatus_cache_rcu_free);
-	}
-}
-
 static void __ghes_panic(struct ghes *ghes,
 			 struct acpi_hest_generic_status *estatus,
 			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index 974d5f032799..cb7f6f684087 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -10,10 +10,14 @@
  */
 
 #include <linux/err.h>
+#include <linux/genalloc.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/mm.h>
 #include <linux/ratelimit.h>
+#include <linux/rcupdate.h>
+#include <linux/sched/clock.h>
 #include <linux/slab.h>
 
 #include <acpi/apei.h>
@@ -24,6 +28,9 @@
 
 #include "apei-internal.h"
 
+static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
+static atomic_t ghes_estatus_cache_alloced;
+
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -255,3 +262,136 @@ void ghes_clear_estatus(struct ghes *ghes,
 	if (is_hest_type_generic_v2(ghes))
 		ghes_ack_error(ghes->generic_v2);
 }
+
+/*
+ * GHES error status reporting throttle, to report more kinds of
+ * errors, instead of just most frequently occurred errors.
+ */
+int ghes_estatus_cached(struct acpi_hest_generic_status *estatus)
+{
+	u32 len;
+	int i, cached = 0;
+	unsigned long long now;
+	struct ghes_estatus_cache *cache;
+	struct acpi_hest_generic_status *cache_estatus;
+
+	len = cper_estatus_len(estatus);
+	rcu_read_lock();
+	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
+		cache = rcu_dereference(ghes_estatus_caches[i]);
+		if (cache == NULL)
+			continue;
+		if (len != cache->estatus_len)
+			continue;
+		cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
+		if (memcmp(estatus, cache_estatus, len))
+			continue;
+		atomic_inc(&cache->count);
+		now = sched_clock();
+		if (now - cache->time_in < GHES_ESTATUS_IN_CACHE_MAX_NSEC)
+			cached = 1;
+		break;
+	}
+	rcu_read_unlock();
+	return cached;
+}
+
+static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
+	struct acpi_hest_generic *generic,
+	struct acpi_hest_generic_status *estatus)
+{
+	int alloced;
+	u32 len, cache_len;
+	struct ghes_estatus_cache *cache;
+	struct acpi_hest_generic_status *cache_estatus;
+
+	alloced = atomic_add_return(1, &ghes_estatus_cache_alloced);
+	if (alloced > GHES_ESTATUS_CACHE_ALLOCED_MAX) {
+		atomic_dec(&ghes_estatus_cache_alloced);
+		return NULL;
+	}
+	len = cper_estatus_len(estatus);
+	cache_len = GHES_ESTATUS_CACHE_LEN(len);
+	cache = (void *)gen_pool_alloc(ghes_estatus_pool, cache_len);
+	if (!cache) {
+		atomic_dec(&ghes_estatus_cache_alloced);
+		return NULL;
+	}
+	cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
+	memcpy(cache_estatus, estatus, len);
+	cache->estatus_len = len;
+	atomic_set(&cache->count, 0);
+	cache->generic = generic;
+	cache->time_in = sched_clock();
+	return cache;
+}
+
+static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
+{
+	struct ghes_estatus_cache *cache;
+	u32 len;
+
+	cache = container_of(head, struct ghes_estatus_cache, rcu);
+	len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
+	len = GHES_ESTATUS_CACHE_LEN(len);
+	gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
+	atomic_dec(&ghes_estatus_cache_alloced);
+}
+
+void
+ghes_estatus_cache_add(struct acpi_hest_generic *generic,
+		       struct acpi_hest_generic_status *estatus)
+{
+	unsigned long long now, duration, period, max_period = 0;
+	struct ghes_estatus_cache *cache, *new_cache;
+	struct ghes_estatus_cache __rcu *victim;
+	int i, slot = -1, count;
+
+	new_cache = ghes_estatus_cache_alloc(generic, estatus);
+	if (!new_cache)
+		return;
+
+	rcu_read_lock();
+	now = sched_clock();
+	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
+		cache = rcu_dereference(ghes_estatus_caches[i]);
+		if (cache == NULL) {
+			slot = i;
+			break;
+		}
+		duration = now - cache->time_in;
+		if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
+			slot = i;
+			break;
+		}
+		count = atomic_read(&cache->count);
+		period = duration;
+		do_div(period, (count + 1));
+		if (period > max_period) {
+			max_period = period;
+			slot = i;
+		}
+	}
+	rcu_read_unlock();
+
+	if (slot != -1) {
+		/*
+		 * Use release semantics to ensure that ghes_estatus_cached()
+		 * running on another CPU will see the updated cache fields if
+		 * it can see the new value of the pointer.
+		 */
+		victim = xchg_release(&ghes_estatus_caches[slot],
+				      RCU_INITIALIZER(new_cache));
+
+		/*
+		 * At this point, victim may point to a cached item different
+		 * from the one based on which we selected the slot. Instead of
+		 * going to the loop again to pick another slot, let's just
+		 * drop the other item anyway: this may cause a false cache
+		 * miss later on, but that won't cause any problems.
+		 */
+		if (victim)
+			call_rcu(&unrcu_pointer(victim)->rcu,
+				 ghes_estatus_cache_rcu_free);
+	}
+}
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index 2e3919f0c3e7..1f012a23d0c6 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -11,6 +11,7 @@
 #ifndef ACPI_APEI_GHES_CPER_H
 #define ACPI_APEI_GHES_CPER_H
 
+#include <linux/atomic.h>
 #include <linux/workqueue.h>
 
 #include <acpi/ghes.h>
@@ -49,6 +50,8 @@
 	((struct acpi_hest_generic_data *)                              \
 	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
 
+extern struct gen_pool *ghes_estatus_pool;
+
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
@@ -91,5 +94,8 @@ int __ghes_check_estatus(struct ghes *ghes,
 int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
 			u64 buf_paddr, enum fixed_addresses fixmap_idx,
 			size_t buf_len);
+int ghes_estatus_cached(struct acpi_hest_generic_status *estatus);
+void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
+			    struct acpi_hest_generic_status *estatus);
 
 #endif /* ACPI_APEI_GHES_CPER_H */

-- 
2.43.0


