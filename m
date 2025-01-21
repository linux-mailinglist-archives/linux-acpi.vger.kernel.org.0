Return-Path: <linux-acpi+bounces-10780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E44A1873F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 22:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F45164487
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 21:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFCD1F37B5;
	Tue, 21 Jan 2025 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy03XKFZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E431BBBC4;
	Tue, 21 Jan 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737494676; cv=none; b=XPxl7pnzMsUoR991WG7mz+AQsHh617lcw72Pm0viN5EkSiWsDnw4QXYMbMsX81GjR/pNTAmzsYatUROqEvLDkUo1yHnv3aQiyfWm8J4AbCZt7Oe4jK1Pb8SUWFlMdtS2vY2owfNuseUaaJekTleawb19wFdCrqlG7+REwC4U7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737494676; c=relaxed/simple;
	bh=WGwYX3KMDveLuqF0BdJaQZJ/eeFaS/gAAof3k4XUg1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3By8rIMNsmDDvH+9zFTFnLgCLT9oOF8DkQLolpSWDRC9LmxGGsjcrYhD5awdcFTHtlzuHcN4lREaZ1Dsy+Xf5S0eCjdomFncKweSv0O5MsfWxdj/3+v4+oODEu7TW5O7eAjVfOMJ2IRfotMePxQejjR/O/c0A9OI+keaoI/OTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iy03XKFZ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3c9ec344efso8896942276.2;
        Tue, 21 Jan 2025 13:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737494673; x=1738099473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D875B0kpOelYr3S2d/i+EM+Vu91KG28kMKlzUneXEt4=;
        b=iy03XKFZoZpl9P53LELlXyQF5fgs4aOQKWTk+AAIo5AJw2ZXHSrAuEWIcVoaHWy+WQ
         /04QpfkNZPPRK6HY6fxeFCdQLGxEiyOFW28Wbmdb3bYo5N4ba1FvlX41DoZorc/0va9a
         0ZAvsrhHro8oZcmontRaBwf1iAI726yOSt6fuDUpFsEhC+S/Jm9m2Ez8Sg51MmGL1t18
         EIzbLzU5fVxUgMQR5dbnQT/OIWwdu7JKyhkTlipQtRfrke60j0ZJJsT7cDMBUmYzZDT5
         YzL/g3bM369VZtJ2zOkL0Y4bycy9c2sRenu1q7GmyUT6vJKDxlvf4si96coU3UnJm8kT
         TApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737494673; x=1738099473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D875B0kpOelYr3S2d/i+EM+Vu91KG28kMKlzUneXEt4=;
        b=v5XKKYUAp7AAlI0eFN+wSsNWo6PvbXOjwCgAVFlatjZww8tU2zs1Ueb3qUHlcCRk8T
         wt5bXxpM8gPS8aFiMoQk9oOU8yB4F2qlxtCczHZywiEG1IKlwINRD0WNLHp4ktNb8FZh
         PUGqg7SMidolV+Qz4TQZYFmn7OAY0g6XOdxKZ8ogMw+cmNtHNQWpS/2/y3dC0zfm3MJ7
         lEx6mW222gncmMxXeha0oyUhLXu5DNFYHJIytCfqS8CU1/ERdJfx/mbluXhtGzdnuSXv
         pnkBfWK0DerKySIqWzCJAece38QM+e9cwRobmVGCHfX/NYO5yfyG3S7iZi6Eo0dQXXNu
         v50g==
X-Forwarded-Encrypted: i=1; AJvYcCXPYU79F9c8bWcHaHB+zZ2OfAWOXlhrF6Ra1863aKxvPa0h5uyjomYZmjgzDpRqUmuCiVbnD1LD1pqU@vger.kernel.org, AJvYcCXio91UyJwIqkGNTYWl4wVbwnP4R11U2Fa+jKNeS1CeVWkZdbPOdrn9QpaK+H8/aG9UPMCc3egEhHBU9UGe@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4PP+7iJRlXQg7EYv7/ujfdzTLuX26BamTCTsgsgh3RZbYTRP
	NeLGEbIUw944C1GA1y0Di+izX3VVoMQZacjDCUyV4d1I7Zsj5l+4
X-Gm-Gg: ASbGnctqliIpa+GliHBhatPPQHWaAZfIqmKsPt6diUFW8IktdI3cUoIFUUCrMeBuYE+
	HvAdP1tmYmKZva6b8s7wH2GLdywGHUatartsHF2BPH79K/WFsxQpK5QUqh1/+gK+QQ1es+i7HLp
	UFAJsR1xS3kwZ+Ns5ncY8ONCIIb/B/rlllXEQio633YHIoFcp2vjoIgMms+e8oVdNAqGRpp9x2X
	x7QN2PhKAdOJZtiwFRAwskkshSsq1gUZkYJLZlLWliTekT/RF1LX/YWhNHC0ggpqNvu
X-Google-Smtp-Source: AGHT+IExV6nu3DeIm1Zy5TrgewQmR6yEOGT+zm24JFSRqTPSmvKk0BsuLbZ0KG25SLFTZYUT9pxefw==
X-Received: by 2002:a05:690c:7084:b0:6ef:7f34:fe1f with SMTP id 00721157ae682-6f6eb677dbfmr152268897b3.13.1737494673563;
        Tue, 21 Jan 2025 13:24:33 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f734de43basm1769637b3.52.2025.01.21.13.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:24:32 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
Cc: "gourry@gourry.net" <gourry@gourry.net>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	kernel_team@skhynix.com,
	42.hyeyoo@gmail.com,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?UTF-8?q?=EA=B9=80=ED=99=8D=EA=B7=9C=20System=20SW?= <honggyu.kim@sk.com>,
	=?UTF-8?q?=EA=B9=80=EB=9D=BD=EA=B8=B0=20System=20SW?= <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Date: Tue, 21 Jan 2025 13:24:28 -0800
Message-ID: <20250121212430.3902148-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <4ab7bd83-1191-434c-8b5f-75e71ceb26c1@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hyeonggon, thank you for the review!

[...snip...]

> Hi Joshua, thanks for the update!
> It actually is what I was intended in the manual / auto mode description.
> 
> I don't have a strong opinion on the weight of the hot-plugged NUMA node
> in manual mode, as it's not ideal whatever weight we choose and the user
> need to update the weight after hot-plug events anyway.

I'm glad that I was able to correctly interpret the framework you laid
out in the previous conversations. And yes -- I agree, I think no matter
what value I choose, it will always be sub-optimal for some definition
of optimality. I simply chose 1 because it is now the new smallest
weight possible, since 0 no longer works.

> Some comments inlined below:
> 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > index 0b7972de04e9..d30dc29c53ff 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > @@ -20,6 +20,30 @@ Description:	Weight configuration interface for nodeN
> >   		Minimum weight: 1
> >   		Maximum weight: 255
> >   
> > -		Writing an empty string or `0` will reset the weight to the
> > -		system default. The system default may be set by the kernel
> > -		or drivers at boot or during hotplug events.
> > +		Writing invalid values (i.e. any values not in [1,255],
> > +		empty string, ...) will return -EINVAL.
> > +
> > +What:		/sys/kernel/mm/mempolicy/weighted_interleave/mode
> > +Date:		January 2025
> > +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> > +Description:	Auto-weighting configuration interface
> > +
> > +		Configuration modes for weighted interleave. Can take one of
> > +		two options: "manual" and "auto". Default is "auto".
> > +
> > +		In auto mode, all node weights are re-calculated and overwritten
> > +		(visible via the nodeN interfaces) whenever new bandwidth data
> > +		is made available either during boot or hotplug events.
> > +
> > +		In manual mode, node weights can only be updated by the user.
> > +		If a node is hotplugged while the user is in manual mode,
> > +		the node will have a default weight of 1.
> > +
> > +		Modes can be changed by writing either "auto" or "manual" to the
> > +		interface. All other strings will be ignored, and -EINVAL will
> > +		be returned. If "auto" is written to the interface but the
> > +		recalculation / updates fail at any point (-ENOMEM or -ENODEV)
> > +		then the mode will remain in manual mode.
> > +
> > +		Writing a new weight to a node directly via the nodeN interface
> > +		will also automatically update the system to manual mode.
> 
> I think the last paragraph should also be included in the nodeX parameter.

I agree, I will definitely add this in the next version!
 
> > @@ -2450,16 +2548,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
> >   	if (!weights)
> >   		return total_allocated;
> >   
> > -	rcu_read_lock();
> > -	table = rcu_dereference(iw_table);
> > -	if (table)
> > -		memcpy(weights, table, nr_node_ids);
> > -	rcu_read_unlock();
> > -
> > -	/* calculate total, detect system default usage */
> >   	for_each_node_mask(node, nodes) {
> > -		if (!weights[node])
> > -			weights[node] = 1;
> > +		weights[node] = get_il_weight(node);
> >   		weight_total += weights[node];
> >   	}
> 
> Uh-hum...
> Looks like it now allows copying weights from different versions of iw_tables?

This is a good point, this is actually an artifact from a previous
iteration where get_il_weight was needed to handle the weight being
0, but since we no longer allow 0 as a value, it makes more sense to
just take a snapshot under a single rcu lock. Thank you for the catch!

I will also go over the other places this is used and just make sure the
locking behavior is as intended.

> Otherwise this patch looks good to me.
> 
> Best,
> Hyeonggon

Thanks again Hyeonggon, I'll send out a v4 with the changes you mentioned!
Have a great day!!
Joshua

