Return-Path: <linux-acpi+bounces-21418-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKAvG+6TqWlCAQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21418-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 15:32:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DBF2137FB
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 15:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA15D308B450
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612463A6EF0;
	Thu,  5 Mar 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcVX9lqP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92143A0B05;
	Thu,  5 Mar 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720709; cv=none; b=pALOe9G6mNyA7OY9gfxjwZICJN5txFv+njW2cBBI4o0dQpbO/FojRFqOIJkDEBl1bEFiIdJ6p18+595O9o2fAe4yr59GOyFn62k7Qi2PXYuQEGzEcLmoZ+CgaaJLjRqpvYvAZHZL00w4HwVKoBMZVRQSvfIhNJmxWbO38rT5ewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720709; c=relaxed/simple;
	bh=UND8xvhahcE7q/80K7vvrBC8EEtbqKcSL68hzKgc8Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw/tX3k/fHAl0BfqGGGJF3pvUfNqrPnryzlBnTuesr96KKnGQE3Xv9mbbXkhwDuaPFXWGqo+CV7lkxDeChZzXq5qh2jV3PBWU4ySQhfnBK8QxQCAfpBb99J2GqjdDOkVSCTe7PAkCpNrPg9/uKlk8YNp/3dN0jz/L+ibvFmbmNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcVX9lqP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772720707; x=1804256707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UND8xvhahcE7q/80K7vvrBC8EEtbqKcSL68hzKgc8Lw=;
  b=WcVX9lqPvGat+f7l/F/SnHSVbcasb/nn2NT3Hzq72m7NmUUzX5YrAvdD
   xNqLS44b2VxNsA8RmAGwE6Faff9Navr9TZFRFQEk+9WjbeskyAPKZxvl6
   itUh7IbBja8/1TB5PLyNIA4+2etaK0cimXgr4OmzAeFRk8jTqKmk6Euw/
   D9sjhT6nDY6kUUhyShYlVLMxm/0g00Pr3p4XcuEydzfb9DXr6p2ulQv2d
   H9wl3R2+0otgGyyXLQppLOrnPgKU/iQDptQDcS6gE3jbrM9q2TGDK6kxf
   bfO/HtjAFHglRHL2Eq+DltAT3QV/eviAzAzL5tPtaPscKAjIvk/wj5L0F
   w==;
X-CSE-ConnectionGUID: XhTww3hNQjmnNUpoemuXUA==
X-CSE-MsgGUID: xF7VZhfzT3Ok2HLJrptGUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="72835923"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="72835923"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 06:25:06 -0800
X-CSE-ConnectionGUID: F23Q4HAtQZOHCQj1Y+ZJiQ==
X-CSE-MsgGUID: 8InoVMI7SAakhBhZj/4klQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="217938311"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2026 06:25:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B050B95; Thu, 05 Mar 2026 15:25:00 +0100 (CET)
Date: Thu, 5 Mar 2026 15:25:00 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Frank Rowand <frowand.list@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20260305142500.GB2275908@black.igk.intel.com>
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
 <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305-gpio-hog-fwnode-v1-2-97d7df6bbd17@oss.qualcomm.com>
X-Rspamd-Queue-Id: 42DBF2137FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21418-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:51:27AM +0100, Bartosz Golaszewski wrote:
> Refactor line hogging code by moving the parts duplicated in
> gpiolib-acpi-core.c and gpiolib-of.c into gpiolib.c, leaving just the
> OF-specific bits in the latter.
> 
> This makes fwnode the primary API for setting up hogs and allows to use
> software nodes in addition to ACPI and OF nodes.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

