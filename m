Return-Path: <linux-acpi+bounces-11075-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A1A31A52
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 01:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D36D3A25DF
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8EA1367;
	Wed, 12 Feb 2025 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bkoKcMUZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EF5661
	for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319475; cv=none; b=JHoBIxYl3fQb0AlNdRpFl1nwDpH299JoyBDrszi3iZj1d4ggPczAjAbCR81N7S0FCJ9snS7jRXGn8xHYHlCOcvUKxD5uSkrCj/wW6cXNG6UgwHP4x06bkyjHrGfhOjJBRAUOUVtwyQYYs4d/4MPPU7QK93voKrFRLNRkLys0rUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319475; c=relaxed/simple;
	bh=32KkHloJYCtZwikjLtOAwLrz1z6Zc340EGeVc3fcy0g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GtyFza0QnrPnd9hr6Bi2jZAhwysWk2RCBFiqgWiTsdGG5Oyhmh5W4M+z4KyED62gHeoItNVcJZbCLe4PRZjXNBs2RS925Ychsw0QcxaILta/s6WLlL+hqjlZjTZmvr1MOjgjeX4CekeQuu52aCdHXdG/Rs207gzkIqR712hkW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bkoKcMUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72914C4CEDD;
	Wed, 12 Feb 2025 00:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739319474;
	bh=32KkHloJYCtZwikjLtOAwLrz1z6Zc340EGeVc3fcy0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bkoKcMUZ9hzvID14imCkkC6Nef+XzgMK++AqquQnrzkhY9s7CM9qD9vrQlxLichz5
	 N0L5EN1OV1BpSkCwmJFHjF86W4zr0a3VXLWVPvWCH7fGkC55yBvc7G/VcwCXnX4bMX
	 xfz7AYlawh9FtzHE1isEi96n2LVKEE2bD464UipU=
Date: Tue, 11 Feb 2025 16:17:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, hyeonggon.yoo@sk.com, ying.huang@linux.alibaba.com,
 honggyu.kim@sk.com, rafael@kernel.org, lenb@kernel.org,
 gregkh@linuxfoundation.org, rakie.kim@sk.com, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave.jiang@intel.com, horen.chuang@linux.dev,
 hannes@cmpxchg.org, linux-kernel@vger.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Message-Id: <20250211161752.64dd397e66a2754097ab8c2a@linux-foundation.org>
In-Reply-To: <20250208050606.800498-1-joshua.hahnjy@gmail.com>
References: <20250207182009.7fc099c3074ad00338f25e0a@linux-foundation.org>
	<20250208050606.800498-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Feb 2025 21:06:04 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Fri, 7 Feb 2025 18:20:09 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Fri,  7 Feb 2025 12:13:35 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > 
> > > This patch introduces an auto-configuration mode for the interleave
> > > weights that aims to balance the two goals of setting node weights to be
> > > proportional to their bandwidths and keeping the weight values low.
> > > In order to perform the weight re-scaling, we use an internal
> > > "weightiness" value (fixed to 32) that defines interleave aggression.
> > 
> > Question please.  How does one determine whether a particular
> > configuration is working well?  To determine whether
> > manual-configuration-A is better than manual-configuration-B is better
> > than auto-configuration?
> > 
> > Leading to... how do we know that this patch makes the kernel better?
> 
> Hello Andrew,
> 
> Thank you for your interest in this patch!
> 
> To answer your 1st question: I think that users can do some
>
> ...
>

Interesting, thanks.

Have we adequately documented all these considerations for our users or
can we add some additional words in an appropriate place?


