Return-Path: <linux-acpi+bounces-10985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2E4A2FF42
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 01:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287783A656B
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 00:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8B5D477;
	Tue, 11 Feb 2025 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JzCRggp4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC403EA98
	for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234382; cv=none; b=cgGNvVuyIv/ZDBQ0ib8IL5pBEgHr7y9W3UsxLtA+0g306q5yEHVHhpZjyHOjHapJMq8L0BTXABpzLJ0wXoZ2Alqvz9eqE+wWcTMZlpjpHfByk8AsVWV2O2bzvYZtuGtSY5pNsBiY8fMFXwn6UUuWHg0tSR0GClULWPVOca15gJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234382; c=relaxed/simple;
	bh=PqRnffFFb7mMFeS0wQRDk3n3tdxM/h7SLVOOWWza72Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sn/bxjiwOx2Z0O4hJaMDeu4hYH8U9DxbmFxtFm4Vtiv9M7lOn3Go+zHFz4ARhVUEghzQW/97UCsKMnByhwAs3Su1FGHSC8v1I0EWupnWHUkdBwTSYTjmBX0HcLD9LkWaRg4cveidrfkrQ0g+ZUWJT0iLZOs5EZvhGQnYZHBQYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JzCRggp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AC4C4CED1;
	Tue, 11 Feb 2025 00:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739234382;
	bh=PqRnffFFb7mMFeS0wQRDk3n3tdxM/h7SLVOOWWza72Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JzCRggp4W0TtGGt058AdSYkUxteplcjAuD7YWfnxvkIg/OVvXLnIglxjfORx02ga+
	 163pl7nAg3VZg495M6pMhKMVoSr3S2pQYAiKfZJQVaco+GUNrC3Kw5owAIxMDrpbXQ
	 jHmgX6gRd9zCVHRtH8JCA1dLa+CJeFCAj5VryZCM=
Date: Mon, 10 Feb 2025 16:39:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
 ying.huang@linux.alibaba.com, honggyu.kim@sk.com, rafael@kernel.org,
 lenb@kernel.org, gregkh@linuxfoundation.org, rakie.kim@sk.com,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
 linux-kernel@vger.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Message-Id: <20250210163941.15da1e935ed47aacf810fdd0@linux-foundation.org>
In-Reply-To: <Z6mQUIAOTvHj3wSp@gourry-fedora-PF4VCD3F>
References: <20250207201335.2105488-1-joshua.hahnjy@gmail.com>
	<20250207182009.7fc099c3074ad00338f25e0a@linux-foundation.org>
	<Z6mQUIAOTvHj3wSp@gourry-fedora-PF4VCD3F>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 00:36:16 -0500 Gregory Price <gourry@gourry.net> wrote:

> On Fri, Feb 07, 2025 at 06:20:09PM -0800, Andrew Morton wrote:
> > On Fri,  7 Feb 2025 12:13:35 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > 
> > Leading to... how do we know that this patch makes the kernel better?
> 
> Just focusing on this question:
> 
> The default behavior of weighted interleave without this patch is
> equivalent to normal interleave.  This provides a differentiation
> out-of-the box, and that's just a better experience.
> 
> We may find the default values / calculations need tweaking in the
> future, but this gives us a good starting point.  Anecdotally, I've
> seen an "optimal" distribution of 10:1 based on the numbers run
> sub-optimally compared to 7:1 or 13:1 (but better than default mempol).

How was this optimality measured/observed?

> So there will always be a "try it and see" component to this.
> 
> (Not to mention hardware/firmware lies regularly, and their reported
>  performance numbers rarely if ever match their tested numbers - so
>  *at best* this can be considered a best-effort feature)


