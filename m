Return-Path: <linux-acpi+bounces-10022-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9EF9E9DDC
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27177167026
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3DB155327;
	Mon,  9 Dec 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2vdUnGw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3161F5F6;
	Mon,  9 Dec 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767909; cv=none; b=d7vouUISjgaT/YxJiX4DsoLsGFuWTTsWHqvWcCj16Zg8mieYeQRaKVr1zj5RVy6H8ZApFa5MKUqc9FVB39crCP/cHB8QXiDkDgmNDb6v20XdcI/uNv02iIpgmSkQ6djqmPT7SBZ59vk2NURhhlXwYzUNvSUlqKwwEC4Ad6ijQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767909; c=relaxed/simple;
	bh=HALWU73HHHPXsP1faQOW67Q/YjQtHp6d/UBGGuNnpyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clRaZoPcdGSdc5l3PBAC+NWJmRMpFTEA4LKe62Ss/TT65r1OSrkye1O5mWmQCsLntIm6+KCqjhgur8k8v7W/16Vt1L5zf8nei+ECDnI2hVs1HMJAnpqgyIEbc1baLMpFFyM2XdhDBRB7hJAjpgkyKHGKsza4WgVgyG343vQPYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2vdUnGw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733767907; x=1765303907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HALWU73HHHPXsP1faQOW67Q/YjQtHp6d/UBGGuNnpyM=;
  b=N2vdUnGw63tIx+T/LWd6uNfAuye+5qwuYgA8flfQD2BUtpFTrYfRMbkM
   6LY/gS9Nl+hhgHuqjA+Dz72k/uFX/h7fw7iIp14Q5wwhq5rvohFEFmuys
   tm/4hoRiAYj6NrsE78DH9/aQM9gUNgs2a3goz1JNO30g0RGdYXT1jAbBk
   Bbrm4z0YXaL8/iwVdZFyMUBOEIZzS/1KW1t+afrKyBcjAPzrAC90eMVYq
   tl2iaQmwrKgDsrHmrxrNqNh6YHSW71hPamKWQywa0pdfkHodp68wnMEnd
   00qrLyBkVa7R0c5QiqfATd2lXgUOlrtmuo1wQ7Gh7Fq70KL1szfWCHp2Q
   g==;
X-CSE-ConnectionGUID: ftB+X+q6SamGV9uv0UNbIw==
X-CSE-MsgGUID: aAWvZeErRhy/DznBXE2kbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33420856"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="33420856"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:11:46 -0800
X-CSE-ConnectionGUID: dulZpdfURQ2v6FW0BvP97A==
X-CSE-MsgGUID: OjizZAeXS6aSN/08umbp9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="118403655"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:11:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tKiEP-00000005pQW-3jg9;
	Mon, 09 Dec 2024 20:11:41 +0200
Date: Mon, 9 Dec 2024 20:11:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] device property: fix UAF in
 device_get_next_child_node()
Message-ID: <Z1cy3YuFXY0unhsY@smile.fi.intel.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <20241128053937.4076797-2-dmitry.torokhov@gmail.com>
 <Z0huCS4Z7dkgpCQ8@smile.fi.intel.com>
 <Z0j5tGF9ikgVR_0w@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0j5tGF9ikgVR_0w@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 28, 2024 at 03:16:04PM -0800, Dmitry Torokhov wrote:
> On Thu, Nov 28, 2024 at 03:20:09PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 27, 2024 at 09:39:35PM -0800, Dmitry Torokhov wrote:
> > > fwnode_get_next_child_node() always drops reference to the node passed
> > > as the "child" argument,
> > 
> > As commented previously,it might be just a documentation bug. So, please
> 
> No, absolutely not. Consider calling device_get_next_child_node() with
> "child" pointing to the last child of the primary fwnode.
> fwnode_get_next_child_node() will drop the reference to "child"
> rendering it unusable, and return NULL. The code will go and call
> fwnode_get_next_child_node(fwnode->secondary, child) with invalid child
> pointer, resulting in UAF condition.
> 
> Also, consider what happens next. Let's say we did not crash and instead
> returned first child of the secondary node (let's assume primary is an
> OF node and secondary is a software node). On the next iteration of
> device_get_next_child_node() we will call
> fwnode_get_next_child_node(fwnode, child) which results in passing
> swnode child to of_fwnode_get_next_child_node() which may or may not
> work. It all is very fragile.

It seems some of OF calls will crash on this.

> That is why it is best to check if the child argument is indeed a child
> to a given parent before calling fwnode_get_next_child_node() on them.

> > elaborate on the use case before this patch that leads to an issue.
> > 
> > > which makes "child" pointer no longer valid
> > > and we can not use it to scan the secondary node in case there are no
> > > more children in primary one.
> > > 
> > > Also, it is not obvious whether it is safe to pass children of the
> > > secondary node to fwnode_get_next_child_node() called on the primary
> > > node in subsequent calls to device_get_next_child_node().
> > > 
> > > Fix the issue by checking whether the child node passed in is indeed a
> > > child of primary or secondary node, and do not call
> > > fwnode_get_next_child_node() for the wrong parent node. Also set the
> > > "child" to NULL after unsuccessful call to fwnode_get_next_child_node()
> > > on primary node to make sure secondary node's children are scanned from
> > > the beginning.
> > 
> > To me it sounds over complicated. Why not just take reference to the child once
> > more and put it after we find next in either cases?
> 
> You want to "reset" when switching from primary node over to secondary
> instead of hoping that passing child pointer which is not really a child
> to secondary node will somehow cause fwnode_get_next_child_node() to
> return first its child.

At some point we need to switch from primary to a secondary, yes, we need
to "reset" it somehow to switch the type.

> > Current solution provides
> > a lot of duplication and makes function less understandable.
> 
> The simplicity of the old version is deceiving. See the explanation
> above.


-- 
With Best Regards,
Andy Shevchenko



