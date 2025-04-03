Return-Path: <linux-acpi+bounces-12681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73745A7A28D
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765D43B61F3
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B324C667;
	Thu,  3 Apr 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUxBJBPn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3924BBE3;
	Thu,  3 Apr 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682337; cv=none; b=UP67KJn9eOAewYUSEtBk3fEfDbAfnFPKtvZejlbJGgZimA+k6cB68JEm8y14UvdfKWUqw6nlZaY+wrhaOVn4z74V86Fw39KpkevJ8rS8raQNpMUEuH0UqXfCuZ3m7R6mi2xJps0KPoYsrKo3eEN6mCPQAuEkJHotKoR/eD7PhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682337; c=relaxed/simple;
	bh=wfP32hGUDJLS7BIEMu7eBqsJmv6hR2C4VyHYiauDOUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJeDViXifc05QwwaFZhnIz5NuUc1ckXL/OsgtfeuuwIXRAJkCEjzBTtNzvjKfDorTXVzH1J8euAzSpeXWDxfcmBYLm4ZlKOhuzxq+xM+EtSzLofrvHy0TVwwO3agY7SBZy1rvubtTSCowhbWiitd59A3D1G+s3F1C3DvxpHcpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUxBJBPn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743682336; x=1775218336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wfP32hGUDJLS7BIEMu7eBqsJmv6hR2C4VyHYiauDOUo=;
  b=NUxBJBPnGzJRZ3oRNZvEweuXPtTmjTcD7ehkY1i0MECacu8qySQOREge
   IIA5Wwa0wpKALmKUTJDMwUcsGwVIC+OCLXvHcGxFrhBXQCjAuN6P2FZVG
   I6vtUnvvKGSPEtLOk79PXCgq9hJ9fsY8IusfHmHj2FPFqLWtFv8Tw6gol
   NFB0Up6UZUxYrFsbO5rgLpdgRmUVrjRYsptT5CQMrHscHcJb3NtnLTJzC
   t6UFVvsUn/Jh7SRNrbjKrW6Xw3d8h3LQvOay+KHMcJ8RwZXfR8c2LuUyw
   CC0KHpblwnEY/q+AwEEAazHL6rMsruj/b/jXogccbNDimFj9LX0eLozAo
   A==;
X-CSE-ConnectionGUID: z9xeQGqTSPaIsALF9QM0Rg==
X-CSE-MsgGUID: 6eG2orcyQCu83c4N5M4YzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="70455092"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="70455092"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 05:12:14 -0700
X-CSE-ConnectionGUID: L3yn9IUzScOSAD31e8EBGw==
X-CSE-MsgGUID: kIp9hziHQe6HiipGdXjO3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="131968745"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 05:12:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0JQW-00000008nfB-3i9Y;
	Thu, 03 Apr 2025 15:12:08 +0300
Date: Thu, 3 Apr 2025 15:12:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 4/5] gpiolib: acpi: Reuse struct acpi_gpio_params in
 struct acpi_gpio_lookup
Message-ID: <Z-57GF_DWR8D-AZG@smile.fi.intel.com>
References: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
 <20250402122301.1517463-5-andriy.shevchenko@linux.intel.com>
 <20250403103506.GJ3152277@black.fi.intel.com>
 <Z-5rJDWaSJd58lTa@smile.fi.intel.com>
 <CAMRc=Mc3YUsLm5dX0b3rFsuCErf0WmyyYtXZgDYBt0w+xwqkCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc3YUsLm5dX0b3rFsuCErf0WmyyYtXZgDYBt0w+xwqkCQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 01:57:22PM +0200, Bartosz Golaszewski wrote:
> On Thu, Apr 3, 2025 at 1:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Apr 03, 2025 at 01:35:06PM +0300, Mika Westerberg wrote:
> > > On Wed, Apr 02, 2025 at 03:21:19PM +0300, Andy Shevchenko wrote:
> > > > Some of the contents of struct acpi_gpio_lookup repeats what we have
> > > > in the struct acpi_gpio_params. Reuse the latter in the former.
> >
> > > > +   struct acpi_gpio_params par;
> > >
> > > params is better name
> >
> > It's been already used elsewhere in the code. Do you want renaming there as
> > well for consistency's sake?
> 
> +1 for using param or params here and elsewhere. It's much better than par.

Okay, will be an add-on in the next version. But I will wait for Mika and
others to review the rest and give tags and/or comments where it applies.

-- 
With Best Regards,
Andy Shevchenko



