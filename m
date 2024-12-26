Return-Path: <linux-acpi+bounces-10310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7141A9FCC91
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2024 19:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00344161816
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2024 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166CA146D55;
	Thu, 26 Dec 2024 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uJoZPD6k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51843145335
	for <linux-acpi@vger.kernel.org>; Thu, 26 Dec 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735236832; cv=none; b=K//9krR3GAORYdSuGOmE872hKVkeWMCkeOmu6xmE+416z8A9hmd19wXXTKDjSfGmnhrcw3oSP9j4qRC9Lc5j6f7UlIydKtPHzKKg6Lavj8bhi4WLfQ7vaHrgKNdhrAORrYb/XbC/DnWAw74SF4UnZ9MuvBkTgnLOgOh8xNDn/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735236832; c=relaxed/simple;
	bh=b4QKHYme5yT3asASBjmHflWTpAaOfdad2vw1w15H5zs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFgYS6uhnVEEIBzpe1z97jkxq4Sgs5dk2prW3XJoPA7SjBPWXtiRSwKmyRHqZKBBkfhej+AHpaO9ewJ5VCKYChKGlDAGsomkQP3dHPKHWnPbfcmZX7GXnlvG8XlINvEr2hxoLxbOvf2AAClA8e63lhjVGXaQPRPaGdlPyXEV73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uJoZPD6k; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd1b895541so430966d6.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Dec 2024 10:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1735236829; x=1735841629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SkOwnM04gSYaxumeHOgniGqId9jfVrv1XuEeE/2uYQg=;
        b=uJoZPD6k9NbEC5J2Mch4KuQ5H0GSLcaiPXVRor9wnEZyie7u7MBxNQUKpmikRmB4r1
         K2jZxHhm0nFHDjMI8kFQ2fjou29pWQ4nd3x9lQ1kalYVEeqLi+BAjJW1bdnUxOZMZW+K
         aspwcKen6s42zDgtwWyfQfQjm1SPf7lz4UPn3gPtf0b8h024P6ki0esv825mgBonKp6a
         hKTCt/PsuNrNZZrgAwIKuw80fjHiJdj2XxYupQ9E8J92b++qHBzZv8q+pgKu+iJciOE1
         PVjvCwvneb3xk+1Q7AKrbA8cj6byDzSyq7wOF/m2dH2LwfgsRlU9Mrpj4nwBt4cRy1fR
         DpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735236829; x=1735841629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkOwnM04gSYaxumeHOgniGqId9jfVrv1XuEeE/2uYQg=;
        b=gWpgprKCpUca1DFZyjupJywpl1wf7RQVCY7hgWFl4JqauSmVtTmQKxqf/UYHTMplLi
         gU0rrKtClzpKgKx2KoTVzXQxmW2lBB1kvav/d/x5UkZDdseSJD6N971NYrfJ8oI1BUBS
         NMJYwQbIrtGUTPCbYEqBv7UhtMjZLTVtQbdXVITiET2RLEO2xH3l2+EyFx+EjIarHWha
         7u7goMrxQYqi1li+bM03mPuTJ8/bmUj3rMxAe3L4c1S6YpmKV/8pHt1uhrjCwuIoYU5U
         LAA/260qujas5qIX1P6g52C+tAN8cbyzTw+tqLuLjOWFTXtKDgPxGP+NREjJSlzYySmN
         6L5w==
X-Forwarded-Encrypted: i=1; AJvYcCXE/EKscEPoUE95UOirelmL96+UMJGA6NhymUDpjo72GVMpcIGxEqt/qm6T34tUn5F4t24D17ON8B8m@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHqhZJZKLPOx3lTUCwklwqcjbKiwgMCcJ2AASaw40mQNrXe6a
	i4tTWqcc6hbGyAbzix0DaNOiMflCzQsMN9Yq3Zz0iqJEz970a1fio7KgcGztrEU=
X-Gm-Gg: ASbGncvRCqZBniAp3DS7FgsbifNuJj6BFQyEyiscRwSzMuj+1E2bo0quO8UB42ALGGr
	F47dfi1mCOYUsWCG6tU+XZHk+5WekrtSgkYHaiNsFM4Uv4gCWnAl5flPKVNKlhdRZdcv+orNnrx
	fxsH5gRAHazplxAvOQ5JLZPhNK+eqVAYkGvLv2j64dzU3XXYlwkhoIVkA0x7cGuTgPr5EGV1m0l
	s4oGgBcj7z4xshQ5pIabDq7w7ew2ZAviF60zPPtmPFtoM8B+Iiy1koNkw5ay5G0Wl1sJnKcqzXI
	1JEm
X-Google-Smtp-Source: AGHT+IEUtGlBtvIBAaSwJqvpGIIc9+7GUi7eXzltAEh/k3pKnpnybjiBzhcqj4Cy/VPQZ/ExExE8gA==
X-Received: by 2002:ad4:5d67:0:b0:6d8:86c8:c29a with SMTP id 6a1803df08f44-6dd2331a3cbmr423864206d6.10.1735236829103;
        Thu, 26 Dec 2024 10:13:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([184.169.45.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181c13b6sm71417116d6.96.2024.12.26.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 10:13:48 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
X-Google-Original-From: Gregory Price <gourry@gourry-fedora-pf4vcd3f>
Date: Thu, 26 Dec 2024 11:13:21 -0700
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Gregory Price <gourry@gourry.net>, hyeonggon.yoo@sk.com,
	kernel_team@skhynix.com, "rafael@kernel.org" <rafael@kernel.org>,
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
Message-ID: <Z22cwZycFV47wOfX@gourry-fedora-PF4VCD3F>
References: <20241225093042.7710-1-joshua.hahnjy@gmail.com>
 <874j2rp6or.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j2rp6or.fsf@DESKTOP-5N7EMDA>

On Thu, Dec 26, 2024 at 09:35:32AM +0800, Huang, Ying wrote:
> > Having two files for each node (nodeN, defaultN) seems a bit too
> > cluttered for the user perspective. Making the nodeN interfaces serve
> > multiple purposes (i.e. echo -1 into the nodes will output the default
> > value for that node) also seems a bit too complicated as well, in my
> > opinion. Maybe having a file 'weight_tables' that contains a table of
> > default/user/effective weights (as have been used in these conversations)
> > might be useful for the user? (Or maybe just the defaults)
> >
> > Then a workflow for the user may be as such:
> >
> > $ cat /sys/kernel/mm/mempolicy/weighted_interleave/weight_tables
> > default vales: [4,7,2]
> >   user values: [-,-,-]
> >     effective: [4,7,2]
> 
> AFAIK, this breaks the sysfs attribute format rule as follows.
> 
> https://docs.kernel.org/filesystems/sysfs.html#attributes
> 
> It's hard to use array sysfs attribute here too.  Because the node ID
> may be non-consecutive.  This makes it hard to read.
>

Would generally agree. I think essentially a
   use_defaults => (0 | 1)
interface is probably the best we can do.

Setting any node changes use_defaults from 1 => 0
echoing 1 into use_default clears user_values

This still allows 0 to be a manual "reset specific node to default"
mechanism for a specific node, and gives us a clean override.

The only question is a matter of hotplug behavior

nodes_online: 0,1
  default_values: [5,3]
  user_values   : [-,-]

event: node1 is taken offline
  default_values: [5,3] <-- nothing happens

event: node1 comes back online with different bandwidth attribute
  default_values: [6,5] <-- reweight as occured silently

event: user sets a custom value (node1 <= 2)
  default_values: [6,5]
  user_values:    [6,2] <= note, *no reduction*

event: node1 is taken offline
  default_values: [6,5]
  user_values:    [6,2] <= value still present but not used

event: node1 comes back online with different bandwidth attribute
  default_values: [5,3] <-- default reweight has occurred silently
  user_values   : [6,2] <-- user responsible for triggering re-weight

The user has the option of

echo 1 > /sys/.../weghted_interleave/user_defaults
result
	default_values: [5,3]
	user_values   : [-,-]
or
echo 0 > /sys/.../weighted_interleave/node1
result
	default_values: [5,3]
	user_values   : [6,3] <= only node1 is updated, no re-weight

Basically, if the user ever sets any value, we never automatically pull
new values in, and the admin is responsible for triggering a re-weight
(use_default) or manually reweighting *all* nodes - because changing
values implies a change in the bandwidth distribution anyway.

I think this makes the most sense.

~Gregory

