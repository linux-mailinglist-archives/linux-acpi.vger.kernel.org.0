Return-Path: <linux-acpi+bounces-20783-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKALCdFhfGl0MAIAu9opvQ
	(envelope-from <linux-acpi+bounces-20783-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 08:46:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CC2B8067
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 08:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6C323016D01
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB5264602;
	Fri, 30 Jan 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSEbCua/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8901D6AA;
	Fri, 30 Jan 2026 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759176; cv=none; b=LorQttSeFcbbExOq5yjcVnpnOaJtitS4zuO9jjmDMk6LfB+Uq0QM1+Q30x5+qnVtW9e5dNuPhXk6bjRi0f1ey2R0D9IAMnrGd28aeI4CD77QBfxiDiWruFWKlBEG2i8+wx+sRmCzAe1Q7Zti6sehSYMTXxX3oO/LcKEphxILPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759176; c=relaxed/simple;
	bh=MqqIt/Lb2bULi3NnoO9UbS1O849AW9xMvCqcQ63ZfsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mstXIUBMeEMWJe6gsYz4O7rFXfP+x0sCf41g5JJY/1Pbxp5gbWmIdrA9lX2zVN5DLA9qorINhML5v+ewOvRHr6AArlKqNDx1+w9d32kUitufWv47TsvMFJR3rUUANUo03+2Htt1j6C7MQwjeXRh+KYXifs22VnWRgafif/5sNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSEbCua/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769759175; x=1801295175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MqqIt/Lb2bULi3NnoO9UbS1O849AW9xMvCqcQ63ZfsU=;
  b=KSEbCua/RNLux50gse7JBVQE+0z871JTpPb5QQtmpy/5Gexvax511QXE
   YS4/mpVI7hOFHPMuaSplRIIyEJOf0jXuYxf8JOw3Jsh/SqCtuVk0ciKp0
   Q2Ml5DpVc4AuSduVAg9TV84dUexgbqD0WcIVCMCccFCjeyQSlKMuK8gfz
   8lqSF/zLmEe2Kglvojyef83jtS3/UzuqGJuu/bWH6fqNPJ5OSWbfVQEls
   7OjJmaPSyQJSiDC27qfCeOMy0TywsWlhrQn5Ny63pySqOAxSQphuKGXyf
   teq+NrJC7cPAZgvLBQefQQnwiORMWDN446NkBX6JjXDP7pmmVIFdHuaC6
   A==;
X-CSE-ConnectionGUID: B3p34HIFSEeQBG/LBdPtgw==
X-CSE-MsgGUID: 8M+IfRFsRWmPFXaqQvCnJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="88424638"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="88424638"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:46:14 -0800
X-CSE-ConnectionGUID: wKIXdd2XSQGWCPc7XVDhWw==
X-CSE-MsgGUID: VVu7I2RATwijjEKrzAr5AA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jan 2026 23:46:12 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E07DC95; Fri, 30 Jan 2026 08:46:10 +0100 (CET)
Date: Fri, 30 Jan 2026 08:46:10 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alban Bedel <alban.bedel@lht.dlh.de>
Cc: linux-gpio@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Fix gpio count with string references
Message-ID: <20260130074610.GX2275908@black.igk.intel.com>
References: <20260129145944.3372777-1-alban.bedel@lht.dlh.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129145944.3372777-1-alban.bedel@lht.dlh.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20783-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dlh.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: A2CC2B8067
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 03:59:44PM +0100, Alban Bedel wrote:
> Since commit 9880702d123f2 ("ACPI: property: Support using strings in
> reference properties") it is possible to use strings instead of local
> references. This work fine with single GPIO but not with arrays as
> acpi_gpio_package_count() didn't handle this case. Update it to handle
> strings like local references to cover this case as well.
> 
> Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

