Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38681EFE4F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 18:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFEQzd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 12:55:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgFEQzd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jun 2020 12:55:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AE17DACE3;
        Fri,  5 Jun 2020 16:55:32 +0000 (UTC)
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
To:     Kees Cook <keescook@chromium.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Roman Gushchin <guro@fb.com>
References: <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
 <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
 <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
 <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com>
 <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
 <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
 <202006050828.F85A75D13@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <92d994be-e4f5-b186-4ad7-21828de44967@suse.cz>
Date:   Fri, 5 Jun 2020 18:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <202006050828.F85A75D13@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 6/5/20 5:44 PM, Kees Cook wrote:
> On Fri, Jun 05, 2020 at 04:44:51PM +0200, Vegard Nossum wrote:
>> On 2020-06-05 16:08, Vlastimil Babka wrote:
>> > On 6/5/20 3:12 PM, Rafael J. Wysocki wrote:
>> > > On Fri, Jun 5, 2020 at 2:48 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>> > > > 
>> > > > On 2020-06-05 11:36, Vegard Nossum wrote:
>> > > > > 
>> > > > > On 2020-06-05 11:11, Vlastimil Babka wrote:
>> > > > > > So, with Kees' patch reverted, booting with slub_debug=F (or even more
>> > > > > > specific slub_debug=F,ftrace_event_field) also hits this bug below. I
>> > > > > > wanted to bisect it, but v5.7 was also bad, and also v5.6. Didn't try
>> > > > > > further in history. So it's not new at all, and likely very specific to
>> > > > > > your config+QEMU? (and related to the ACPI error messages that precede
>> > > > > > it?).
>> > [...]
>> > [    0.140408] ------------[ cut here ]------------
>> > [    0.140837] cache_from_obj: Wrong slab cache. Acpi-Namespace but object is from kmalloc-64
>> > [    0.141406] WARNING: CPU: 0 PID: 1 at mm/slab.h:524 kmem_cache_free+0x1d3/0x250
> 
> Ah yes! Good. I had improved this check recently too, and I was worried
> the freelist pointer patch was somehow blocking it, but I see now that
> the failing config didn't have CONFIG_SLAB_FREELIST_HARDENED=y. Once
> SLAB_CONSISTENCY_CHECKS was enabled ("slub_debug=F"), it started
> tripping. Whew.
> 
> I wonder if that entire test block should just be removed from
> cache_from_obj():
> 
>         if (!memcg_kmem_enabled() &&
>             !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
>             !unlikely(s->flags & SLAB_CONSISTENCY_CHECKS))
>                 return s;
> 
> and make this test unconditional? It's mostly only called during free(),
> and shouldn't be too expensive to be made unconditional. Hmm.

Hmm I have a different idea. The whole cache_from_obj() was added because of
kmemcg (commit b9ce5ef49f00d) where per-memcg cache can be different from the
root one. And I just realized this usecase can go away with Roman's series [1].
But cache_from_obj() also kept the original SLUB consistency check case, and you
added the freelist hardening case. If kmemcg use case went away it would be nice
to avoid the virt_to_cache() and check completely again, unless in debugging or
hardened kernel.

Furthermore, the original SLUB debugging case was an unconditional pr_err() plus
WARN_ON_ONCE(1), which was kept by commit b9ce5ef49f00d.  With freelist
hardening this all changed to WARN_ONCE. So the second and later cases are not
reported at all for hardening and also not for explicitly enabled debugging like
in this case, which is IMHO not ideal.

So I propose the following - the freelist hardening case keeps the WARN_ONCE,
but also a one-line pr_err() for each case so they are not silent. The SLUB
debugging case is always a full warning, and printing the tracking info if
enabled and available. Pure kmemcg case does virt_to_cache() for now (until
hopefully removed by Roman's series) but no checking at all. Would that work for
everyone?

[1] https://lore.kernel.org/linux-mm/d7cdecbc-db24-8ced-1a86-6f4534613763@suse.cz/

----8<----
diff --git a/mm/slab.h b/mm/slab.h
index 815e4e9a94cd..1182ca2cb11a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -275,6 +275,14 @@ static inline int cache_vmstat_idx(struct kmem_cache *s)
 		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
 }
 
+#ifdef CONFIG_SLUB_DEBUG
+void slab_print_tracking(struct kmem_cache *s, void *object);
+#else
+static inline void slab_print_tracking(struct kmem_cache *s, void *object)
+{
+}
+#endif
+
 #ifdef CONFIG_MEMCG_KMEM
 
 /* List of all root caches. */
@@ -520,9 +528,18 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 		return s;
 
 	cachep = virt_to_cache(x);
-	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
-		  "%s: Wrong slab cache. %s but object is from %s\n",
-		  __func__, s->name, cachep->name);
+	if (unlikely(s->flags & SLAB_CONSISTENCY_CHECKS)) {
+		if (WARN(cachep && !slab_equal_or_root(cachep, s),
+			  "%s: Wrong slab cache. %s but object is from %s\n",
+			  __func__, s->name, cachep->name))
+			slab_print_tracking(cachep, x);
+	} else if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED)) {
+		if (unlikely(cachep && !slab_equal_or_root(cachep, s))) {
+			pr_err("%s: Wrong slab cache. %s but object is from %s\n",
+				  __func__, s->name, cachep->name);
+			WARN_ON_ONCE(1);
+		}
+	}
 	return cachep;
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index d4a9a097da50..ff2d817c5a94 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -634,7 +634,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
 #endif
 }
 
-static void print_tracking(struct kmem_cache *s, void *object)
+void slab_print_tracking(struct kmem_cache *s, void *object)
 {
 	unsigned long pr_time = jiffies;
 	if (!(s->flags & SLAB_STORE_USER))
@@ -698,7 +698,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 	unsigned int off;	/* Offset of last byte */
 	u8 *addr = page_address(page);
 
-	print_tracking(s, p);
+	slab_print_tracking(s, p);
 
 	print_page_info(page);
 
@@ -3858,7 +3858,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 
 		if (!test_bit(slab_index(p, s, addr), map)) {
 			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
-			print_tracking(s, p);
+			slab_print_tracking(s, p);
 		}
 	}
 	slab_unlock(page);
