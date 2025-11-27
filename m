Return-Path: <linux-acpi+bounces-19308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8ADC8E34E
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 13:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D17F34BFF8
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B332E128;
	Thu, 27 Nov 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUYQwiT4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B3318152;
	Thu, 27 Nov 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245508; cv=none; b=dHQ8ZfDeA4sxwgfh2JdIzUrkTG/r+cTnauR0vJITgCuErGSosklI+pMbzKncmeRDvd3wmsotmz094rqRgRAxT2o9yk0in4njwrQpraBkW8iuFUhxon//Sfmwh3Qib3xC62hW4vmUyz+VNTyLmsG4gxBcKnoLrx2ras2d2TTfGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245508; c=relaxed/simple;
	bh=LXDgqcysQchAQtxKVAqF+yisHSm+vLWY9SjQmRJty18=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cvz5BeBGIYKR2CXYu3eSYoihDpQxuzui5EHLnoQAbhyFLpud3VB3Ym4YpX4aaKeXwEEn1ZJvMy3BCbRXNFIaLM07iOamyIcEDQU86p2nuBbcOtr1KrFJCylSJjAK8T0ZPCKd30XJ5Wa6W7Hm8RdWkyBU8YHworfqDZLTqHgMjEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUYQwiT4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764245506; x=1795781506;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LXDgqcysQchAQtxKVAqF+yisHSm+vLWY9SjQmRJty18=;
  b=XUYQwiT4P/J87e6Lu3UoK46XayhegsnTIVCraivdSYjjhskvquoCDTSj
   zagYgu+7+Q9qII21D9AJFMqPC5TdPrOA+GJ6cSSK5qbslSBqxU054P4QP
   RfUTXkn1PfuSP3SaNtoMvbl9s5fOwTSmK/J6dpwt8xMG0gmKCBKc7FyRe
   y267Ce6RyVPfBPXE4TdBzFmAU1mpnMt/7SDZxrOwiJknVuYL1+Qo1kHOk
   5Hvmz2ij3B7N9YRyI+ik6RDXdg+p6eWNhbKB5jDXyQEOe6N7QO8KmcLAl
   VXuhO5+kvi/SJmyniH8tUeYr9ZPU1SDG+7icqXuCmClsUq7ppmAxMs44H
   Q==;
X-CSE-ConnectionGUID: G6Zl0whlQEa+/i3U7SDDzg==
X-CSE-MsgGUID: XF1sDFSCR4OhZ/WHacLAjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77394340"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="77394340"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 04:11:45 -0800
X-CSE-ConnectionGUID: iQmZRf1GSi6r28Y4bJlMNg==
X-CSE-MsgGUID: VTDfkI1zS0642kzT7VHGiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193021648"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 04:11:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 27 Nov 2025 14:11:36 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>, "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Mario Limonciello <superm1@kernel.org>, 
    Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/3] acpi: platform_profile - Add max-power profile
 option
In-Reply-To: <e801bef5-158e-4422-9c23-93dc2210f734@gmx.de>
Message-ID: <bf61e05b-74ac-28de-d8ea-4a909d6e5fb8@linux.intel.com>
References: <20251113212639.459896-1-derekjohn.clark@gmail.com> <20251113212639.459896-2-derekjohn.clark@gmail.com> <7050cadc-9cb7-4f9b-8393-247bddb56965@gmx.de> <CFD27662-0044-4AF3-8E66-65229324CECF@gmail.com> <e801bef5-158e-4422-9c23-93dc2210f734@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 Nov 2025, Armin Wolf wrote:

> Am 16.11.25 um 20:01 schrieb Derek J. Clark:
> 
> > On November 16, 2025 8:13:17 AM PST, Armin Wolf <W_Armin@gmx.de> wrote:
> > > Am 13.11.25 um 22:26 schrieb Derek J. Clark:
> > > 
> > > > Some devices, namely Lenovo Legion devices, have an "extreme" mode where
> > > > power draw is at the maximum limit of the cooling hardware. Add a new
> > > > "max-power" platform profile to properly reflect this operating mode.
> > > > 
> > > > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > > > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > > > ---
> > > >    Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
> > > >    drivers/acpi/platform_profile.c                        | 1 +
> > > >    include/linux/platform_profile.h                       | 1 +
> > > >    3 files changed, 4 insertions(+)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile
> > > > b/Documentation/ABI/testing/sysfs-class-platform-profile
> > > > index dc72adfb830a..fcab26894ec3 100644
> > > > --- a/Documentation/ABI/testing/sysfs-class-platform-profile
> > > > +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> > > > @@ -23,6 +23,8 @@ Description:	This file contains a space-separated
> > > > list of profiles supported
> > > >    					power consumption with a
> > > > slight bias
> > > >    					towards performance
> > > >    		performance		High performance operation
> > > > +		max-power		Higher performance operation that may
> > > > exceed
> > > > +					internal battery draw limits when on
> > > > AC power
> > > I am not sure if it is a good idea to allow platform_profile_cycle() to
> > > cycle into this
> > > new max-power profile. The system could encounter a brownout if it is
> > > currently operating
> > > on battery power when selecting max-power.
> > > 
> > > Maybe we should prevent platform_profile_cylce() from selecting max-power?
> > At least for Lenovo devices unplugging AC will automatically throttle the
> > ppt values to roughly equivalent to performance. It will look at a different
> > WMI data block for the values when switched, so there's no risk for cycling
> > in this case. This seems like smart hardware design, but we've certainly
> > seen bad hardware design so the concern is warranted. Perhaps it is worth
> > visiting if another vendor implements it differently? That being said, what
> > you're describing would match up with how the physical profile selection
> > button works, so it would align with consumer expectation. I have no strong
> > feelings either way, but I'm a little concerned about meeting the merge
> > window as this series fixes a pretty disruptive bug affecting 6.17 users.
> > 
> > Regards,
> > - Derek
> > 
> If the physical platform selection button does not automatically select the
> max-power profile under Windows, then we should copy this behavior i think.
> The changes necessary for that are fairly small, basically you only have to
> extend the handling of PLATFORM_PROFILE_CUSTOM inside platform_profile_cycle()
> to also include the max-power profile. So i would prefer if we modify
> platform_profile_cycle() now has doing this later might be seen as a
> regression.

Derek,

Any comments on this?

I'd very much prefer to take this series in this cycle but this comment 
seems unresolved and has userspace visible impact so may bind us 
irrevocably to certain behavior.

--
 i.

> 
> Thanks,
> Armin Wolf
> 
> > > Other than that:
> > > Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > > 
> > > >    		custom			Driver defined custom profile
> > > >    		====================
> > > > ========================================
> > > >    diff --git a/drivers/acpi/platform_profile.c
> > > > b/drivers/acpi/platform_profile.c
> > > > index b43f4459a4f6..aa1dce05121b 100644
> > > > --- a/drivers/acpi/platform_profile.c
> > > > +++ b/drivers/acpi/platform_profile.c
> > > > @@ -37,6 +37,7 @@ static const char * const profile_names[] = {
> > > >    	[PLATFORM_PROFILE_BALANCED] = "balanced",
> > > >    	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] =
> > > > "balanced-performance",
> > > >    	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
> > > > +	[PLATFORM_PROFILE_MAX_POWER] = "max-power",
> > > >    	[PLATFORM_PROFILE_CUSTOM] = "custom",
> > > >    };
> > > >    static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
> > > > diff --git a/include/linux/platform_profile.h
> > > > b/include/linux/platform_profile.h
> > > > index a299225ab92e..855b28340e95 100644
> > > > --- a/include/linux/platform_profile.h
> > > > +++ b/include/linux/platform_profile.h
> > > > @@ -24,6 +24,7 @@ enum platform_profile_option {
> > > >    	PLATFORM_PROFILE_BALANCED,
> > > >    	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> > > >    	PLATFORM_PROFILE_PERFORMANCE,
> > > > +	PLATFORM_PROFILE_MAX_POWER,
> > > >    	PLATFORM_PROFILE_CUSTOM,
> > > >    	PLATFORM_PROFILE_LAST, /*must always be last */
> > > >    };
> > 
> 

