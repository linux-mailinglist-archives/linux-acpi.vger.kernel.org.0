Return-Path: <linux-acpi+bounces-21482-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIJvKuvAqmk1WwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21482-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 12:56:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB3A21FF2C
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 12:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9437C301DCE2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2C3659F0;
	Fri,  6 Mar 2026 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxFDStwM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B193659E1;
	Fri,  6 Mar 2026 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798049; cv=none; b=XVLq9LEaUZalJsmla9v4k1Bx0UqTieshl9LfWWEoD/iOHZF1ADRaVHV7rTHNbzug7xlpx9rFsFtGSQl42GPqdEtJRzOFW/VEu93slmFWtKtKlrlLkqWKTtGMMYQ1fu56Tnew1a3x1VjG1JZXU1IYo+wIA5MwlCVJpOUBqukH/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798049; c=relaxed/simple;
	bh=gxY2HteUlEPwtGAhzmFFS7SvKb27QN/7kHK5ETDjuv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFikE2xC/WXcFpHXM01gTH7q50WlFIFTqBJjnJNjfc75kXeyttFE2DZ//TUjGiMlQEDwwrBVocPGZ1343yWthCABM1NLQfEHpw8rnnaFWBeRfwhN+etmvgCg9wI3JlWt4UgQIGo545L4HSgwLDm9R6LNTv1sIL+icDjI7/Zjmyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxFDStwM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772798037; x=1804334037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gxY2HteUlEPwtGAhzmFFS7SvKb27QN/7kHK5ETDjuv8=;
  b=cxFDStwMjTcsrQSUOWjlhJ/TWOXOgJbMxDTINmXYZysJ8rrSZ1VO2O7J
   zo8UVkKNr1PKPwkeeQtxMVIHuhQSX/OCxhgIh3YzcnFvqhAsnksVtq/w5
   2CV+g8L/GpAgz9dhUjRkOZd6xut+3bIU3dzm2Ay9JLTNdEnr42WSRrO6E
   rnYHRAIb1LXtOBFwYFhuFzGTUvzq2UPfsVX84omuEq+NX93uQXkRQtwQI
   CCIo59IKF83ZjR1U1bV7OwRQ/4glHjVc35UnyJuljNore+scGU5QvuY4+
   lBADobV763yV1Qv6/3qBgQEnDhfHOisciK1ef5RekYaMmRwxjBTpmIasd
   w==;
X-CSE-ConnectionGUID: KEoE6wxVRh6i45RCdX7J0g==
X-CSE-MsgGUID: w13mqQ5cSpCMq+QaUVFoew==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="74020367"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="74020367"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 03:53:51 -0800
X-CSE-ConnectionGUID: EwWNBUmeSwO6ezV8ekzYDw==
X-CSE-MsgGUID: eZsczoX6Q3CYsfBXL7YygA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="249460615"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 03:53:46 -0800
Date: Fri, 6 Mar 2026 13:53:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Frank Rowand <frowand.list@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] gpio: move hogs into GPIO core
Message-ID: <aarARyStudt76FMo@ashevche-desk.local>
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
 <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 0DB3A21FF2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21482-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:51:27AM +0100, Bartosz Golaszewski wrote:
> Refactor line hogging code by moving the parts duplicated in
> gpiolib-acpi-core.c and gpiolib-of.c into gpiolib.c, leaving just the
> OF-specific bits in the latter.
> 
> This makes fwnode the primary API for setting up hogs and allows to use
> software nodes in addition to ACPI and OF nodes.

...

> +int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_handle *gc_node = dev_fwnode(&gc->gpiodev->dev);
> +	struct of_phandle_args gpiospec;
> +	enum gpiod_flags dflags;
> +	struct gpio_desc *desc;
> +	unsigned long lflags;
> +	const char *name;
> +	int ret, argc;
> +	u32 gpios[3]; /* We support up to three-cell bindings. */
> +	u32 cells;
> +
> +	lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
> +	dflags = GPIOD_ASIS;
> +	name = NULL;
> +
> +	argc = fwnode_property_count_u32(fwnode, "gpios");
> +	if (argc < 0)
> +		return ret;

As LKP noticed this perhaps needs to be changed to

		return argc;

> +	if (argc > 3)
> +		return -EINVAL;
> +
> +	ret = fwnode_property_read_u32_array(fwnode, "gpios", gpios, argc);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (is_of_node(fwnode)) {
> +		/*
> +		 * OF-nodes need some additional special handling for
> +		 * translating of devicetree flags.
> +		 */
> +		ret = fwnode_property_read_u32(gc_node, "#gpio-cells", &cells);
> +		if (ret)
> +			return ret;

> +		if (cells && argc != cells)
> +			return -EINVAL;

Hmm... So, when cells is 0 we don't care about argc not being 0?

> +		memset(&gpiospec, 0, sizeof(gpiospec));
> +		gpiospec.np = to_of_node(fwnode);
> +		gpiospec.args_count = argc;
> +		memcpy(&gpiospec.args, gpios, argc * sizeof(u32));
> +
> +		ret = of_gpiochip_get_lflags(gc, &gpiospec, &lflags);

I prefer to see less OF things here, id est we may use struct
fwnode_reference_args.

> +		if (ret)
> +			return ret;
> +	} else {
> +		/*
> +		 * GPIO_ACTIVE_LOW is currently the only lookup flag
> +		 * supported for non-OF firmware nodes.
> +		 */
> +		if (gpios[1])
> +			lflags |= GPIO_ACTIVE_LOW;
> +	}
> +
> +	if (fwnode_property_present(fwnode, "input"))
> +		dflags |= GPIOD_IN;
> +	else if (fwnode_property_present(fwnode, "output-low"))
> +		dflags |= GPIOD_OUT_LOW;
> +	else if (fwnode_property_present(fwnode, "output-high"))
> +		dflags |= GPIOD_OUT_HIGH;
> +	else
> +		return -EINVAL;
> +
> +	fwnode_property_read_string(fwnode, "line-name", &name);
> +
> +	desc = gpiochip_get_desc(gc, gpios[0]);
> +	if (IS_ERR(desc))
> +		return PTR_ERR(desc);

> +	ret = gpiod_hog(desc, name, lflags, dflags);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Can be

	return gpiod_hog(desc, name, lflags, dflags);

> +}

-- 
With Best Regards,
Andy Shevchenko



