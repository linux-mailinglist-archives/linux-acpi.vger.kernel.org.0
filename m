Return-Path: <linux-acpi+bounces-10492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4DCA08076
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 20:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801FD7A138D
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473B1ACEC6;
	Thu,  9 Jan 2025 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOiX6SRM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B118A93C;
	Thu,  9 Jan 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449870; cv=none; b=PvMJbkCJBMXcrpYv/JFk3YjrhC3r6wegun/ZWy5I5WYYNYObol9hRB99obSN5LGh02IKfYqYEO5JuAfguonLSDV53onkLDFT/SyWOb/TEf4ag4ZjRqmlzq9Rd+XkY3MeK5Z0nkw1CIPdJiFVLkHq9aRbmYAhE3/TYtSUktHVWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449870; c=relaxed/simple;
	bh=gl4FyVRDW48yi/tuLjmHbJPQFls6kOVNyirRB+cVdbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qg17QeyDXxXW5qfDgdrSqRDVkezuc0Jt3DQHMPKKeQXhU8yMQibcAAOW9en0qwAXI6pi8uraM71FwlhXxGO0LiXyCD854SKNBVydK3fX6kOdNg9ycNeYyJzaIp0Q6f2W0gLpEiHjUThV/b9QyoHNqProvErzQceqq5k/6PbcRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOiX6SRM; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e398484b60bso1931139276.1;
        Thu, 09 Jan 2025 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736449867; x=1737054667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBTrbYpmfem2EyOa0J8S2yQxi7tWCdipbLey68Ww0NA=;
        b=FOiX6SRMdMR0PLK1OGmtrfFqHkOmAfVEJFD+BzIj2xjeXY7CQW71GYHCvBa0xlzU8Y
         dkAkwoVgYUWJAlAcIbVkPxj8MtZoZJMpZJujMMoOTlW0AvnUPwIKwzCtKC/co5A74Ngm
         yZDszIIkMCFFPJyqvlSEXI3hCx9x+Y/MJkS12mVAuopPnLrdNj2t4M4QiWMRLEKyqdqp
         rHI+WF0kSsGo5VqB6Iqasf68z2UnNNAY0jdl6kbgqRxYJh5kUzc7/Nynj0dS6lqIPlzQ
         ENQDEap7dB245mOGqzHAI7SKzrO/SEfWRISZb+mg5Xx/J4x4AJm9pOhnJtPmX90BKzIv
         IsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736449867; x=1737054667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBTrbYpmfem2EyOa0J8S2yQxi7tWCdipbLey68Ww0NA=;
        b=Cewi9lx6imDgV0jh66ShEesTBSRPgWrILvSlpYVmRxYKpdGrHRW0zm+lKFnV8TH5dY
         NGJaDn/ewdCVt8GBPgrJ9ogoSHj2rwB0K65L2eJfhukyMdKuF2U6erJnawTG+lRydfJ9
         WMWEp1pcF1MnhygvbuOhQKoL6U6KEtSluOJDFVuKzYdObuoMZ0DLsiqiGPwn/Cw8jlzQ
         46nskOyG3kLuu7iKehbQnrRlS1PUMnYP5Rb/Qa2oFAsF1N0C/W1X+vRZKEK6PA2wxikJ
         atYMbR59wHENDI5BvcdEcivSJ4q7T87jCz/5jcV7TGZe9J1y/HX+ToJatlKiOeOo/eqM
         AyDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+enJnE/BhhpUGzUaysGXdpltRIgtU4Q/zsqCt1H79zJnrObV0SnsfXhOCSZoLgQBuETbsPJDbkog1@vger.kernel.org, AJvYcCW8OwiojuPKIqT+rBpQiDGShoG1/NTb9Pv0SkGzDMTobFrP/yrwW4xJ4k4eViSb1ZsgtPbiRxbeFGRHEhEY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tux5cjUMxz3iCHbZq9mSRGfFF8PQZGyMR0+w7X4c7jKKtuIa
	TvJFchtCTodSFt7ex9BdCiqLjBouISvUgUn810AR7dvMddByCSz5
X-Gm-Gg: ASbGncu2Yz2ubja33enurTos2zBIa/clhqoKcxulTn3VY/NYyGeWgJgQ1r1AxI/1KdD
	5BQ/FTKigBWb7IpLavclINAN/5/ZOSwmcTpLeq7hSsArlxH/sGFBPmsljvJj9h1awMb4+bbUYNS
	wuZEaarJfoZmHrt4qT59NqxPHm24V7kob/At5M4/QagsdpdvJFapjtZoYXwMeAKwGRiKzg9iWne
	e/HCA1iXDgnZge7USfGuJM/Vxu9DXQdTfVJOSmTixL413GBHWO1HAc=
X-Google-Smtp-Source: AGHT+IGlMK+MnZJnvD8iPdz04O+PPRS8FHqS2mJSglSFK+0FQXFaGCYsiWwk+CCTrDKD3ANBmQTbOg==
X-Received: by 2002:a05:690c:f83:b0:6e3:fd6:6ccb with SMTP id 00721157ae682-6f53124d794mr68717987b3.13.1736449867423;
        Thu, 09 Jan 2025 11:11:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546dd7066sm3604577b3.93.2025.01.09.11.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 11:11:06 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Gregory Price <gourry@gourry.net>,
	Hyeonggon Yoo <hyeonggon.yoo@sk.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	kernel_team@skhynix.com,
	42.hyeyoo@gmail.com,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?utf-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKQ==?= System SW <honggyu.kim@sk.com>,
	=?utf-8?B?6rmA65296riwKEtJTSBSQUtJRSk=?= System SW <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave auto-tuning
Date: Thu,  9 Jan 2025 11:10:34 -0800
Message-ID: <20250109191102.3772288-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250109171821.3203865-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 9 Jan 2025 09:18:18 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Thu, 9 Jan 2025 10:56:20 -0500 Gregory Price <gourry@gourry.net> wrote:
> 
> > On Wed, Jan 08, 2025 at 10:19:19AM +0900, Hyeonggon Yoo wrote:
> > > Hi, hope you all had a nice year-end holiday :)
> > > 
> > ... snip ...
> > > Please let me know if there's any point we discussed that I am missing.
> > > 
> > > Additionally I would like to mention that within an internal discussion
> > > my colleague Honggyu suggested introducing 'mode' parameter which can be
> > > either 'manual' or 'auto' instead of 'use_defaults' to be provide more
> > > intuitive interface.
> > > 
> > > With Honggyu's suggestion and the points we've discussed,
> > > I think the interface could be:
> > > 
> > > # At booting, the mode is 'auto' where the kernel can automatically
> > > # update any weights.
> > > 
> > > mode             auto         # User hasn't specified any weight yet.
> > > effective        [2, 1, -, -] # Using system defaults for node 0-1,
> > >                               # and node 2-3 not populated yet.
> > > 
> > > # When a new NUMA node is added (e.g. via hotplug) in the 'auto' mode,
> > > # all weights are re-calculated based on ACPI HMAT table, including the
> > > # weight of the new node.
> > > 
> > > mode             auto         # User hasn't specified weights yet.
> > > effective        [2, 1, 1, -] # Using system defaults for node 0-2,
> > >                               # and node 3 not populated yet.
> > > 
> > > # When user set at least one weight value, change the mode to 'manual'
> > > # where the kernel does not update any weights automatically without
> > > # user's consent.
> > > 
> > > mode             manual       # User changed the weight of node 0 to 4,
> > >                               # changing the mode to manual config mode.
> > > effective        [4, 1, 1, -]
> > > 
> > > 
> > > # When a new NUMA node is added (e.g. via hotplug) in the manual mode,
> > > # the new node's weight is zero because it's in manual mode and user
> > > # did not specify the weight for the new node yet.
> > > 
> > > mode             manual
> > > effective        [4, 1, 1, 0]
> > > 
> > 
> > 0's cannot show up in the effective list - the allocators can never
> > percieve a 0 as there are (race) conditions where that may cause a div0.
> > 
> > The actual content of the list may be 0, but the allocator will see '1'.
> > 
> > IIRC this was due to lock/sleep limitations in the allocator paths and
> > accessing this RCU protected memory. If someone wants to take another
> > look at the allocator paths and characterize the risk more explicitly,
> > this would be helpful.
> 
> Hi Gregory and Hyeonggon,
> 
> Based on a quick look, I see that there can be a problematic scenario
> in alloc_pages_bulk_array_weighted_interleave where we sum up all
> the weights from iw_table and divide by this sum. This _can_ be problematic
> for two reasons, one of them being the div0 mentioned.
> 
> Currently, you can access the weights in one of two ways:
> The first way is to call get_il_weight, which will retrieve a specified
> node's weight under an rcu read lock. Within this function, it first
> checks if the value at iw_table[nid] is 0, and if it is, returns 1.
> Although this prevents a div0 scenario by ensuring that all weights are
> nonzero, there is a coherency problem, since each instance of get_il_weight
> creates a new rcu read lock. Therefore, retrieving node weights within a
> loop creates a race condition in which the state of iw_table may change
> in between iterations of the loop.
> 
> The second way is to directly dereference iw_table under a rcu lock,
> copy its contents locally, then free the lock. This is how
> alloc_pages_bulk_array_weighted_interleave currently calculates the sum.
> The problem here is that even though we solve the coherency issue, there
> is no check to ensure that this sum is zero. Thus, while having an array of
> weights [0,0,0,0] gets translated into [1,1,1,1] when inspecting each
> node individually using get_il_weight, it is still stored internally as 0
> and can lead to a div0 here.
> 
> There are a few workarounds:
> - Check that weight_total != 0 before performing the division.
> - During the weight sum iteration, add by weights[node] ? weights[node] : 1
>   like it is calculated within get_il_weight
> - Prevent users from ever storing 0 into a node.
> 
> Of course, we can implement all three of these changes to make sure that
> there are no unforunate div0s. However, there are realistic scenarios
> where we may want the node to actually have a weight of 0, so perhaps
> it makes sense to just do the first to checks. I can write up a quick
> patch to perform these checks, if it looks good to everyone.
> 
> Please let me know if I missed anything as well.

On second thought, the second bullet point doesn't make much sense, if
we expect nodes to have 0 as a valid value. Here is something that could
work for the first bullet point, though. I can send this as a separate
patch since this is not explicitly related to this thread.

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index cb355bdcdd12..afb0f2a7bd4f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2552,10 +2552,13 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
         * if (rounds > 0) and (delta == 0), resume_node will always be
         * the node following prev_node and its weight.
         */
-       rounds = rem_pages / weight_total;
-       delta = rem_pages % weight_total;
        resume_node = next_node_in(prev_node, nodes);
        resume_weight = weights[resume_node];
+       if (weight_total == 0)
+               goto out;
+
+       rounds = rem_pages / weight_total;
+       delta = rem_pages % weight_total;
        for (i = 0; i < nnodes; i++) {
                node = next_node_in(prev_node, nodes);
                weight = weights[node];
@@ -2582,6 +2585,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
                        break;
                prev_node = node;
        }
+
+out:
        me->il_prev = resume_node;
        me->il_weight = resume_weight;
        kfree(weights);

Of course, the only way this can happen is if a user purposefully
sets all of the node weights to 0, so I don't think this is something
that should ever happen naturally. Even with the new reduce_interleave_weights
function, it manually checks and makes sure that the lowest possible value
is 1.

Again, please let me know if I am missing anything!
Joshua

