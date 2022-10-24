Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6B60B394
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiJXRKt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiJXRKN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 13:10:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A080691852;
        Mon, 24 Oct 2022 08:45:12 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e790329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e790:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C09221EC068C;
        Mon, 24 Oct 2022 17:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666626225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iwOcNJ3tdFU+iSv3M1smqB1ztPNnc9b/fECkwptfiec=;
        b=jlVX/Yx8sBzWdXGUX3sE5MvjvGYb4rijjF+jbcs5dwbmUjToExs+VABma8jXgyhGEF9uDp
        yxWxiI17rTU+H2RnKWXfysJ86dyppaIaMVdXMVDynesTP0DptvgLh6Kt8gkaY5gI6P6DUj
        ufv8jYZKwXMX1Vwb+BcEt/b8jCyUMYc=
Date:   Mon, 24 Oct 2022 17:43:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] apei/ghes: Use xchg_release() for updating new cache slot
 instead of cmpxchg()
Message-ID: <Y1ayrYZgLqjp7WOG@zn.tnic>
References: <20221018082214.569504-1-justin.he@arm.com>
 <20221018082214.569504-7-justin.he@arm.com>
 <Y1OtRpLRwPPG/4Il@zn.tnic>
 <CAMj1kXFu36faTPoGSGPs9KhcKsoh_DE9X2rmwdenxaJwa3P_yw@mail.gmail.com>
 <Y1O/QN32d2AlzEiA@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1O/QN32d2AlzEiA@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ok,

here's what I've done to it, holler if something's still missing.

@rjw, if you wanna take this through your tree, it should work too - it
is unrelated to the ghes_edac changes we're doing. Or I can carry it,
whatever you prefer.

Thx.

---
From: Ard Biesheuvel <ardb@kernel.org>

Some documentation first, about how this machinery works:

It seems, the intent of the GHES error records cache is to collect
already reported errors - see the ghes_estatus_cached() checks. There's
even a sentence trying to say what this does:

  /*
   * GHES error status reporting throttle, to report more kinds of
   * errors, instead of just most frequently occurred errors.
   */

New elements are added to the cache this way:

  if (!ghes_estatus_cached(estatus)) {
          if (ghes_print_estatus(NULL, ghes->generic, estatus))
                  ghes_estatus_cache_add(ghes->generic, estatus);

The intent being, once this new error record is reported, it gets cached
so that it doesn't get reported for a while due to too many, same-type
error records getting reported in burst-like scenarios. I.e., new,
unreported error types can have a higher chance of getting reported.

Now, the loop in ghes_estatus_cache_add() is trying to pick out the
oldest element in there. Meaning, something which got reported already
but a long while ago, i.e., a LRU-type scheme.

And the cmpxchg() is there presumably to make sure when that selected
element slot_cache is removed, it really *is* that element that gets
removed and not one which replaced it in the meantime.

Now, ghes_estatus_cache_add() selects a slot, and either succeeds in
replacing its contents with a pointer to a newly cached item, or it just
gives up and frees the new item again, without attempting to select
another slot even if one might be available.

Since only inserting new items is being done here, the race can only
cause a failure if the selected slot was updated with another new item
concurrently, which means that it is arbitrary which of those two items
gets dropped.

And "dropped" here means, the item doesn't get added to the cache so
the next time it is seen, it'll get reported again and an insertion
attempt will be done again. Eventually, it'll get inserted and all those
times when the insertion fails, the item will get reported although the
cache is supposed to prevent that and "ratelimit" those repeated error
records. Not a big deal in any case.

This means the cmpxchg() and the special case are not necessary.
Therefore, just drop the existing item unconditionally.

Move the xchg_release() and call_rcu() out of rcu_read_lock/unlock
section since there is no actually dereferencing the pointer at all.

  [ bp:
    - Flesh out and summarize what was discussed on the thread now
      that that cache contraption is understood;
    - Touch up code style. ]

Co-developed-by: Jia He <justin.he@arm.com>
Signed-off-by: Jia He <justin.he@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221010023559.69655-7-justin.he@arm.com
---
 drivers/acpi/apei/ghes.c | 60 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 249cd01cb920..6164bf737ee6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -154,7 +154,7 @@ struct ghes_vendor_record_entry {
 static struct gen_pool *ghes_estatus_pool;
 static unsigned long ghes_estatus_pool_size_request;
 
-static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
+static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_panic_timeout __read_mostly = 30;
@@ -789,48 +789,42 @@ static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
 	return cache;
 }
 
-static void ghes_estatus_cache_free(struct ghes_estatus_cache *cache)
+static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
 {
+	struct ghes_estatus_cache *cache;
 	u32 len;
 
+	cache = container_of(head, struct ghes_estatus_cache, rcu);
 	len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
 	len = GHES_ESTATUS_CACHE_LEN(len);
 	gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
 	atomic_dec(&ghes_estatus_cache_alloced);
 }
 
-static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
-{
-	struct ghes_estatus_cache *cache;
-
-	cache = container_of(head, struct ghes_estatus_cache, rcu);
-	ghes_estatus_cache_free(cache);
-}
-
-static void ghes_estatus_cache_add(
-	struct acpi_hest_generic *generic,
-	struct acpi_hest_generic_status *estatus)
+static void
+ghes_estatus_cache_add(struct acpi_hest_generic *generic,
+		       struct acpi_hest_generic_status *estatus)
 {
-	int i, slot = -1, count;
 	unsigned long long now, duration, period, max_period = 0;
-	struct ghes_estatus_cache *cache, *slot_cache = NULL, *new_cache;
+	struct ghes_estatus_cache *cache, *new_cache;
+	struct ghes_estatus_cache __rcu *victim;
+	int i, slot = -1, count;
 
 	new_cache = ghes_estatus_cache_alloc(generic, estatus);
-	if (new_cache == NULL)
+	if (!new_cache)
 		return;
+
 	rcu_read_lock();
 	now = sched_clock();
 	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
 		cache = rcu_dereference(ghes_estatus_caches[i]);
 		if (cache == NULL) {
 			slot = i;
-			slot_cache = NULL;
 			break;
 		}
 		duration = now - cache->time_in;
 		if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
 			slot = i;
-			slot_cache = cache;
 			break;
 		}
 		count = atomic_read(&cache->count);
@@ -839,18 +833,30 @@ static void ghes_estatus_cache_add(
 		if (period > max_period) {
 			max_period = period;
 			slot = i;
-			slot_cache = cache;
 		}
 	}
-	/* new_cache must be put into array after its contents are written */
-	smp_wmb();
-	if (slot != -1 && cmpxchg(ghes_estatus_caches + slot,
-				  slot_cache, new_cache) == slot_cache) {
-		if (slot_cache)
-			call_rcu(&slot_cache->rcu, ghes_estatus_cache_rcu_free);
-	} else
-		ghes_estatus_cache_free(new_cache);
 	rcu_read_unlock();
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
 }
 
 static void __ghes_panic(struct ghes *ghes,
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
