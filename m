Return-Path: <linux-acpi+bounces-1056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7BC7D9560
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3D21C20FB9
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF07918044
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNdJXDUs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E11775B
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 10:12:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2003BD;
	Fri, 27 Oct 2023 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698401523; x=1729937523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fC4NawWJxctEmEJLsZMy6ys4v8xn8O7rZqwzS7NeHnk=;
  b=MNdJXDUspd8LsbbaVo0dVUGTwGRigo3RHGf4Eug/R1fdA6FyzKbbniN8
   KXJPjoaS6WM5qahdk8gwAaVtuhtFGccH7nODYhhbnqjLUjRiiXRkjlzn6
   JO1DL2Vu24J7GpNTn7cRrh01QWRimhcuJZbru8i3Ivnn/UMJ36VUUQ8Kr
   vxpEyjRhyHqEvflcsZXCuIxDqAKTmB4ZjmeQunmP2daBwue4cOm7sq+Zd
   uRWMTWar+7D0EnDyPkWn3yJcXkXu8kQsggDvIZhzuTgWfs7DO7QsP7isx
   6rnXcazj33EPIbboSkP6KtOvCrNHXjdi8oH3BGDq1Bkl6RhKpWekxzsvk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="387562322"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="387562322"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 03:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="788789658"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="788789658"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 03:11:59 -0700
Date: Fri, 27 Oct 2023 13:11:56 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: rafael@kernel.org, len.brown@intel.com,
	andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTuMo2qDO6Aqq3D_@black.fi.intel.com>
References: <20231026083335.12551-1-raag.jadav@intel.com>
 <20231027081855.GK3208943@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027081855.GK3208943@black.fi.intel.com>

On Fri, Oct 27, 2023 at 11:18:55AM +0300, Mika Westerberg wrote:
> On Thu, Oct 26, 2023 at 02:03:35PM +0530, Raag Jadav wrote:
> > Now that we have a standard ACPI helper, we can use acpi_dev_uid_match()
> > for matching _UID as per the original logic before commit 2a036e489eb1
> > ("ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()"),
> > instead of treating it as an integer.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> The change still looks good to me, however I wonder if we could maybe
> improve acpi_dev_uid_match() to support both data types possible for
> _UID? This of course is separate patch (unless there are objections).
> 
> There is the _Generic() thing and I think that can be used to make
> 
>   acpi_dev_uid_match()
> 
> which takes either u64 (or maybe even unsigned int) or const char * and
> based on that picks the correct implementation. Not sure if that's
> possible, did not check but it would allow us to use one function
> everywhere instead of acpi_dev_uid_to_integer() and
> acpi_dev_uid_match().

The way I see it, acpi_dev_uid_to_integer() is useful when drivers want to
parse _UID and store it in their private data, so that it is available for
making various decisions throughout the lifetime of the driver, as opposed
to acpi_dev_uid_match() which is more useful for oneshot comparisons in my
opinion.

So I'm a bit conflicted about merging them into a single helper, unless
ofcourse there is a way to serve both purposes.

However, I do agree that we can improve acpi_dev_uid_match() by treating
uids as integers underneath, instead of doing a raw string comparison.
This would make it more aligned with the spec as suggested by Andy.

Raag

