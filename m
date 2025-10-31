Return-Path: <linux-acpi+bounces-18392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5599EC23CF1
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 09:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115573A1F73
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B432DF710;
	Fri, 31 Oct 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnVBXX1Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B43254B18;
	Fri, 31 Oct 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899042; cv=none; b=ad55ER+qWLTvULLY5P2GyJDNSRlVCW5NnaKpORYWXIGnN69yitIAFWRnsuoXPgsvaWk5R3exsFVZHPFxchfKTrF1EtxnabX/BQjam06wiRjSHozKsfb7XyD/INNPWyXeKyB0WEaL/9wevXe2MO5YMS9Sr4VvW76vu+XKDdpGgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899042; c=relaxed/simple;
	bh=iNeitY+jy/bxrj72/Zpk5k1d9UslaqD88+dmUtZte5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHOITlXy18gXsDOwkNy5w8Gu7VhFaaK37ZDJCPnAKBX4Ky51yvBYQlBPRTlzDMBEviezk2eJ7Vjt2zyxtz7cJOpehkszxPyBMiFQrjvjL84Oua/a0cHW0LCXEl+5MscEHASVjxGzA0Jxj8rFLOs2R5h4nK87nOnFgMqKg/qjx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnVBXX1Z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761899040; x=1793435040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iNeitY+jy/bxrj72/Zpk5k1d9UslaqD88+dmUtZte5k=;
  b=EnVBXX1ZQsYHthl0hG8L0cM0BGdkZD2l0HAyTYMeSvd1NWb5o5a5r776
   3o5HM/ZmhVZbdlFXBnmVZVDezsMJeNN0K7wM7Fq4ymFG5NDlX+paGbi30
   5Dk6+dmEN/ZSzG3RhewA6LYecnXDTbB0p7oWGyoKB+s2gVt6xaL2lDWGk
   X9HhmYZHZbEcKGdE91LLPbRWr3J4wSfnF+7Mp8kh+d65cOW6salmxEO5S
   jpFCl2Pac+dUwvkpKvEHtPF4UQoFuAnIYqZhMpU7JiB3LCp53X3ITBtpn
   LuJnU4VR0R0eO4xP/TUy4ybVREW+hlBbqm0bgk280PGGttO5S4ywZidYB
   g==;
X-CSE-ConnectionGUID: PJxVEbyeRFyyPdkDxxILaw==
X-CSE-MsgGUID: 5dA0s9W7SFGJ5W2cWW17gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="51627082"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="51627082"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:23:59 -0700
X-CSE-ConnectionGUID: rrF45/pJRDuOs+Lzjeoj/Q==
X-CSE-MsgGUID: S9HDMt2PQe6LDFeMtec76A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="223409521"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:23:57 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEkQI-00000004Cvo-2hZi;
	Fri, 31 Oct 2025 10:23:50 +0200
Date: Fri, 31 Oct 2025 10:23:49 +0200
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
Subject: Re: [PATCH v3 03/10] software node: allow referencing firmware nodes
Message-ID: <aQRyFSHWzccTPa3M@smile.fi.intel.com>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
 <aQMy00pxp7lrIrvh@smile.fi.intel.com>
 <CAMRc=MdP58d=o7ZL4bAdsaYwzrs6nJo3bhS7Jf1UkDNwPOnAsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdP58d=o7ZL4bAdsaYwzrs6nJo3bhS7Jf1UkDNwPOnAsg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 04:17:48AM -0700, Bartosz Golaszewski wrote:
> On Thu, 30 Oct 2025 10:41:39 +0100, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Wed, Oct 29, 2025 at 01:28:37PM +0100, Bartosz Golaszewski wrote:
> >>
> >> At the moment software nodes can only reference other software nodes.
> >> This is a limitation for devices created, for instance, on the auxiliary
> >> bus with a dynamic software node attached which cannot reference devices
> >> the firmware node of which is "real" (as an OF node or otherwise).
> >>
> >> Make it possible for a software node to reference all firmware nodes in
> >> addition to static software nodes. To that end: add a second pointer to
> >> struct software_node_ref_args of type struct fwnode_handle. The core
> >> swnode code will first check the swnode pointer and if it's NULL, it
> >> will assume the fwnode pointer should be set. Rework the helper macros
> >> and deprecate the existing ones whose names don't indicate the reference
> >> type.
> >>
> >> Software node graphs remain the same, as in: the remote endpoints still
> >> have to be software nodes.
> >
> > ...
> >
> >> -#define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
> >> +#define __SOFTWARE_NODE_REF(_ref, _node, ...)			\
> >>  (const struct software_node_ref_args) {				\
> >> -	.node = _ref_,						\
> >> +	._node = _ref,						\
> >>  	.nargs = COUNT_ARGS(__VA_ARGS__),			\
> >>  	.args = { __VA_ARGS__ },				\
> >>  }
> >
> > Okay, looking at this again I think we don't need a new parameter.
> > We may check the type of _ref_
> > (actually why are the macro parameters got renamed here and elsewhere?)
> > and assign the correct one accordingly. I think this is what _Generic()
> > is good for.
> >
> 
> Oh, that's neat, I would love to use _Generic() here but I honest to god have
> no idea how to make it work. I tried something like:
> 
> #define __SOFTWARE_NODE_REF(_ref, ...)                          \
> _Generic(_ref,                                                  \
>         const struct software_node *:                           \
>                 (const struct software_node_ref_args) {         \
>                         .swnode = _ref,                         \
>                         .nargs = COUNT_ARGS(__VA_ARGS__),       \
>                         .args = { __VA_ARGS__ },                \
>                 },                                              \
>         struct fwnode_handle *:                                 \
>                 (const struct software_node_ref_args) {         \
>                         .fwnode = _ref,                         \
>                         .nargs = COUNT_ARGS(__VA_ARGS__),       \
>                         .args = { __VA_ARGS__ },                \
>                 }                                               \
>         )
> 
> 
> But this fails like this:
> 
> In file included from ./include/linux/acpi.h:16,
>                  from drivers/reset/core.c:8:
> drivers/reset/core.c: In function ‘__reset_add_reset_gpio_device’:
> drivers/reset/core.c:958:52: error: initialization of ‘const struct
> software_node *’ from incompatible pointer type ‘struct fwnode_handle
> *’ [-Wincompatible-pointer-types]
>   958 |                                                    parent->fwnode,
>       |                                                    ^~~~~~
> ./include/linux/property.h:374:35: note: in definition of macro
> ‘__SOFTWARE_NODE_REF’
>   374 |                         .swnode = _ref,                         \
> 
> So the right branch is not selected. How exactly would you use it here?

I believe this is an easy task.

But first of all, your series doesn't compile AFAICS:

drivers/reset/core.c:981:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
  981 |         if (IS_ERR(rgpio_dev->swnode))
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/reset/core.c:1001:9: note: uninitialized use occurs here
       1001 |         return ret;
            |                ^~~
drivers/reset/core.c:981:2: note: remove the 'if' if its condition is always false
  981 |         if (IS_ERR(rgpio_dev->swnode))
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  982 |                 goto err_put_of_node;
      |                 ~~~~~~~~~~~~~~~~~~~~
drivers/reset/core.c:905:13: note: initialize the variable 'ret' to silence this warning
  905 |         int id, ret, lflags;
      |                    ^
      |                     = 0
1 error generated.

So, but to the topic

I have applied this and get the only error as per above

 (const struct software_node_ref_args) {                                \
 -       ._node = _ref,                                          \
 +       .swnode = _Generic(_ref, const struct software_node *: _ref, default: NULL), \
 +       .fwnode = _Generic(_ref, struct fwnode_handle *: _ref, default: NULL), \


-- 
With Best Regards,
Andy Shevchenko



