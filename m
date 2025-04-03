Return-Path: <linux-acpi+bounces-12698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D3BA7A7B5
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5458F3AB3D7
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B3B2512C5;
	Thu,  3 Apr 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6QN2Q3W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C7223708;
	Thu,  3 Apr 2025 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696955; cv=none; b=L1XO+KLoPSmfw6DQ857HvQOFVbTYC0Edu6/ijB6lmdEG/GNTQcz1nyqEVsB9M3p7YPG9r6ugcdJCIplWRqAvJPgEi8usQOqpX/l2zLVWc9VqtI9rDAC/FWQOAjl3JDpHwt4n4pOnYK+nuJ2nwA1BhuDoDX3pxnB3D56ByxUKsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696955; c=relaxed/simple;
	bh=l7VRQc4+D3pijgVYYBAlonmqtfH0kadk7/t7vKZe+oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQQU+FFCw3GRMvfivoyU6nomR/jRlSEqOeeEDOA7+VdVGz9nZrChIW9Xgl/hjEIfCtd7WKoNcrHiO0QboIVSy3djw2CoqxJJoLPzOvTu0DGEDWsYzX+EeeQoo0t9KSpUkG5gWqQei/ejzGFqsAu64cAZ8QdvFn6QiopOSNfGVTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6QN2Q3W; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743696954; x=1775232954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l7VRQc4+D3pijgVYYBAlonmqtfH0kadk7/t7vKZe+oc=;
  b=Z6QN2Q3W2djZZUN6RkoHSAsQ3V5LhiaQ7nM2XsuWmd2c0YOWdsGJtvi6
   pLmPQCErJioC2hFms2NOq2UUGpIiA7Bd+M76EpXJV5a0f0FmZYlifX650
   hFNweWYv1XaFk3uePE4Cr24x3vUu346ntKCfdo1SlHs6ChdFlkHOIy3pd
   SZdrvBNvH+jdGwk/qM4xb8NGxjpRTEuNLLt0MUo/vxDiFDNOvzYyLs6xl
   CDYKAFngIJYu+Qu787a1e6q/BYa0ePdzQKOjoPYOuqI85evC8VvcnfB/S
   YvlXM/yp+1m1ADYwK9YsLra5EYdoAswvVQfv5yyY41tg57r88Hn4TH+hf
   A==;
X-CSE-ConnectionGUID: C5netHwSTqGJch/iJQ3L+Q==
X-CSE-MsgGUID: HYb6Pj4ZRv27Edv4punGQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45291984"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="45291984"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 09:15:53 -0700
X-CSE-ConnectionGUID: rfQgWugaR7eN4AAKRAVm4g==
X-CSE-MsgGUID: BIL/yz7aSdKNRI61mr1xdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="132258563"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 09:15:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0NEF-00000008rev-3zvn;
	Thu, 03 Apr 2025 19:15:43 +0300
Date: Thu, 3 Apr 2025 19:15:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Remo Senekowitsch <remo@buenzli.dev>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 03/10] device property: Add
 fwnode_property_read_int_array()
Message-ID: <Z-60LwRrw30cq4YE@smile.fi.intel.com>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
 <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 11:04:32AM -0500, Rob Herring wrote:
> On Thu, Mar 27, 2025 at 3:41 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
> > > The rust bindings for reading device properties has a single
> > > implementation supporting differing sizes of integers. The fwnode C API
> > > already has a similar interface, but it is not exposed with the
> > > fwnode_property_ API. Add the fwnode_property_read_int_array() wrapper.

...

> > > +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
> >
> > I'm not sure about this. We have a lot of assumptions in the code that the
> > arrays beneath are only represented by the selected number of integer types.
> > This opens a Pandora's box, e.g., reading in u24, which is not supported by
> > the upper layers..
> 
> We can probably drop the export if it is just that which you object to.

Yes, this is main point, but dropping it does not prevent from still using in
the complied-in code. Is it possible to hide it better?

> Without this function, the implementation is just multiple levels of
> switch statements to work-around what's needed for the nicest rust
> API.

-- 
With Best Regards,
Andy Shevchenko



