Return-Path: <linux-acpi+bounces-14666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B07DAE938C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 02:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9357B0E8A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D32618DB1F;
	Thu, 26 Jun 2025 00:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c6lo9Rup"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C551494A9
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 00:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750899314; cv=none; b=D/gvBueCAjhKr4rhOwn7rYN5iW2MdsiWO1gKCcCFpAEbu0azEduQ3Y64GTnHRIZxW38GboJwW/FxS2HpHor3OJ1HKl3bG1T28LvHMqg+rdrJhWd3HW+BEfoRcvEVZMv3v8HMS4SVps+Ne9P5HqsYZYuNu8+kIexEcWcTb1yhJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750899314; c=relaxed/simple;
	bh=oihTkeYSM3F2FJv2FCUK9bfx7uScQ8QpK4/Isp4GQeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQBLFAnVl5duNxaI+DN48kKQpCcya7f7d7czKAnNb9ugMsN2+74tfQBHYWZqlp3XqU4OoJYBcmIZ6SPKUhBDRyUv9LBm1ubC0fPB7Tu7MlWS/lvlMkzZYK8tujMjGYe76PcBXyNhWTk7Y/S35PWrF/q16XlWbBCk3rsPpiTwt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c6lo9Rup; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Jun 2025 20:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750899309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5q54Sayz71e1LNZ1+orW1d57JU8r4ylgMOb6QLaulnM=;
	b=c6lo9Rup2DNUlQEiGvgzY65qQXV3X1mQ0bz3PU15ucLOnOsJwfLnKd8TUtt0I1ilI6GdYj
	VpMC2XHvFWwXM35xA9llh2WLBqMdKUwxwpWfGbGD4cZHGLUO/NYFjTo5N8fXNnELSFiQrT
	A6qSJI5rXPReqtE8NMA/dCGAe2W5lYg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Marc Herbert <marc.herbert@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Benjamin.Cheatham@amd.com, 
	Jonathan.Cameron@huawei.com, dakr@kernel.org, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, 
	rafael@kernel.org, sudeep.holla@arm.com, Dan Carpenter <dan.carpenter@linaro.org>, 
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <p66tblbusj2uw4q35nytnangb7z5ziyrkenl67hjgfsatw3fdj@odgdtnzk7at6>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh>
 <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
 <2025061546-exile-baggage-c231@gregkh>
 <bcd3848d-54dd-453e-b0b5-91cb72160645@linux.intel.com>
 <6853586e9d366_1f9e10087@dwillia2-xfh.jf.intel.com.notmuch>
 <206ebae8-4e2d-4e04-8872-fa3a56b3e398@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206ebae8-4e2d-4e04-8872-fa3a56b3e398@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 18, 2025 at 08:33:27PM -0700, Marc Herbert wrote:
> 2. Are C99 declarations acceptable.

To comment on this one, since I was linked - I'd say there's definite
pros and cons to C99 declarations to be aware of

pros:
- not separating the definition and the assignment is better style, and
  does lead to a reduction in bugs
- discourages reusing the same variable for multiple purposes, better
  and more readable code

the big con:
- they interact badly with gotos, you can get undefined behaviour from
  using a variable that wasn't actually defined _and the compiler will
  not warn you_

So, same issue as __cleanup.

There are no downsides to c99 style for loop declations that I've ever
seen, and we have seen definite cases where using those would have
prevented bugs.

But the issue with gotos is worth highlighting. Be careful when using
them in code that hasn't been converted to __cleanup.

