Return-Path: <linux-acpi+bounces-6667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BE391BC31
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 12:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E737B1F240E8
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22A015382F;
	Fri, 28 Jun 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOJVXqE1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A931103;
	Fri, 28 Jun 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569266; cv=none; b=X2UhKCZZfl2gij4GVixj0cI84p4qw4/5d8dCMZLGIPMM4o4gbBH3feaaxFmNWTvVIsvJ6PHOycBTOHYqpzwOiPefAMgmqhEq7lgnyMlnpOW7ndxm+TtczndVUGkvXyFKPfvUpwcfvhV1D1DdjLHrNQaVLEI4cnR/hVhaD9qvR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569266; c=relaxed/simple;
	bh=Voh2C7qCaV/cWCEnXBTrbP1xAUMZz06Xk4vviWO2iNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFhMcNuwyxfOM22wWx2L6Bwc14U8/hL3wzW4I+3JMq0HM5P4rFX0g+qx0JPQdst+s4vY69WXeZhpg7ZTyYCsdZcE+j21wraz0+NQsxVM8BVO6d22p4f4g8WYfPQ7Wz2fgT1eAcqWMcPVfHQ9rD8F/nDPjBkoYNh4KmjwDlQrqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOJVXqE1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719569266; x=1751105266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Voh2C7qCaV/cWCEnXBTrbP1xAUMZz06Xk4vviWO2iNI=;
  b=aOJVXqE1I/5otWEwLdogh9DXknOHyCC9oEMkYUYQRrQYNzxG2eLaR0mu
   OKi5NGnn4g10TN71Q/s9HEo4/DuQIWEKToJsu797vITN/t3uSFZz7G5hL
   F8izS2Q+EJvgE3yaPhqP1FNi2srOoudUuqJehzUyLzwKIJW2Te+uoAeMm
   aM2ZmhRBHC1+1b7GiUmsnItbne7rE3y6arOoUT5cgJeZaUJWbIYgpmHjS
   UWoqOCqihCX/aZrrhTisOCR8odv5NC0IMryCm/Q7xZEhzFXbRM3BmxMZv
   40BWrQLDboSFb1oInSZXsDcuYNyycKFdn4RbjVHIN9jsNTnuOnuQojPDx
   g==;
X-CSE-ConnectionGUID: SZymHW3fRjmT18pT3UNjFg==
X-CSE-MsgGUID: HFlRKlD4TmaqG8vLRAVihQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="12298837"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="12298837"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 03:07:45 -0700
X-CSE-ConnectionGUID: NpkJWFq5ROCvHUKFGl0zsQ==
X-CSE-MsgGUID: 7Sy9J/ZARnKWSVKcCQbVlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="49296111"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jun 2024 03:07:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 771C91C7; Fri, 28 Jun 2024 13:07:41 +0300 (EEST)
Date: Fri, 28 Jun 2024 13:07:41 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Zhiquan Li <zhiquan1.li@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, hpa@zytor.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
Message-ID: <2lqydi2yuc5qlyasr6q7wrqq7b5jn6juc4bp7nehshcpxqmnzz@rcld4x7sc3bs>
References: <20240628082119.357735-1-zhiquan1.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628082119.357735-1-zhiquan1.li@intel.com>

On Fri, Jun 28, 2024 at 04:21:19PM +0800, Zhiquan Li wrote:
> The issue was found on the platform that using "Multiprocessor Wakeup
> Structure"[1] to startup secondary CPU, which is usually used by
> encrypted guest.  When restrict boot time CPU to 1 with the kernel
> parameter "maxcpus=1" and bring other CPUs online later, there will be
> a kernel panic.
> 
> The variable acpi_mp_wake_mailbox, which holds the virtual address of
> the MP Wakeup Structure mailbox, will be set as read-only after init.
> If the first AP gets online later, after init, the attempt to update
> the variable results in panic.
> 
> But it is worth noting that the memremap() function that initializes the
> variable cannot be moved into acpi_parse_mp_wake() because memremap() is
> not yet functional at this point in the boot process.

  The memremap() call that initializes the variable cannot be moved into
  acpi_parse_mp_wake() because memremap() is not functional at that point
  in the boot process.

> 
> [1] Details about the MP Wakeup structure can be found in ACPI v6.4, in
>     the "Multiprocessor Wakeup Structure" section.
> 
> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
> 

Otherwise looks good to me.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

