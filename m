Return-Path: <linux-acpi+bounces-18164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDD5C031E7
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 21:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993E53A45D1
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347833B97D;
	Thu, 23 Oct 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsIe2nJv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95C33C50D
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245985; cv=none; b=hdf4iEozuVO8qfxiMzsvtdGoahp+H3UrNil9kHTJ23HYNlq4p+vwfw4N7HMHc31oR113L2+KnKrs82iUi9PIrw6Q2JHRVPlbwU97S8MQMtiZ+hW0wMVfRvp3Yb2Xf80BbKv1phcCaTEDfqFNddGE6NH4pP425WuKY8KHAGFWA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245985; c=relaxed/simple;
	bh=vvuZKT0jV0qQFxzuTdrY2/VtK4l2cJzuGZ9tqyC51xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOg1N2AODcHaCp1dVN37HxqmkYon3yYaAyxdrvPh6hFmlHGFvofnBnLf7jOaq6T3ZqrNsjRKMyTjcDf4tgHPqOFG+0TNM2hg9pcwgydewDdkdBBW+xsLVgsiya+en7IMKmw8G0YOwb7e6lSJt7uY647wYHt9YZJvx9uwnB37HeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsIe2nJv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761245984; x=1792781984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vvuZKT0jV0qQFxzuTdrY2/VtK4l2cJzuGZ9tqyC51xg=;
  b=DsIe2nJvC3D2x90ndUsOYooavfnryRimsHh9FygFLQ88LxJ9KAAG43qK
   6o821Tq73T0gghhSkKdp2WooqGCqywly/ceJ66T07IviS6QAxXaPYtArv
   FkvURoCAfQjCOVL5WuXXCyOnXjhQMjKZQByNkjtjwPkKdRKAK8MLVnHFW
   9YcmfCd4OTkXxpOjErnEzOFX7pP+celGS0ASjKrcUpmSAvmT2LbH+o78Y
   vejlXiU5TMfPpf86NL+BL/TeD5+aN5qpAwdT/0k5SeRboBTCbF24DC04K
   q68gb6GIquSNM56BDTU4c96iyOfHuaGUgut4I6KPyW3y2ta7bRhKMaeJ6
   w==;
X-CSE-ConnectionGUID: Y6Lh80HdTFOBpTPeo3Y4lQ==
X-CSE-MsgGUID: dbKYnmt5RbyE1+Cl3Kt8eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67264541"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67264541"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:59:43 -0700
X-CSE-ConnectionGUID: X6AaoZhqTdeNGSecQDLhlg==
X-CSE-MsgGUID: RNUqOfE/QcWogB9tjm137g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="188528985"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:59:42 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vC0XD-0000000214D-2I2w;
	Thu, 23 Oct 2025 21:59:39 +0300
Date: Thu, 23 Oct 2025 21:59:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: i2c-mux ACPI parent device references in example
Message-ID: <aPp7GwK4Rb9XZMO6@smile.fi.intel.com>
References: <48d0fb45-096c-4caa-b51c-753c2f17f018@gmail.com>
 <aPPthnO3bKFhTN3A@ashevche-desk.local>
 <CAOiHx=npyRdxvN7EywuXTvOMPYQ2FE_T7eVVJtZzh3Di05hxJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx=npyRdxvN7EywuXTvOMPYQ2FE_T7eVVJtZzh3Di05hxJQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 09:31:54AM +0200, Jonas Gorski wrote:
> On Sat, Oct 18, 2025 at 9:42 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Oct 08, 2025 at 11:14:37AM +0200, Jonas Gorski wrote:

...

> > > E.g. should it be "\\_SB.SMB1.MUX0.CH00" instead of "\\_SB.SMB1.CH00"?
> > >
> > > FWIW, the references were changed from relative to absolute in e65cb011349e
> > > ("Documentation: ACPI: Fix parent device references").
> >
> > Oh, seems to me like a miss from my side. Thanks for a good catch!
> > Can you send a formal fix patch?
> 
> Was my plan until my internet connection went down yesterday. Will
> send it out once it's back.

Is it okay now? Or did I miss the patch?

-- 
With Best Regards,
Andy Shevchenko



