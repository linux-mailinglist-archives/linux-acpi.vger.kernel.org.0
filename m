Return-Path: <linux-acpi+bounces-12490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F831A72B9C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 09:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634B83B706C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555302080C5;
	Thu, 27 Mar 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3t/pveb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB70207E1A;
	Thu, 27 Mar 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064668; cv=none; b=N848TtIqzJZQNr5KA17xLHAO6PJ5Phq0V9Q3109cQi3jhV3s0JhrWDG2sEw8Mjqn525yrHDtlBOpkNN981JJ7cHlF7UiMo1crVFJeQ0KgPFU60bkPF3jV+YlJ9h8xB7zA/l+Pc/p9kO9GX8Q1Yb8jTGDy4jp5OlTt2DAnBrjMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064668; c=relaxed/simple;
	bh=fvNCk8mWPbYbqIm9YLpQcvKGz7nO0wU4sub/wgDHloM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToGKK1oKCdmI7aE+YkcXK+kubni16LjTzFnbUJq+Q+4U0FyZMHmNArBrYT1sq1M4evMJQh3r8cbEvQOCsKIDewoOIRaspyFodh2yt6m1f5wos11SQ6TjSUk9hehmtba68L2Itjcy85CkTI5CuprOQZ1aKbmvjRO/mQM+PRdZaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3t/pveb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743064667; x=1774600667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvNCk8mWPbYbqIm9YLpQcvKGz7nO0wU4sub/wgDHloM=;
  b=m3t/pvebAR7wptMyScWtTmBKhRZYneucHvDtd2fcns/V3Z8F6fuRrMwu
   Wz4qpyiLuFv9MhMCDuvtzoF9mIp0+9EdSg7OYmZY/H/HEb91QhiNCmxVa
   1fVnFq9OyPpmfQ+cXxr9LU7BJeHKdBZ4lFowPDpkj80wmrVnOGmWrRthp
   Hapq5i/wDjYkJ4DwsOpk/SrilKtSBy4xta5NGJ3R7cL5i60r3xwmLAQKW
   7XIF+JVClyiF9SY87bGuV9EpF4XpUI913jP6AIdKdT/6ViafDqm24EPV9
   goW+OCDJ+Uyq2tPnkbSCa7+XyYk1SHt5hfRUuu+XAmw7z3pNq2qi85iAE
   w==;
X-CSE-ConnectionGUID: icQfVMQPQs6JAn7o17gQYg==
X-CSE-MsgGUID: A580wrFnQ3+j+70VIOavJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="66852908"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="66852908"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 01:37:46 -0700
X-CSE-ConnectionGUID: imB5jEJOQ/Gcy44BQuru+w==
X-CSE-MsgGUID: GhLbc/iSQhKIDv2K52yJdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="129918508"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 01:37:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1txik5-00000006KZB-0xsF;
	Thu, 27 Mar 2025 10:37:37 +0200
Date: Thu, 27 Mar 2025 10:37:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Rob Herring <robh@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>,
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
Message-ID: <Z-UOUKq8GKZM1wuo@smile.fi.intel.com>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-2-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-2-remo@buenzli.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 06:13:40PM +0100, Remo Senekowitsch wrote:
> Not all property-related APIs can be exposed directly on a device.
> For example, iterating over child nodes of a device will yield
> fwnode_handle. Thus, in order to access properties on these child nodes,
> the APIs has to be duplicated on a fwnode as they are in C.
> 
> A related discussion can be found on the R4L Zulip[1].
> 
> [1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/DS90UB954.20driver.20done.2C.20ready.20to.20upstream.3F/near/505415697

You can make the above to be a Link tag like

Link: ... [1]

> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>

...

> +struct fwnode_handle *rust_helper_dev_fwnode(struct device *dev)
> +{
> +	return dev_fwnode(dev);
> +}

Why not const? For most of the property retrieval APIs the parameter is const.

-- 
With Best Regards,
Andy Shevchenko



