Return-Path: <linux-acpi+bounces-11127-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF03A32CF9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118281883DCA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 17:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E3256C95;
	Wed, 12 Feb 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxRxSRWO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78237212B31
	for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380011; cv=none; b=cwuaGAX72s1L//senrD/M3+oGHQYP3Mw+Z5zXU4uV0PR+z+VE/TKhBdR/4NuIJGyFISAWYZm0jyNlEbJ7GbcJGmFaeQxZaX0cohVg6h2+LkSDEzaJn3tjZFjG6EyRHgzoCordxNq2/7TXeXrrMNW4O+dG2gvkT5Yojeqf2gmJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380011; c=relaxed/simple;
	bh=H9pK6UUuz8mTCNtJN9f3vWk2JLGgFKmY8tsdGP0A21c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V05YDjyn82wxQbPq64EYAWyXFDJN7KY/2oAArzrZn09eK+1aqC7C5phCce4X7FEz+HD/UdViIV3icGL6k1xv1Qs+4SrXOgzfkS+uxrFnB8fbkNxcHMpadx1kK4TiN71nLRfUMkb2YsOcXTRIo4dCn1d8o4kQdvRUP4sI1UqHpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxRxSRWO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fb0200b193so32490097b3.0
        for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 09:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739380008; x=1739984808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHhgDa+15Ow4EU32iMlqezS/s+Dmcp5L9qnpQ95X31U=;
        b=CxRxSRWOUB7BgfIZay2fINSgBMAIitcL968g5vkqWXJd33El1K5pzcPN1AuNYV9Cq1
         YzeMCXguMFdbhrOAmC6WK4J5v8IVoxThcCtLfp4p8ySHZYsnHUcGkh0uLyPrhN1iL87G
         /P+fWtgOSMVdmb+KLomtlXh4+rFHMTzN6V0EmpTgkGk5q0r+gaS99dDQnTZdxzNBWqpG
         oemfqY1ovudimvHkgJedIb771UxyXHfCklM35dfgoXEDwAT8wwODcuJ4zxUHtYx4YIGo
         wct/WIAqyR2FMhB6iDnECKDuaoi/8ioaTKSvXD9osp9JAwAiYWYGMSteL903BQbhlm66
         07Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380008; x=1739984808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHhgDa+15Ow4EU32iMlqezS/s+Dmcp5L9qnpQ95X31U=;
        b=KGR+GJTqTPKg0ebtWI9wGEZSczSYQjfuf25UomJkQR1OHIg97WydCEb1WeDv5KQNhr
         EukeCvo+m/OpvhIBKFNlKWu9qm3e/m1ykDMprHmIni7j9AoL6K2iGmTb9Bj3C5dbKXOM
         1+/4RhfrQ2sBftf4EUr0oRcZHVWCuumLdgUyxzqPpighdjcBCh6sEtSQnc1XuHAUcwiX
         +4O5UAKzc+hUg/Jdtx949VV4aodI0HvCwE/6B1Gn+4lu0a6+8SWYTCFg4D+Wn+s1GXI+
         yBFtTqrRQJnbiyHw1aEeL0/neMYL1dvG5uGEjpBvhtI6fmhSzMT3MwfvnPNDvVx12g7j
         41uw==
X-Forwarded-Encrypted: i=1; AJvYcCUGpq1vMJe8ibZQHDzUH+exTqmHjGSu18MlcMheb+pagMxm4vobPS7dOVa8G6aOZ56DUcw32py1XeMf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfoi3OeS2J7lDiQpAC5o3+iUTiTU9P7W1i2i25Z1T55bhaedC9
	B6w3grAOxajLxSpO3vRtQFN1q3ZtIsIL516v1RH2MjEiDRexqn0e
X-Gm-Gg: ASbGnct6lHCDzmLbfXTXZFBnMxjF5qUvrgDSiIIkR4T7oEtrtTVr7JVHJpSJH8NxsSx
	c3BupBcqM1MH2Et1rFSHoFoW4cemwFK9Y31jeq6O/Tg+oJGk5WuLhb2XfzkpzHcoEM9HiZ+Ozx/
	pO9d/3mMuARFrpApk5FmBe1D4g4S98sY1MlLRTSCYzF80ESkwtQVGawLFzE2GHYIrnFsdvWoX36
	Cfppcoig6GA4x8cjjaONtQCyWHh6icwWVXmd33DOmIA0JPNAnY/Un4EMHRzkTurkCip2w+Qzx+v
	Nha74FwL+AIAbA==
X-Google-Smtp-Source: AGHT+IHUNoQgf2R9a7OphhBMiQ7H3h8YLQWV053bqd5METYdW0bV3GZsxihxsz4cEOxVwaUfLVto4A==
X-Received: by 2002:a05:690c:6b89:b0:6f9:8916:3b66 with SMTP id 00721157ae682-6fb1f5a6fffmr43129347b3.12.1739380008194;
        Wed, 12 Feb 2025 09:06:48 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99fd3c323sm27237247b3.49.2025.02.12.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:06:47 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: gourry@gourry.net,
	hyeonggon.yoo@sk.com,
	honggyu.kim@sk.com,
	akpm@linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Wed, 12 Feb 2025 09:06:40 -0800
Message-ID: <20250212170645.1080771-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <87a5ar3mir.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 10:49:32 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Hi, Joshua,
> 
> Thanks for your patch and sorry for late reply.

Hi Ying, no worries! Thank you for taking time to review this patch.

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:

[...snip...]

> > This patch introduces an auto-configuration mode for the interleave
> > weights that aims to balance the two goals of setting node weights to be
> > proportional to their bandwidths and keeping the weight values low.
> > In order to perform the weight re-scaling, we use an internal
> > "weightiness" value (fixed to 32) that defines interleave aggression.
> 
> As asked by Andrew in another thread, you may need to make it more
> explicit about why we need this patch.

Yes, I think that makes a lot of sense. Probably some details about
why we use 32 as the default weightiness value will also help with clarity.

[...snip...]

> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > index 0b7972de04e9..ef43228d135d 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > @@ -20,6 +20,38 @@ Description:	Weight configuration interface for nodeN
> >  		Minimum weight: 1
> >  		Maximum weight: 255
> >  
> > -		Writing an empty string or `0` will reset the weight to the
> > -		system default. The system default may be set by the kernel
> > -		or drivers at boot or during hotplug events.
> > +		Writing invalid values (i.e. any values not in [1,255],
> > +		empty string, ...) will return -EINVAL.
> > +
> > +		Changing the weight to a valid value will automatically
> > +		update the system to manual mode as well.
> > +
> > +What:		/sys/kernel/mm/mempolicy/weighted_interleave/auto
> > +Date:		February 2025
> > +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> > +Description:	Auto-weighting configuration interface
> > +
> > +		Configuration mode for weighted interleave. A 'Y' indicates
> > +		that the system is in auto mode, and a 'N' indicates that
> > +		the system is in manual mode. All other values are invalid.
> > +
> > +		In auto mode, all node weights are re-calculated and overwritten
> > +		(visible via the nodeN interfaces) whenever new bandwidth data
> > +		is made available during either boot or hotplug events.
> > +
> > +		In manual mode, node weights can only be updated by the user.
> > +		Note that nodes that are onlined with previously set / defaulted
> 
> Sorry, I don't understand this well.  What is "defaulted" weights?  Why
> not just "previously set"?

This is just poor word choice on my end. I meant to say that if they had
been using auto mode previously and the node contained system-calculated
weights, then offlining and onlining while in manual mode would bring
back the weights from the system. This is the scenario:

Auto: weights are set to [1,2,3]
Mode changes from auto --> manual
Manual: weights are still [1,2,3]
Manual: update node0 to be [7,2,3]
Offline node2
Manual: weights are still [7,2,3], even though node2 is offline
Online node2
Manual: weights are still [7,2,3]
                               ^ I just wanted to highlight that it will
			         online with a weight of 3, which is a
				 value set by the system.

> > +		weights will inherit those weights. If they were not previously
> > +		set or are onlined with missing bandwidth data, they will be
> > +		defaulted to a weight of 1.
> > +
> > +		Writing Y or 1 to the interface will enable auto mode, while
> > +		writing N or 0 will enable manual mode. All other strings will
> > +		be ignored, and -EINVAL will be returned.
> > +
> > +		If Y or 1 is written to the interface but the recalculation or
> > +		updates fail at any point (-ENOMEM or -ENODEV), then the system
> > +		will remain in manual mode.
> 
> IMHO, it's unnecessary to make this a part of the interface definition.
> However, I have no strong opinion on this.

Thank you for your input. I was just trying to be as explicit and
thorough as possible, but I can see how this might feel a bit cluttered.

> > +		Writing a new weight to a node directly via the nodeN interface
> > +		will also automatically update the system to manual mode.
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index 80a3481c0470..cc94cba112dd 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/list_sort.h>
> >  #include <linux/memregion.h>
> >  #include <linux/memory.h>
> > +#include <linux/mempolicy.h>
> >  #include <linux/mutex.h>
> >  #include <linux/node.h>
> >  #include <linux/sysfs.h>
> 
> This change should be removed?

Ah I see. Harry (Hyeonggon) had pointed this out in v4 of the patch,
but I misread the response because I thought his comment was about
the include in node.c, not in hmat.c. Sorry, Harry! This is correct;
this include statement should not be here. 

[...snip...]

> >  struct mempolicy {};
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 04f35659717a..51edd3663667 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -109,6 +109,7 @@
> >  #include <linux/mmu_notifier.h>
> >  #include <linux/printk.h>
> >  #include <linux/swapops.h>
> > +#include <linux/gcd.h>
> >  
> >  #include <asm/tlbflush.h>
> >  #include <asm/tlb.h>
> > @@ -138,16 +139,18 @@ static struct mempolicy default_policy = {
> >  
> >  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
> >  
> > +static uint64_t *node_bw_table;
> 
> Usually, we use "u64" instead of "uint64_t" in kernel.  It appears that
> we don't need u64. "unsigned int" should be enough because "struct
> access_coordinate" uses that too.
> 
> It's better to move this after iw_table definition below.  And make it
> explicit that iw_table_lock protects all interleave weight global
> variables.

I see, that makes sense. I will change it to unsigned int and move
it below, I agree that the scope of the lock should be clearer as well.

> > +
> >  /*
> > - * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
> > - * system-default value should be used. A NULL iw_table also denotes that
> > - * system-default values should be used. Until the system-default table
> > - * is implemented, the system-default is always 1.
> > - *
> > + * iw_table is the interleave weight table.
> > + * If bandwidth data is available and the user is in auto mode, the table
>                                              ~~~~
>                                              system?

Thank you, I'll fix this.

> > + * is populated with default values in [1,255].
> 
> If system is in manual mode, the weight value is in [1, 255] too?
> 
> NULL iw_table is still a valid configuration, so we still need to
> describe its behavior.  Right?

Yes, that is true. I just wanted to explicilty note that the default
values selected by the system in auto mode will be in that range.

I'll also include what happens when iw_table is null. It only happens
when there is absolutely no bandwidth information available, so I
will note that in the description as well.

> >   * iw_table is RCU protected
> >   */
> >  static u8 __rcu *iw_table;
> >  static DEFINE_MUTEX(iw_table_lock);
> > +static const int weightiness = 32;
> > +static bool weighted_interleave_auto = true;
> >  
> >  static u8 get_il_weight(int node)
> >  {
> > @@ -156,14 +159,114 @@ static u8 get_il_weight(int node)
> >  
> >  	rcu_read_lock();
> >  	table = rcu_dereference(iw_table);
> > -	/* if no iw_table, use system default */
> 
> It appears that this applies at some degree.

Yes -- but this is only possible if there is no bandwidth data available
(and therefore, mempolicy_set_node_perf is never called). If this is
the case, then all nodes will have the same weight. Setting the default
weight to 1 means weighted interleave is reduced to unweighted interleave,
but setting the default weight to 0 will mean no memory can be allocated.

[...snip...]

> > +	if (old_bw)
> > +		memcpy(new_bw, old_bw, nr_node_ids * sizeof(uint64_t));
> > +	new_bw[node] = bw_val;
> > +	node_bw_table = new_bw;
> > +
> > +	if (weighted_interleave_auto) {
> > +		reduce_interleave_weights(new_bw, new_iw);
> > +	} else if (old_iw) {
> > +		/*
> > +		 * The first time mempolicy_set_node_perf is called, old_iw
> > +		 * (iw_table) is null. If that is the case, assign a zeroed
> > +		 * table to it. Otherwise, free the newly allocated iw_table.
> 
> We shouldn't assign a zeroed iw_table?  Because 0 isn't valid now.
> Please check changes in weighted_interleave_nid() below.

Thank you for the catch! I will fix this and write that it will contain
default values of 1 instead!.

> > +		 */
> > +		mutex_unlock(&iw_table_lock);
> > +		kfree(new_iw);
> > +		kfree(old_bw);
> > +		return 0;
> > +	}
> > +
> > +	rcu_assign_pointer(iw_table, new_iw);
> > +	mutex_unlock(&iw_table_lock);
> > +	synchronize_rcu();
> > +	kfree(old_iw);
> 
> If you want to save one synchronize_rcu() if unnecessary, you can use
> 
>         if (old_iw) {
>                 synchronize_rcu();
>                 kfree(old_iw);
>         }

I see, that makes sense. Thank you!

[...snip...]

> > +static ssize_t weighted_interleave_mode_show(struct kobject *kobj,
> 
> IMHO, it's better to name the function as
> weighted_interleave_auto_show()?

That makes sense, this was an artifact of when we named the interface
to be "mode", but it seems like I overlooked renaming this function.

> > +		struct kobj_attribute *attr, char *buf)
> > +{
> > +	if (weighted_interleave_auto)
> > +		return sysfs_emit(buf, "Y\n");
> > +	else
> > +		return sysfs_emit(buf, "N\n");
> 
> str_true_false() can be used here.

Thank you!

> > +}
> > +
> > +static ssize_t weighted_interleave_mode_store(struct kobject *kobj,
> > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > +{
> > +	uint64_t *bw;
> > +	u8 *old_iw, *new_iw;
> > +
> > +	if (count == 0)
> > +		return -EINVAL;
> > +
> > +	if (sysfs_streq(buf, "N") || sysfs_streq(buf, "0")) {
> 
> kstrtobool() can be used here.  It can deal with 'count == 0' case too.

These kernel string tools are very helpful, thank you for bringing
them to my attention : -)

> > +		weighted_interleave_auto = false;
> > +		return count;
> > +	} else if (!sysfs_streq(buf, "Y") && !sysfs_streq(buf, "1")) {
> > +		return -EINVAL;
> > +	}
> > +
> > +	new_iw = kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL);
> > +	if (!new_iw)
> > +		return -ENOMEM;
> > +
> > +	mutex_lock(&iw_table_lock);
> > +	bw = node_bw_table;
> > +
> > +	if (!bw) {
> > +		mutex_unlock(&iw_table_lock);
> > +		kfree(new_iw);
> > +		return -ENODEV;
> > +	}
> > +
> > +	old_iw = rcu_dereference_protected(iw_table,
> > +					   lockdep_is_held(&iw_table_lock));
> > +
> > +	reduce_interleave_weights(bw, new_iw);
> > +	rcu_assign_pointer(iw_table, new_iw);
> > +	mutex_unlock(&iw_table_lock);
> > +
> > +	synchronize_rcu();
> > +	kfree(old_iw);
> > +
> > +	weighted_interleave_auto = true;
> 
> Why assign weighted_interleave_auto after synchronize_rcu()?  To reduce
> the race window, it's better to change weighted_interleave_auto and
> iw_table together?  Is it better to put them into a data structure and
> change them together always?
> 
>         struct weighted_interleave_state {
>                 bool weighted_interleave_auto;
>                 u8 iw_table[0]
>         };

I see, I think your explanation makes sense. For the first question,
I think your point makes sense, so I will move the updating to be
inside the rcu section.

As for the combined data structure, I think that this makes sense,
but I have a few thoughts. First, there are some times when we don't
update both of them, like moving from auto --> manual, and whenever
we just update iw_table, we don't need to update the weighted_interleave
auto field. I also have a concern that this might make the code a bit
harder to read, but that is just my humble opinion.

> ---
> Best Regards,
> Huang, Ying

Thank you Ying for your detailed comments! It seems like there are a lot
of things that I missed, thank you for reviewing my patch and catching
the mistakes. Please let me know if there are any other changes that you
see fit for the patch. Have a great day!

Joshua

Sent using hkml (https://github.com/sjp38/hackermail)


