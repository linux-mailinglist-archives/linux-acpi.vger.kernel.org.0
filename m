Return-Path: <linux-acpi+bounces-18446-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B46CEC2B27B
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 11:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38C3D342DCA
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076D72FFF8B;
	Mon,  3 Nov 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRirawsZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1F2FD673;
	Mon,  3 Nov 2025 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167173; cv=none; b=Ky6f+dQ3oLZg8KQtpuMThHOpUvm+hV1l7Ht6kAIJ/Czeqmre13Mv2yBXwDCWQ4/39Q4SFlOEpacGwdMrnTigkiXMVYI/bAsvVM6HDXU7TJICgz2pKlXgK5Q8nLayWmapZ+8DTqMX4BXw2QtDfdueLVXNEZWJ3UIQUMxNjA/hxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167173; c=relaxed/simple;
	bh=au+aqywGB7JieQHRa+pSZnFjB8pjn5+M950+4LVPrfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAEvBwMNN+T1smT2aE5ssjaIMezpYxgzEJDq+jU4OzW6qxGrodR1Mcso479XahxX2k/FGfSSmCUcmOcx2t1UGiRFPdO/iFienBY+6LnCWcAAKASSgF76vhREgQwPm9d8xIhwFb5EJxsKCnpilPdWUj7s1FaKReUnTG3HCHFTvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRirawsZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762167172; x=1793703172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=au+aqywGB7JieQHRa+pSZnFjB8pjn5+M950+4LVPrfE=;
  b=VRirawsZjglsuzhYgFb1wlxerTlikM6uEe7a7co4TTKaNfkUFZ6AjR8J
   5NElRURWAHjUPjGz5WHmOxx/kYV07IMm844WfE0tWtTce8avlNLowRWDN
   J6cZCRBrQ9GJPbz8OQtelo0fo+Upl1SohAeMWirVU7BqxDmsoZ18Yak7E
   QHJnT2A4FYdhAeFaiCYisdzowDoWFt07O8a8beD7/vDkgaMakFeTDaMlq
   w1WKOIzIFgXNm2QE9jOrIvJAWauNClHKbo+AHcmWLpRbqvxyE+59bXBg/
   9JhTLa9Rl4vcXFY8eO7y6AoXvKHqSVjRCqZbDfmR+3Ak8qtwY9C5NvsLs
   A==;
X-CSE-ConnectionGUID: +9fSpcrISxuxf1/SsLUj7A==
X-CSE-MsgGUID: phx2JRGSQIW7DiqYMj7rgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64164567"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64164567"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:52:51 -0800
X-CSE-ConnectionGUID: B6Yy3RabQzO0/New8HIfgQ==
X-CSE-MsgGUID: iEzanjqVSTW6OGI0r1ELpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186790655"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.27])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:52:48 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id AE11A120D07;
	Mon, 03 Nov 2025 12:52:49 +0200 (EET)
Date: Mon, 3 Nov 2025 12:52:49 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 03/10] software node: allow referencing firmware nodes
Message-ID: <aQiJgRDm0lZYqSmj@kekkonen.localdomain>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-3-6461800b6775@linaro.org>
 <aQh6n2XuI0oayg2g@smile.fi.intel.com>
 <CAMRc=Md=r7GaO3A_7de+EqzboyA2cqNSTZx7+64VSMvRBb9gpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md=r7GaO3A_7de+EqzboyA2cqNSTZx7+64VSMvRBb9gpw@mail.gmail.com>

Hi Bartosz, Andy,

On Mon, Nov 03, 2025 at 11:36:36AM +0100, Bartosz Golaszewski wrote:
> On Mon, Nov 3, 2025 at 10:49 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > > +#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)                  \
> > > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > > +
> > > +#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)                  \
> > > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > > +
> > > +/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
> > > +#define SOFTWARE_NODE_REFERENCE(_ref, ...)                   \
> > > +     SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)
> >
> > Now, useless.
> >
> 
> No, why? With these changes, SOFTWARE_NODE_REFERENCE()'s name is a bit
> misleading or incomplete, so I'm proposing to start replacing it with
> SOFTWARE_NODE_REF_SWNODE() which is compatible with the former but has
> a better name.

Given we're already using _Generic() to determine the argument type, could
we simply use e.g. SOFTWARE_NODE_REF() in both cases?

-- 
Kind regards,

Sakari Ailus

