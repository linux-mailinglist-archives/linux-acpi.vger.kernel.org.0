Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B3A575142
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiGNO6v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbiGNO6s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 10:58:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8406C6276;
        Thu, 14 Jul 2022 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657810722; x=1689346722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/k3U6MM/QU/ipwYFEym0fsVVyXCQEiy/mFvGfF6OsGQ=;
  b=SumbVcfui8Mnyiyj5p4qGRuWLUsK6BdudPfwy+XBW+y0EEL+dvMRMIcF
   J2N0Xf3YMPsdkWUdIUNxuBULb0BKHDapcv7SHc+uzEmzU1rjoSXQU3aW5
   fntPoDSzsQ9nKBaHzAMFcO/5oxXbiSznviSfa9g+RTcBwzjWjhxtDvh5m
   fNSvBbpxzPdx/ap9u+H+UzCUgyg0NYXaECwOSYABTsBFKXPo+tQiQC9zJ
   n27pWMZRyfZrwbp11UO2skfUu+f8hinoDl+sQCoCAc36HQ9zk7+d1ARkH
   0sVmVu+wtE59TTq4sGrxgx5MDlU626Y5Fs8K2Fv7qeAamsH7CWVUKFVdw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347212130"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="347212130"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 07:58:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="628732300"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 07:58:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oC0IW-001DNE-21;
        Thu, 14 Jul 2022 17:58:36 +0300
Date:   Thu, 14 Jul 2022 17:58:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
Message-ID: <YtAvHMmGay/3HACZ@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713131421.1527179-1-nuno.sa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 13, 2022 at 03:14:17PM +0200, Nuno Sá wrote:
> The gpio core looks at 'FLAG_BIAS_DISABLE' in preparation of calling the
> gpiochip 'set_config()' hook. However, AFAICT, there's no way that this
> flag is set because there's no support for it in firwmare code. Moreover,
> in 'gpiod_configure_flags()', only pull-ups and pull-downs are being
> handled.
> 
> On top of this, there are some users that are looking at
> 'PIN_CONFIG_BIAS_DISABLE' in the 'set_config()' hook. So, unless I'm
> missing something, it looks like this was never working for these chips.
> 
> Note that the ACPI case is only compiled tested. At first glance, it seems
> the current patch is enough but i'm not really sure...

So, I looked closer to the issue you are trying to describe here.

As far as I understand we have 4 state of BIAS in the hardware:
1/ AS IS (defined by firnware)
2/ Disabled (neither PU, not PD)
3/ PU
4/ PD

The case when the default of bias is not disabled (for example specific, and I
think very special, hardware may reset it to PD or PU), it's a hardware driver
responsibility to inform the framework about the real state of the lines and
synchronize it.

Another case is when the firmware sets the line in non-disabled state and
by some reason you need to disable it. The question is, why?

> As a side note, this came to my attention during this patchset [1]
> (and, ofr OF,  was tested with it).
> 
> [1]: https://lore.kernel.org/linux-input/20220708093448.42617-5-nuno.sa@analog.com/

Since this provides a GPIO chip, correct?, it's responsibility of the driver to
synchronize it, no? Basically if you really don't trust firmware, you may
go via all GPIO lines and switch them to the known (in software) state. This
approach on the other hand is error prone, because firmware should know better
which pin is used for which purpose, no? If you don't trust firwmare (in some
cases), then it's a matter of buggy platform that has to be quirked out.

-- 
With Best Regards,
Andy Shevchenko


