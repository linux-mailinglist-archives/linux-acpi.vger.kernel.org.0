Return-Path: <linux-acpi+bounces-12510-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC5BA73CB7
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 18:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6A3189BED1
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6F7218E9F;
	Thu, 27 Mar 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D840APvf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D191A3150;
	Thu, 27 Mar 2025 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097756; cv=none; b=itsp95FSskg1a1IH/30eO4GiWVdgHni2fe2yPwl+/EiihRfaYmM139J+SW2VoZ+9tkNm00lzKs02QHUjwWvtMOEgWCs71wCLZseCm0NHLz6mr1dES0bLRDd1ZPpPF6OuRTiX5kYjg1XWoMnscdQib7ArotJ0CRcefUAVNMtQjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097756; c=relaxed/simple;
	bh=HQ/FzZVtjQERReDmzXONMLGbORUdtOvwHc5UTpdvpxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlVIMWg1ii3JGEEhNV4kOCHG/g0YYe9mKad7vNa+bF3sbllc+LpZ8w8osrqt3x/iPqO1cA8bu98wBKBQOPvuZKG8WnbG8FwAAbgTMvqXpz3GJThxtziDUFjSiaz2pu7gfnqDT/zCrvJ20ydKqPgytnj0moG48BY4tpbzwFQw2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D840APvf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743097754; x=1774633754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HQ/FzZVtjQERReDmzXONMLGbORUdtOvwHc5UTpdvpxc=;
  b=D840APvfNVSXm4ML9mH/yW2c/f8mfBO4jJ+RMy88vTOtwiV4JMO9hmzB
   1Pa0P9S6CD4IhoLF4KP9YcqCk3IgTLQZZvJ75XjZieVUyUoeJhlx5QVmO
   EAG80NO6NJXbWWbuTfK35EGfiZ0dJiSufItcpmhj8mUSeWbl3GDLpYFYn
   Aw1Tk56Fi/2pqMv1Y/n1g2fapGeUqPN5EWLJABADshAPrNK67okmd/P2N
   oUZiLcLfptRBK7oAqtkZYweSlvyYLMBa7i8G8ifN06gOoAyJ2dpwvpPEU
   y+COob7U82PZMEw+1E+lWgtZsN9Op/7gdCzfpiiVQB63tECXli+gSbUrV
   A==;
X-CSE-ConnectionGUID: qHBuWnODSMGnhEV96QDATg==
X-CSE-MsgGUID: FaI1B/9ySC6cEah4FN1X5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="66917216"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="66917216"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:49:14 -0700
X-CSE-ConnectionGUID: ysmv07ksQC2FCgRw2Cr6Cw==
X-CSE-MsgGUID: YS9fTSY5RcyHPGEzYIJgpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="148393660"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:49:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1txrLl-00000006VGp-16M8;
	Thu, 27 Mar 2025 19:49:05 +0200
Date: Thu, 27 Mar 2025 19:49:05 +0200
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
Subject: Re: [PATCH 01/10] rust: Move property_present to property.rs
Message-ID: <Z-WPkSJRO6_SrOz-@smile.fi.intel.com>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-2-remo@buenzli.dev>
 <Z-UOUKq8GKZM1wuo@smile.fi.intel.com>
 <CAL_JsqKY17zfLo5rUd9zvO46M1_dR0-V1X-d-NmsO+exDbGY5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKY17zfLo5rUd9zvO46M1_dR0-V1X-d-NmsO+exDbGY5A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 27, 2025 at 08:55:42AM -0500, Rob Herring wrote:
> On Thu, Mar 27, 2025 at 3:37 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Mar 26, 2025 at 06:13:40PM +0100, Remo Senekowitsch wrote:

...

> > > +struct fwnode_handle *rust_helper_dev_fwnode(struct device *dev)
> > > +{
> > > +     return dev_fwnode(dev);
> > > +}
> >
> > Why not const? For most of the property retrieval APIs the parameter is const.
> 
> Because you might need to modify the refcount.
> 
> Though the rust code should probably use __dev_fwnode() and/or
> __dev_fwnode_const() directly and avoid the need for the helper here.

Indeed, that would help at least to understand the intention.

-- 
With Best Regards,
Andy Shevchenko



