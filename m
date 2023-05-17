Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3204A706E80
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEQQr7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEQQr5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 12:47:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CDE59DC;
        Wed, 17 May 2023 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684342076; x=1715878076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3aGbiMN0V+5yc6Amt+Y7GgCQxqWtHVXzMieUoBpl1Y0=;
  b=NwujApARbS7z1+LSFfGoME6jThv38EVEpbFbdRsSmpRq/iKKAQs2HeIZ
   jJlEWubv7r4iGiwuTLAoRvQDvWLxJqRj7o/J9WXzngQy4EoBJsBFjI9fP
   rjdNxavDWXW5CtSU2AU4CXvE46E1VGSbPUVKcaIhu2AllfO55IQEvDp/c
   klRU9gK1V50fBPsHNXAkzXK9LcKuGS9MjHnNCNR+7Wku7Z6T6iqyuvMCF
   kWe+DgG5JMjPI14pnwIsQ3G4My6eP10PKejM0RsYy3mD463l6zeQWwYre
   5r1AdcPFAxjCiiWSiu3Qu9/g1ujYOThj1fqnHQWKXQuQni50baQfZV707
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="351834340"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="351834340"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 09:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="948338934"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="948338934"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2023 09:47:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pzKJL-0008UB-36;
        Wed, 17 May 2023 19:47:35 +0300
Date:   Wed, 17 May 2023 19:47:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Wolfram Sang <wsa@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        netdev@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 2/7] iio: mb1232: relax return value check for IRQ get
Message-ID: <ZGUFJ5LRCzW2V0a1@smile.fi.intel.com>
References: <cover.1684220962.git.mazziesaccount@gmail.com>
 <429804dac3b1ea55dd233d1e2fdf94240e2f2b93.1684220962.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429804dac3b1ea55dd233d1e2fdf94240e2f2b93.1684220962.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 16, 2023 at 10:12:41AM +0300, Matti Vaittinen wrote:
> fwnode_irq_get() was changed to not return 0 anymore.
> 
> Drop check for return value 0.

...

> -	if (data->irqnr <= 0) {
> +	if (data->irqnr < 0) {
>  		/* usage of interrupt is optional */
>  		data->irqnr = -1;
>  	} else {


After this change I'm not sure we need this branch at all, I mean that -errn is
equal to -1 in the code (but needs to be checked for silly checks like == -1).

Hence

Entire excerpt can be replaced with

	if (data->irqnr > 0) {

-- 
With Best Regards,
Andy Shevchenko


