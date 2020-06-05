Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA83C1F0011
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgFESqk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgFESqj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 14:46:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B4FC08C5C2
        for <linux-acpi@vger.kernel.org>; Fri,  5 Jun 2020 11:46:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so4061781pll.10
        for <linux-acpi@vger.kernel.org>; Fri, 05 Jun 2020 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Da0IbFTrNfj9bJaxBOpwux7VHsiRSXba/ar+wuI/Gg=;
        b=jVF836jpngEgOt8ljxat1BJiqjwfDFPTZi7flYc19znEdTtBiJY2eDmgaMXonEp3C+
         iWjBg2OuU07b6zg0WeVRxc5RnyYkAhaGEWnN8MtUXutRFmKURQdumN+fTjo3nl7eUcx/
         GoTrOUw5R2c69SKrEU01/XQVZdHNeb6jdGtQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Da0IbFTrNfj9bJaxBOpwux7VHsiRSXba/ar+wuI/Gg=;
        b=Wn9J8NmtXCHE5LaMxTS8/jRVLdEcbqiWG4Fe5JECsupfJPu8S73AyjAxXY9nxJCIs8
         0l0opmql+7crRxItE8vqD8KoqbW7lmje43yk9HJUCIfSQc/oBfVKBIpSVffY3wUgJCUH
         BaLyB99bQ2/c6teOyQWPHZhgETUnaaRsUa2qggJTH7EG6n17hSlKaw2BU6MsCOEmNsKh
         S7kckVBzVKHP5udYgMKZ4Rwcy2Fqg4mNHJP8R0c2d6cRykQ5LFkluu25TIQGRKbwbPYX
         XBiO92xehwNXUcm0becPgobOaT4xBuswvRxEhTSwrega3r5g+Kromw7n6eFrMhNTLv4f
         DH1A==
X-Gm-Message-State: AOAM531Tx8aIxzEDEVtrqu0iuw7wOa1zVieL3hJSpcEw6t/z8vCJXNc7
        ESsT59mt7LHYQeoSj8zOXTyMEw==
X-Google-Smtp-Source: ABdhPJya74OMyihjnTjGxzZFaoi1KSfjgwyxOOnrXbzf31ztL16rMNupMZQ5aig3yL4AWuICkr/eRg==
X-Received: by 2002:a17:902:b582:: with SMTP id a2mr7488097pls.224.1591382798721;
        Fri, 05 Jun 2020 11:46:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m12sm8493256pjs.41.2020.06.05.11.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:46:37 -0700 (PDT)
Date:   Fri, 5 Jun 2020 11:46:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
Message-ID: <202006051053.A61A42374C@keescook>
References: <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
 <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com>
 <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
 <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
 <202006050828.F85A75D13@keescook>
 <92d994be-e4f5-b186-4ad7-21828de44967@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92d994be-e4f5-b186-4ad7-21828de44967@suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 05, 2020 at 06:55:27PM +0200, Vlastimil Babka wrote:
> 
> On 6/5/20 5:44 PM, Kees Cook wrote:
> > On Fri, Jun 05, 2020 at 04:44:51PM +0200, Vegard Nossum wrote:
> >> On 2020-06-05 16:08, Vlastimil Babka wrote:
> >> > On 6/5/20 3:12 PM, Rafael J. Wysocki wrote:
> >> > > On Fri, Jun 5, 2020 at 2:48 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> >> > > > 
> >> > > > On 2020-06-05 11:36, Vegard Nossum wrote:
> >> > > > > 
> >> > > > > On 2020-06-05 11:11, Vlastimil Babka wrote:
> >> > > > > > So, with Kees' patch reverted, booting with slub_debug=F (or even more
> >> > > > > > specific slub_debug=F,ftrace_event_field) also hits this bug below. I
> >> > > > > > wanted to bisect it, but v5.7 was also bad, and also v5.6. Didn't try
> >> > > > > > further in history. So it's not new at all, and likely very specific to
> >> > > > > > your config+QEMU? (and related to the ACPI error messages that precede
> >> > > > > > it?).
> >> > [...]
> >> > [    0.140408] ------------[ cut here ]------------
> >> > [    0.140837] cache_from_obj: Wrong slab cache. Acpi-Namespace but object is from kmalloc-64
> >> > [    0.141406] WARNING: CPU: 0 PID: 1 at mm/slab.h:524 kmem_cache_free+0x1d3/0x250
> > 
> > Ah yes! Good. I had improved this check recently too, and I was worried
> > the freelist pointer patch was somehow blocking it, but I see now that
> > the failing config didn't have CONFIG_SLAB_FREELIST_HARDENED=y. Once
> > SLAB_CONSISTENCY_CHECKS was enabled ("slub_debug=F"), it started
> > tripping. Whew.
> > 
> > I wonder if that entire test block should just be removed from
> > cache_from_obj():
> > 
> >         if (!memcg_kmem_enabled() &&
> >             !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> >             !unlikely(s->flags & SLAB_CONSISTENCY_CHECKS))
> >                 return s;
> > 
> > and make this test unconditional? It's mostly only called during free(),
> > and shouldn't be too expensive to be made unconditional. Hmm.
> 
> Hmm I have a different idea. The whole cache_from_obj() was added because of
> kmemcg (commit b9ce5ef49f00d) where per-memcg cache can be different from the
> root one. And I just realized this usecase can go away with Roman's series [1].
> But cache_from_obj() also kept the original SLUB consistency check case, and you
> added the freelist hardening case. If kmemcg use case went away it would be nice
> to avoid the virt_to_cache() and check completely again, unless in debugging or
> hardened kernel.

Is it that expensive? (I'm fine with it staying behind debug/hardening,
but if we can make it on by default, that'd be safer.)

> Furthermore, the original SLUB debugging case was an unconditional pr_err() plus
> WARN_ON_ONCE(1), which was kept by commit b9ce5ef49f00d.  With freelist
> hardening this all changed to WARN_ONCE. So the second and later cases are not
> reported at all for hardening and also not for explicitly enabled debugging like
> in this case, which is IMHO not ideal.

Oh, I have no problem with WARN vs WARN_ONCE -- there's no reason to
split this. And I'd love the hardening side to gain the tracking call
too, if it's available.

I had just used WARN_ONCE() since sometimes it can be very noisy to keep
warning for some condition that might not be correctable.

> So I propose the following - the freelist hardening case keeps the WARN_ONCE,
> but also a one-line pr_err() for each case so they are not silent. The SLUB
> debugging case is always a full warning, and printing the tracking info if
> enabled and available. Pure kmemcg case does virt_to_cache() for now (until
> hopefully removed by Roman's series) but no checking at all. Would that work for
> everyone?
> [...]
> @@ -520,9 +528,18 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  		return s;
>  
>  	cachep = virt_to_cache(x);
> -	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
> -		  "%s: Wrong slab cache. %s but object is from %s\n",
> -		  __func__, s->name, cachep->name);
> +	if (unlikely(s->flags & SLAB_CONSISTENCY_CHECKS)) {
> +		if (WARN(cachep && !slab_equal_or_root(cachep, s),
> +			  "%s: Wrong slab cache. %s but object is from %s\n",
> +			  __func__, s->name, cachep->name))
> +			slab_print_tracking(cachep, x);
> +	} else if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED)) {
> +		if (unlikely(cachep && !slab_equal_or_root(cachep, s))) {
> +			pr_err("%s: Wrong slab cache. %s but object is from %s\n",
> +				  __func__, s->name, cachep->name);
> +			WARN_ON_ONCE(1);
> +		}
> +	}

How about just this (in addition to your slab_print_tracking() refactor):

diff --git a/mm/slab.h b/mm/slab.h
index 207c83ef6e06..107b7f6db3c3 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -520,9 +520,10 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 		return s;
 
 	cachep = virt_to_cache(x);
-	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
+	if (WARN(cachep && !slab_equal_or_root(cachep, s),
 		  "%s: Wrong slab cache. %s but object is from %s\n",
-		  __func__, s->name, cachep->name);
+		  __func__, s->name, cachep->name))
+		slab_print_tracking(cachep, x);
 	return cachep;
 }
 

-- 
Kees Cook
