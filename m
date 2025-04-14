Return-Path: <linux-acpi+bounces-13034-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F88A88C02
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 21:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC353AF9F2
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C4E28BAA0;
	Mon, 14 Apr 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ9nlmw2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9918BC3B;
	Mon, 14 Apr 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658099; cv=none; b=Xj3QTesfI1avPDqFT8cuZ5d3x/SfaeNforCkZ9djM1dLrE3nf1DKpmD+l7bl6+lUXRXfJZ7yqGNVK2kRVpz3qWHv7szoSuBZ5G58iTgTyl6SimvSvKdbWEJ23HLMU4IEXXDE2qZkhBGI0N72AVeSyU8ovVx6hNY8Y6z2M+u6p6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658099; c=relaxed/simple;
	bh=d6bsR5l7cg9Y5z2eVE/tx/vMQBEe8OgypU34VvTet8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/w5JIHdm0offxd7245W98Bahky9Jgw572vj9e5FF9kHkx2KiLxheBaXgnxCqmEk6235SeuQgD0SJ/3Zd5GvINUc9lN1dDtFzIC8bHiV9Tuun/Fu3ya6KXw2NetJ09LJWH6kKcR/3Q6cRDEXZN3ptWKEuvGcof3HDTEOlmLP01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ9nlmw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B2AC4CEE2;
	Mon, 14 Apr 2025 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744658099;
	bh=d6bsR5l7cg9Y5z2eVE/tx/vMQBEe8OgypU34VvTet8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZZ9nlmw2MvpBPOy5qbcCVnza5uH33dxy7y4iBkRc4v6Y2/GMmgxjPS6ANIZTErwGU
	 EcJ+hPsfWLdLMA7OCBgRfv4fMrHlf+CoQdzCHc/Gnh2J7LJ54xRoUhLywtr2by8K+2
	 zMmn+wWc9+0brKBDOm2YUTtmIxzvGbN4ZW9C+5lhz6OUYjtGt8sd/z1KcB6B9ShF15
	 o9MBWJ7f2b7fxE16tH0ahFOrNpi8bH9eK5hHMueUpvSEdHlOr2Ykz7pWUxALEpa1Kv
	 G0uB7D5ByWVM9Z2P0VYKPiRsDaPD3+wa+SEWUiiFiLVXTUr5rOIvxkUk67I1NsCPLm
	 1gaw/NEx7XPjA==
Date: Mon, 14 Apr 2025 20:14:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] property: Use tidy for_each_named_* macros
Message-ID: <20250414201450.43fb8d9c@jic23-huawei>
In-Reply-To: <Z_yvkKTgI4XSlGya@smile.fi.intel.com>
References: <Z_ew4DN0z71nCX3C@mva-rohm>
	<Z_yvNl23GcEpOkK1@smile.fi.intel.com>
	<Z_yvkKTgI4XSlGya@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 09:47:44 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 14, 2025 at 09:46:14AM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 10, 2025 at 02:52:00PM +0300, Matti Vaittinen wrote:  
> > > Implementing if-conditions inside for_each_x() macros requires some
> > > thinking to avoid side effects in the calling code. Resulting code
> > > may look somewhat awkward, and there are couple of different ways it is
> > > usually done.
> > > 
> > > Standardizing this to one way can help making it more obvious for a code
> > > reader and writer. The newly added for_each_if() is a way to achieve this.
> > > 
> > > Use for_each_if() to make these macros look like many others which
> > > should in the long run help reading the code.  
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Thanks for cleaning these up!
> >   
> > > ---
> > > The patch was crafted against the IIO/testing branch, and it depends on
> > > the 76125d7801e5 ("property: Add functions to iterate named child").
> > > Hence I'd suggest taking this via IIO tree (if this gets accepted).  
> > 
> > I'm not sure why. The for_each_if() is part of v6.15-rc1.  
> 
> Ah, I see, you are trying to fix newly introduced stuff? I would rather suggest
> to make this straightforward against the current upstream and ask Jonathan to
> rebase the testing to fold the fixes into a new APIs.
> 

Or we just do this next cycle maybe.  Definitely not going to take anything
through IIO that hasn't been on the iio list btw.

Jonathan

