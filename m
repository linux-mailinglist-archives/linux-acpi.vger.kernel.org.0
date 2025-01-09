Return-Path: <linux-acpi+bounces-10490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC4A07E96
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 18:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA991167A71
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9975418A6A1;
	Thu,  9 Jan 2025 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9KeIQJS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD616FF4E;
	Thu,  9 Jan 2025 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443106; cv=none; b=LR+PNBLgzxI42gwJXmT854aWE6yicaSgaI24osVmfZ11SILm9FgtteBmjIKTsmtfwbF1ow5+nmO0LyQOWAPUk4goa+u/Csk+INBIpALtZ6BZZr9xu0BnI4XskdRrtkiWPvb2Q1aUfQSad/aujwPDxLpv0LCX+A0L1COzxEpG7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443106; c=relaxed/simple;
	bh=t5xZbPrwc+38ynVesi5T4jmflaqrCcd/wTI0JLX8jQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VK+NTg/42nq/WN2xegIIptR48obZy4h9UEeZFRqVNoPgoVRJKXvV0sBVT02u1Sm7zqfsWh73D+xN+oc4cGduSg8mhZ6xAK7LOG1wA6dhTGQAH6LEGjJeeW+ek4jXmSgtnwtmqczHcq69YI75b+xrfR/CYexh/q4uaKFcMDborsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9KeIQJS; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so1686463276.1;
        Thu, 09 Jan 2025 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736443104; x=1737047904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUGgop6jtE3EgW6/6rlTjHVm8v6s3KcgoYismoC8low=;
        b=N9KeIQJSpDcGDYdjAbUbcljIjlDn0dmWPy5Qbik1rPGBmr2JFfFLyIyYRo1dO2UhtP
         O0iDY2vDTj+v2aUBy89zblpE1QaVim5XnJ5jDGiL8u/OfWTFF6hUHbEazhZUKv18FR4C
         Utg1TtiewNBkZRTVXeApIYO5+zvFTnRu0Qfnl7EmBNy6oy8H8orf2m42K0er4v3nT0Cs
         U4/rHtCWx8aUFplp2FixC58NWKIqlUtBX42gsO2Agb2hFhmgD8dwbC2ec+gCaMm7IhoT
         DOhAQW5Bvfry923QdBqL2t5xVD/frk3+s1RlQ6fzS7s7Fsxi6WSGtALphg5NjQWrGMl1
         b8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736443104; x=1737047904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUGgop6jtE3EgW6/6rlTjHVm8v6s3KcgoYismoC8low=;
        b=dRCACRN/VA+tVKJVdWYQ6S+pt828xK3rDJvj2FyoP1u/QiUn8C4y+b3Z3TpPpcsw0W
         UroJc0qD9OGQZ1j0Ln+yrx+PP6Ep+L6hKKy4rXZ9cdFWX1anZORxjSxrp9w7SNU9BMPx
         ud2yM01Z/ey1Zhh8NOwy2cSPBU8cC7xNL0LKpsUAvTBWNdxDfJ74UhCYa8/pIFbeSV6e
         BzN4lbvfx8WW1xJ+E5d6ZK7H9eZvRtoCp1UD/YdtXtEB9qLzxBqo6bHZ0TaTL7OiLVBQ
         7r3PSwQ0Gh6JomJO8ajONKA3HL8TxN3Q1tXz/xhOum4F7eKzEQbqP0aCu0rnlOxfHrNd
         PJkA==
X-Forwarded-Encrypted: i=1; AJvYcCWggnkFZoHtdZrApr3WZ7j1j/S39C3FXr39URIg+x+EWoBSRirpHJDCRnV4jnS6SOUqnlPDhUrVLjCT4SHF@vger.kernel.org, AJvYcCXLBrsn627nPesOsd5Bt/E5TFyxtHHh6ZZop6QHVeFrMd/EPTXaaW2hflCOSic1Rz/A2/IjEVfjvERN@vger.kernel.org
X-Gm-Message-State: AOJu0YygZ4S3FszIZNTEDQx3F4i2mTplq4NOjTow1SaHkZeKi1wqHxWs
	ktePI+0neWlE97vlTl7c1AAcunwOavYoqtf+Ds9YOxvygXhZ6wXC
X-Gm-Gg: ASbGncsi/V8RxCKVgYCSxwhQR0dOuh2MZK20zB/W8SxlrS53pVfJaVkYFxfIocNWEo7
	GrJuNtAtRMgSjH44v/pBc8iL4OCuMUyv6DMvMwhj13+s0u5HUHBNcmsbAXJpr18nB3oWpTNOJqb
	PVEzPToFKmh/gfk9o1Jy/wYukOGrMf8RSsBOy7E/Qtdn1K0Gdku2HbpmV3+j6WsKXyzBXFFW1/K
	8B5vgIWwdL3h+u3791tN8C3ty6Xh1vkvl20xCy/3t6VPlAJ1xLSDlJv
X-Google-Smtp-Source: AGHT+IELsYcB6T/ck4lH4klPT6vDU6KCIg9dPGWh9gmz8YJ7e4Z+gj6z3yGKPXuQMSRsPUErAOo4TA==
X-Received: by 2002:a05:6902:108d:b0:e4b:6ef6:e7ba with SMTP id 3f1490d57ef6-e54ee2055ddmr6122667276.33.1736443103774;
        Thu, 09 Jan 2025 09:18:23 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e55a597b658sm10842276.30.2025.01.09.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:18:23 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Gregory Price <gourry@gourry.net>
Cc: Hyeonggon Yoo <hyeonggon.yoo@sk.com>,
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
Date: Thu,  9 Jan 2025 09:18:18 -0800
Message-ID: <20250109171821.3203865-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <Z3_xpKZ7YtVvCSG4@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 9 Jan 2025 10:56:20 -0500 Gregory Price <gourry@gourry.net> wrote:

> On Wed, Jan 08, 2025 at 10:19:19AM +0900, Hyeonggon Yoo wrote:
> > Hi, hope you all had a nice year-end holiday :)
> > 
> ... snip ...
> > Please let me know if there's any point we discussed that I am missing.
> > 
> > Additionally I would like to mention that within an internal discussion
> > my colleague Honggyu suggested introducing 'mode' parameter which can be
> > either 'manual' or 'auto' instead of 'use_defaults' to be provide more
> > intuitive interface.
> > 
> > With Honggyu's suggestion and the points we've discussed,
> > I think the interface could be:
> > 
> > # At booting, the mode is 'auto' where the kernel can automatically
> > # update any weights.
> > 
> > mode             auto         # User hasn't specified any weight yet.
> > effective        [2, 1, -, -] # Using system defaults for node 0-1,
> >                               # and node 2-3 not populated yet.
> > 
> > # When a new NUMA node is added (e.g. via hotplug) in the 'auto' mode,
> > # all weights are re-calculated based on ACPI HMAT table, including the
> > # weight of the new node.
> > 
> > mode             auto         # User hasn't specified weights yet.
> > effective        [2, 1, 1, -] # Using system defaults for node 0-2,
> >                               # and node 3 not populated yet.
> > 
> > # When user set at least one weight value, change the mode to 'manual'
> > # where the kernel does not update any weights automatically without
> > # user's consent.
> > 
> > mode             manual       # User changed the weight of node 0 to 4,
> >                               # changing the mode to manual config mode.
> > effective        [4, 1, 1, -]
> > 
> > 
> > # When a new NUMA node is added (e.g. via hotplug) in the manual mode,
> > # the new node's weight is zero because it's in manual mode and user
> > # did not specify the weight for the new node yet.
> > 
> > mode             manual
> > effective        [4, 1, 1, 0]
> > 
> 
> 0's cannot show up in the effective list - the allocators can never
> percieve a 0 as there are (race) conditions where that may cause a div0.
> 
> The actual content of the list may be 0, but the allocator will see '1'.
> 
> IIRC this was due to lock/sleep limitations in the allocator paths and
> accessing this RCU protected memory. If someone wants to take another
> look at the allocator paths and characterize the risk more explicitly,
> this would be helpful.

Hi Gregory and Hyeonggon,

Based on a quick look, I see that there can be a problematic scenario
in alloc_pages_bulk_array_weighted_interleave where we sum up all
the weights from iw_table and divide by this sum. This _can_ be problematic
for two reasons, one of them being the div0 mentioned.

Currently, you can access the weights in one of two ways:
The first way is to call get_il_weight, which will retrieve a specified
node's weight under an rcu read lock. Within this function, it first
checks if the value at iw_table[nid] is 0, and if it is, returns 1.
Although this prevents a div0 scenario by ensuring that all weights are
nonzero, there is a coherency problem, since each instance of get_il_weight
creates a new rcu read lock. Therefore, retrieving node weights within a
loop creates a race condition in which the state of iw_table may change
in between iterations of the loop.

The second way is to directly dereference iw_table under a rcu lock,
copy its contents locally, then free the lock. This is how
alloc_pages_bulk_array_weighted_interleave currently calculates the sum.
The problem here is that even though we solve the coherency issue, there
is no check to ensure that this sum is zero. Thus, while having an array of
weights [0,0,0,0] gets translated into [1,1,1,1] when inspecting each
node individually using get_il_weight, it is still stored internally as 0
and can lead to a div0 here.

There are a few workarounds:
- Check that weight_total != 0 before performing the division.
- During the weight sum iteration, add by weights[node] ? weights[node] : 1
  like it is calculated within get_il_weight
- Prevent users from ever storing 0 into a node.

Of course, we can implement all three of these changes to make sure that
there are no unforunate div0s. However, there are realistic scenarios
where we may want the node to actually have a weight of 0, so perhaps
it makes sense to just do the first to checks. I can write up a quick
patch to perform these checks, if it looks good to everyone.

Please let me know if I missed anything as well.

Hope you all have a great day!
Joshua

