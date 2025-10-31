Return-Path: <linux-acpi+bounces-18394-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E73B1C23D62
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 09:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79A844F4EFA
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9702D47F5;
	Fri, 31 Oct 2025 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXyIi2vX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A42D6E6E;
	Fri, 31 Oct 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899459; cv=none; b=AemIcgIK4EM78q9F+PNk8Q8B6MvS0ro0en3pkoVFmtD5K+ENcXWjnHiIeaMihUc2ZKerX2oTFVfQP9/Y4sptdIwpNbVQMcTJL9z0XnaB37nj4OOBTMyFjEk7vG+MGgQnnEQNjrtp1x5uWZNPqTpPHaCeGFGvkxUqKKW4QzxUw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899459; c=relaxed/simple;
	bh=Xh8tWIUHv3j/DCmIBgO9QEjcm9WyoIDhq2xE8ObAHoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCrwixKwthZqS3pV+BHdxcPJOayUf1PdroRzhUPn+w2hW/Va8jg5XCWDGDgpy46SdEm4zYtcuVUOiFwoX7r319UZgQxsntV5I8hMblrGxiU1FYxOPrUvUCXn1TcgW/o66Zvy4O8T8Z/p+L2+Nm5zJ7EsgjrRqvtV3shlYjM/gFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXyIi2vX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761899457; x=1793435457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xh8tWIUHv3j/DCmIBgO9QEjcm9WyoIDhq2xE8ObAHoo=;
  b=gXyIi2vXGFrRThuLslnLhfrtokFgGPs2hs+lNL3O09nawuroEPypnHf5
   GoEPvUd1ofUnmRBwBK7Jsc0ovh3W5QCQk8CHLDr5U46NUCTlghs8TEeJl
   n5CwFPvmhoH22Ej6ZwhKia/4wkIRCtdXbGdeVX8L4L5hrCszlnMQRnC4a
   hxFlmFY56qRTAPqexo6Fk9rZ0BdkmkBtuM8pbRk6HzJXxDDrojna/BnNr
   iu5eMUHd6CB5P9V+x6L7NGLciES83n59O4eNMwIqB1/LLUwjjPv2M6nEM
   4bqup47EHkYKN6DA6CGjD2DUqXHT4JEg+q2ad6pb2Cx03ve2XBDlqdwOk
   w==;
X-CSE-ConnectionGUID: XHek2SXjRWCZAkoXzA4r7A==
X-CSE-MsgGUID: Bavm9zpHREydJ0TSZh3M8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="89519738"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="89519738"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:30:57 -0700
X-CSE-ConnectionGUID: 5MO/jTVdRdumF9aGiIXU4g==
X-CSE-MsgGUID: xQ4VzNAzTkurEuMfbw1Now==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="185866335"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:30:54 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEkX2-00000004D0w-2sGt;
	Fri, 31 Oct 2025 10:30:48 +0200
Date: Fri, 31 Oct 2025 10:30:47 +0200
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
Subject: Re: [PATCH v3 02/10] software node: increase the reference of the
 swnode by its fwnode
Message-ID: <aQRztwrOFCWk8IG8@smile.fi.intel.com>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org>
 <aQMxNgC9SWQp-yUy@smile.fi.intel.com>
 <CAMRc=Md=Dcwj0qDu5ysDafjuV0Ud9z2Ky3PQpDzfiKRt2L-HgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Md=Dcwj0qDu5ysDafjuV0Ud9z2Ky3PQpDzfiKRt2L-HgQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 03:33:02AM -0700, Bartosz Golaszewski wrote:
> On Thu, 30 Oct 2025 10:34:46 +0100, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Wed, Oct 29, 2025 at 01:28:36PM +0100, Bartosz Golaszewski wrote:
> >>
> >> Once we allow software nodes to reference other kinds of firmware nodes,
> >> the node in args will no longer necessarily be a software node so bump
> >> its reference count using its fwnode interface.
> >
> > Same, a short comment (or an update of a kernel-doc if present, I don't
> > remember).
> >
> 
> Andy: the resulting code after patch 3/10 looks like this:
> 
> struct fwnode_handle *refnode;
> 
> (...)

Let's say something like below to be put here

/*
 * The reference in software node may refer to a node of a different type.
 * Depending on the type we choose either to use software node directly, or
 * delegate that to fwnode API.
 */

> if (ref->swnode)
> 	refnode = software_node_fwnode(ref->swnode);
> else if (ref->fwnode)
> 	refnode = ref->fwnode;
> else
> 	return -EINVAL;
> 
> if (!refnode)
> 	return -ENOENT;
> 
> if (nargs_prop) {
> 	error = fwnode_property_read_u32(refnode, nargs_prop,
> 					 &nargs_prop_val);
> 	if (error)
> 		return error;
> 
> 		nargs = nargs_prop_val;
> }
> 
> (...)
> 
> args->fwnode = fwnode_handle_get(refnode);
> 
> I'm typically all for comments but this code really is self-commenting.
> There's nothing ambiguous about the above. We know the refnode is an fwnode,
> we assign it and we pass it to the fwnode_ routines. What exactly would you
> add here that would make it clearer?

See above.

-- 
With Best Regards,
Andy Shevchenko



