Return-Path: <linux-acpi+bounces-4170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10118758F8
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 22:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6922AB2247E
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B90651B9;
	Thu,  7 Mar 2024 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dEzV6Mlt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9C2376A;
	Thu,  7 Mar 2024 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845360; cv=none; b=ebiwvh624F0SiH6sLxKtL7SAdTiyAHplzR2fAjP4I99XvAF6bGLjg97KmaRWdldEXYiIXvKyP0UiDdoMM9Y78gTEfa/7IfI+fJMQ4wT85VT/bUat127Azm7VkLWXbdppMYCRiptcIS35FRVg8ZLUHS4lhghJrn6wRFBEF4zAsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845360; c=relaxed/simple;
	bh=eu+RNQH2/4O10Zw3NcoKSSqNVhU7rkqGoBQPn+s4Mtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6z3SBsXxdUMBe8Vd9lso3bgnKkg04aTIpDQJcQ/EtQog87RcClMh7fTE9dx9nL23BVPDPdpnUOjAXpCKThZBMiNx1t+OSnI3BSfTSSspy2SB48y6ZXvKMD0fBL8GhsK/CV8zY0CrZLh5NjvSZME4R4vCHUrKNbpGDd2St2No9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dEzV6Mlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF70C433C7;
	Thu,  7 Mar 2024 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709845359;
	bh=eu+RNQH2/4O10Zw3NcoKSSqNVhU7rkqGoBQPn+s4Mtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEzV6MltWttzj5FJTWY+yJyodDei8ViBbTpI4Xppr+9tWalDmAOinOg61OQQQfbOh
	 9xnmcCQQp3yEEsglzoLs61TFk/0kiVHHr7O2wjC12aUUamN5oYpuh9oYr+5PGdU4yG
	 jDJxWpnDfV8chx5HOlbKRSBQO7M+/S3fQCXZP4C4=
Date: Thu, 7 Mar 2024 21:02:37 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, rafael@kernel.org
Subject: Re: [PATCH v6 02/12] base/node / ACPI: Enumerate node access class
 for 'struct access_coordinate'
Message-ID: <2024030729-ditch-stung-62ca@gregkh>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
 <20240220231402.3156281-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220231402.3156281-3-dave.jiang@intel.com>

On Tue, Feb 20, 2024 at 04:12:31PM -0700, Dave Jiang wrote:
> Both generic node and HMAT handling code have been using magic numbers to
> indicate access classes for 'struct access_coordinate'. Introduce enums to
> enumerate the access0 and access1 classes shared by the two subsystems.
> Update the function parameters and callers as appropriate to utilize the
> new enum.
> 
> Access0 is named to ACCESS_COORDINATE_LOCAL in order to indicate that the
> access class is for 'struct access_coordinate' between a target node and
> the nearest initiator node.
> 
> Access1 is named to ACCESS_COORDINATE_CPU in order to indicate that the
> access class is for 'struct access_coordinate' between a target node and
> the nearest CPU node.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

