Return-Path: <linux-acpi+bounces-11742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3878FA4CDBE
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 22:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55090172650
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E8722FDF3;
	Mon,  3 Mar 2025 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiKBgU4v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC71F0E49;
	Mon,  3 Mar 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039003; cv=none; b=POAlfk2fUQss/bp1sG9dwL0Xmr7nGt1wq/Fu4AibhGD3KW/JkFa58hzDeF1QKBGwNViNDYjTG5Dr8pYfDgPMeqlIZSNAPJxowkGxul/KphLL06oLPPBiuiKZtI2PVq122V5lv/kNkhDVPS/1uiyj/cMbeENFTubZ3Cjs4ZNGb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039003; c=relaxed/simple;
	bh=lEaVgkWLDsAoo7SCtrvHeS2rrk7e+4rhOrGqQw8hgx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GElZVDZ3/cmipwhiDtuyuThxD7MoFqBig74/BO/TzZLs5+3M3LwIZXHGlzDaZxgHQ85lhx9rs+vCXaVwAhjLYjvzfX0lhYch9hs7KthGotxrV+kGU4SvXSdGZ0h39xTHHXb3L6PlO+FtNzJ54YQfZ9JafChA3oSwCGNVxLR4XbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiKBgU4v; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so3674362276.0;
        Mon, 03 Mar 2025 13:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039000; x=1741643800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNbwSIfUeSXXPmyUg0Xj+MaylekMn1nHxUkSWUyl25E=;
        b=MiKBgU4v2bMJxeVC89sYOfaX04ZbMqdTZcET0he37eDT2WSl/B+1u1CiCdpVl7/m8P
         lMiGynT0qCD5s+ZB6vB8+XhRpi0KGu4lQ2GvlDtDr3qo1GJq+aj0oOEnXiK0nBm/CBl0
         2D1bTz7eOpGolHpdWMZtZIuQy4N+ZgWy/S3l+5B6wn+/oGBhnXF3cFiAaZxsiZS4wFmf
         Pn4ANVi0Zywv06tMKLDYESMZsrAK77hNS5vIMlxZGIWMCDxeP/cYm1qGuK9IB/Uh0WO9
         2i3sNVyy2K21Ng8ZrQrYZMAhaLHJq17nCDrep87T5LmNl9UyJ1ulIAPpoxrpIbTCbRb6
         PiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039000; x=1741643800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNbwSIfUeSXXPmyUg0Xj+MaylekMn1nHxUkSWUyl25E=;
        b=l7nG87cD5lGc2n8cDUKekLFaNBBVc4uIZRryV68cDWEOKMvkZSbGo+LQO0GYqdO9XY
         kWuIpR6c2JkSYe2qsW3CjJrWsc6++ftGSR5gqsHU8ODk4UBWBsXJV03rTx2eGW2c6hJU
         H5SuHeZGRmzCtXTXYNt2zHu3VZQQWk5+eupm0eDEpF6EDzzRRspsr4+SbQJitgODn4Dq
         l7na9smOFOWZLO65kSCj0EfSa1/vHNxXxRAagvbwV1u2WST6c+xYeYpN/V7Ib1STB7Go
         RMyr4GPceNWg+9vjvQyw/vPbm5+BwqYpd/aZmZgtqjCuwJNw+QhUZisz7z5opT+3I/lI
         zR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1V8hfyaMbUXl/+7tPvG0/B8Nyr5jPEQvq1veOjFy6cd+HgaLVsdJ00XiFPgIcVcevpAwcCG7Y8lfw@vger.kernel.org, AJvYcCWw2Z5qROstoZzgil5T+anoe+0kjVbGOt5eDBk78GpVok/Elq6STw1tQL75CIrQPHB8xdro2iTS0FtpjpnR@vger.kernel.org
X-Gm-Message-State: AOJu0YwFA9X/pmzv+wsBdSLbTsNXa1kzPyubM4LWFPYY6azxpySfVONF
	nHzk4p5K1u6bjBo6sHN3hIAAT6mie2T22IV8DTKrs/HzgkmubN1w
X-Gm-Gg: ASbGncsEHW6bcjZ6fYEBbT8G5TttZ/it1W4J/5MwNywZWRa9VOnUGzJUgxxAv/fJEzD
	P3eTEaT0+VzK6+2PZ2RiduyMuId3/8VdUsbs5ehJFY4O3z942Q0n1vVer82hucZOd3rYuQ4Gwkw
	407XLYCgc0S35xsNzZBYrgF6koOj6RNqAD41LAAUdRiobls1aUqfiZQu6KO3wFo2wxTxvXxBEv9
	q1bKzLqO5CHMRojrx5rQGJEdLqw+IHr78rauKk4DEtW5WEqErfycfXn8L+6dhU5tccCS3H5g52h
	rYWPV+r7+U0yC1aYL3PKSoy6hERWf6ZXzjNq6/P2Twc=
X-Google-Smtp-Source: AGHT+IEA8yLhpHzDWjatXgDyinVX0Lpz5abZAJlFq+1cN7NEeFsiJwzy35+xYSdJC0T1I1JTUbAr+Q==
X-Received: by 2002:a05:6902:1682:b0:e5a:ca6b:4531 with SMTP id 3f1490d57ef6-e60b2e9a4d2mr20720874276.12.1741039000158;
        Mon, 03 Mar 2025 13:56:40 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3a42594sm3315506276.31.2025.03.03.13.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:56:39 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: gourry@gourry.net,
	harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	akpm@linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for memoryless nodes
Date: Mon,  3 Mar 2025 13:56:36 -0800
Message-ID: <20250303215638.317539-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <c43c64f4-e697-468e-80af-87bd02a95ba2@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 12:20:03 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

Hi Honggyu, thank you for taking time to review my patch, as always!
I thought I had sent this, but it seems like it was left in my draft
without being sent. 

I will follow Gregory's advice and we will drop the patch from this series,
and send the first patch only (with Yunjeong's changes). Thanks again!

> 
> On 2/27/2025 11:32 AM, Honggyu Kim wrote:
> > Hi Joshua,
> > 
> > On 2/27/2025 6:35 AM, Joshua Hahn wrote:
> >> We should never try to allocate memory from a memoryless node. Creating a
> >> sysfs knob to control its weighted interleave weight does not make sense,
> >> and can be unsafe.
> >>
> >> Only create weighted interleave weight knobs for nodes with memory.
> >>
> >> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> ---
> >>   mm/mempolicy.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> >> index 4cc04ff8f12c..50cbb7c047fa 100644
> >> --- a/mm/mempolicy.c
> >> +++ b/mm/mempolicy.c
> >> @@ -3721,7 +3721,7 @@ static int add_weighted_interleave_group(struct 
> >> kobject *root_kobj)
> >>           return err;
> >>       }
> >> -    for_each_node_state(nid, N_POSSIBLE) {
> > 
> > Actually, we're aware of this issue and currently trying to fix this.
> > In our system, we've attached 4ch of CXL memory for each socket as
> > follows.
> > 
> >          node0             node1
> >        +-------+   UPI   +-------+
> >        | CPU 0 |-+-----+-| CPU 1 |
> >        +-------+         +-------+
> >        | DRAM0 |         | DRAM1 |
> >        +---+---+         +---+---+
> >            |                 |
> >        +---+---+         +---+---+
> >        | CXL 0 |         | CXL 4 |
> >        +---+---+         +---+---+
> >        | CXL 1 |         | CXL 5 |
> >        +---+---+         +---+---+
> >        | CXL 2 |         | CXL 6 |
> >        +---+---+         +---+---+
> >        | CXL 3 |         | CXL 7 |
> >        +---+---+         +---+---+
> >          node2             node3
> > 
> > The 4ch of CXL memory are detected as a single NUMA node in each socket,
> > but it shows as follows with the current N_POSSIBLE loop.
> > 
> > $ ls /sys/kernel/mm/mempolicy/weighted_interleave/
> > node0 node1 node2 node3 node4 node5
> > node6 node7 node8 node9 node10 node11

I see. For my education, would you mind explaining how the numbering works
here? I am not very familiar with this setup, and not sure how you would
figure out what node is which, just by looking at the numbering.

> >> +    for_each_node_state(nid, N_MEMORY) {
> 
> Thinking it again, we can leave it as a separate patch but add our patch 
> on top of it.

That sounds good to me. 

> The only concern I have is having only N_MEMORY patch hides weight
> setting knobs for CXL memory and it makes there is no way to set weight 
> values to CXL memory in my system.

You can use weighted interleave auto-tuning : -)
In all seriousness, this makes sense. It seems pretty problematic that
the knobs aren't created for the CXL channels, and I'm not sure that hiding
it is the correct approach here (it was not my intent, either).

> IMHO, this and our patch is better to be submitted together.

That sounds good. We can hold off on this patch then, and just consider
the first patch of this series. Thank you for letting me know!

Thank you for always reviewing my patches. Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)


