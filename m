Return-Path: <linux-acpi+bounces-18545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF9BC35FBE
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 15:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8823134621C
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20632936A;
	Wed,  5 Nov 2025 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kb/TH+y9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801B32936D;
	Wed,  5 Nov 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351839; cv=none; b=SqpezRikEXYapF4nT072nst6bFiCsb9nt/WPZypo5gsd9DfGZ4l2aaLFfQtXnd/jyR+0nzqZIALTzNDbVLMf45+psaefAJI2jTYFV5YPRhcViOhf+NxkiR6zeJPET0DQ+9UZ9z7zRXVSdTWCBSoLajrVa212DkBj7sfbBHTVYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351839; c=relaxed/simple;
	bh=RvaksF7Hq1kN7fGENv4I4RcGzJ9u3o9W9L1twZmYgos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfQeARdu03EwWmKJ1DWcADQ2sizTTTIgr5RWjihJ5QU7JdN/JFyzafPQS6kygPYd0POov3UlVt7xSs7CSr5/KMSQlRn/u+vn29zVW7wXLoot6wDMSNIKIsZs1Qp/vw7ddk7gdTCkbLYEBO9osNoZktBn4/NM8WHG9c171gob+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kb/TH+y9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762351837; x=1793887837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RvaksF7Hq1kN7fGENv4I4RcGzJ9u3o9W9L1twZmYgos=;
  b=Kb/TH+y9sUjE369El/iwLp1BshgWsREkJICGyJZmzJOyq5WCM/BLfK4j
   m2sra/B/kGZaPegWkAFQ97CJLiqPSuB/tMHdJmHw9lE9zLerBcB2m2ihc
   OP4/aNMO3CWgVX3VVJEZqMmmiCWfzfBdNKF5OaFN60dg5pPNhlDzQOrtj
   o5C7M06dYbaE8S61n2T2w5b7UsgxiVwJrtarOkn8khhc74DAF02st8XUF
   Lonlvtmc1N+een0wRG8QEqqkwjq6mDKoFjTEfIqeeOV4K5gJtyKC3WpXC
   AbzzSPh4IWl/3iuyGUO1mD3XtEn33+copefavlvNfZk0a7+T/PiZOj2jK
   A==;
X-CSE-ConnectionGUID: q6Cg3kSqTjK/Cl/gwfRMbQ==
X-CSE-MsgGUID: N9G9gGqARCeQxLBiPdLtCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="74758546"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="74758546"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:10:37 -0800
X-CSE-ConnectionGUID: pnbL2JC5SG65MWsR3XaRqg==
X-CSE-MsgGUID: guoSZJ7oQ5KDgZIc3XT28A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="224711896"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:10:34 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGeDU-00000005nu9-0auL;
	Wed, 05 Nov 2025 16:10:28 +0200
Date: Wed, 5 Nov 2025 16:10:27 +0200
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
Subject: Re: [PATCH v5 8/8] reset: gpio: use software nodes to setup the GPIO
 lookup
Message-ID: <aQta01b_PyeHirxu@smile.fi.intel.com>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
 <20251105-reset-gpios-swnodes-v5-8-1f67499a8287@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-reset-gpios-swnodes-v5-8-1f67499a8287@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 09:47:39AM +0100, Bartosz Golaszewski wrote:
> 
> GPIO machine lookup is a nice mechanism for associating GPIOs with
> consumers if we don't know what kind of device the GPIO provider is or
> when it will become available. However in the case of the reset-gpio, we
> are already holding a reference to the device and so can reference its
> firmware node. Let's setup a software node that references the relevant
> GPIO and attach it to the auxiliary device we're creating.

...

>  static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
>  {
> +	struct property_entry properties[] = { {}, {} };

It's an interesting way of saying this?

	struct property_entry properties[2] = { };

>  	struct reset_gpio_lookup *rgpio_dev;
> +	unsigned int offset, of_flags;
> +	struct device *parent;
> +	int id, ret, lflags;

I assumed that lflags shouldn't be signed. And IIRC they are unsigned long
elsewhere (yes, just confirmed).

...

> +	rgpio_dev->swnode = fwnode_create_software_node(properties, NULL);
> +	if (IS_ERR(rgpio_dev->swnode)) {
> +		ret = PTR_ERR(rgpio_dev->swnode);
> +		goto err_put_of_node;
> +	}

Can save 1 LoC?

	rgpio_dev->swnode = fwnode_create_software_node(properties, NULL);
	ret = PTR_ERR_OR_ZERO(rgpio_dev->swnode);
	if (ret)
		goto err_put_of_node;

-- 
With Best Regards,
Andy Shevchenko



