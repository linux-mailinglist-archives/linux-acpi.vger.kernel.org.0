Return-Path: <linux-acpi+bounces-1067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5617DA090
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 20:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCDF1C2096F
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 18:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C83C6B6
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbwtnDCq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B538F89
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 16:51:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22847E1;
	Fri, 27 Oct 2023 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698425484; x=1729961484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CIzSUICgUbCBinCWTNlvODDWm9cp8C+3Sy6BfA5aCfE=;
  b=PbwtnDCq3Zg6/z6A6EaK57pmxvmkcavverQWMIpHZoOSs8U+iUgOZ+6o
   6nDb71iz0A+IKcy+QSPtXr8TzH+IDHrVDecbWr5I6hpZVhWdlRMZiqxrr
   TuYpVZEbDOksi+NmOm8Ug/F51igJdeBLh//YuAzskH97X73K5+9z/gsw9
   mNvfaSYuPf3o0ZoK2S46EFVRyeM0P85HtVRzRUdbavZz0ohD8jyQbl3uj
   X5DORlVGGKL8lztXCe+grwVf3ZThtI9koUaY50WPWYNJftD1sFdMdMr9w
   U/cRdZw9ngoSNhRMVfFNeqLiVgQpxcPW1oQ2IX9PIH43GPudFUT0YmNPV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="378180553"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="378180553"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 09:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="1006793183"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="1006793183"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 09:51:21 -0700
Date: Fri, 27 Oct 2023 19:51:18 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: rafael@kernel.org, len.brown@intel.com,
	andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTvqYwFWm9PQeKIU@black.fi.intel.com>
References: <20231026083335.12551-1-raag.jadav@intel.com>
 <20231027081855.GK3208943@black.fi.intel.com>
 <ZTuMo2qDO6Aqq3D_@black.fi.intel.com>
 <ZTvGaNZmGWpsM-yw@black.fi.intel.com>
 <20231027142856.GL3208943@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027142856.GL3208943@black.fi.intel.com>

On Fri, Oct 27, 2023 at 05:28:56PM +0300, Mika Westerberg wrote:
> On Fri, Oct 27, 2023 at 05:17:12PM +0300, Raag Jadav wrote:
> > Or perhaps something like,
> > 
> > bool acpi_dev_uid_match(struct acpi_device *adev, const void *uid2, enum uid_type type)
> > {
> >         u64 uid1_d, uid2_d;
> > 
> >         if (type == UID_TYPE_STR) {
> >                 char *uid2_s = (char *)uid2;
> >                 if (!(uid2_s && !kstrtou64(uid2_s, 0, &uid2_d)))
> >                         return false;
> >         } else if (type == UID_TYPE_INT) {
> >                 u64 *uid2_p;
> >                 uid2_p = (u64 *)uid2;
> >                 uid2_d = *uid2_p;
> >         } else {
> >                 return false;
> >         }
> > 
> >         if (!acpi_dev_uid_to_integer(adev, &uid1_d) && uid1_d == uid2_d)
> >                 return true;
> >         else
> >                 return false;
> > }
> > 
> > Although this looks unnecessarily hideous.
> 
> Indeed, but using the _Generic() you should be able to have
> a single acpi_dev_uid_match() to work for either type so:
> 
> acpi_dev_uid_match(adev, "1")
> 
> and
> 
> acpi_dev_uid_match(adev, 1)
> 
> would both work with type checkings etc.
> 
> Not sure if this is worth the trouble though.

Well, in that case we can probably try both and hope for the best ;)

bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
{
        const char *uid1 = acpi_device_uid(adev);
        u64 uid1_d;

        return uid1 && uid2 && (!strcmp(uid1, uid2) ||
               (!kstrtou64(uid1, 0, &uid1_d) && uid1_d == (u64)uid2));
}

But I'm guessing the compiler wouldn't be very happy about this.

Raag

