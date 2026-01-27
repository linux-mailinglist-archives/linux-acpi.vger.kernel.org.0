Return-Path: <linux-acpi+bounces-20643-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFsGNURzeGnEpwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20643-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 09:11:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8BD90F5F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 09:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B4E30136AC
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 08:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11902874E0;
	Tue, 27 Jan 2026 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cx9rbg0K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC66285050;
	Tue, 27 Jan 2026 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501500; cv=none; b=T+Xu+Hnc1bFCEtCFGcY1xDf7sReftpniu+a/MCHZYopIqjDLRWDSWJMf6fn6K+P+RbR+qFBrl3U9LbPwQvad+m4V2wdIWNfWx/MECqG/8bRxulcOMwJKkoBdQrKdeX7X1capQl2O/dkUhCAhUM0v5BWg9On8LQfJM8xuR0eijvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501500; c=relaxed/simple;
	bh=QUwNGB/s8nKRM9QYdJgfqZJNE8ZZwRUQW45GfXq4nuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU1OEuGi0OiQJCM3/ZL7fiHaGzSZ8MG5UE9S4YIvB4WkIOHL8tS78aNsq5eByDf5sSXPSsoO67/1yO+Y6YgqGQi5N41WkmW3u6KX+iA3h+HMBIauROPfB71Z5Z0xg3klUg+yAaoNbvj0e2F60z7JmnOL0GESQWvgUsq68GfWosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cx9rbg0K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769501499; x=1801037499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QUwNGB/s8nKRM9QYdJgfqZJNE8ZZwRUQW45GfXq4nuI=;
  b=cx9rbg0K8o3t2YfUq2/JWDzY/IXmVrjgEdX415FAOQfBIqLNhuE++voO
   a/sgbaOtx+oGe/9fO9Xcwkusp96B7YPTfAAt1iaxhU88wc7TXoDWVyMpB
   B1yP5poeSBD9QZoNnx2Im0CZlVzsde1pZwVWk+yWi0Jf6WiMOIabUOQ93
   U0eIGsFe2zED0zy/JDPYCWNFrOwLwrGzFBW3ijsdf21JA5ukHGH8VjAi5
   D/6iVUYnXHw6nm2fxDjWYMfUPkvBfWOnDZ2Iz5U8EJXo/cWJFC4Rl1bqN
   K5yqs7kkQJH2VBI616KKL60Xi1bJ1P6rgdPsxUQZsCEyW00dwbHuG+nCM
   Q==;
X-CSE-ConnectionGUID: G3SOChk/RWWctAGuUwdT3w==
X-CSE-MsgGUID: BBZ6+qK/SNGUvvCL6saeoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70778702"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70778702"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 00:11:39 -0800
X-CSE-ConnectionGUID: f2Ta+NZiQSWxMysBOoo2hg==
X-CSE-MsgGUID: 8WWFQRv2TKCNEnjh+5DXIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207799738"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 27 Jan 2026 00:11:37 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6844798; Tue, 27 Jan 2026 09:11:36 +0100 (CET)
Date: Tue, 27 Jan 2026 09:11:36 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH v1 1/1] gpiolib: acpi: Fix potential out-of-boundary left
 shift
Message-ID: <20260127081136.GZ2275908@black.igk.intel.com>
References: <20260126134226.3617924-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126134226.3617924-1-andriy.shevchenko@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20643-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,black.igk.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D8BD90F5F
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 02:42:26PM +0100, Andy Shevchenko wrote:
> GPIO Address Space handler gets a pointer to the in or out value.
> This value is supposed to be at least 64-bit, but it's not limited
> to be exactly 64-bit. When ACPI tables are being parsed, for
> the bigger Connection():s ACPICA creates a Buffer instead of regular
> Integer object. The Buffer exists as long as Namespace holds
> the certain Connection(). Hence we can access the necessary bits
> without worrying. On the other hand, the left shift used in the
> code is limited by 31 (on 32-bit platforms) and otherwise considered
> to be Undefined Behaviour. Also the code uses only the first 64-bit
> address for the value, and anything bigger than	63 will be also
                                                 ^^^^^^^
There is some extra whitespace above.

> subject to UB. Fix all this by modifying the code to correctly set or
> clear the respective bit in the bitmap constructed of 64-bit values.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-acpi-core.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> index 83dd227dbbec..da0ab749b4dc 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -1104,6 +1104,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
>  		unsigned int pin = agpio->pin_table[i];
>  		struct acpi_gpio_connection *conn;
>  		struct gpio_desc *desc;
> +		u16 vala, valo;

Perhaps bit more descriptive names.

And while at it, add comment why this is needed.

>  		bool found;
>  
>  		mutex_lock(&achip->conn_lock);
> @@ -1158,10 +1159,17 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
>  
>  		mutex_unlock(&achip->conn_lock);
>  
> -		if (function == ACPI_WRITE)
> -			gpiod_set_raw_value_cansleep(desc, !!(*value & BIT(i)));
> -		else
> -			*value |= (u64)gpiod_get_raw_value_cansleep(desc) << i;
> +		vala = i / 64;
> +		valo = i % 64;
> +
> +		if (function == ACPI_WRITE) {
> +			gpiod_set_raw_value_cansleep(desc, value[vala] & BIT_ULL(valo));
> +		} else {
> +			if (gpiod_get_raw_value_cansleep(desc))
> +				value[vala] |= BIT_ULL(valo);
> +			else
> +				value[vala] &= ~BIT_ULL(valo);
> +		}
>  	}
>  
>  out:
> -- 
> 2.50.1

