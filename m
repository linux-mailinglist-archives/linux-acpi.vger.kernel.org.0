Return-Path: <linux-acpi+bounces-10433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ADCA062C2
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 17:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8741887B86
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B71FF7AA;
	Wed,  8 Jan 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9F7i9bX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DB17E900;
	Wed,  8 Jan 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355514; cv=none; b=utk0ZaJGpUjslH7u+A4G/DqDKaSMNRlQjRqRWxh+4lpYzKI0uwiX1MkAp5l9KGyeV6YhPy4F8ZZ+b6B6wp6kSHxkpWwQ13r2ku7skua1UpMPeg2sn+kviBMo3MM+eVXoGLoCTBaqWbzwPZn7tcNTLp5O9Fw398j+fcE+tM+b6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355514; c=relaxed/simple;
	bh=Hzi000gRnS31DZGbZ5wri8123xkYgOidtULgAX4J2uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpQdhk4CrjnPnzwJRuzP9C5kMmNHWdI3S7wByVuvTJYp6jtRREKLdu7nsBmn/8GoELarn6GmKh5b16X1EJYq+58ig4k6AWmTLIwlmcAFIzBFv+7sC0kJ9nTd9ipHwMlmQyAdDhwUaiRAEYI/4Kv09O32GoSo2Otmk7havSgwcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9F7i9bX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21649a7bcdcso245644265ad.1;
        Wed, 08 Jan 2025 08:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736355512; x=1736960312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te0tqfmNg1Pxd++YCQH+vCI4MIXZva+uen0jwvleMzg=;
        b=R9F7i9bXLapU9mAPehiAFio/EM8SYbPqWZjZbq3eMZaLR9mV18ieEKz0JZ5RrBGVi2
         QjlNewsAspCwO3llNybi/gHhUrKpmIopNwYHCvtekGj12SYVzTvI7uEwzR6qIAGtIGGN
         bEwqPaXFIDwF/FAhwthEzkL3LA0J1MduQMmbrF5bQl90NyioXBCbvOJd9az1TMo1gQVX
         k1TaA/ZfpTl4tWsQxHYedg2fhnvZ191MUbt7oefbYiry9+/13FU0NukqOXIYgsMnNA6h
         EKTUu86Ljq+nZSixhjCS3ZhAPvs25GjHD1+G2t3N8RczMeCxLPdqSO7r2eNNRGOZ75a4
         tgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355512; x=1736960312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te0tqfmNg1Pxd++YCQH+vCI4MIXZva+uen0jwvleMzg=;
        b=Dqr4Co/GV5omlxc8DVQU7s765POH5i/wNd2JCBit1orY7ovWvI/Fltz4l7Mi+gn+bt
         PlXavh3AMZHXqv3iqgtdhxfERHAEIFgmJGe6TDPsnTt9CDr2WXuD3n85PQ2iHZv+joV3
         mNsrqCo3F+7IVKsK6qGd2adWT8h6u+lrSrq6EhSdNmuEES5DwWS18EcwRqEXq26SsCfe
         n3r0afgA/O6RJPoSTlRHLQJdF+aL3Nw8wsQfo8l/AeOH/GhOTOFNy2VS1UpUYh3W61Dx
         YBvTMSnZdE6M+BKbdqmz4glE0MyIVRw38GU4cQ345v/vnL67cN1TusDU9Z2yhl+86qFk
         PA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDiPn03Mwv8El3qz7LUUYdVsRqnI77fTbB3792sYAfIDu86bhM2imFoIioVpIsH8bLYTZ/3uph2rnyHCxi@vger.kernel.org, AJvYcCXUBX+S793k0jzAGU/R3++uxawDFP3LZmYfh9ObgWTt86dP2v5j5GjGLRUx6/spNe/5S6VbMCCpBBKE@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTpZHTKzUM1uCjCFZWL0TyRPa1MusUBVqT2PM+mf9mtu8zVKA
	ER/FsWTOg+e0FHE/A+65ULwgFPf9bc2orhSiQ8GMJnAJz0aJvZ7TlyxQmpob
X-Gm-Gg: ASbGncttgKfQ3M7/2XDbgVd2WPBorTY9O7W9+fNq8Wu5Thu5nMxxaHvRe6BMHJtWdcZ
	mI8CVid3MvSibvqrzLtIcx/k1oe2tpkw1Zoq5EoHXCTGf/wdNZr2Cy1Owvhz4gG5oR6siOuYWFy
	0VfHxfieA8HoB+rL16yhlP3xWDTYgztevQvAZbtCSym5J+i2/RpPqW+qwWloFJ1Ljljf8T47DDB
	T+gVLmK92dj7ol9hg5/1UIqSGsdkk88wT1GiWy2N2ixA8YjvcrK+87S6CKYte/k3FWgS2lq0/ji
	vNCN2fjJ
X-Google-Smtp-Source: AGHT+IGGdhNceu6iBGn/AzWihd4IO9LBhEVsyvoRvfFe45JrrXRM3/9+6nFk90LtKUgqkDWB3dt0aw==
X-Received: by 2002:a05:6a00:9a7:b0:725:ebab:bb2e with SMTP id d2e1a72fcca58-72d21f64e2amr4470027b3a.11.1736355512456;
        Wed, 08 Jan 2025 08:58:32 -0800 (PST)
Received: from joshuahahn-mbp.thefacebook.com ([2620:10d:c091:500::7:bdef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad815835sm36776186b3a.27.2025.01.08.08.58.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jan 2025 08:58:31 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
X-Google-Original-From: Joshua Hahn <joshuahahn@meta.com>
To: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
Cc: Joshua Hahn <joshuahahn@meta.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	kernel_team@skhynix.com,
	42.hyeyoo@gmail.com,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?UTF-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKSBTeXN0ZW0gU1c=?= <honggyu.kim@sk.com>,
	=?UTF-8?B?6rmA65296riwKEtJTSBSQUtJRSkgU3lzdGVtIFNX?= <rakie.kim@sk.com>,
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
Date: Wed,  8 Jan 2025 11:56:32 -0500
Message-Id: <20250108165632.76746-1-joshuahahn@meta.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <769f98b3-f5e5-448c-966e-4dd5468e5041@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 8 Jan 2025 10:19:19 +0900 Hyeonggon Yoo <hyeonggon.yoo@sk.com> wrote: 
> 
> On 2024-12-30 3:48 AM, Huang, Ying wrote:
> > Gregory Price <gourry@gourry.net> writes:
> > 
> >> On Fri, Dec 27, 2024 at 09:59:30AM +0800, Huang, Ying wrote:
> >>> Gregory Price <gourry@gourry.net> writes:
> >>>> This still allows 0 to be a manual "reset specific node to default"
> >>>> mechanism for a specific node, and gives us a clean override.
> >>>
> >>> The difficulty is that users don't know the default value when they
> >>> reset a node's weight.  We don't have an interface to show them.  So, I
> >>> suggest to disable the functionality: "reset specific node to default".
> >>> They can still use "echo 1 > use_defaults" to reset all nodes to
> >>> default.
> >>>
> >>
> >> Good point, and agree.  So lets just ditch 0.  Since that "feature"
> >> wasn't even functional in the current code (it just reset it to 1 at
> >> this point), it's probably safe to just ditch it.  Worst case scenario
> >> if someone takes issues, we can just have it revert the weight to 1.
> > 
> > Before implementing the new version, it's better to summarize the user
> > space interface design first.  So, we can check whether we have some
> > flaws.
> 
> Hi, hope you all had a nice year-end holiday :)

Hi Hyeonggon, thank you for the review! I hope you have had a great
start to 2025 as well : -)

> Let me summarize the points we've discussed:
> 
> - A new knob 'weightiness' is unnecessary until it's proven useful.
>    Just using an internal default weightiness value will be enough.

Yup, and as Gregory mentioned, we're pretty confident that 32 gives
a good balance of reduction aggression & error minimization.

> - It will be counter-intuitive to update the value previously set by
>    user, even if the value will no longer be valid (e.g. due to CXL
>    memory hot-plug). User should update the weights accordingly in that
>    case, instead of the kernel updating automatically overwriting them.

Agreed. I think we should lean on the side of keeping user-set values
at the highest priority, and avoid overwriting them.

> - Ditch the way of using 0 as 'system default' value because the user
>    won't know what will be the default when setting it anyway. 0 value
>    now means the kernel won't weight-interleave the node.

Yes, and I think this is going to be important to convey to users,
especially since the current expected behavior is that hotplugged nodes
are expected to automatically be included in interleaving.

> - Setting a node weight to default value (e.g. via the previous
>    semantic of '0') could be problematic because it's not atomic -
>    the system may be updating default values while the user's
>    trying to set a node weight to default value.
> 
>    To deal with that, Huang suggested 'use_defaults' to atomically update
>    all the weights to system default.

One concern that I have here is that even for the use_defaults interface,
the users don't know what the system default values are. From the user
perspective, when they make the judgement between using user values and
system defaults, one side of the choice is always going to be opaque,
as long as we only have a "one-layer" interface.

With that said, I think that in this new design where the choice is
either to only use system defaults vs. manually set everything, I think
the problem is much smaller, since there is no hybrid of using both.

I think this will bucket users into two categories: those who expect
weighted interleave to work out of the box with no configurations, and
those who will want to manually tune node weights. I think this is a
reasonable categorization, especially given Huang's earlier comment
on how "setting one node means the user thinks all other node weights
are reasonable". As long as we support these two user types, I think
we will cover most use cases.

Like mentioned previously by others, I think we don't have to support use
cases where some nodes are fixed to user values and others are fixed to
defaults, until an explicit use case comes up.

> Please let me know if there's any point we discussed that I am missing.
> 
> Additionally I would like to mention that within an internal discussion
> my colleague Honggyu suggested introducing 'mode' parameter which can be
> either 'manual' or 'auto' instead of 'use_defaults' to be provide more
> intuitive interface.
> 
> With Honggyu's suggestion and the points we've discussed,
> I think the interface could be:
> 
> # At booting, the mode is 'auto' where the kernel can automatically
> # update any weights.
> 
> mode             auto         # User hasn't specified any weight yet.
> effective        [2, 1, -, -] # Using system defaults for node 0-1,
>                                # and node 2-3 not populated yet.
> 
> # When a new NUMA node is added (e.g. via hotplug) in the 'auto' mode,
> # all weights are re-calculated based on ACPI HMAT table, including the
> # weight of the new node.
> 
> mode             auto         # User hasn't specified weights yet.
> effective        [2, 1, 1, -] # Using system defaults for node 0-2,
>                                # and node 3 not populated yet.
> 
> # When user set at least one weight value, change the mode to 'manual'
> # where the kernel does not update any weights automatically without
> # user's consent.
> 
> mode             manual       # User changed the weight of node 0 to 4,
>                                # changing the mode to manual config mode.
> effective        [4, 1, 1, -]
> 
> 
> # When a new NUMA node is added (e.g. via hotplug) in the manual mode,
> # the new node's weight is zero because it's in manual mode and user
> # did not specify the weight for the new node yet.
> 
> mode             manual
> effective        [4, 1, 1, 0]
> 
> # When user changes the mode to 'auto', all weights are changed to
> # system defaults based on the ACPI HMAT table.
> 
> mode             auto
> effective        [2, 1, 1, 1]  # system defaults
> 
> In the example I did not distinguish 'default weights' and 'user
> weights' because it's not important where the weight values came from --
> but it's important to know 1) what's the effective weights now and 2) if
> the kernel can update them.
> 
> Any thoughts?

Please let me know if I am missing anything, but the way I understand the
"mode" interface, it follows the blanket use_defaults-like semantics of
auto / manual, but uses the one-layer interface like the v2 of this patch.

Personally, I think this makes a lot of sesne. I have a few thoughts:

First, it seems like re-weighting is something that only happens when
mode == auto. I think this makes sense, since the point of re-weighting
is to reduce ugly bandwidth values into interleave weight values. However,
I want to gather some thoughts on whether there are any scenarios that I am
missing, for when a user would want to be in manual mode but also trigger
a re-weighting.

One lingering thought I have is what happens when a hotplug event happens
in manual mode. The way I see it, there are 3 options on what to set the
value as:
- 0, since the user is in manual mode and has not set any value.
- 1, since we still want the node to be in use, even though the user has
  not explicitly stated that they want it to be in use. 1 as a default
  value makes sense, since it is the minimum weight a node can have,
  and can only help by relieving bandwidth pressure from the other nodes.
- A value >= 1, determined by what the default value should have been
  based on the bandwidths of the other nodes.

I am personally leaning towards the second option (1), but I also want to
hear everyone's thoughts on what makes the most sense.
 
> ---
> Best,
> Hyeonggon

Happy 2025 everyone! Thank you for all of your continued interest
and feedback on this patch. I am confident that we will come up with
a solution that makes sense for everyone, thanks to your time & efforts.

Have a great day!
Joshua

