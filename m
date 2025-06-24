Return-Path: <linux-acpi+bounces-14530-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D4AE67C8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 16:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0141C16EECC
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36452951A8;
	Tue, 24 Jun 2025 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdgJo9fg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA042C15B5;
	Tue, 24 Jun 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773857; cv=none; b=HFnrYEPwD/MHgqg3s+LClL81qrD4IDXOJpaDSaOpNilF0PoAMKxdZ0vY3weOfE1ATmH/88avG0v7GJPYupw/0Armm/+Vk6ZAg5AWtfxNU+BI6HGmokkFl7RlYw0iT3xGeRSfpaXwMGk9iVQkHLJrmrtQWhCsaUyjjIXqmgYk5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773857; c=relaxed/simple;
	bh=/9L6vkupFwbSjfa+qYhoW5NL2QlLgrc+8n6luizeN/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bShlvEXNV3QynybrTpnNq1jmKQ2pr8Ucp9aQ5x66M5uvF3IqyzyipxwacDjWu8cQCPm1ywEm8sGzRt/dT65peSl9if8/PR7No9t/mbBkYCobDOSaXZ+dDnrHkfOAx65Po5rmj0QJfrHdvKWOc0UuqHYn1qbdjhpm3hkA4uXP6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdgJo9fg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750773856; x=1782309856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/9L6vkupFwbSjfa+qYhoW5NL2QlLgrc+8n6luizeN/A=;
  b=hdgJo9fgTMpoQPZa7JkyWy849G01jX9jVcW+Ipl24synSqe34KJo1i6w
   Erl/7gyT5s33zDgV+P1IUxA3kwdYe+CtRWideD2pgBn9yzjw6qv1/STPU
   NKfUf3cFlH89textmGBJLnEMRnQ/Qdzi0LI4fbkSworD6anUNJusyGZIg
   JI3NswXYZezCdCo2NdxGm8Um80Rbp7cKBd0lD/EODCDTDUb5q19SAwKCv
   jQlU5TijzAH21OheV/ho94WvIL+3nO2aABelElQY/WWcrqkJN4VyiAxQF
   NjlmLP3wT6ahcfkw++s3A/DUJnfhnRp+/3+FeFvQFcCKZsAkPcl7r467Q
   A==;
X-CSE-ConnectionGUID: Pc5qwrjKRSiryQnI75J53w==
X-CSE-MsgGUID: MrsYSbXxQLe4t5Y2cY5g3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52984853"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52984853"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:04:14 -0700
X-CSE-ConnectionGUID: S9y9AU7yRr69IcrBiZ7TVQ==
X-CSE-MsgGUID: taWOR8i/RV64HLXsWN47+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151352258"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:04:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uU4Ft-00000009UIS-36eD;
	Tue, 24 Jun 2025 17:04:09 +0300
Date: Tue, 24 Jun 2025 17:04:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 0/5] ACPI: proc: A few cleanups
Message-ID: <aFqwWToG3HBe3rEo@smile.fi.intel.com>
References: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612201321.3536493-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 12, 2025 at 11:11:24PM +0300, Andy Shevchenko wrote:
> While looking into warning related to export.h inclusion, I took
> the opportunity to make the module up-to-date to the modern APIs.
> Hence this mini-series. Note, the first patch is to make the used
> type consistent across the files.

Hmm... Any comments on this? Do I need to do anything?

-- 
With Best Regards,
Andy Shevchenko



