Return-Path: <linux-acpi+bounces-18361-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B59FC1F5C5
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 10:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9F2D4E8AC9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D818343D6F;
	Thu, 30 Oct 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKUul9Cv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62901342170;
	Thu, 30 Oct 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817308; cv=none; b=OqDBWIx9mDXeFYExKhMoFGDUDh+qlqkaWMIrUU3ew0jeUivmNu5lquZ7MZFfWpXy9D9oI04ZLqGnXQJUs9PO8sobWeNlxzn7HIIc19sn3jiji4LmgWSCWII2ghp4NJvKVaOfM+6Sz7pNtiVi/uQrEZy7bkVolJhX9heEd+3NJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817308; c=relaxed/simple;
	bh=96f0HHie9Rype+AxiSlvXgHs8dSjnSUG9UaN5uQtgCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKaylB9im5D/X2BYsMFPLT6a735dMl343bentIW8IvZhx8h5jex5skzmMnpyUvJgFhmdMLbq1GnDdVR8UTEkVkaD2JjNEmMMhcXPwGm6wNSghx0ciFWl85dgXVkIVs1VZtJcKfhyMnHtckDsn3hJ5wRVl+ZLtuJqBMPfVWhh/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKUul9Cv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761817306; x=1793353306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=96f0HHie9Rype+AxiSlvXgHs8dSjnSUG9UaN5uQtgCA=;
  b=cKUul9CvA5Iu/VDw22HNjNPREGHwI2q6vrbMTQ/tey7B6RKI9pgnfqay
   KqkvRaGT1YxHqB8BjfBVWJYz/U82sYrZ1SDFjn0uhxMSiN/bQZYbtIwFm
   i0dPs5N6t+bO1wLd8sEVmyNrn0spmEMEGamaEAXUwlAYotRyKYkmfW1mc
   pA/tuN1gCchxIk2yi3kfRYsw9UBdHh4n2t41FgUizoNIc67Ddqv8nZQSC
   LKQ+swzbI9VAaqOiH/f74DMSKHyfaJuwJla1WymFBzFYye3i2Ma1C4axC
   AzaxrAHrGbUVkJk3cPfE6YH0lIuRgSqCQAybYab7BFX4WRSOIoSyEKa38
   A==;
X-CSE-ConnectionGUID: o34QNY8TT7GPQw3eg9uXtQ==
X-CSE-MsgGUID: LDeyidBdT9um8jcV57cwAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67788379"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67788379"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:41:46 -0700
X-CSE-ConnectionGUID: PwVRsI+KQFmxj0dKfTofng==
X-CSE-MsgGUID: BE1Z+VKKTo+X92Mb0siYGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190270848"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:41:41 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEPA3-00000003rQD-391F;
	Thu, 30 Oct 2025 11:41:39 +0200
Date: Thu, 30 Oct 2025 11:41:39 +0200
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
Message-ID: <aQMy00pxp7lrIrvh@smile.fi.intel.com>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 01:28:37PM +0100, Bartosz Golaszewski wrote:
> 
> At the moment software nodes can only reference other software nodes.
> This is a limitation for devices created, for instance, on the auxiliary
> bus with a dynamic software node attached which cannot reference devices
> the firmware node of which is "real" (as an OF node or otherwise).
> 
> Make it possible for a software node to reference all firmware nodes in
> addition to static software nodes. To that end: add a second pointer to
> struct software_node_ref_args of type struct fwnode_handle. The core
> swnode code will first check the swnode pointer and if it's NULL, it
> will assume the fwnode pointer should be set. Rework the helper macros
> and deprecate the existing ones whose names don't indicate the reference
> type.
> 
> Software node graphs remain the same, as in: the remote endpoints still
> have to be software nodes.

...

> -#define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
> +#define __SOFTWARE_NODE_REF(_ref, _node, ...)			\
>  (const struct software_node_ref_args) {				\
> -	.node = _ref_,						\
> +	._node = _ref,						\
>  	.nargs = COUNT_ARGS(__VA_ARGS__),			\
>  	.args = { __VA_ARGS__ },				\
>  }

Okay, looking at this again I think we don't need a new parameter.
We may check the type of _ref_
(actually why are the macro parameters got renamed here and elsewhere?)
and assign the correct one accordingly. I think this is what _Generic()
is good for.

-- 
With Best Regards,
Andy Shevchenko



