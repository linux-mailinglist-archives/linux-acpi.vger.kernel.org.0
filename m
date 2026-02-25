Return-Path: <linux-acpi+bounces-21150-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPVpDRzVnmkTXgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21150-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 11:55:24 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B64C81960E0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 11:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B76430DB7D3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E903F3939C2;
	Wed, 25 Feb 2026 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBrshBXn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973443939A5;
	Wed, 25 Feb 2026 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016756; cv=none; b=n+452qI1JsCCtZxt9mSTbHZMXDW/dxXZuXxLjnBiq6A3x7S4YNb5FDJyxQQ2j6YAwxPzqPL5LAcJ9f5nXjSyAqgIaZt5APgEEAQLuzGo9WBYZyKqSnC4mk6fcX3UfrR9T9d3bmX0Y/y7DoRqGHmxzvNwkDJZBBlFZObzjfvozTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016756; c=relaxed/simple;
	bh=ZL2NP48sUkinx3lz9dwmnDt/y7p1gAhJzbV8XYVTUOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzrN442wV6YcTvR1d/iaEsV4d3zHXeZZ5Yg5Xpqba2rsuoxRV7cbTX5Qo24H4cSq5tXwxIVDWoTm40RvbN2NU9d9CBH5LHCMnBfq7wXiIhYafZ2tZFAoiCM+5DH4BZEfAcydl6TtTgcvQRC4Av5AHt3RG7NvoZw1huTDx7Pt4FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBrshBXn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772016756; x=1803552756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZL2NP48sUkinx3lz9dwmnDt/y7p1gAhJzbV8XYVTUOU=;
  b=kBrshBXndfQqf4/nIBEEepwxiiGtNx7XVM7QjPneSC+CQaTFPBLzpfJQ
   VBeAR/RMIZuQn3PQxzft7sm/BDIMaj8Z3T2Miqm0v0zRFFuk82y4a2S5D
   Od5Bufr+CYn4T8NANseOsKnc6FsofNYJxnTWOz/oDJZE9+Df94pKG7Yb/
   rjB8GhWD6FmYYX36cwZTdZQxThvmWSpUuEbcNxiKoLdXb+Z3A9MI2bZfP
   vZkb20eh8EXr3SaFM6CAZxbfgQ68aHOJ4WvscmhkgWzqWY4e2g9rbxhSL
   05oX6jdjvjwqzp1I8I410RPb9PrWuv+gSNAzJnZwfCxt3CWaXJ16baNFa
   Q==;
X-CSE-ConnectionGUID: iGIpQ5YoRom1RvgQbwAnaw==
X-CSE-MsgGUID: lNoFVg9IS92uR05bppPQlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84508378"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="84508378"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:52:35 -0800
X-CSE-ConnectionGUID: V27CPTvNTTi95czjLfV9NQ==
X-CSE-MsgGUID: o4AJKeDeQF6H6DqeiQ8+iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="216209392"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:52:32 -0800
Date: Wed, 25 Feb 2026 12:52:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Message-ID: <aZ7UbXkmiM6NGkyI@smile.fi.intel.com>
References: <20260225-device-match-secondary-fwnode-v3-1-a7152054135a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225-device-match-secondary-fwnode-v3-1-a7152054135a@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21150-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B64C81960E0
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:12:25AM +0100, Bartosz Golaszewski wrote:
> In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> reference to a specific fwnode, we only match it against the primary
> node of the controllers. Let's extend that to also the secondary node by
> reworking gpio_chip_match_by_fwnode()

...

> +	if (IS_ERR(fwnode))
> +		return 0;
> +
> +	if (device_match_fwnode(dev, fwnode))
> +		return 1;
> +
> +	return node && !IS_ERR(node->secondary) && node->secondary == fwnode;

I believe Rafael is right in suggesting just

	return node && node->secondary == fwnode;

At this point fwnode either NULL or valid. 'node' comes from device,
so it may be all three. Assuming it's actually can't be error pointer
the above check is sufficient. But maybe you wanted full check, then

	return !IS_ERR_OR_NULL(node) && node->secondary == fwnode;

-- 
With Best Regards,
Andy Shevchenko



