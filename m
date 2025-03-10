Return-Path: <linux-acpi+bounces-12027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D79A59ECB
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF4188E4DC
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6040D23026D;
	Mon, 10 Mar 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPkUL71Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590C22D7A6;
	Mon, 10 Mar 2025 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628066; cv=none; b=AuCe1EM45cPEcRjHEQ2YQ942y2pUR6yvvE+VqgqTpLqFGdnzv8ooKe61i75IffOvOkuvmT19/2FR7mnzziuMpf2pp3Y+Q9w0CmffyaJc71FikLC8NWoGoDyWtBdn5Y+Uz+k78Fy+nSZgCv75sO54CrnRyVru+ONq7nnDMbtau+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628066; c=relaxed/simple;
	bh=MVx+fCo85u4wgalBIFZ21CCzFjRouZcgwppJvfQn7/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjyaWKAI6g8xBsHnIaaLkFlDWD+g+10KA5UJ/OuufU5t+MxcPkrtOqlDtwu5+RKuzR81+mszIXbQTqBFXQ/I9LcLgsfKPQIrtIE5iRggn241So3a15AJLdvINGa52DvqeW/GgMXNVB0KU3ScO9LzmFf7rgAnkT0bCTlnGJK67wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPkUL71Q; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fef1d35589so11930667b3.0;
        Mon, 10 Mar 2025 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741628063; x=1742232863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OqdZvwViuemiAWalUFPpXAEeEJqmTa93Po2Bd4FDRE=;
        b=iPkUL71Q731yfIfaUwEf1P9mf3onHzpzSo9N0RzO9jSsLV3UsZMz2ren8pjkqp1tnE
         xe0W1ReA79HpfDQy+202RTrDi2aG5o7KK8I84ZVkh8kclTtbS1niJswsd+3GZQmzciOD
         cdhylEaVOCToztQgGHukrQ1z5qQ7Ov614MsJmAIdVmyGBWG7wbQEuy4Vyezi8qbVhy32
         Q6SFYyqsjeAOVcxb0iCwgUAEYqlA22hyXyZEJuP5uDNi1QE45Y/sdPkh+6MDv+a6zOa7
         utxEpD1WBVHLdWyENS32UJPGvrqbUxyf77pXtqcQ5Ng4tqh11fL9DU9EatB5Az/4qrsW
         Ntdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741628063; x=1742232863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OqdZvwViuemiAWalUFPpXAEeEJqmTa93Po2Bd4FDRE=;
        b=tNFB/0tLp3COfmoLRIIaOlpOpmN0honwVn98Oum1TZl5ZfZxiu5rvDoc8PVV7qCfjr
         ejaluDMpD4K9IdLbsTsMnKJzJkWgdZBnkK4iEx97rc5+yL0l7hg2WumuOoZB4FKn6eyX
         HA4Ypnapoe0sUwkm5hrCcKjhkPUD98k+aQsDLkbCmXcT86DUoSBckO79rfSA0+jU1jLs
         qZc1oKs/NHSiVxjt+4SjksqRLGBkAn3mY/6Oir4npgMcA9vUrNM8iBlkyGRl5vi+jAIq
         CX6+HI7FhJN+hWo9hRP8P8vmoznuyhMH5Rf4Rbyla05FJ70TYpifaHrNbNvH0Lddu9Ia
         G6pw==
X-Forwarded-Encrypted: i=1; AJvYcCUx2Gsb77c7y80KZfC7oSO2QEKm2UUGAiTLkxOlYKbMsUqU9PhIvIQ0sFtBOnHlFKmDCZc+yaeP4KATEhhe@vger.kernel.org, AJvYcCVfgxIGoU0HNYZNN5JTr/l5TE4NFv1jNojEVAeAqNcsgyuEumCCs+pr/syzo1mXtOFQdA6H7BDzumpC@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgq1V9KRJHzMEvLIiuk5ETP+dAhTkCaIQQu0dqm/x/UP7YAJf
	z+vGVEO6cGyvLKdeGq0j3Bf/a0fLRueYBDYQe6puXtQNU3TVsWJ/DORsLw==
X-Gm-Gg: ASbGncuP/E2/Yu2CXH48+mqFFVAcEfO2YO9RUDmnfmQ+MNj7qc5zzj/guFd5mdJ2YOw
	gHJeUFD+AE0hN4jk2QtCTipXJGiYltz0ygKf0RK19AP75XEQIn2wsFd0ZAcunJT19YW5FP0cV44
	ifrUNmalWCYL8hSCzrX8cbccaiwqWMOciJ5zg5f2D2YAm0wet8tYV4zn9p0wrCUvh8TIvjbrn8X
	lA91i93YSoWbvELhTydyJG6NV74JcVbuyDWaddhanwDY5kVK1Nv39unqRWWzJathMsQWf8xlB8X
	0J52XWpnKUr+rgNT2wHJDElClLssEfMpH2jHgCE3zcE=
X-Google-Smtp-Source: AGHT+IFFP80rhMMdb4dQpy8xACZsyTMqZugcmMkdrMh8ivN/mf7QiBrFhw+eHS5oi/KRsnSfOfwc+g==
X-Received: by 2002:a05:690c:670f:b0:6fd:32ab:ed28 with SMTP id 00721157ae682-6febf2d84b1mr217949967b3.15.1741628062939;
        Mon, 10 Mar 2025 10:34:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c2e885sm22133987b3.70.2025.03.10.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:34:22 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	akpm@linux-foundation.org
Cc: gourry@gourry.net,
	harry.yoo@oracle.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v7] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Mon, 10 Mar 2025 10:33:37 -0700
Message-ID: <20250310173420.539849-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <874j0162vt.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Mar 2025 10:22:30 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

Hello Andrew,

I'm sincerely sorry, but I think I think that there are some RCU race
conditions that I overlooked in this patch. Would it be ok with you to
pull the patch out of mm-unstable once more, and for me to send a v8? I think
it would also be safe to wait for Ying's signature on this patch as well,
since he has been reviewing this patch since the first iteration.
Thank you for your help as always! 

> Hi, Joshua,
> 
> Thanks for your new version.
> 
> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On machines with multiple memory nodes, interleaving page allocations
> > across nodes allows for better utilization of each node's bandwidth.
> > Previous work by Gregory Price [1] introduced weighted interleave, which
> > allowed for pages to be allocated across nodes according to user-set ratios.
> >
> > Ideally, these weights should be proportional to their bandwidth, so
> > that under bandwidth pressure, each node uses its maximal efficient
> > bandwidth and prevents latency from increasing exponentially.
> >
> > Previously, weighted interleave's default weights were just 1s -- which
> > would be equivalent to the (unweighted) interleave mempolicy, which goes
> > through the nodes in a round-robin fashion, ignoring bandwidth information.
> >
> > This patch has two main goals:
> > First, it makes weighted interleave easier to use for users who wish to
> > relieve bandwidth pressure when using nodes with varying bandwidth (CXL).
> > By providing a set of "real" default weights that just work out of the
> > box, users who might not have the capability (or wish to) perform
> > experimentation to find the most optimal weights for their system can
> > still take advantage of bandwidth-informed weighted interleave.
> >
> > Second, it allows for weighted interleave to dynamically adjust to
> > hotplugged memory with new bandwidth information. Instead of manually
> > updating node weights every time new bandwidth information is reported
> > or taken off, weighted interleave adjusts and provides a new set of
> > default weights for weighted interleave to use when there is a change
> > in bandwidth information.
> >
> > To meet these goals, this patch introduces an auto-configuration mode
> > for the interleave weights that provides a reasonable set of default
> > weights, calculated using bandwidth data reported by the system. In auto
> > mode, weights are dynamically adjusted based on whatever the current
> > bandwidth information reports (and responds to hotplug events).
> >
> > This patch still supports users manually writing weights into the nodeN
> > sysfs interface by entering into manual mode. When a user enters manual
> > mode, the system stops dynamically updating any of the node weights,
> > even during hotplug events that shift the optimal weight distribution.
> >
> > A new sysfs interface "auto" is introduced, which allows users to switch
> > between the auto (writing 1 or Y) and manual (writing 0 or N) modes. The
> > system also automatically enters manual mode when a nodeN interface is
> > manually written to.
> >
> > There is one functional change that this patch makes to the existing
> > weighted_interleave ABI: previously, writing 0 directly to a nodeN
> > interface was said to reset the weight to the system default. Before
> > this patch, the default for all weights were 1, which meant that writing
> > 0 and 1 were functionally equivalent.
> 
> Forget to describe the new functionality?

Hi Ying, thank you for reviewing my patch again!
Thank you for letting me know. When I re-wrote the patch letter from v5-->v6,
I was reworking this portion, and tried to make it shorter and shorter... and
I think I missed being explicit about what the new behavior is. 

[...snip...]

> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > index 0b7972de04e9..862b19943a85 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > @@ -20,6 +20,34 @@ Description:	Weight configuration interface for nodeN
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
> > +		the system is in manual mode.
> 
> str_true_false() is used to show the attribute, so the "true/false" will
> be displayed?

Yep, makes sense to me!

> > +
> > +		In auto mode, all node weights are re-calculated and overwritten
> > +		(visible via the nodeN interfaces) whenever new bandwidth data
> > +		is made available during either boot or hotplug events.
> > +
> > +		In manual mode, node weights can only be updated by the user.
> > +		Note that nodes that are onlined with previously set weights
> > +		will inherit those weights. If they were not previously set or
> 
> s/inherit/reuse/?
> 
> However my English is poor, so keep it if you think that is better.

Hmm, I think reuse is indeed the better word to use here. Inherit kind of makes
it seeem like there is some parent-child hierarchy, which is definitely
not the case here. 

> > +		are onlined with missing bandwidth data, the weights will use
> > +		a default weight of 1.
> > +
> > +		Writing Y or 1 to the interface will enable auto mode, while
> 
> kstrtobool() is used to parser user input, so maybe something like
> below?
> 
> Writing any true value string (e.g., Y or 1) will enable auto mode.

Noted, I will take this change as well.

> > +		writing N or 0 will enable manual mode. All other strings will
> > +		be ignored, and -EINVAL will be returned.
> > +
> > +		Writing a new weight to a node directly via the nodeN interface
> > +		will also automatically update the system to manual mode.
> 
> s/update/switch/?
> 
> Again, keep your words if think that it's better.

And here as well. Thank you for the suggestions!

[...snip...]

> > diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> > index ce9885e0178a..78f1299bdd42 100644
> > --- a/include/linux/mempolicy.h
> > +++ b/include/linux/mempolicy.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/rbtree.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/node.h>
> >  #include <linux/nodemask.h>
> >  #include <linux/pagemap.h>
> >  #include <uapi/linux/mempolicy.h>
> > @@ -56,6 +57,11 @@ struct mempolicy {
> >  	} w;
> >  };
> >  
> > +struct weighted_interleave_state {
> > +	bool mode_auto;
> 
> Just "auto" looks more natural for me.  However, I have no strong
> opinion on thist.

Yep, my concern was that just leaving "auto" might be a bit vague, but
there is always the doucmentation for folks to reference if they are confused.

> > +	u8 iw_table[]; /* A null iw_table is interpreted as an array of 1s. */
> 
> What is "null" array?

You are right, there is no concept of a null array in a dynamically sized
struct

> IIUC, iw_state is prevous iw_table now, so we may replace this with,
> 
> A null wi_state is interpreted as mode is "auto" and the weight of any
> node is "1".

Yup, this makes sense. The only 2 cases with a "null" iw_table is if
wi_state itself is null, or if the length is 0 (in which case the table
isn't null, it will just point to the next address in memory). I'll take your
new description here. Thank you for the suggestion!
> >  /*
> > - * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
> > - * system-default value should be used. A NULL iw_table also denotes that
> > - * system-default values should be used. Until the system-default table
> > - * is implemented, the system-default is always 1.
> > - *
> > - * iw_table is RCU protected
> > + * weightiness balances the tradeoff between small weights (cycles through nodes
> > + * faster, more fair/even distribution) and large weights (smaller errors
> > + * between actual bandwidth ratios and weight ratios). 32 is a number that has
> > + * been found to perform at a reasonable compromise between the two goals.
> >   */
> > -static u8 __rcu *iw_table;
> > -static DEFINE_MUTEX(iw_table_lock);
> > +static const int weightiness = 32;
> > +
> > +/* wi_state is RCU protected */
> 
> "__rcu" below can replace the above comments?

Yes, I will remove the comments above.

> > +static struct weighted_interleave_state __rcu *wi_state;
> > +static unsigned int *node_bw_table;
> > +
> > +/*
> > + * wi_state_lock protects both wi_state and node_bw_table.
> > + * node_bw_table is only used by writers to update wi_state.
> > + */
> > +static DEFINE_MUTEX(wi_state_lock);
> >  
> >  static u8 get_il_weight(int node)
> >  {
> > -	u8 *table;
> > -	u8 weight;
> > +	u8 weight = 1;
> >  
> >  	rcu_read_lock();
> > -	table = rcu_dereference(iw_table);
> > -	/* if no iw_table, use system default */
> > -	weight = table ? table[node] : 1;
> > -	/* if value in iw_table is 0, use system default */
> > -	weight = weight ? weight : 1;
> > +	if (rcu_access_pointer(wi_state))
> > +		weight = rcu_dereference(wi_state)->iw_table[node];
> 
> IIUC, wi_state may be changed between rcu_access_pointer() and
> rcu_dereference().  If so, it's better to use rcu_dereference()
> directly.

Yes, you are correct. To be completely transparent, I had misunderstood
the rcu_dereference_pointer function and had assumed NULL pointers should
not be passed to it. I now understand that we should actually do the null check
afterwards. There are a few other places where this is used -- I'll go and
fix all of them.

[...snip...]

> > +int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
> > +{
> > +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> > +	unsigned int *old_bw, *new_bw;
> > +	unsigned int bw_val;
> > +	int i;
> > +
> > +	bw_val = min(coords->read_bandwidth, coords->write_bandwidth);
> > +	new_bw = kcalloc(nr_node_ids, sizeof(unsigned int), GFP_KERNEL);
> > +	if (!new_bw)
> > +		return -ENOMEM;
> > +
> > +	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> > +			       GFP_KERNEL);
> 
> NIT: because we will always initialize new_wi_state->iw_table[] below,
> we can just use kmalloc() and initailze new_wi_state->mode_auto?

Yes, this makes sense to me.

> > +	if (!new_wi_state) {
> > +		kfree(new_bw);
> > +		return -ENOMEM;
> > +	}
> > +	for (i = 0; i < nr_node_ids; i++)
> > +		new_wi_state->iw_table[i] = 1;
> > +
> > +	/*
> > +	 * Update bandwidth info, even in manual mode. That way, when switching
> > +	 * to auto mode in the future, iw_table can be overwritten using
> > +	 * accurate bw data.
> > +	 */
> > +	mutex_lock(&wi_state_lock);
> > +
> > +	old_bw = node_bw_table;
> > +	if (old_bw)
> > +		memcpy(new_bw, old_bw, nr_node_ids * sizeof(unsigned int));
> 
> I prefer
> 
> 		memcpy(new_bw, old_bw, nr_node_ids * sizeof(*old_bw));
> 
> a little.  But it's not a big deal.

We can do this. old_bw should not be null here, anyways!

> > +	new_bw[node] = bw_val;
> > +	node_bw_table = new_bw;
> > +
> > +	/* wi_state not initialized yet; assume auto == true */
> > +	if (!rcu_access_pointer(wi_state))
> > +		goto reduce;
> > +
> > +	old_wi_state = rcu_dereference_protected(wi_state,
> > +					lockdep_is_held(&wi_state_lock));
> > +	if (old_wi_state->mode_auto)
> 
> Because we can use "!old_wi_state || !old_wi_state->mode_auto" here, I
> don't think rcu_access_pointer() above gives us something.

Sounds good as well.

> > +		goto reduce;
> > +
> > +	mutex_unlock(&wi_state_lock);
> > +	kfree(new_wi_state);
> > +	kfree(old_bw);
> > +	return 0;
> > +
> > +reduce:
> > +	new_wi_state->mode_auto = true;
> > +	reduce_interleave_weights(new_bw, new_wi_state->iw_table);
> > +	rcu_assign_pointer(wi_state, new_wi_state);
> > +
> > +	mutex_unlock(&wi_state_lock);
> > +	if (old_wi_state) {
> > +		synchronize_rcu();
> > +		kfree(old_wi_state);
> > +	}
> > +	kfree(old_bw);
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * numa_nearest_node - Find nearest node by state
> >   * @node: Node id to start the search
> > @@ -1988,34 +2093,33 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
> >  	u8 *table;
> >  	unsigned int weight_total = 0;
> >  	u8 weight;
> > -	int nid;
> > +	int nid = 0;
> >  
> >  	nr_nodes = read_once_policy_nodemask(pol, &nodemask);
> >  	if (!nr_nodes)
> >  		return numa_node_id();
> >  
> >  	rcu_read_lock();
> > -	table = rcu_dereference(iw_table);
> > +	if (!rcu_access_pointer(wi_state))
> > +		goto out;
> 
> If wi_state == NULL, why should we always return 0?  IIUC, wi_state ==
> NULL means the weight of any node is 1.

That is true, we can still find out what the correct value should be
based on just assuming all weights to be 1 -- I will make this change.

> > +
> > +	table = rcu_dereference(wi_state)->iw_table;
> >  	/* calculate the total weight */
> > -	for_each_node_mask(nid, nodemask) {
> > -		/* detect system default usage */
> > -		weight = table ? table[nid] : 1;
> > -		weight = weight ? weight : 1;
> > -		weight_total += weight;
> > -	}
> > +	for_each_node_mask(nid, nodemask)
> > +		weight_total += table ? table[nid] : 1;
> 
> When will table be NULL here?

It couldn't before. But given your feedback above, we can just set
table to be null if iw_table does not exist, and the code should behave
as intended.

[...snip...]

> > +update_wi_state:
> > +	rcu_assign_pointer(wi_state, new_wi_state);
> > +	mutex_unlock(&wi_state_lock);
> > +	if (old_wi_state) {
> > +		synchronize_rcu();
> > +		kfree(old_wi_state);
> > +	}
> > +	return count;
> > +}
> > +
> > +static struct kobj_attribute wi_attr =
> 
> NIT: "wi_attr" appears too general for me.  Maybe something like
> "wi_auto_attr"?

Will do!
> ---
> Best Regards,
> Huang, Ying

Thank you for all of your feedback, Ying! I will send out a v8 soon with
all of your proposed changes. Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)


