Return-Path: <linux-acpi+bounces-13838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E647ABF646
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 15:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF3166904
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D1526C3BE;
	Wed, 21 May 2025 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feXNF1/T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M084V+jA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feXNF1/T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M084V+jA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A2238C3A
	for <linux-acpi@vger.kernel.org>; Wed, 21 May 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834707; cv=none; b=HWx+NjoRYauPTwidq2iy+lWnl2atM3wX7iQBI5gZ1k9UJOgOjL9+ADaZe2yV4yNRjE2dKeqVBLFnTBLuLLD5DkqGnwJGQRnlD0l43cOsKXabkDW4yg7bjAJ4ouQp2HIWko1yfK+iRtRW4pJ6+DpDB6o4+lHSBaT0MnytvH3sUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834707; c=relaxed/simple;
	bh=Gfz45NQ5VPSCUu47fmwJT5RTDENMs4pScjEvknNGDes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pprU57m+LMgrgf0gfNmrGFxFAHkG01VuxqoFAFvRRZk3qiRo9cUu22AwSLUNj165Iy3WwUgjNmGC1GZgpLgGVyYAxz5jcI9aFrCTkMIqqt9arBp1c/ZJLKLzlRqUxRApjdmitf2KHEKBLBS3keSBbIxLieKZ/SeiLd+Yo/dg8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=feXNF1/T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M084V+jA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=feXNF1/T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M084V+jA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27AE41F8AE;
	Wed, 21 May 2025 13:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747834704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dhfg3H/kMqcAQUy5NiNon0brigmHV98r+/CIaPhl+U=;
	b=feXNF1/TetZfXPNofNc8bq4KpoSdU0iW6BUKlAMUvZ4kcg5RAJkxVYBEtNIQx061FHlDBP
	lVxNH+kgk9B10cWODA18n8D0ZHZCrl5tXy30YRzJKyg8HLN6X3FJI7ja9EC7NRkeNsosLe
	dJIpa8guhtSPTgLrogKS9qHYN5rvIaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747834704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dhfg3H/kMqcAQUy5NiNon0brigmHV98r+/CIaPhl+U=;
	b=M084V+jAm0VBZfhv64XyxAANc4FtfGQxsMZUpKI10JOKzUxLryKEEZKuXrqVfQyH4ya8sd
	2XrgJsMeD+CzZFAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="feXNF1/T";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=M084V+jA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747834704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dhfg3H/kMqcAQUy5NiNon0brigmHV98r+/CIaPhl+U=;
	b=feXNF1/TetZfXPNofNc8bq4KpoSdU0iW6BUKlAMUvZ4kcg5RAJkxVYBEtNIQx061FHlDBP
	lVxNH+kgk9B10cWODA18n8D0ZHZCrl5tXy30YRzJKyg8HLN6X3FJI7ja9EC7NRkeNsosLe
	dJIpa8guhtSPTgLrogKS9qHYN5rvIaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747834704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dhfg3H/kMqcAQUy5NiNon0brigmHV98r+/CIaPhl+U=;
	b=M084V+jAm0VBZfhv64XyxAANc4FtfGQxsMZUpKI10JOKzUxLryKEEZKuXrqVfQyH4ya8sd
	2XrgJsMeD+CzZFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D260713888;
	Wed, 21 May 2025 13:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vZxXMk/XLWiGBwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 21 May 2025 13:38:23 +0000
Date: Wed, 21 May 2025 15:38:22 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, akpm@linux-foundation.org, harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com, honggyu.kim@sk.com,
	yunjeong.mun@sk.com, gregkh@linuxfoundation.org, rakie.kim@sk.com,
	rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v9] mm/mempolicy: Weighted Interleave Auto-tuning
Message-ID: <aC3XTsCknvx2z-u_@localhost.localdomain>
References: <20250520141236.2987309-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520141236.2987309-1-joshua.hahnjy@gmail.com>
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 27AE41F8AE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,gourry.net:email,alibaba.com:email,sk.com:email]

On Tue, May 20, 2025 at 07:12:35AM -0700, Joshua Hahn wrote:
> On machines with multiple memory nodes, interleaving page allocations
> across nodes allows for better utilization of each node's bandwidth.
> Previous work by Gregory Price [1] introduced weighted interleave, which
> allowed for pages to be allocated across nodes according to user-set ratios.
> 
> Ideally, these weights should be proportional to their bandwidth, so
> that under bandwidth pressure, each node uses its maximal efficient
> bandwidth and prevents latency from increasing exponentially.
> 
> Previously, weighted interleave's default weights were just 1s -- which
> would be equivalent to the (unweighted) interleave mempolicy, which goes
> through the nodes in a round-robin fashion, ignoring bandwidth information.
> 
> This patch has two main goals:
> First, it makes weighted interleave easier to use for users who wish to
> relieve bandwidth pressure when using nodes with varying bandwidth (CXL).
> By providing a set of "real" default weights that just work out of the
> box, users who might not have the capability (or wish to) perform
> experimentation to find the most optimal weights for their system can
> still take advantage of bandwidth-informed weighted interleave.
> 
> Second, it allows for weighted interleave to dynamically adjust to
> hotplugged memory with new bandwidth information. Instead of manually
> updating node weights every time new bandwidth information is reported
> or taken off, weighted interleave adjusts and provides a new set of
> default weights for weighted interleave to use when there is a change
> in bandwidth information.
> 
> To meet these goals, this patch introduces an auto-configuration mode
> for the interleave weights that provides a reasonable set of default
> weights, calculated using bandwidth data reported by the system. In auto
> mode, weights are dynamically adjusted based on whatever the current
> bandwidth information reports (and responds to hotplug events).
> 
> This patch still supports users manually writing weights into the nodeN
> sysfs interface by entering into manual mode. When a user enters manual
> mode, the system stops dynamically updating any of the node weights,
> even during hotplug events that shift the optimal weight distribution.
> 
> A new sysfs interface "auto" is introduced, which allows users to switch
> between the auto (writing 1 or Y) and manual (writing 0 or N) modes. The
> system also automatically enters manual mode when a nodeN interface is
> manually written to.
> 
> There is one functional change that this patch makes to the existing
> weighted_interleave ABI: previously, writing 0 directly to a nodeN
> interface was said to reset the weight to the system default. Before
> this patch, the default for all weights were 1, which meant that writing
> 0 and 1 were functionally equivalent. With this patch, writing 0 is invalid.
> 
> [1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
> 
> Suggested-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Tested-by: Honggyu Kim <honggyu.kim@sk.com>
> Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> Co-developed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Acked-by: Oscar Salvador <osalvador@suse.de>



-- 
Oscar Salvador
SUSE Labs

