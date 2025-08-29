Return-Path: <linux-acpi+bounces-16165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E97B3B21A
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 06:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C65565EAF
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 04:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD878635B;
	Fri, 29 Aug 2025 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uth4TT9R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1AB8821;
	Fri, 29 Aug 2025 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756441406; cv=none; b=Zr7ss226axu2ZkPs0oAMs+SELm9/8/ElKLFTKaA88WWtZErCk684qZFqZz9n6/IgN4y60Olojx+8QF0j++1OJEeE1Zl3uOkF8CXhpcOdiY6G7upQeyIgupV5Xq/8z+OMgEOYpWUCb9p8+vySqT7Mu/QbIui+nzpXNOHxLSPyHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756441406; c=relaxed/simple;
	bh=T9LMVgGcKV1Pl4nv8nPVa+Y3TUkwZBT3XArHw1YhQwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1Uw8Ngnc/qBTVB1jHlZROn2CQ6m1oSgi9sZMbsVlAWIRwWtZnHVYBIn13WInhYE4iAeAxK+/z141QiLGkQvP3nDPAi4mpgn0tpccSE1rhMDvGx1302J+P6Xj9sK2OaSAOmEsPTq1X1TJ4330ZxRC27WjFV306q9+FqQFYCHmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uth4TT9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3C9C4CEF0;
	Fri, 29 Aug 2025 04:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756441406;
	bh=T9LMVgGcKV1Pl4nv8nPVa+Y3TUkwZBT3XArHw1YhQwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uth4TT9RMBqheGxNHOLlG+gah+0ELGAvawFgO39ue4OpAIt3wJ1u2KFCPRj4M0VqP
	 cv/x8KmSe9bhItEL+/7Mu0hU8Uix2sEwJfbR/CemowOA8sJBdnBPoFTZs6zR4gUEDK
	 rtIQ0KJ/KEB4pDrlvf2mifj0j+fTV/SfZ9B0FtkE=
Date: Fri, 29 Aug 2025 06:23:22 +0200
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
Message-ID: <2025082953-splendor-unsold-e4f2@gregkh>
References: <20250829021802.16241-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829021802.16241-1-jefflessard3@gmail.com>

On Thu, Aug 28, 2025 at 10:17:59PM -0400, Jean-François Lessard wrote:
> Add scoped versions of fwnode child node iterators that automatically
> handle reference counting cleanup using the __free() attribute:
> 
> - fwnode_for_each_child_node_scoped()
> - fwnode_for_each_named_child_node_scoped()
> - fwnode_for_each_available_child_node_scoped()
> 
> These macros follow the same pattern as existing scoped iterators in the
> kernel, ensuring fwnode references are automatically released when the
> iterator variable goes out of scope. This prevents resource leaks and
> eliminates the need for manual cleanup in error paths.
> 
> The implementation mirrors the non-scoped variants but uses
> __free(fwnode_handle) for automatic resource management, providing a safer
> and more convenient interface for drivers iterating over firmware node
> children.
> 
> Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
> ---
> 
> Notes:
>     checkpatch reports false positives that are intentionally ignored:
>     COMPLEX_MACRO, MACRO_ARG_REUSE, MACRO_ARG_PRECEDENCE
>     This is a standard iterator pattern following kernel conventions.
> 
>  include/linux/property.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 82f0cb3ab..279c244db 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -176,6 +176,20 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>  	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
>  	     child = fwnode_get_next_available_child_node(fwnode, child))
>  
> +#define fwnode_for_each_child_node_scoped(fwnode, child)		\
> +	for (struct fwnode_handle *child __free(fwnode_handle) =	\
> +		fwnode_get_next_child_node(fwnode, NULL);		\
> +	     child; child = fwnode_get_next_child_node(fwnode, child))
> +
> +#define fwnode_for_each_named_child_node_scoped(fwnode, child, name)	\
> +	fwnode_for_each_child_node_scoped(fwnode, child)		\
> +		for_each_if(fwnode_name_eq(child, name))
> +
> +#define fwnode_for_each_available_child_node_scoped(fwnode, child)	\
> +	for (struct fwnode_handle *child __free(fwnode_handle) =	\
> +		fwnode_get_next_available_child_node(fwnode, NULL);	\
> +	     child; child = fwnode_get_next_available_child_node(fwnode, child))
> +
>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  						 struct fwnode_handle *child);
>  

We need a real user of this before we can add them, so please do that as
part of a patch series.

thanks

greg k-h

