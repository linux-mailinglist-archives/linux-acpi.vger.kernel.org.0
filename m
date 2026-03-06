Return-Path: <linux-acpi+bounces-21483-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MnTNHTBqmlXWQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21483-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 12:58:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B6921FFB9
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 12:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 491193049505
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88736920C;
	Fri,  6 Mar 2026 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTVuQsjD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142A367F25;
	Fri,  6 Mar 2026 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798321; cv=none; b=Lqj2p+x8+0kpreX5cTAqIFlvtQD02mx5IPBxCZBtMU8sH7n8hdAdCS32HsiTMLzWOCPpJb1eNE09VsgVrG8pFKOKdD89yTcC6m1au3vqZB8cvsV04+90xkqnn4h+akLyjFCLeG/KpcAE5IYNkVtZr0YDfBfcEUjVhbJPLgsAj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798321; c=relaxed/simple;
	bh=cEQaX+VtmqE/SxpWMBRV1Qx0pWS+puKGMQ6VzGSrkUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR8t4YmGr5FfMjMO8iG9KcPYbn8PKZ+99Q9JymsiInUA/7w774BZj+e8WDe0isJrvWVFRbwerC6MOAIC340mZtDcxZeQrJSdUzMpAGZi/E12HVSqY+XZzoM5avIAmw66ohab5I0vPklDcb6CkLOsIHsjYW2HNVy2RWj6CmYtIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTVuQsjD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772798318; x=1804334318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cEQaX+VtmqE/SxpWMBRV1Qx0pWS+puKGMQ6VzGSrkUc=;
  b=fTVuQsjDzrgIyDVuJSmZAZB2JtSjQdN3rseM7OW0fZ7af+YgWyD4ZIzx
   AtMo0uzSIkioZNSvd1ZbqqLgfhOYHNvsg7Tj5aVFK/SkvZlej2Jgehey8
   Y14eGPRWdIktTvpj+xGxLyRq0bTZ1nBOxOvsGPBhpGOufhMC5qx0LpTZ4
   ceUTxGcNDJZv37M7yoLW6jxNkreEhOIpUFVugML8YYOmduUNimdBAJ6+8
   AJMqA743vutcaPtRViJUCj4fujuR3CK4sGa9o9/OV5+cDzm1XgtDRnC27
   rBxrUUyPMZKu6BMLWGL8/soXLk6vLS2szwQX1i8gwt8w2PDfVWVCedtWy
   Q==;
X-CSE-ConnectionGUID: eTBh3d8lRUmCSOd6K6ZUHA==
X-CSE-MsgGUID: k6sFTmdJRHiUU+whnVmrrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73095931"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73095931"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 03:58:36 -0800
X-CSE-ConnectionGUID: C9sHvJJDTHOtW+4gpDJeSw==
X-CSE-MsgGUID: 1hJhBcTBSgCKnGYEoy/d5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="218224486"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 03:58:30 -0800
Date: Fri, 6 Mar 2026 13:58:27 +0200
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
	linux-doc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/6] gpiolib: unify gpio-hog code
Message-ID: <aarBY4VjGC0DGGcN@ashevche-desk.local>
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 58B6921FFB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21483-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:51:25AM +0100, Bartosz Golaszewski wrote:
> GPIO hogs are handled separately in three places: for OF, ACPI and
> machine lookup. In addition hogs cannot be set up using software nodes.
> A lot of that code is actually redundant and - except for some special
> handling of OF nodes - can be unified in one place.
> 
> This series moves hogging into GPIO core and bases it on fwnode API
> (with a single helper from OF to translate devicetree properties into
> lookup flags), converts the two remaining users of machine hogs to using
> software node approach and removes machine hog support entirely. In
> addition, there's a patch extending the configurability of gpio-sim now
> that it uses software nodes for hogs.
> 
> For merging: I think this should go through the GPIO tree with an Ack
> from OMAP1 maintainers.
> 
> Even with the new feature for gpio-sim, this series still removes twice
> the number of lines, it adds.

Lovely! This was in my TODO list somewhere deep, but I never started it for
real (had some very very initial patches)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
(Maybe I will have time to test it later on, I need to check if there is a use
of them on Intel Galileo Gen1 platform).

-- 
With Best Regards,
Andy Shevchenko



