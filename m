Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1B75C4F8
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGUKsn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGUKsj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 06:48:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE731710
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689936518; x=1721472518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PPKQcDVhLLTeC60IQNJOoLbReyavUTfuP4zZdRc3Nzo=;
  b=DeOgxzfsuzqTSYeppkqo8f+k4L/sbhohAnONKsARHIMoMJqgw+7PZ2/f
   tNUxYA8nMVwQoCmjxrl+ftFf8dawMqpICL/yW1yf+2rRdlHsRkBrhLmE9
   Ydq4ZbLCw0FQ+Kc86NIvjgg61V+zkNZQrc/ybadFdZ+D+DY4u8Tyml3W4
   Sz0NErq5AmhHyrjhv7yvVcOtq1kXrkGVYhpM+y++J6WmIuNKt0suEUZ9+
   SQFmxDdixPfR0bI5Z2gxmzhvKkujEtcn+2B+YsV6UNKuDwpPRbk7aEJHj
   jGJ3akizou5VCYReg1Cjjm2WryD2pCmuZx/dv1kErwUeb3T+vsXgBOlGw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370595468"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370595468"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759913744"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="759913744"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2023 03:48:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMngY-000kCa-2O;
        Fri, 21 Jul 2023 13:48:34 +0300
Date:   Fri, 21 Jul 2023 13:48:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v3 2/4] ACPI: NHLT: Introduce acpi_gbl_nhlt
Message-ID: <ZLpigtZ0ptwhhWEi@smile.fi.intel.com>
References: <20230721094722.300586-1-cezary.rojewski@intel.com>
 <20230721094722.300586-3-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721094722.300586-3-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 21, 2023 at 11:47:20AM +0200, Cezary Rojewski wrote:
> While there is no strict limit to amount of NHLT tables present, usually
> just the first one is utilized. To simplify implementation of sound
> drivers, provide publicly accessible pointer. Accessing it after calling
> acpi_nhlt_get_gbl_table() yields the first NHLT table met during the
> scan.

...

> @@ -594,6 +594,9 @@ config ACPI_PRMT

> +config ACPI_NHLT

Wouldn't be better to squeeze it to the most ordered piece of the file, so
the list of the table support code files will be kinda ordered?


Otherwise looks good to me, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


