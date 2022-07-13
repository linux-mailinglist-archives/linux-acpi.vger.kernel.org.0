Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50999573C10
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jul 2022 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiGMRhs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jul 2022 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGMRhs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2022 13:37:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24BA2CCBA;
        Wed, 13 Jul 2022 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657733867; x=1689269867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jkI+8p3nzS5uhRs0bvgZsKIkyptdyJilhkJ4VnAOZB8=;
  b=nzW0QCVonDb0+aaSm1DsX6WCaoJ9VVj9wgH/r+h8U0Yr6Kn1U8pHDKVW
   c5mARU3sT4n0fwrilAqt1GLzQiQn+2O/qB9DZ33d+s3nmVGJiFO9/6wmV
   MKocvowpCoLTucPGyVwacSAFtP64VAe0F58UIMwsYMkrvjcyzgUgsxtuh
   38rQqXhapmqTkVW5g7FogOqkH6EFMl3k9ToKEBKAFEcg19yHRUXmVYE4c
   O+FY/7wXZ1FCBGX2EHAasAJMv4x2Ur3kDwxBzz+f+y8YuG9Y0H3KdrfBc
   J+FuBCVbLsQL/gnLYwvYUWiCBy4/F2CXVbtBHiQZ8PCFJEA56ufNvaJ/N
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="371609382"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="371609382"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:36:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="737966971"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:36:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBgHv-001CZF-0z;
        Wed, 13 Jul 2022 20:36:39 +0300
Date:   Wed, 13 Jul 2022 20:36:38 +0300
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
Subject: Re: [PATCH 1/4] gpiolib: add support for bias pull disable
Message-ID: <Ys8CpqYhWp7zVNC8@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
 <20220713131421.1527179-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713131421.1527179-2-nuno.sa@analog.com>
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

On Wed, Jul 13, 2022 at 03:14:18PM +0200, Nuno Sá wrote:
> This change prepares the gpio core to look at firmware flags and set
> 'FLAG_BIAS_DISABLE' if necessary. It works in similar way to
> 'GPIO_PULL_DOWN' and 'GPIO_PULL_UP'.

...

>  	GPIO_PULL_UP			= (1 << 4),
>  	GPIO_PULL_DOWN			= (1 << 5),
> +	GPIO_PULL_DISABLE		= (1 << 6),

To me it seems superfluous. You have already two flags:
PUp
PDown
When none is set --> Pdisable

-- 
With Best Regards,
Andy Shevchenko


