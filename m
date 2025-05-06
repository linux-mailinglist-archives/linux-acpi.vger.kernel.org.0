Return-Path: <linux-acpi+bounces-13505-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E8AAACD67
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 20:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005783B6567
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C128E286882;
	Tue,  6 May 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2BHOxDw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E5283C89;
	Tue,  6 May 2025 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556652; cv=none; b=Bl+l9CNHrVPvBejaCiqnmlC0tXIHeoF9XgRsT3XUaPvFyYsyglC8RxvlVqVxWn9lB8Fx/Yn+CytcpuQBJ4gnMaYVBfhPPPuzopoClmRn8KTPUMGilBWWgo7wEy/FBR5r+VhSyE1K3VRYYXGjw7eGvGykwhNhqYDb1umDx0GXNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556652; c=relaxed/simple;
	bh=1t6ifNaTTzKgr2uUkBF2eN7jEVCbkIA3GK8BNoDuxKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPeAwEsH4XfuECynFNWoZmrAi/yNkn3kseSPrw73Kf0uOGdGMTnsoHh+hGaLY7hYP/kJOZBcqX7dSwzNmSuJGqyXpgdBdBHgRmePaxS6/4yEvvNqz7/eFFBlMMwEXKDOdVdC6kAMuxQbGRMeD0zLBHhRfv8aLhbBKkh+glDTpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2BHOxDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55630C4CEE4;
	Tue,  6 May 2025 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746556651;
	bh=1t6ifNaTTzKgr2uUkBF2eN7jEVCbkIA3GK8BNoDuxKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2BHOxDwSo1WmG4EmsV60CjLvifCNxeDKaIpySQKp/ktqAIopYWP7goYECDLaqqkf
	 XHPktFERb8hV96KIZu4ideaCiQjRbMN2qR3KeEsIq9pmSji2LNsMIjTOs5dmv3Occb
	 zy0HCI+47VYW7oMR/LLvIcZ8rLJIYugHOsynk3rBttPz9EFck2rmKaBrhwT4BrVeYi
	 SvyVub4O5tCQFBYp7I9DMuuXU++a/K+o7piB3qVUAXlek0vzdBLcQyJob9UYraw2Ik
	 jWMMgKeSRQ4PqvRacldx6emYDAlB7Pk/guEpXM7PaBJM5x1BaKP5uR6XG+yN+pSqSz
	 eKyIRhVMvsydA==
Date: Tue, 6 May 2025 11:37:28 -0700
From: Kees Cook <kees@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, justinstitt@google.com,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] UAPI: ndctl / acpi: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <202505061135.C76B6CA9F@keescook>
References: <Z618ILbAR8YAvTkd@kspp>
 <Z65xV2TaFY32eYdp@aschofie-mobl2.lan>
 <202504071106.3A0AF875F@keescook>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504071106.3A0AF875F@keescook>

On Mon, Apr 07, 2025 at 11:11:08AM -0700, Kees Cook wrote:
> On Thu, Feb 13, 2025 at 02:25:27PM -0800, Alison Schofield wrote:
> > On Thu, Feb 13, 2025 at 03:29:12PM +1030, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > > 
> > > So, in order to avoid ending up with flexible-array members in the
> > > middle of other structs, we use the `__struct_group()` helper to
> > > separate the flexible array from the rest of the members in the
> > > flexible structure. We then use the newly created tagged `struct
> > > nd_cmd_pkg_hdr` to replace the type of the objects causing trouble
> > > (`pkg`) in multiple structs.
> > > 
> > > So, with these changes, fix the following warnings:
> > > 
> > > drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > One sample warning is good.
> > 
> > How about adding a comment on why the usage of __struct_group() here
> > means this doesn't break userspace.
> > 
> > snip
> > 
> > > diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
> > > index 73516e263627..34c11644d5d7 100644
> > > --- a/include/uapi/linux/ndctl.h
> > > +++ b/include/uapi/linux/ndctl.h
> > 
> > FWIW: In a patch like this where reviewers likely want to see
> > the header file change first, put it first in the diff.
> > (git diff.orderfile)
> 
> TIL about diff.orderfile! :) Just for my own education, what do you have
> as the contents for your orderfile? Is it just simply:
> 
> *.h
> 
> ?

I've updated my local environment to use this, to see how well it ends up
behaving:

Kconfig
*/Kconfig
*/Kconfig.*
Makefile
*/Makefile
*/Makefile.*
scripts/*
Documentation/*
*.h
*.S
*.c
tools/testing/*

https://github.com/kees/kernel-tools/commit/909db155b5cd36832d10d7d9932d7b51b46388aa

-Kees

-- 
Kees Cook

