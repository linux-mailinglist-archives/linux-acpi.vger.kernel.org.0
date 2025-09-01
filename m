Return-Path: <linux-acpi+bounces-16228-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0FB3D98F
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 08:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4FD3B4DDC
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 06:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59BA23E346;
	Mon,  1 Sep 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPM/m+3Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252CC21019C;
	Mon,  1 Sep 2025 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707071; cv=none; b=X/UZKvqyW5BFCfwO1fiY1H7BNFrrKR0WXba4DuS67okeCyl0giIHQOewfxw2FIpYljLPJmHtqoruxzzF5luwwDhW7coqM4cLTziPCo0fjQyFj/jtWVZDEeCYw3eRHwhvAl3+KRY+EzJQjZA8FIsSUHUZtnt9W7OJokOxFKNCeLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707071; c=relaxed/simple;
	bh=EXA+JUFqz75CzbLShd7tO7Y84ICHRgM5TZo54RLMKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3E4pMCuCwmd4h2RXwvVjrRiAIt2Y5PSJ/KI17BFUHUGswHZGVTvZQYws5QPBd5UZWcPwVsPTmrum515cG0Ne4QRfMHBF1yzPB1Jb6ISNA1cYizPO3OxFQkQSuy8arlhB0vDl/CsY6b3ckPXQg3hCZJ1MW0ZzLotZotoWdt6y5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPM/m+3Y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756707071; x=1788243071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EXA+JUFqz75CzbLShd7tO7Y84ICHRgM5TZo54RLMKVg=;
  b=NPM/m+3YD2fXVN/jLrlsAjah7iDxY2N0j9IxbGVMu3Epiu1bPfGPeMRz
   hyz9b1AWKJmdHJ3X9SyPm6wffVCIy+acvmXnm7YaSXEBfko9Pxcr/l1Jd
   BrfE6UjbbW/pMuXIfpMLIVQbAJRQLXf3A6mDN3NKviaQlJmug74Ss3+kH
   xBlmKDu9Nhy/Fnz13qBpfOhSKEY9wZf9fDqwZbha5GMdi6FiXdlyEkLVu
   YaPwHGhk/13kVdizrzWHls/GhErAy9XIWEezeuWKRDjm6TSaKrjUqjmwY
   WG9DC0Ty1nYXjhOmOymNUY0m2jWka3S8dsWhTzKldBsH7P0yHEPrTGaLt
   g==;
X-CSE-ConnectionGUID: iMTF6yTbSES6kkVAdG3wUw==
X-CSE-MsgGUID: wLoEx6oPRZ2eQAN0zfKEhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="69168651"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="69168651"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 23:11:10 -0700
X-CSE-ConnectionGUID: eSP3FSChTC6nlqq2ufwJdA==
X-CSE-MsgGUID: /0NTK+5eRa2iQMP2bhqA9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="171055298"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 23:11:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1usxku-0000000AGxM-0yBq;
	Mon, 01 Sep 2025 09:11:04 +0300
Date: Mon, 1 Sep 2025 09:11:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: Add scoped fwnode child node iterators
Message-ID: <aLU497rXkuHtTl43@smile.fi.intel.com>
References: <20250829021802.16241-1-jefflessard3@gmail.com>
 <2025082953-splendor-unsold-e4f2@gregkh>
 <AA99AF86-CD2A-4BBE-92BC-3D9005E7BA3B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AA99AF86-CD2A-4BBE-92BC-3D9005E7BA3B@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 29, 2025 at 07:34:17AM -0400, Jean-François Lessard wrote:
> Le 29 août 2025 00 h 23 min 22 s HAE, Greg Kroah-Hartman <gregkh@linuxfoundation.org> a écrit :
> >On Thu, Aug 28, 2025 at 10:17:59PM -0400, Jean-François Lessard wrote:

...

> >We need a real user of this before we can add them, so please do that as
> >part of a patch series.
> >
> 
> I understand the "no dead code" policy, but I found existing manual
> implementations of this exact pattern in the current kernel.
> 
> For example, drivers/i2c/i2c-core-slave.c already does:
> 
> 		struct fwnode_handle *child __free(fwnode_handle) = NULL;
> ...
> 		fwnode_for_each_child_node(fwnode, child) {
> ...
> 		}
> 
> This suggests developers are already wanting this functionality but
> implementing it manually.
> 
> If included with my driver series, I would only add the
> fwnode_for_each_available_child_node_scoped() variant that I actually use,

I fully agree with Greg, please make it series out of two, I will review both
as soon as it appears in my mailbox.


-- 
With Best Regards,
Andy Shevchenko



