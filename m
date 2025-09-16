Return-Path: <linux-acpi+bounces-17018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6AB59916
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71313463C48
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C521254D;
	Tue, 16 Sep 2025 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MV1a4xA0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08434129E6E;
	Tue, 16 Sep 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031788; cv=none; b=PrlVVBggUshQkkkmIj3woldhUn8KU8Zh+dHBOV8yOHWskDfkWDOqBZC8RA3cF5fn7JEiDcqsvxM5cGx9cfcAGTH45uDh5K9j/UFGUxEEWiUsvQ1zWtbHN6lVtAGvGQtTtIO8l4qVwCaOtUQGxVSLi5DpJiK+mRjN07v4KzsG1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031788; c=relaxed/simple;
	bh=c3hdJCePaCWo+2BYA/qk6Bwz0gVTkkoU44/V5dyaDhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGmvY74EX8y/Dgu+3y57dvFxDPmGlwpY0Vkq5DhTZzm6kGaKaFbu/oZjsB7IFXAXYThgXmrQMj1tiUjS6WbPzeXMvGD4oY2MbOjV2VqDMHdJVOa4foj0F/ii70dflWmRwRQRbsqfzw93wEV/Z3TIxa0nqAhC/yHSwFpwbnvFxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MV1a4xA0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758031788; x=1789567788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c3hdJCePaCWo+2BYA/qk6Bwz0gVTkkoU44/V5dyaDhs=;
  b=MV1a4xA0deYhASnxWGau+QviKLYTsKY+V9NO0DY9JUCCNfjhVrfJyPXR
   CieP1CCYXWYW4m3YDdnzDbFR2pe9f32XMyicP+S195BDo5GedukOWiRyd
   No64IbtsIpruRpFcdxAMJ0JF+pfuijw7mTPinOxtlgLYkOyUwthulorDa
   WAau4YSqiLWtnTfgqnAzAFlr1uSIbvnUJVO+Pt5+Qs1ZDnZwcD9B0BIAt
   XW20U1vOnSi5x/Dz6Uxe3Kc07Rvn5bJhdkVpoLImuQ5NusiVtKhESd/zS
   4B9iDLnR4gDE1KvJG4kFZqLlcon6o4svq1SxcbSJgPnvjULfgZW3zN1Lh
   A==;
X-CSE-ConnectionGUID: /CgABUPlSz6W2YKsdfgbbw==
X-CSE-MsgGUID: QFZEObFxTbCxYvDPRxt8wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="70563350"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="70563350"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 07:09:47 -0700
X-CSE-ConnectionGUID: XkqJQqM1Tt+Q/RSLDKcHXQ==
X-CSE-MsgGUID: KArXQVdoT+6uGSMFE86lAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="175731890"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 07:09:43 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 428D8121EFF;
	Tue, 16 Sep 2025 17:09:41 +0300 (EEST)
Date: Tue, 16 Sep 2025 17:09:41 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/5] ACPI: property: Two fixes, more documentation and
 a cleanup
Message-ID: <aMlvpfVbEP9JOULX@kekkonen.localdomain>
References: <5922318.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5922318.DvuYhMxLoT@rafael.j.wysocki>

Hi Rafael,

On Mon, Sep 15, 2025 at 08:20:03PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-acpi/5046661.31r3eYUQgx@rafael.j.wysocki/
> 
> A user report regarding "ACPI: \: Can't tag data node" error messages in dmesg
> made me look at the ACPI property code and I've found a couple of issues in
> it.
> 
> Also, it took me some time to figure out why the code was doing what it was
> doing, so I decided to add some comments explaining it.
> 
> Finally, there's always something that can be cleaned up in every piece of
> kernel code.
> 
> Hence, this series.

For the set:

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus

