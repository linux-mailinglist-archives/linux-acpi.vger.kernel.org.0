Return-Path: <linux-acpi+bounces-18359-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C46C1F523
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 10:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4651E4E59F8
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6634164B;
	Thu, 30 Oct 2025 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muo6QcSh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECC34028D;
	Thu, 30 Oct 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816818; cv=none; b=f0aUsCAtAkr74HnxO0ICUr9+9WyglPazXubO+y8dm3s/2T0DgLJAFVrWJEYGNKSVhK4/a/oVUC6k0ummUIOeDjPTwK4gyBpeiIRQuS+6tQthB4AkPAGgcjhtRNghiv9jG6B4OJ/Ij23ofwQHW+A8muTu3lSGyV3eAVsdEz5xXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816818; c=relaxed/simple;
	bh=iUzaj/HC8cI0ED6gbD+JxBUi5KPlIooYnQCOqA8856Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAQxjK5AHghpAPumwVjE0D96NYn6SPkaHL9gayxyuEqyePTTBohUkmBdlbuOn1N1on60xhq/aOhladhgQ0VhmBq45W+NKOtmQ78PT6yyLK50Hql4iaLY5FEV7e8qUSKgM+jRAmCvwxG/cUyv1t/e/G2ak/CLBi4wVgBLIU0nHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muo6QcSh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761816817; x=1793352817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iUzaj/HC8cI0ED6gbD+JxBUi5KPlIooYnQCOqA8856Y=;
  b=muo6QcSh6TgqNCNyjSEBpItYP0R0vBH39QNRsdBvXuKbgMifXpeLSRzr
   jl+FcUeiZydJ8/JJy7eJCakZvdHuo+qyagyuKHfHO0uajVuTpYjeeil30
   3xPOnV4djhOo01tAGfYsi2yR8rQlzJJyIYQVbVGrfEEy1VNa0qH4eGyve
   m6Ev4WB1u1aZTB+8xY42yfDLLxqvBICW+E1jSjOsDlIGMWuZNl97bQChC
   3/dqzyBJW7aYn9VqeSkSmtERVw2UdP574zgUVOnLc1SrO3vO3PtWTYzza
   GPveU4ruNml4hk/paQ6TD52K7oxjHtFN4n10VPEgq/bVA2H1rFKJ9WzUq
   w==;
X-CSE-ConnectionGUID: yaAuaB8nSjezKlZkKCubVg==
X-CSE-MsgGUID: pIF4e7roTKmaKCvSMOnKnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75073348"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="75073348"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:33:28 -0700
X-CSE-ConnectionGUID: 6uxt4iFzR0OrZ3aeQApLDA==
X-CSE-MsgGUID: a4xHlyO0S2eOkT/56V+emQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="216567635"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:33:24 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEP20-00000003rKs-2B90;
	Thu, 30 Oct 2025 11:33:20 +0200
Date: Thu, 30 Oct 2025 11:33:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 01/10] software node: read the reference args via the
 fwnode API
Message-ID: <aQMw4ID6W3bouX9b@smile.fi.intel.com>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-1-638a4cb33201@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-reset-gpios-swnodes-v3-1-638a4cb33201@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 01:28:35PM +0100, Bartosz Golaszewski wrote:
> 
> Once we allow software nodes to reference all kinds of firmware nodes,
> the refnode here will no longer necessarily be a software node so read
> its proprties going through its fwnode implementation.

As pointed out in previous reviews this would have benefit of a short comment.
explaining the indirect call to read an array.

...

>  	if (nargs_prop) {
> -		error = property_entry_read_int_array(ref->node->properties,
> -						      nargs_prop, sizeof(u32),
> -						      &nargs_prop_val, 1);
> +		error = fwnode_property_read_u32(refnode, nargs_prop,
> +						 &nargs_prop_val);

It can be one line now. We are not fanatics of 80 limitation. :-)

>  		if (error)
>  			return error;

-- 
With Best Regards,
Andy Shevchenko



