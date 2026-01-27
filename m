Return-Path: <linux-acpi+bounces-20642-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHpDMoFyeGnEpwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20642-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 09:08:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A50090F18
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 09:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD4B83013A87
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51581283FDF;
	Tue, 27 Jan 2026 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkhWaeRI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC821A447;
	Tue, 27 Jan 2026 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501286; cv=none; b=g6GkoQDtDEU1aTgfSu0YKUUq9yJmsGewpVbaZ8PmZkEppFxqLhAZEv7dKD9BAomD7Bhk7UC6zGxGRagV8qGDw3yPJHTV0seteybNNZO4ftdDv/UPPhkD283hP785mZZ3gmB4TcvW8tQt3HJzjHCV1IphlvUtluBoiPgSH9Yllos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501286; c=relaxed/simple;
	bh=oF3IoeobJxMEeLSxYINywFJrFZWabtnbb3YnMtFwqhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXZ6NG8ereabiywtUxeqi3aJUy7uo+oMdyat1dewq78CJ7oKoq/UopKoBWZuEeGBYKjZVEG4ttp+igD65nfb5Bq1ZXaWFMU1paAbpIy1tHZ6jCVjgbwguhZPHIfQC9LioNkOR3frCqm7LhrBdN9eksxNaxrYk3QM966TZLw2wUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkhWaeRI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769501285; x=1801037285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oF3IoeobJxMEeLSxYINywFJrFZWabtnbb3YnMtFwqhE=;
  b=VkhWaeRI4JxIn2ChWhahw1oud7MxOdqul7qrEmTEG2gw+pvp+3pjAkEd
   seMnkCwxI1lQPJ6KIigqC3MLxqwqw6eiiJscQNntd0t2YX24xSxQgXINI
   aGkw6dF0I/g02n+b4BC/E9zDzBMtAO4D01X/4hO3NjXC9hJS3mVVcw0qB
   HsbdklrQjI33WN/ORiiQyJN39tVk3IU1aU3DJB4fLxEcgylOprYdJSkeg
   8aP6szOXpwcovjGsjTJUmzTAze7LNwkxYlm2HcXJ79oNjwr1lGkwP0HvA
   PwuU3Gd1OdnUiRpG6mLxB3vaoz390kDaA9FvLtlM0RrPeGpkNGD5OLmPH
   w==;
X-CSE-ConnectionGUID: /odgnCvdSmquKtV30eXxGw==
X-CSE-MsgGUID: Ul6gbpDfRuKr1pzWeRf2Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="82117801"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="82117801"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 00:08:04 -0800
X-CSE-ConnectionGUID: BphpS31ZQyqrifjhAXNbKQ==
X-CSE-MsgGUID: fpCgC6kKRb6GUDFTHblp5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230862365"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jan 2026 00:08:01 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id BC4E998; Tue, 27 Jan 2026 09:07:59 +0100 (CET)
Date: Tue, 27 Jan 2026 09:07:59 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: westeri@kernel.org, andriy.shevchenko@linux.intel.com,
	linusw@kernel.org, brgl@kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] gpiolib: acpi: use BIT_ULL() for u64 mask in address
 space handler
Message-ID: <20260127080759.GY2275908@black.igk.intel.com>
References: <20260126035914.16586-1-denserg.edu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126035914.16586-1-denserg.edu@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20642-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,linuxtesting.org:url,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: 2A50090F18
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 06:59:14AM +0300, Denis Sergeev wrote:
> The BIT() macro uses unsigned long, which is 32 bits on 32-bit
> architectures. When iterating over GPIO pins with index >= 32,
> the expression (*value & BIT(i)) causes undefined behavior due
> to shifting by a value >= type width.
> 
> Since 'value' is a pointer to u64, use BIT_ULL() to ensure correct
> 64-bit mask on all architectures.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: 2c4d00cb8fc5 ("gpiolib: acpi: Use BIT() macro to increase readability")
> Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>

Reviewed-by: Mika Westerberg <westeri@kernel.org>

