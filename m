Return-Path: <linux-acpi+bounces-16180-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55158B3BA0B
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 13:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEBF562190
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795372D5A10;
	Fri, 29 Aug 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2+N1yYe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC82D3725;
	Fri, 29 Aug 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467585; cv=none; b=ZxbonbrL/od/TPbF3/B5B0vDXGhgLbupnqrQZND2aGrNJITOOWRaFyxdUq5x1qwSi9/q+M67r8QkNaRWwixFEp34iyqYbFbZhOVCr8W1GJHF7gOcBneGYIke5WQHU4BHIruiADgHcrrtusXQFYlX4OpNbA3dI3/czL6W6m+vlZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467585; c=relaxed/simple;
	bh=CbhwLF5irTqC+PrHibkgukN+rKM+TtRpocqODCiBcfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG1Idjo5oQV5czHUoI2hmhd+TdnAa5p2ZwbH4nI5WbhUZXmKgSSa0vbuvzs996UqOVPd9LKRBSok944jT6GYXqZxghaoarYjXc0o+ZhJjTlgKLf0EWsp/r2cciDRjE/GcOBDcxgMLT85xEZ6MAPUYCTtlbF1NgCEjqgmDYQG5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d2+N1yYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95282C4CEF0;
	Fri, 29 Aug 2025 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756467585;
	bh=CbhwLF5irTqC+PrHibkgukN+rKM+TtRpocqODCiBcfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2+N1yYeS6xDBCuqwAgIEuGw7pSxUDt/97g6xZ/v8lfsxvIci330FF0qE47qfQmWu
	 KHcFhR2z1Y4y2pA9as/MuCdO1S3Ni3Q5q7Cm7ADY649lwgbUd81pZR2+0en3YIy6vC
	 5PH0fYdhzDdlzrN2c+joveTXk+5g9PpWBC84ghXs=
Date: Fri, 29 Aug 2025 13:39:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: Add scoped fwnode child node iterators
Message-ID: <2025082919-nebulizer-suitable-6b2c@gregkh>
References: <20250829021802.16241-1-jefflessard3@gmail.com>
 <2025082953-splendor-unsold-e4f2@gregkh>
 <AA99AF86-CD2A-4BBE-92BC-3D9005E7BA3B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AA99AF86-CD2A-4BBE-92BC-3D9005E7BA3B@gmail.com>

On Fri, Aug 29, 2025 at 07:34:17AM -0400, Jean-François Lessard wrote:
> Le 29 août 2025 00 h 23 min 22 s HAE, Greg Kroah-Hartman <gregkh@linuxfoundation.org> a écrit :
> >On Thu, Aug 28, 2025 at 10:17:59PM -0400, Jean-François Lessard wrote:
> >> Add scoped versions of fwnode child node iterators that automatically
> >> handle reference counting cleanup using the __free() attribute:
> >> 
> >> - fwnode_for_each_child_node_scoped()
> >> - fwnode_for_each_named_child_node_scoped()
> >> - fwnode_for_each_available_child_node_scoped()
> >> 
> >> These macros follow the same pattern as existing scoped iterators in the
> >> kernel, ensuring fwnode references are automatically released when the
> >> iterator variable goes out of scope. This prevents resource leaks and
> >> eliminates the need for manual cleanup in error paths.
> >> 
> >> The implementation mirrors the non-scoped variants but uses
> >> __free(fwnode_handle) for automatic resource management, providing a safer
> >> and more convenient interface for drivers iterating over firmware node
> >> children.
> >> 
> >> Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
> >> ---
> >> 
> >> Notes:
> >>     checkpatch reports false positives that are intentionally ignored:
> >>     COMPLEX_MACRO, MACRO_ARG_REUSE, MACRO_ARG_PRECEDENCE
> >>     This is a standard iterator pattern following kernel conventions.
> >> 
> >>  include/linux/property.h | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >> 
> >> diff --git a/include/linux/property.h b/include/linux/property.h
> >> index 82f0cb3ab..279c244db 100644
> >> --- a/include/linux/property.h
> >> +++ b/include/linux/property.h
> >> @@ -176,6 +176,20 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
> >>  	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
> >>  	     child = fwnode_get_next_available_child_node(fwnode, child))
> >>  
> >> +#define fwnode_for_each_child_node_scoped(fwnode, child)		\
> >> +	for (struct fwnode_handle *child __free(fwnode_handle) =	\
> >> +		fwnode_get_next_child_node(fwnode, NULL);		\
> >> +	     child; child = fwnode_get_next_child_node(fwnode, child))
> >> +
> >> +#define fwnode_for_each_named_child_node_scoped(fwnode, child, name)	\
> >> +	fwnode_for_each_child_node_scoped(fwnode, child)		\
> >> +		for_each_if(fwnode_name_eq(child, name))
> >> +
> >> +#define fwnode_for_each_available_child_node_scoped(fwnode, child)	\
> >> +	for (struct fwnode_handle *child __free(fwnode_handle) =	\
> >> +		fwnode_get_next_available_child_node(fwnode, NULL);	\
> >> +	     child; child = fwnode_get_next_available_child_node(fwnode, child))
> >> +
> >>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> >>  						 struct fwnode_handle *child);
> >>  
> >
> >We need a real user of this before we can add them, so please do that as
> >part of a patch series.
> >
> 
> I understand the "no dead code" policy, but I found existing manual
> implementations of this exact pattern in the current kernel.
> 
> For example, drivers/i2c/i2c-core-slave.c already does:
> 
> 		struct fwnode_handle *child __free(fwnode_handle) = NULL;
> ...
> 		fwnode_for_each_child_node(fwnode, child) {
> ...
> 		}
> 
> This suggests developers are already wanting this functionality but
> implementing it manually.

Great, then add it here and fix up drivers/i2c/i2c-core-slave.c to use
it!

thanks,

greg k-h

