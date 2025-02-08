Return-Path: <linux-acpi+bounces-10947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AAFA2D44E
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 07:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EC73A966D
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 06:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4D192B71;
	Sat,  8 Feb 2025 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nJMeWehv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EO2+v697";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nJMeWehv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EO2+v697"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C413D28F
	for <linux-acpi@vger.kernel.org>; Sat,  8 Feb 2025 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738997505; cv=none; b=GeYIMZyeFOazbeh/KqyFQVOA7uV1kt59bXdSXukQS6YltevrEF48N1KGBSc/VT8OgEshMuGztbvI2dIqraIn7ljIuFzdAizFNcdrTc7fdxHlQhJmiv7xW/WokmqxbMYCn4jkRKt1ICSBIN3xHe9rVvJ2UOZ7oyKxTXNU973tQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738997505; c=relaxed/simple;
	bh=xxu7oGLWQXAds1yHZvg+4WcKwmM3JQ3zot10u1pjz38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH/KQKWrzcgaGXKC9gHPjk8eq9iTFTH/Xdu1kmui1102sSPvqhrwxxPNIiUNJYV9J7f/9Hg+Ja89k5Co9gi1sgBdxVbS/hWHjGOvZ292QemAawn+t4g4TcNeHSbw64BDnIFTvw7aMZBQFTpq5ekMMYhZ8ASxVborqKN0wApcdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nJMeWehv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EO2+v697; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nJMeWehv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EO2+v697; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AC8C2115F;
	Sat,  8 Feb 2025 06:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738997501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0MWXuPM/bMM0908L1atALX4t7lCHtq7sbFIGN82KGU=;
	b=nJMeWehv/yy1KejSKMePgW9DSQ8Df4oel6vPtFXnGqkncwgEUdXm+W7imiCuqRCoEZ/JYL
	HTfJ0IejEclJKvbXJubRtiNul6LZv/XmAV0Ofe6Eh9lywC/x7B1AoyJByTEl3KF/+7jbFp
	MiX8jLniwfa38PQahFqGtioCTINKEjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738997501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0MWXuPM/bMM0908L1atALX4t7lCHtq7sbFIGN82KGU=;
	b=EO2+v697wtHWhMOJqXUCtofVz39NF6AAz5vb7O5gkXfzNKrg+lRwTTzegmktD32UHDzXcN
	3WPJpGNG6iDzmYBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nJMeWehv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EO2+v697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738997501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0MWXuPM/bMM0908L1atALX4t7lCHtq7sbFIGN82KGU=;
	b=nJMeWehv/yy1KejSKMePgW9DSQ8Df4oel6vPtFXnGqkncwgEUdXm+W7imiCuqRCoEZ/JYL
	HTfJ0IejEclJKvbXJubRtiNul6LZv/XmAV0Ofe6Eh9lywC/x7B1AoyJByTEl3KF/+7jbFp
	MiX8jLniwfa38PQahFqGtioCTINKEjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738997501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0MWXuPM/bMM0908L1atALX4t7lCHtq7sbFIGN82KGU=;
	b=EO2+v697wtHWhMOJqXUCtofVz39NF6AAz5vb7O5gkXfzNKrg+lRwTTzegmktD32UHDzXcN
	3WPJpGNG6iDzmYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41DFC139CB;
	Sat,  8 Feb 2025 06:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KF27DPz+pmdZPwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 08 Feb 2025 06:51:40 +0000
Date: Sat, 8 Feb 2025 07:51:38 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, hyeonggon.yoo@sk.com, ying.huang@linux.alibaba.com,
	honggyu.kim@sk.com, akpm@linux-foundation.org, rafael@kernel.org,
	lenb@kernel.org, gregkh@linuxfoundation.org, rakie.kim@sk.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Message-ID: <Z6b--rdWJD3UQDI-@localhost.localdomain>
References: <20250207201335.2105488-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207201335.2105488-1-joshua.hahnjy@gmail.com>
X-Rspamd-Queue-Id: 5AC8C2115F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 07, 2025 at 12:13:35PM -0800, Joshua Hahn wrote:
> On machines with multiple memory nodes, interleaving page allocations
> across nodes allows for better utilization of each node's bandwidth.
> Previous work by Gregory Price [1] introduced weighted interleave, which
> allowed for pages to be allocated across nodes according to user-set ratios.   
> 
> Ideally, these weights should be proportional to their bandwidth, so
> that under bandwidth pressure, each node uses its maximal efficient
> bandwidth and prevents latency from increasing exponentially.
> 
> At the same time, we want these weights to be as small as possible.
> Having ratios that involve large co-prime numbers like 7639:1345:7 leads
> to awkward and inefficient allocations, since the node with weight 7
> will remain mostly unused (and despite being proportional to bandwidth,
> will not aid in relieving the bandwidth pressure in the other two nodes).
> 
> This patch introduces an auto-configuration mode for the interleave
> weights that aims to balance the two goals of setting node weights to be
> proportional to their bandwidths and keeping the weight values low.
> In order to perform the weight re-scaling, we use an internal
> "weightiness" value (fixed to 32) that defines interleave aggression.
> 
> In this auto configuration mode, node weights are dynamically updated
> every time there is a hotplug event that introduces new bandwidth.
> 
> Users can also enter manual mode by writing "N" or "0" to the new "auto"
> sysfs interface. When a user enters manual mode, the system stops
> dynamically updating any of the node weights, even during hotplug events
> that can shift the optimal weight distribution. The system also enters
> manual mode any time a user sets a node's weight directly by using the
> nodeN interface introduced in [1]. On the other hand, auto mode is
> only entered by explicitly writing "Y" or "1" to the auto interface.
> 
> There is one functional change that this patch makes to the existing
> weighted_interleave ABI: previously, writing 0 directly to a nodeN
> interface was said to reset the weight to the system default. Before
> this patch, the default for all weights were 1, which meant that writing
> 0 and 1 were functionally equivalent.
> 
> This patch introduces "real" defaults, but moves away from letting users
> use 0 as a "set to default" interface. Rather, users who want to use
> system defaults should use auto mode. This patch seems to be the
> appropriate place to make this change, since we would like to remove
> this usage before users begin to rely on the feature in userspace.
> Moreover, users will not be losing any functionality; they can still
> write 1 into a node if they want a weight of 1. Thus, we deprecate the
> "write zero to reset" feature in favor of returning an error, the same
> way we would return an error when the user writes any other invalid
> weight to the interface.
> 
> [1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Co-developed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---

Hi Joshua

> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ea653fa3433..16e7a5a8ebe7 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -7,6 +7,7 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/memory.h>
> +#include <linux/mempolicy.h>
>  #include <linux/vmstat.h>
>  #include <linux/notifier.h>
>  #include <linux/node.h>
> @@ -214,6 +215,12 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  			break;
>  		}
>  	}
> +
> +	/* When setting CPU access coordinates, update mempolicy */
> +	if (access == ACCESS_COORDINATE_CPU) {
> +		if (mempolicy_set_node_perf(nid, coord))
> +			pr_info("failed to set node%d mempolicy attrs\n", nid);

Not a big deal but I think you want to make that consistent with the error
pr_info? that is: "failed to set mempolicy attrs for node %d".

Also, I guess we cannot reach here with a memoryless node, right?

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 04f35659717a..51edd3663667 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -109,6 +109,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/printk.h>
>  #include <linux/swapops.h>
> +#include <linux/gcd.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
> @@ -138,16 +139,18 @@ static struct mempolicy default_policy = {
>  
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>  
> +static uint64_t *node_bw_table;
> +
>  /*
> - * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
> - * system-default value should be used. A NULL iw_table also denotes that
> - * system-default values should be used. Until the system-default table
> - * is implemented, the system-default is always 1.
> - *
> + * iw_table is the interleave weight table.
> + * If bandwidth data is available and the user is in auto mode, the table
> + * is populated with default values in [1,255].
>   * iw_table is RCU protected
>   */
>  static u8 __rcu *iw_table;
>  static DEFINE_MUTEX(iw_table_lock);
> +static const int weightiness = 32;

You explain why you chose this value in the changelog, but I would either
drop a comment, probably in reduce_interleave_weights() elaborating a
little bit, otherwise someone who stumbles upon that when reading that
code will have to go through the changelog.


-- 
Oscar Salvador
SUSE Labs

