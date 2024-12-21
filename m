Return-Path: <linux-acpi+bounces-10250-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E09FA137
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 15:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4585E18834D6
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AC91F37DD;
	Sat, 21 Dec 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kZ+weGHr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC11F2C36
	for <linux-acpi@vger.kernel.org>; Sat, 21 Dec 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734793094; cv=none; b=bH6QN4XcBLKbr3ejuGCul7KBMA18R18lj/H39ObxORFM9xfNry1r5V71ZSktZTNnbY9VtA+GW96kkiqS92g+Ct+f9MFFHrddhpGSWlGcYmTqBvfF4Smju64hueAUmqh4Sox7IyHAVvSOy/HlEtCEZZ+iUL4FXvRcw2h7jmBtglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734793094; c=relaxed/simple;
	bh=bLJFJgUuUGa4aQRH9jlb2YXHP9UMyaPtaWlZTZQ5RLU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XShI6Hqj9HIG1G4FGUJNONEUAeP5ckJSyhwNJoeZfXZMcnaud63Ay5edOxEGJMJIKNUlQDUk4owSkQEAMpxeFEXgJEltct75wtVYxU3XvNSJSZHrOVFIkc5D9kdqNTKFLmkT10sxo0ZyezbUNBIEFsDtrG4BkXDEwDMBmDz1OOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kZ+weGHr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6eeff1fdfso233268285a.2
        for <linux-acpi@vger.kernel.org>; Sat, 21 Dec 2024 06:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1734793092; x=1735397892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBgdCj8qzQbjXPZyDo9umjvbz0FQ++8ByuLBpWSlyEY=;
        b=kZ+weGHrbTfSXVWHp2eXTDCUaM5CnQteqMkQ4BW5K7yKdEzCh2t7p2cHwOMWfoWGYs
         W61lStpXLMBLpaRZov3xSnHs4191xDvorZcdFvnPvuUIYwxPcRM5uD6n8FhhSLg67LV3
         gSaVlllBTIveoVc2Siv9ezn4yaKj1A765UC/JE6ay1AFnTLCnc6wTOvJkYa/iDkkMJI1
         rqm2RlhMkXFCfv6pmzNqSKi4cFusztRL6i9k+v4WjiM6rgcdY1H0NnuQaPl7K8ogjsKI
         RBK+D3Vx5kIsxkk60+MNbQA/9Ulrb8XOGQtenKSUDelhfCBFHQVc5/9isQo2IcfR/qR/
         o+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734793092; x=1735397892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBgdCj8qzQbjXPZyDo9umjvbz0FQ++8ByuLBpWSlyEY=;
        b=YVABpAtObpK8ea4sqfJgEx/I0xGUo6BNY2BgGhVHw90AtfEwdZppkAwqgkjKFKHIF3
         ivJQs0IWQ5AWEDG5B4jhieKH4t2wXgeBZ7fIWP5/bnd4JON744TD12UfqN6p2KHT+hO1
         gm7wlF7J6if5kg6FcX6dIrxXVOseV3VlffPF9aSr1LgUhsNeg7pxNpUQJ9+pbWCtiK5S
         RBWMxIRUNYtoe58W8cOgkpT4bJzmncheupHlGc3Zfgiljz+DjWD5JiKX4PFcxNVPb8sf
         EiVGSbAVKooedqN/TONtg4rp4n9Ms/Cme6Xu/EKEuCFC++AfhiL7jZ7AfiLF9hUv5dT4
         Yo0w==
X-Forwarded-Encrypted: i=1; AJvYcCWjym4HyzBV48CjCbL6M9S/VUC3UktqwajpRmIBXc/Xx9cNlIIgZHhhCWsXiqMEFR6BcuBMNuOvZcTw@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBtbWe4rtd2T1RMdgZ6fSx4ssf6BddIGskYp6m5HjXZfj0HL1
	B7H5doTq/3VjKu/2WtpVjPFy/fMq+5XfHDvQfF+doX6CT0EqM/1fyOULnj5r5TM=
X-Gm-Gg: ASbGncvCuC4Bvi6FGGjJp3gMVVeCH2OuJfLd0O/4GdCjmB+qzEzHtE9x7Ujcwf2zG1m
	e91cH85wQTEosQRkVmjXyCnv65VmXt9Q8+aFcPL9J3wlGbUNGqaJfXiXY4Y3ELeW/Tb6cJgd9Ns
	WG02na5+DDkkJ5nHmEfBuDy9WfIrbuNOLrOdbKNd0z+8sXFa3+T7W4X714SZWr+XWeLVBWWEAqv
	ozjqBROYfQwz5bybdw2xf5chDU6+EJwwvRXFI64m9o169ypuZphv50CmIXJqhqultXBK8EgQoOF
	KLeq3nZa98Yy3AYYIy4ijlLIZkrX5ee0bA2eaLtig6jGIPJrQkwU92k=
X-Google-Smtp-Source: AGHT+IEgen1JW0Sf/lyCSUkaoVFMrNI48GAZq54w9vfNDCg0KyyfP72OZmixkjresa0McFobW6rDgA==
X-Received: by 2002:a05:620a:318c:b0:7b6:de65:9ee7 with SMTP id af79cd13be357-7b9ba7ee78dmr1161952785a.43.1734793091760;
        Sat, 21 Dec 2024 06:58:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4be70bsm227827985a.96.2024.12.21.06.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 06:58:10 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
X-Google-Original-From: Gregory Price <gourry@gourry-fedora-pf4vcd3f>
Date: Sat, 21 Dec 2024 09:58:08 -0500
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
	"gourry@gourry.net" <gourry@gourry.net>, kernel_team@skhynix.com,
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
Subject: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave
 auto-tuning
Message-ID: <Z2bXgMw5WPCqwGSk@gourry-fedora-PF4VCD3F>
References: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
 <20241213195754.2676135-1-joshua.hahnjy@gmail.com>
 <87jzbtr315.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzbtr315.fsf@DESKTOP-5N7EMDA>

On Sat, Dec 21, 2024 at 01:57:58PM +0800, Huang, Ying wrote:
> Hi, Joshua,
> 
> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On Fri, 13 Dec 2024 15:19:20 +0900 Hyeonggon Yoo <hyeonggon.yoo@sk.com> wrote:
> >
> >> On 2024-12-11 06:54 AM, Joshua Hahn wrote:
> 
> [snip]
> 
> >
> > [-----8<-----]
> >
> >> > +What:		/sys/kernel/mm/mempolicy/weighted_interleave/max_node_weight
> 
> I don't think that we need a new knob for this.  Just use a reasonable
> default value, for example, 32 or 16.  If it turns out that a knob will
> be really helpful, we can add it at that time.  For now, I don't think
> the requirements are clear.  And, this is a new ABI and we need to
> maintain it almost for ever.  We must be careful about new knob.
> 

This is fair.  We spent a good amount of time modeling the best
effective maximum weight and basically came to the conclusion that 32
has a good balance of minimizing error and being somewhat aggressive.

Ripping out the sysfs is easy enough.

> >
> > Regardless of what implementation makes sense, I can re-write the
> > description so that there is no ambiguity when it comes to the
> > expected behavior of the code. Thank you for pointing this out!
> 
> I don't think that it's a good idea to override the user supplied
> configuration values.  User configurations always have higher priority
> than system default configurations.  IIUC, this is the general rule of
> Linux kernel user space interface.
> 

We discussed this and decided it was confusing no matter what we did.

If new data comes in (CDAT data from a hotplug event), then the weights
are now wrong for the new global state - regardless of whether the user
set a weight manually or not.  This also allowed us to simplify the
implementation a bit.

But if generally we need to preserve user settings, then I think the
best we can do to provide a sane system is ignore the user setting when
re-weighting on a hotplug event.

e.g. user has not set a value

default_values [5,2,-] <- 1 node not set, expected to be hotplugged
user_values    [-,-,-] <- user has not set values
effective      [5,2,-]

hotplug event
default_values [2,1,1] - reweight has occurred
user_values    [-,-,-]
effective      [2,1,1]

e.g. user has set a value

default_values [5,2,-] <- 1 node not set, expected to be hotplugged
user_values    [4,-,-] <- user has only set one value
effective      [4,2,-]

hotplug event
default_values [2,1,1] - reweight has occurred
user_values    [4,-,-]
effective      [4,1,1]


So default values get updated, but user values get left alone.

If that's sane we'll fix it up.

> ---
> Best Regards,
> Huang, Ying

