Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1B77BCCB
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Aug 2023 17:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjHNPP4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Aug 2023 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjHNPPv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Aug 2023 11:15:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F4A1735;
        Mon, 14 Aug 2023 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692026126; x=1723562126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lIMpV+W7YmVMVwOyDQd8JNNCLggqNMdvE6byXIvkzq4=;
  b=J3TGuOErcKeHAvfb+otUOF9XORIzQAhvoO27oQ0Bxxi5xJ0t6GjgHJW2
   bVxcppsE5EsQblLX1mt0H4gtLy7lKfXkCREqBkkOwhKQz2Xa9JrdVfiSS
   7MIw3fifH9n7C5s5S9wXMGZKV1Grr1f76XOMSV9yXfSWw4nNJdSClZ4D8
   anLKPkFyOHLIO19IJRQzJiWi8Vj5K8nucgdGVboQJs3gcx4BPs1qxp9W6
   UZzBjnZanFV7c1VYO15yCTXQJZUFyD9/AFaqQ6mzHUIHrfU24SsJyQeJ3
   7pff2QEfcnRuzZe+UHt3SQe7t9BuFpfwe+KdZXj2vxDnftW5DZvk4Lo6j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357021978"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="357021978"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683341625"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="683341625"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2023 08:15:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVZHh-00AEuP-2z;
        Mon, 14 Aug 2023 18:15:09 +0300
Date:   Mon, 14 Aug 2023 18:15:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Ruan Jinjie <ruanjinjie@huawei.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] gpiolib: acpi: Use LIST_HEAD() to initialize the
 list_head
Message-ID: <ZNpE/QsbREv5b8Ji@smile.fi.intel.com>
References: <20230812071423.3481790-1-ruanjinjie@huawei.com>
 <CAMRc=Md2D39ciYT6TmWRN60z16rD5uEkn8vuzj=Ap8fcchoAbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md2D39ciYT6TmWRN60z16rD5uEkn8vuzj=Ap8fcchoAbA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Aug 13, 2023 at 08:49:28PM +0200, Bartosz Golaszewski wrote:
> On Sat, Aug 12, 2023 at 9:14 AM Ruan Jinjie <ruanjinjie@huawei.com> wrote:
> >
> > Use LIST_HEAD() to initialize the list_head instead of open-coding it.

...

> My opinion: this is actually less readable than what is there now and
> I doubt the compiler would generate less code. With this change I now
> need to check what LIST_HEAD() actually does, while defining a temp
> variable of a clear type and then using a macro to initialize it is
> much more obvious.
> 
> I'll let Andy decide as ACPI is his domain but for me it's a NAK.

The code is identical, I have no strong opinion (I'm fine with the either),
since you already have an opinion, let it be NAK then.

-- 
With Best Regards,
Andy Shevchenko


