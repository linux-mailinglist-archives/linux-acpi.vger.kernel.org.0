Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31E7573C15
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jul 2022 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiGMRjv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jul 2022 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiGMRjr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2022 13:39:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F652CDDE;
        Wed, 13 Jul 2022 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657733986; x=1689269986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gSo9n+h/0n7VMQiSc66NjBQwHdhMPYnAit+C0irfWRk=;
  b=nu1iN2V6aigRBY3Z0TMAIO50y3OwrIUfgJOsYuWCby3OoJMeqU/CyM8l
   +EgBJ3FwxoP3iB8Ljy80YhATmXQ81ajwjmWEuldglYQBvnMxBuZJ0G90q
   xP8/axci8TIqpbwoe+gMP2aBXABKmZmpJgXtdSR767HA0/q+pS/1zN75O
   OBFm0a2BGXCUMfoR+pP3tJQ2j27MWsVrQIP8/gMXTK1RdyvlcHbtbaiTs
   H6/sGHPciY9QfdqRUwhlUScRYts5cvfjN7HawYj5bBEFKnh5vGX6xvnop
   UauEhQh7D48y86OEKalDv0Qpo1p8naVgwRAJXyQeg7f+jbfmRmAmTK2cJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282849828"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="282849828"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:39:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570728793"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:39:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBgKK-001CZP-1u;
        Wed, 13 Jul 2022 20:39:08 +0300
Date:   Wed, 13 Jul 2022 20:39:08 +0300
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
Message-ID: <Ys8DPCzRa1qo2AKJ@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713131421.1527179-1-nuno.sa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

Isn't it enough?

> On top of this, there are some users that are looking at
> 'PIN_CONFIG_BIAS_DISABLE' in the 'set_config()' hook. So, unless I'm
> missing something, it looks like this was never working for these chips.

It seems you are looking into wrong source of issues. Isn't it a issue of
particular pin control driver?

> Note that the ACPI case is only compiled tested. At first glance, it seems
> the current patch is enough but i'm not really sure...
> 
> As a side note, this came to my attention during this patchset [1]
> (and, ofr OF,  was tested with it).

-- 
With Best Regards,
Andy Shevchenko


