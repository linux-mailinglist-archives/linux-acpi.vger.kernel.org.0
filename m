Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF41F16F5
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jun 2020 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgFHKvs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Jun 2020 06:51:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbgFHKvs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Jun 2020 06:51:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76DDDAC37;
        Mon,  8 Jun 2020 10:51:48 +0000 (UTC)
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
To:     Kees Cook <keescook@chromium.org>
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
 <202006051053.A61A42374C@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <228295be-2e40-3c91-68a0-2715e66486d1@suse.cz>
Date:   Mon, 8 Jun 2020 12:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <202006051053.A61A42374C@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/5/20 8:46 PM, Kees Cook wrote:
>> 
>> Hmm I have a different idea. The whole cache_from_obj() was added because of
>> kmemcg (commit b9ce5ef49f00d) where per-memcg cache can be different from the
>> root one. And I just realized this usecase can go away with Roman's series [1].
>> But cache_from_obj() also kept the original SLUB consistency check case, and you
>> added the freelist hardening case. If kmemcg use case went away it would be nice
>> to avoid the virt_to_cache() and check completely again, unless in debugging or
>> hardened kernel.
> 
> Is it that expensive? (I'm fine with it staying behind debug/hardening,
> but if we can make it on by default, that'd be safer.)

Well, it's fast path and e.g. networking guys did a lot of work to optimize
SLUB. If we decide to stop trusting the supplied cache pointer completely, we
can deprecate kmem_cache_free() and use kfree() everywhere (SLOB would need some
adjustments to store size with each object like for kmalloc) but it would have
to be a conscious decision.

>> Furthermore, the original SLUB debugging case was an unconditional pr_err() plus
>> WARN_ON_ONCE(1), which was kept by commit b9ce5ef49f00d.  With freelist
>> hardening this all changed to WARN_ONCE. So the second and later cases are not
>> reported at all for hardening and also not for explicitly enabled debugging like
>> in this case, which is IMHO not ideal.
> 
> Oh, I have no problem with WARN vs WARN_ONCE -- there's no reason to
> split this. And I'd love the hardening side to gain the tracking call
> too, if it's available.
> 
> I had just used WARN_ONCE() since sometimes it can be very noisy to keep
> warning for some condition that might not be correctable.

OK.

>> So I propose the following - the freelist hardening case keeps the WARN_ONCE,
>> but also a one-line pr_err() for each case so they are not silent. The SLUB
>> debugging case is always a full warning, and printing the tracking info if
>> enabled and available. Pure kmemcg case does virt_to_cache() for now (until
>> hopefully removed by Roman's series) but no checking at all. Would that work for
>> everyone?
>> [...]
>> @@ -520,9 +528,18 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>>  		return s;
>>  
>>  	cachep = virt_to_cache(x);
>> -	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
>> -		  "%s: Wrong slab cache. %s but object is from %s\n",
>> -		  __func__, s->name, cachep->name);
>> +	if (unlikely(s->flags & SLAB_CONSISTENCY_CHECKS)) {
>> +		if (WARN(cachep && !slab_equal_or_root(cachep, s),
>> +			  "%s: Wrong slab cache. %s but object is from %s\n",
>> +			  __func__, s->name, cachep->name))
>> +			slab_print_tracking(cachep, x);
>> +	} else if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED)) {
>> +		if (unlikely(cachep && !slab_equal_or_root(cachep, s))) {
>> +			pr_err("%s: Wrong slab cache. %s but object is from %s\n",
>> +				  __func__, s->name, cachep->name);
>> +			WARN_ON_ONCE(1);
>> +		}
>> +	}
> 
> How about just this (in addition to your slab_print_tracking() refactor):

That could work, I will send a proper patch.

> diff --git a/mm/slab.h b/mm/slab.h
> index 207c83ef6e06..107b7f6db3c3 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -520,9 +520,10 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  		return s;
>  
>  	cachep = virt_to_cache(x);
> -	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
> +	if (WARN(cachep && !slab_equal_or_root(cachep, s),
>  		  "%s: Wrong slab cache. %s but object is from %s\n",
> -		  __func__, s->name, cachep->name);
> +		  __func__, s->name, cachep->name))
> +		slab_print_tracking(cachep, x);
>  	return cachep;
>  }
>  
> 

