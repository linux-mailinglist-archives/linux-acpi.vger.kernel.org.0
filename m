Return-Path: <linux-acpi+bounces-20659-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDZdOd7CeGmltAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20659-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 14:51:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3288A951F8
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 14:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEFCB30AB298
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD535C1B7;
	Tue, 27 Jan 2026 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCd/CYAA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3635B142;
	Tue, 27 Jan 2026 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521386; cv=none; b=olo0Uj8a00Mp9Q1efrVSjpPoHYmGP4FWztzUrhqi7+hTvTBLTmxka6Ua1zlM6lfenZi9ZOOP40K42wrMDWlHEQobfQR+fQ6boUtq359sLKmHIBbqTdfArDWgH2ST7Lt9uzgE6BmX4afxQJ59uVy365SQiAQcn/DGmOMiwl3vnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521386; c=relaxed/simple;
	bh=JcDa4Cel5hMJn6p81InCMCDmOuT0Ipx7bdJ7RF6rLjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoLLphEcPjDJWJ0aSd6S/GwH9FGBbesu3jvbVp4D6gK+ulHvNguSABU/a7+NjgOKDuSKfDrI2P+gFbWrCYkQjFJmMYCUsGls/Sm2RZyl1a58/DwNLQ0qVBs81yPDW2Kw03Q5pjDNesXAPw67LhK67hqndOSeSWPNnCaxjfM9Vsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCd/CYAA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769521384; x=1801057384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JcDa4Cel5hMJn6p81InCMCDmOuT0Ipx7bdJ7RF6rLjg=;
  b=TCd/CYAAEsCNO7Uvkc3oTxAdyzYOfJR0ryD60hvLBdYujfWJzQRQt6SA
   IpIZH9xieFdDlgaiLEkC2CRKg430lRR3he4BF3rTJdhZhEiq4lNhmBy8B
   r9zAIQ9kn6hcjAtWfqdA3Mj3a6jaD5ScrLKTfQfdjHpTtsDPOI4dzDGuW
   lqxFqn4GuJhBWNLuK52zXbWiZgQFTiMJ26eWeBzTe7Ho1tDamQLoisCEt
   5Xzo4ssCIHfrfDOtOX9qjKP3BBopKdC7ZqKTiU/ruaB4r4TPmweBseo/C
   3wd/Z3Eux0ZNpJjgBwEhMx7t5eaNSBnGCLHKA8Mi8+wwsnc8nmnYsi6Tu
   A==;
X-CSE-ConnectionGUID: 8Y/6SPXrRPio7WBOQfxmdw==
X-CSE-MsgGUID: ZJLMb7d5SDyYt6eFRDOwMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70757011"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70757011"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:43:03 -0800
X-CSE-ConnectionGUID: EfV+69qLRymD4x/KCjP7gQ==
X-CSE-MsgGUID: MtVnC5XLSxu1yyq4q3ShRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207220941"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 27 Jan 2026 05:43:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B489398; Tue, 27 Jan 2026 14:43:00 +0100 (CET)
Date: Tue, 27 Jan 2026 14:43:00 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH v2 1/1] gpiolib: acpi: Fix potential out-of-boundary left
 shift
Message-ID: <20260127134300.GK2275908@black.igk.intel.com>
References: <20260127110824.4020130-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127110824.4020130-1-andriy.shevchenko@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-20659-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: 3288A951F8
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:06:30PM +0100, Andy Shevchenko wrote:
> GPIO Address Space handler gets a pointer to the in or out value.
> This value is supposed to be at least 64-bit, but it's not limited
> to be exactly 64-bit. When ACPI tables are being parsed, for
> the bigger Connection():s ACPICA creates a Buffer instead of regular
> Integer object. The Buffer exists as long as Namespace holds
> the certain Connection(). Hence we can access the necessary bits
> without worrying. On the other hand, the left shift, used in
> the code, is limited by 31 (on 32-bit platforms) and otherwise
> considered to be Undefined Behaviour. Also the code uses only
> the first 64-bit word for the value, and anything bigger than 63
> will be also subject to UB. Fix all this by modifying the code
> to correctly set or clear the respective bit in the bitmap constructed
> of 64-bit words.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Perfect, thanks!

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

