Return-Path: <linux-acpi+bounces-8716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA2799A540
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B122283AFE
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951412185B9;
	Fri, 11 Oct 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nACEZlzO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE05804;
	Fri, 11 Oct 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653948; cv=none; b=d6naWdGcSssG5kS3oNqHNpILQoLIh3bjQ4J7eIgqPpjtsTBn7XndelGDbzboq+8n8Ls1PvfpzuuJ30CMRkrOG0CItLF3LPtkyfD5yJqzS7PJgk29cnRdhoY0WJ/WBZuW4BivEk5krQe3lY42g5XG7l6IraIJR7+SW9n9JLZSBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653948; c=relaxed/simple;
	bh=NeFJiDfBin6S/qt+A0kI6aD97De7gqKLKGeBWCf/zt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwRJNmRzpYtTwQSOVuQsTTG/cfoZxQN1VKPHRGifTs/1UbVVjuo/++cpIONPvucSmCGbkxIZQo3LiaCZYUDlR0DP4ZWVlgB3JUwhVdsEh6qxev5BLmQ3ekREkY6stYpGexx5o3DdeLTbdZ30Ad2QCMpltilUTTihujj77czkZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nACEZlzO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728653947; x=1760189947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NeFJiDfBin6S/qt+A0kI6aD97De7gqKLKGeBWCf/zt8=;
  b=nACEZlzO20/H4JwCyTFhirvdyYGwJlxJmgTWyt9fe15703FFnp6koyJH
   T37lQ3SXP1U00dWhkCXrx8JjYxp+3Oh75LvtXL3f88KIUqY5ZniP+A3WV
   u2INGa7GJ7LWWOiRINIGvmV8qTeHOB2wIJ0ca+V7jmK204HPOX7Ea4/cy
   jm0EXLFNns0iB1KCWVySFGYdDey7mWv4ijU5obGk+WjunkuAtCEQq3Yld
   Di2IKz/fgoeZnHsHU5kfptJmaMsGtYcXLkgzfJ0teaKJKflHpiWMHZKoh
   1t/EGpb/Ylr/hso0xmDyFP/OgGhzwdh32R0cWqKWgIM3zovjf6VOY0ULI
   Q==;
X-CSE-ConnectionGUID: LvdX/gERTJGQayLUpyHzGw==
X-CSE-MsgGUID: QMt2R9W2RgGevwgweV/HLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27923319"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="27923319"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:39:06 -0700
X-CSE-ConnectionGUID: cxbZaPtmQ+W5qLyzoODT2Q==
X-CSE-MsgGUID: RxPLCwo/R8yF7apY82UN7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81530336"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:39:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szFrB-00000001u8Z-19GV;
	Fri, 11 Oct 2024 16:39:01 +0300
Date: Fri, 11 Oct 2024 16:39:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] acpi: allow building without CONFIG_HAS_IOPORT
Message-ID: <ZwkqdKUANkU-29NN@smile.fi.intel.com>
References: <20241011061948.3211423-1-arnd@kernel.org>
 <20241011061948.3211423-2-arnd@kernel.org>
 <Zwj1p3uMEA24a0sU@smile.fi.intel.com>
 <de65a5c8-1bbd-47b3-9dc5-de4ad93c41b8@app.fastmail.com>
 <ZwkIFREb1Ia90hSR@smile.fi.intel.com>
 <CAJZ5v0hG0o3jxH_HnS76s=VUC28M4fY5yuWxQttGSkCX_SvCSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hG0o3jxH_HnS76s=VUC28M4fY5yuWxQttGSkCX_SvCSA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 01:28:23PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 11, 2024 at 1:12 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Oct 11, 2024 at 09:59:46AM +0000, Arnd Bergmann wrote:
> > > On Fri, Oct 11, 2024, at 09:53, Andy Shevchenko wrote:
> > > > On Fri, Oct 11, 2024 at 06:18:18AM +0000, Arnd Bergmann wrote:

...

> > > >> +  if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> > > >> +          *value = BIT_MASK(width);
> > > >> +          return AE_NOT_IMPLEMENTED;
> > > >
> > > > Perhaps it has already been discussed, but why do we need to file value with
> > > > semi-garbage when we know it's invalid anyway?
> > >
> > > It's not strictly necessary, just precaution for possible callers
> > > that use the resulting data without checking the error code.
> >
> > Do you have any examples of that in the kernel?
> 
> Yes, there are at least 2 cases.  May not be relevant, though.

Btw, may be we even can add the error check to them, dunno...

> > > The all-ones data is what an x86 PC would see when an I/O
> > > port is read that is not connected to any device.
> >
> > Yes, but it's not what your code does.
> 
> Care to elaborate?

Sure, but it seems Arnd already figured out that he set one bit only somewhere
in the returned value, not what he stated in the explanation in this email
thread.

-- 
With Best Regards,
Andy Shevchenko



