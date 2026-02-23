Return-Path: <linux-acpi+bounces-21075-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDKfCR2VnGnRJQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21075-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:57:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9604717B2E2
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1651331176CA
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ECD33970F;
	Mon, 23 Feb 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8/1ZLLx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6BD337100;
	Mon, 23 Feb 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869292; cv=none; b=JLtBm13skTC6uP3O65XRS5dCeO6r37GZQfwMa8pfIk/SNihWFEk6ILGWqnGMl3neyZicQ93l6Wl8/dKbXkh5Nu8OHHGXyg32fyopEbHcZn/1wA0dZ54GXAypeNANeUSImNlo0DdhJxk7UBeDZ/jRCgpi6RubEZ9qf4rvR9E3HSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869292; c=relaxed/simple;
	bh=QNk9mwxIRZgCXMrxrgyvewByldxU4cf5Y9MIHnvZKM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYBH6a99msztfGaox3XOXxrKPCzHQUCms3l0SN6OWlxaD6LnbH6VrhKulrjyTfGZQaI+SlzGBM5WJJsVFzkjO2cC4EoHSGTdU8KFNQKARdhzg/Oa8V5TRh0AaPlIc4E7RyQsyaX7D7DB8ftIP/VPoY8iXt6/qlzvmfvtac4XlsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8/1ZLLx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771869290; x=1803405290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QNk9mwxIRZgCXMrxrgyvewByldxU4cf5Y9MIHnvZKM8=;
  b=f8/1ZLLxC2MUNOzdPxD15AQxHCHIn0eaoDrhZUTR7pNV8Etall2p+AN6
   YXW6YtU/+pF5vHb/JX6HibdXUZ+/vatefhiWViPq1EPkOhUqUWj1qvyh0
   CTeEoh6/Lbmy+hxb3nIUAI7ZydHigaJDuFqvdXjb3ZAre+/idt+R4C8Jm
   Ce3bwqjf5AFMKYbkX75z4+xxb104vGuXQxnOZWKvhzq28VHPl3xjNN14o
   1e+2mjd6QD70Eo9QQMxkybgR1d0bT1LwwJ2xNyCU/TtehJX6rARjGriu6
   4N6L6fXJHM7eZEQlUVaV6ocHIphXuw0ZaG5pfD6wkF8FsXWCKd2tav19P
   A==;
X-CSE-ConnectionGUID: wugONLKgSJ2JLrB6DD0bnA==
X-CSE-MsgGUID: oXCRxPgyRAm/8gHFuxOiaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72575033"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72575033"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:54:49 -0800
X-CSE-ConnectionGUID: HVN+B97CTPKV+ku3TafSVw==
X-CSE-MsgGUID: sIQ5ThnORxicLsf7zTUfxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215657998"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:54:45 -0800
Date: Mon, 23 Feb 2026 19:54:43 +0200
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
Subject: Re: [PATCH v2 1/2] driver core: make fwnode_is_primary() public
Message-ID: <aZyUY3ZsmrwHw4X_@smile.fi.intel.com>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21075-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9604717B2E2
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:40:52PM +0100, Bartosz Golaszewski wrote:
> Export fwnode_is_primary() in fwnode.h for use in driver code.

...

> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -230,4 +230,9 @@ void fwnode_links_purge(struct fwnode_handle *fwnode);
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
>  bool fw_devlink_is_strict(void);
>  
> +static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> +{
> +	return fwnode && !IS_ERR(fwnode->secondary);
> +}

This is inconsistent. Please, split out fwnode stuff from device.h to
device/fwnode.h and share it there.

This reminds me to look what I have locally in development...


(With your patch it will be in device.h and fwnode.h and in the latter
 it's even not properly grouped with other non-fwdevlink related stuff.)

-- 
With Best Regards,
Andy Shevchenko



