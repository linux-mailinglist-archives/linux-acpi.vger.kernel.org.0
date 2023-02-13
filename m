Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189BC694E93
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 19:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBMSB3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 13:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBMSB2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 13:01:28 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2470515CB6;
        Mon, 13 Feb 2023 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676311287; x=1707847287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zfiYtpXmeOgRxJECqmsl4smbrbGOVNgV6uhqjDs/mRI=;
  b=k951xyCx+ol03Eo20P7baWI2ey/7tEcElhHFJsLaSAZ1cwqogut7CgON
   M7kWKTTN1Mkzqu0c5Necu2i4uk17CMnOMxZE60blvL+ZdJlGAzsXkzMM4
   12TG0bVf1m3xwjxDbY+Nc800x4fvzTvcEyrB0PFDI8yLxq1mm0cNWU2bW
   abpP5blg3bku0gHS4Q5GvCg1EvDgr6WEiuKoDHAVNVeYzdb/EdtQR70s3
   g5MDpF5Is3UGV30ddC7dCZ0jpBH16K3aFL+du+jbE3vfp/XI3kyqzgl48
   aq25FBx70VqL1/ZUEqZE9Lr7qMR4t842JLi6mJFnVPd74zvOR7s4b8kV/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333088954"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333088954"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:01:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701360009"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701360009"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2023 10:01:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pRd8i-006Tob-2Y;
        Mon, 13 Feb 2023 20:01:20 +0200
Date:   Mon, 13 Feb 2023 20:01:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
Message-ID: <Y+p68FfTYpUP7B1F@smile.fi.intel.com>
References: <Y+Z5OSa6hepQBOyc@smile.fi.intel.com>
 <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
 <Y+owDqifuU9nf+1i@smile.fi.intel.com>
 <86db79fa-5efb-caad-3310-60928907cc58@amd.com>
 <Y+pLLzLDotZQLpdA@smile.fi.intel.com>
 <97026dc5-e92e-62fe-43ae-33533125d900@tuxedocomputers.com>
 <CAHQZ30Cs+kp82coR10Wat7q3S_8+pFf=5=44kMEMcjBOjmn=6A@mail.gmail.com>
 <Y+p4Sq/WnZ4jAp+F@smile.fi.intel.com>
 <Y+p6I379g+V4vpIc@smile.fi.intel.com>
 <Y+p6mY+w9POvkBzC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+p6mY+w9POvkBzC@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 13, 2023 at 07:59:53PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 13, 2023 at 07:57:55PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 13, 2023 at 07:50:02PM +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 13, 2023 at 10:20:41AM -0700, Raul Rangel wrote:
> > > > On Mon, Feb 13, 2023 at 7:47 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
> > > > > Am 13.02.23 um 15:37 schrieb Andy Shevchenko:

...

> > > > > Schematics for the NH5xAx can also be found on this unofficial clevo mirror
> > > > > (service manuals, scroll to end for schematics):
> > > > >
> > > > > http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AC.zip
> > > > >
> > > > > http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AF1.zip
> > > > >
> > > > > User: repo
> > > > >
> > > > > PW: repo
> > > > >
> > > > > >> The schematics were shared by the reporter for the original issue which is
> > > > > >> how we reached the conclusion there was a mistake.
> > > > > >>
> > > > > >> As they're both Clevo designs it's certainly possible they have the same
> > > > > >> mistake in two systems.
> > > > 
> > > > > > Thank you!
> > > > > > I have looked at the schematics and read discussion.
> > > > > >
> > > > > > So, the conclusion that this is a BIOS bug is incorrect in my opinion.
> > > > > > The problem is either in the PMIC/EC firmware that shouldn't shut down 3.3VS
> > > > > > signal for a while or on the PCB level, so that pull up should be connected
> > > > > > to another power source that stays on.
> > > > > >
> > > > > > This means the description on the initial patch with the same issue is
> > > > > > incorrect.
> > > > > >
> > > > > > Do we know the power sequence on the suspend to see which and how on the
> > > > > > time line the power sources are off/on?
> > > > 
> > > > If you look at the load switch for 3.3VS, its EN2 pin is connected to
> > > > SUSB#_EN which is connected to SUSB# which is connected to
> > > > AND(SUSB#_PCH -> SLP_S3_L, PM_SLP_S0 -> S0A3_GPIO). So there is no
> > > > PMIC/EC firmware that is incharge of this. I guess I'm not quite sure
> > > > how they have S0A3_GPIO configured, so maybe I have an invert wrong.
> > > > 
> > > > The EC does control DD_ON which controls the 3.3V and 5V rails.
> > > 
> > > On page 6 of the schematics I see the U7 that forms SUSB# from SUSB#_APU
> > > (which corresponds to what you said) _and_ EC_EN, which is GPIO from IT5570,
> > > which is EC.
> > > 
> > > Are you using different schematics? I'm using the one from FDO bug report.
> > 
> > Just checked this one:
> > http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AC.zip
> > 
> > Also uses EC (SUSB_EC#).

Sorry, this has to be read as SUSBC_EC#.

> So this all makes me thing that either EC firmware is buggy or we have ACPI EC
> code in the kernel to fix.

-- 
With Best Regards,
Andy Shevchenko


