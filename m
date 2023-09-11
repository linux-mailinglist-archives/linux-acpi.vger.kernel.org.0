Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CBF79A2CA
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Sep 2023 07:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjIKFYY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 01:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjIKFYX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 01:24:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806CB1AD;
        Sun, 10 Sep 2023 22:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694409859; x=1725945859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CccuJ6hYNZI7rvMkvWj1E5gRID51QCCa3dq0hBm5MDM=;
  b=OFdkxMc4hoMWVu46fTPIIlfmYwgUOuRqMUBxXRa/lfD110KfDfqqG/Ld
   MUptxajG769r3Zyjfx1+gdG5pyc6SNqrqPQKnAbJqlFJekyXcqnzraEDW
   Ll+ci7PzxMBPhUJ0Bg2nQ6wBNbH/VJi2aBgyiMkIMyOgwUiRvKNNgNICN
   a0blDPzaf5XiEdnwceSZioJsIlxYfx0ZMhDHYyZel4yKq7QwURq390uA7
   AabeihsnmtVCrsUFxWkjmo66kDhcSKaKIIUr3L+kSoWWlij6I2W6AyXi/
   oKsw5EBCRq6zVLl1Pr0gwVwJ6r/gAiKAJ0KvCJATR+IpoM1mWj1S4wgOj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="464374824"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="464374824"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 22:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778258536"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778258536"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Sep 2023 22:24:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8AA87497; Mon, 11 Sep 2023 08:24:15 +0300 (EEST)
Date:   Mon, 11 Sep 2023 08:24:15 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/8] gpiolib: acpi: Check if a GPIO is listed in
 ignore_interrupt earlier
Message-ID: <20230911052415.GV1599918@black.fi.intel.com>
References: <20230909141816.58358-1-hdegoede@redhat.com>
 <20230909141816.58358-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230909141816.58358-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 09, 2023 at 04:18:09PM +0200, Hans de Goede wrote:
> In some cases where a broken AEI is present for a GPIO and the GPIO
> is listed in the ignore_interrupt list to avoid the broken event
> handler, the kernel may want to use the GPIO for another purpose.
> 
> Before this change trying to use such a GPIO for another purpose would
> fail, because the ignore_interrupt list was only checked after
> the acpi_request_own_gpiod() call, causing the GPIO to already be
> claimed even though it is listed in the ignore_interrupt list.
> 
> Fix this by moving the ignore_interrupt list to above
> the acpi_request_own_gpiod() call.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
