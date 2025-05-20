Return-Path: <linux-acpi+bounces-13834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94837ABE2C4
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 20:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A717A519C
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0CF28003E;
	Tue, 20 May 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fueelk5z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483025B1C5;
	Tue, 20 May 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766235; cv=none; b=QswQgeWsnurbbCiyK3BlkYh49eh0jJhw2K+znBMc9rmkpNHFFRP2aVZkRuIl9rjWQ3nRiTgcYwrG4MnEy37rW5PdqzF/bK1+UOpnu6U7SbA6sZn5bsA+3qqvzO7D0T7TuAU3UYulto32OvRmh2fZNAas99SFr8ajY4/aN0XGcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766235; c=relaxed/simple;
	bh=8uyljq9fglx26Qw0ZSeHv5I3AwqfnvRQ/1leFtEkdYs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d+q0tYkWKjEDOIp/LR3oB0FNmt7x1XESbL55dQtq8cFlRJoCHdpObGnlpr1pGUQ6nlLiaBHZ7ZdhZYkRzoSuHT8jD+okVMRRCbgGncd0JrvYnpg/jXgNv51dYuRhDjVgpfONS5tShrJnwnvkvQ54vLYYl/yQWDPF8ZLKqXsF94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fueelk5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9349CC4CEE9;
	Tue, 20 May 2025 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747766235;
	bh=8uyljq9fglx26Qw0ZSeHv5I3AwqfnvRQ/1leFtEkdYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fueelk5z2goq+VFNEwYspQ2psfyXumGQrxPcVxGTA28YcBZEQJoSY6Ei0SOH2lnId
	 tC16OLTRRnhVGvHaTRQ34e4L+Z3jNRRL23+Od2+d+5bhCTUWYUcA6Ioz9G9WvYX+Zx
	 9odTWlAgPnSSN5kmHIJrzuII5rR9G19rNLpUIHbY=
Date: Tue, 20 May 2025 11:37:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
 honggyu.kim@sk.com, yunjeong.mun@sk.com, gregkh@linuxfoundation.org,
 rakie.kim@sk.com, rafael@kernel.org, lenb@kernel.org,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
 osalvador@suse.de, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v9] mm/mempolicy: Weighted Interleave Auto-tuning
Message-Id: <20250520113713.9b28c705b421c8bd3a51ac45@linux-foundation.org>
In-Reply-To: <20250520181125.4155631-1-joshua.hahnjy@gmail.com>
References: <20250520105319.99f3f2f980617e213db6be20@linux-foundation.org>
	<20250520181125.4155631-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 11:11:24 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> > Honggyu's Reviewed-by is the only change I'm seeing between v8 and v9,
> > which is unexpected?
> > 
> 
> Hello Andrew,
> 
> The code cleanups & wordsmithing were part of the fixlets that I submitted,
> so if you are diffing against the version of v8 with the fixlets already in,
> all you should see as diffs are Honggyu's review and test tag, as well as
> Ying's review tag.
> 
> I was not very familiar with the fixlet process, so I imagined that I needed
> so submit a new fixlet to add the 3 tags. If that is not the case (and you
> can just change the tags without adding a new fixlet) perhaps we can keep
> v8, just with the additional tags so we can keep the patch in the unstable
> branch?

Yes, while the patch is in mm-unstable I frequently update changelogs as
acks come in, as people provide testing results etc etc.


