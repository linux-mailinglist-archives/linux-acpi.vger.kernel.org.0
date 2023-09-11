Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23479B382
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 02:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbjIKVTj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbjIKPgm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 11:36:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7515E9;
        Mon, 11 Sep 2023 08:36:38 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375464093"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="375464093"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:36:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="743393633"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="743393633"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:36:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qfixl-008MjX-0U;
        Mon, 11 Sep 2023 18:36:33 +0300
Date:   Mon, 11 Sep 2023 18:36:32 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using
 gpiolib private APIs
Message-ID: <ZP80AKHkUyFP7B06@smile.fi.intel.com>
References: <20230909141816.58358-1-hdegoede@redhat.com>
 <20230909141816.58358-7-hdegoede@redhat.com>
 <CAMRc=MfeKirks7N7scu+dh+M1Nf0bNxzC7PE2Q7J4bxgpRnECw@mail.gmail.com>
 <0b1e0312-9144-85ed-666e-a84110b26418@redhat.com>
 <CAMRc=MfVZCqc-v+5oMkTkhfLvq1pE66E7GykqT2ymxzS_kw83w@mail.gmail.com>
 <01a85a3d-c888-11d8-f47e-be2a26d0cb9d@redhat.com>
 <CAMRc=MeGRreVVz=tCnEWtvixV+ZNEXXvG5SVRRmmnWG_sawMcg@mail.gmail.com>
 <bf866db7-1231-2fd6-eedf-b287ca4fa1b8@redhat.com>
 <CAMRc=MdXLBnjFPE8Ac9tFQj6BXEyV6kRyDFNytsdQa++Yk6suw@mail.gmail.com>
 <22698b72-b293-9ad8-908f-f6aee85430d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22698b72-b293-9ad8-908f-f6aee85430d7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 11, 2023 at 04:12:00PM +0200, Hans de Goede wrote:
> On 9/11/23 16:04, Bartosz Golaszewski wrote:

...

> >>>>>>>> +       lookup->dev_id = KBUILD_MODNAME;
> >>>>>>>> +       lookup->table[0].key = chip;
> >>>>>>>> +       lookup->table[0].chip_hwnum = pin;
> >>>>>>>> +       lookup->table[0].con_id = con_id;
> >>>>>>>> +       lookup->table[0].flags = active_low ? GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH;

Actually you can use GPIO_LOOKUP() macro here as it provides a compound
literal.

	lookup->table[0] = GPIO_LOOKUP(...);

> Therefor I don't want to / cannot change the hashes of the commits,
> so a follow-up patch it is.

-- 
With Best Regards,
Andy Shevchenko


