Return-Path: <linux-acpi+bounces-1064-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A457D9B84
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 16:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7759E1C208E9
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7202374C3
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCmaTBSL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51A358A4
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 14:17:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF99B8;
	Fri, 27 Oct 2023 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698416239; x=1729952239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m6+aEYMf/hf5+wuZDssl5y6BUg7UjE4UJ94L84yPyfU=;
  b=NCmaTBSLn3CXBGPIloavGadDw0yXeeo3hGMHhIWLfo/HMYn3GjMICybY
   XkrYKjrXTPoMO3I4HU2smNpkvs6YWZHLwCFjnLfXj4KPlb/QR8q72CssT
   LDG6wewEqmhISY3EMCsBxIgW6LHOeGiXO5vNLpQK0PlYLhIIEjNURAlXC
   tT8Vvk69bNHVl9JfSsY/eb44lhtzn7vZ6mRjVUv1sgWv4IB+DxIMlGkY6
   WYKwoP3ZT9BB+5820JWwfhAoI59OyOUquoc9/fPlPw+yAYkAU4X1GHVy2
   LkEFUEIdfyTUjl2WViDDCgkzln1Xt0axbUXHzr+LsREQ2n8oR8XXSpt9p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="602552"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="602552"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 07:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="794588821"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="794588821"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 07:17:15 -0700
Date: Fri, 27 Oct 2023 17:17:12 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: rafael@kernel.org, len.brown@intel.com,
	andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTvGaNZmGWpsM-yw@black.fi.intel.com>
References: <20231026083335.12551-1-raag.jadav@intel.com>
 <20231027081855.GK3208943@black.fi.intel.com>
 <ZTuMo2qDO6Aqq3D_@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTuMo2qDO6Aqq3D_@black.fi.intel.com>

On Fri, Oct 27, 2023 at 01:12:02PM +0300, Raag Jadav wrote:
> On Fri, Oct 27, 2023 at 11:18:55AM +0300, Mika Westerberg wrote:
> > On Thu, Oct 26, 2023 at 02:03:35PM +0530, Raag Jadav wrote:
> > > Now that we have a standard ACPI helper, we can use acpi_dev_uid_match()
> > > for matching _UID as per the original logic before commit 2a036e489eb1
> > > ("ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()"),
> > > instead of treating it as an integer.
> > > 
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > The change still looks good to me, however I wonder if we could maybe
> > improve acpi_dev_uid_match() to support both data types possible for
> > _UID? This of course is separate patch (unless there are objections).
> > 
> > There is the _Generic() thing and I think that can be used to make
> > 
> >   acpi_dev_uid_match()
> > 
> > which takes either u64 (or maybe even unsigned int) or const char * and
> > based on that picks the correct implementation. Not sure if that's
> > possible, did not check but it would allow us to use one function
> > everywhere instead of acpi_dev_uid_to_integer() and
> > acpi_dev_uid_match().
> 
> The way I see it, acpi_dev_uid_to_integer() is useful when drivers want to
> parse _UID and store it in their private data, so that it is available for
> making various decisions throughout the lifetime of the driver, as opposed
> to acpi_dev_uid_match() which is more useful for oneshot comparisons in my
> opinion.
> 
> So I'm a bit conflicted about merging them into a single helper, unless
> ofcourse there is a way to serve both purposes.

Or perhaps something like,

bool acpi_dev_uid_match(struct acpi_device *adev, const void *uid2, enum uid_type type)
{
        u64 uid1_d, uid2_d;

        if (type == UID_TYPE_STR) {
                char *uid2_s = (char *)uid2;
                if (!(uid2_s && !kstrtou64(uid2_s, 0, &uid2_d)))
                        return false;
        } else if (type == UID_TYPE_INT) {
                u64 *uid2_p;
                uid2_p = (u64 *)uid2;
                uid2_d = *uid2_p;
        } else {
                return false;
        }

        if (!acpi_dev_uid_to_integer(adev, &uid1_d) && uid1_d == uid2_d)
                return true;
        else
                return false;
}

Although this looks unnecessarily hideous.

Raag

