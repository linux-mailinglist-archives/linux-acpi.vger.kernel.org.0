Return-Path: <linux-acpi+bounces-976-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5217D7353
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8CB1C20CE9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4AD30F8D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gocPp/+N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738920B00
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 18:21:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D81E5;
	Wed, 25 Oct 2023 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698258079; x=1729794079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1XxRYZev688GItXPqGvO0ocX1uiRbGTVxSVwMDhhgRM=;
  b=gocPp/+NV/0biID18u4XD5TMjjrQSked8lNk7k/TZ4pCyW5qO1AcExtk
   ki6E07cZLQCvfvpCUTqpvTSM+ls2cVu/nDWZVlj0SQeqWOK2IykT+s0qM
   9WuO2dgjlO9JumKcbnt6Ot/8YMT5mF1xDVKNDkWyZM3FF1vcmTdnIj4mq
   t2RJyQE5WhECrjR+0JG4ubvwE+WmRCyIt4EZVCY6TJ+Cjn7m7R1yt/g/G
   U2XGL801wntGxU1ud/RY8DjZc4XOTyTtkJNbeIOLWhRj92+BKHFECFCgl
   XFBWjTdzH4KQ4sDdGQgAlrm+2XolYHRjDN1V7J58yJyLEbsCNq78HldPC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="155295"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="155295"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735475743"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="735475743"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:21:15 -0700
Date: Wed, 25 Oct 2023 21:21:12 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, len.brown@intel.com,
	andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com
Subject: Re: [PATCH v1] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <ZTlcmA0VpE2jsbUQ@black.fi.intel.com>
References: <20231025053833.16014-1-raag.jadav@intel.com>
 <20231025055345.GI3208943@black.fi.intel.com>
 <CAJZ5v0iYA3Qh=KQm_+XGm=jvLO=ZN-AyYx7DW=-EiqkE5LS19Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iYA3Qh=KQm_+XGm=jvLO=ZN-AyYx7DW=-EiqkE5LS19Q@mail.gmail.com>

On Wed, Oct 25, 2023 at 08:04:44PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 25, 2023 at 7:53 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Wed, Oct 25, 2023 at 11:08:33AM +0530, Raag Jadav wrote:
> > > Use acpi_dev_uid_match() for matching _UID instead of treating it
> > > as an integer.
> > >
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> I was about to apply this, but then I realized that it might change
> the behavior in a subtle way, because what if the _UID string is
> something like "01"?

I checked the git history and found below.

commit 2a036e489eb1571810126d6fa47bd8af1e237c08
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue Sep 13 19:31:41 2022 +0300

    ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()

    ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
    an integer. Use it instead of custom approach.

    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Reviewed-by: Hans de Goede <hdegoede@redhat.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index c4d4d21391d7..4d415e210c32 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -167,10 +167,10 @@ static struct pwm_lookup byt_pwm_lookup[] = {

 static void byt_pwm_setup(struct lpss_private_data *pdata)
 {
-       struct acpi_device *adev = pdata->adev;
+       u64 uid;

        /* Only call pwm_add_table for the first PWM controller */
-       if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
+       if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
                return;

        pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));

So if we consider the original logic with strcmp, which is more inline
with acpi_dev_uid_match(), "01" should not be the case here in my opinion.

Thanks for sharing your concern though.

Raag

