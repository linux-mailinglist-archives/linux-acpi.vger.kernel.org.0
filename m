Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8804757516D
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiGNPId (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 11:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbiGNPId (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 11:08:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB6643D6;
        Thu, 14 Jul 2022 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657811311; x=1689347311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=M13fIbDJULnHlBOH1WrfeY3SuDM0Ce08MRrVwA7sIjo=;
  b=BfVBLJiWV7y26E/JxL46ua10lh3BOpB3CVnZ+bBzJkGCkMXRFJjDTk8Q
   KKbLXrNcbFXxt+VDdRttTJK1yK+uHiPGBleMRxdc6c70oRsFodkH7YHg4
   u07MocklZ+n5shP1FeqCrbvS1NUDK4EXaxGDVEtZiRxuWvBSn+dmWrL37
   n9Bq3mCSUQQwTQow7f+2Dyedl3WseK6HhIAS6nkv6rbk3nGF+JSLYak9j
   C4OeM2DlQeNysBKb7TsfZQMosc7NliAJ2oGatPUl0hiEbuNrupkjB9r8m
   iAgu3uv03gsZDM6a6YvxH2TES1yWLA1L6GnAO+a8TnzIoxn7KYBwrfJ6Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286278935"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="286278935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 08:08:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="546300032"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 08:08:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oC0S1-001DNj-0c;
        Thu, 14 Jul 2022 18:08:25 +0300
Date:   Thu, 14 Jul 2022 18:08:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] gpiolib: add support for bias pull disable
Message-ID: <YtAxaCsQTrUiI4ir@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
 <20220713131421.1527179-2-nuno.sa@analog.com>
 <Ys8CpqYhWp7zVNC8@smile.fi.intel.com>
 <20220714042050.GA76737@sol>
 <4bf06ba5994f559499c45275cd7f44bfee1bbde1.camel@gmail.com>
 <20220714082710.GA103849@sol>
 <35e8020f513a77b8a8eb12a45d48a2b1390cce7c.camel@gmail.com>
 <20220714120005.GA105609@sol>
 <fc0ce1235dce7303aac7bcc45b856fcca60fcb57.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc0ce1235dce7303aac7bcc45b856fcca60fcb57.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 14, 2022 at 03:02:08PM +0200, Nuno Sá wrote:
> On Thu, 2022-07-14 at 20:00 +0800, Kent Gibson wrote:
> > On Thu, Jul 14, 2022 at 10:47:27AM +0200, Nuno Sá wrote:

...

> > If that solves your immediate problem then you need to decide what
> > problem your patch is trying to address.
> 
> So my patch is trying to solve exactly this case because (IMO), it does
> not make sense for consumers drivers to have to do the above code.
> Moreover, they would need some custom firmware property (eg:
> devicetree) for the cases where we want to disable BIAS since we cannot
> just assume we want to do it.

Why? This is the main question. Why do you need that _in kernel_ API.

> Well, maybe we can just assume FLAG_BIAS_DISABLE in gpiolib (when
> trying to get the gpiod) if no PULL is specified. However, I do have
> some concerns with it (see my conversation with Andy in the cover).

It's AS IS if you trust firmware.

-- 
With Best Regards,
Andy Shevchenko


