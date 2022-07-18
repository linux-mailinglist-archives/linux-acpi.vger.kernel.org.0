Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D23578982
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jul 2022 20:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiGRSZx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jul 2022 14:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiGRSZw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2022 14:25:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DD22D1D7;
        Mon, 18 Jul 2022 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658168751; x=1689704751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZrDvrrA11F1AztQy2Nks0U7/bE0KiSaoQtsQja6PhiM=;
  b=dVYdTtmEVHq75hzPDuYagPMXRPyx6LNdkSvhmHdM6VtxpT8eJ+K7oTvv
   MjoPyNnkpa80riLxUS69F5kKyAtMi3dOwPYSnsjU+ccrOFx00ccxYeOdg
   1tXKdEf9SW244GnrUz9cv2xo0XRQGuA5Xwz+Hsg3Z7NfyfAsZW9/V+q9s
   fPn4som5uh/Yr3hJ4GXOixnx5uU0lSDBa1ZyJvdq5ASD57LrIx/YQWIZy
   En8zK2UgpjsfbM8CirzWWBuQtmYuetMXZvDrV7Wlu9IJDrqbIV1OcdZ02
   muBNFZo2MLrn5QlFl92/3W93T82iGRclG0c0XkOuYFB7G5EzN7jgzCqe3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="311976686"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="311976686"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:25:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="547601715"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:25:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oDVR3-001OO1-1n;
        Mon, 18 Jul 2022 21:25:37 +0300
Date:   Mon, 18 Jul 2022 21:25:37 +0300
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
Subject: Re: [PATCH 3/4] gpiolib: acpi: support bias pull disable
Message-ID: <YtWloTTNtdAPl8Y4@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
 <20220713131421.1527179-4-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713131421.1527179-4-nuno.sa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 13, 2022 at 03:14:20PM +0200, Nuno Sá wrote:
> On top of looking at PULL_UP and PULL_DOWN flags, also look at
> PULL_DISABLE and set the appropriate GPIO flag. The GPIO core will then
> pass down this to controllers that support it.

In case this patch will be in v2,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. I will be on vacation till mid-August.

-- 
With Best Regards,
Andy Shevchenko


