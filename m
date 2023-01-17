Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3C66E0D8
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 15:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAQOfI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 09:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjAQOep (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 09:34:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C0A3EFDD;
        Tue, 17 Jan 2023 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673966069; x=1705502069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NVWH2yqk+u6iJnGmSRoK2kTe6zEZ/IsCLBCA7XERBjk=;
  b=jpg/wqcAn2rKjZB0W9vaCc5cCQt+nIeCSLKqHgdQhy9Jiddo65QkAgf3
   b7GAmLGb4A1SZ7BXTHQvIahPp/tUFHQCH9FXJLF3oAbk5TRAlYvzZBDvG
   jFWwb2tfICfEuYUQmWGSJLgCldek865DFlzrGwqUwQGkPKXnvn9A+4tIt
   G5oMQoFeTyZX8hkD6b6UOjrtCVqvHz7pkOv+ejSmj0Cp9tar9nY/4igF6
   pHeI1i/+ExzwMR+zILMA3oassyzVGc9mNeWqSvzz9bt15h5odrFE6dvlD
   YZLgqQTWASFxgioRim5CTZ9MhDmVk4G0dpKfM9Zcpbos+5lBUnNRz+Ho2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="389206156"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="389206156"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 06:34:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="636887663"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="636887663"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2023 06:34:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHn2X-00AcDa-0z;
        Tue, 17 Jan 2023 16:34:17 +0200
Date:   Tue, 17 Jan 2023 16:34:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y8ax6TUtTCO6qQmz@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117122244.2546597-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:38PM +0200, Sakari Ailus wrote:
> Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> configuration. For now, only figure out where the descriptor is present in
> order to allow adding information from it to related devices.

...

> +/*
> + * MIPI DisCo for Imaging support.
> + *
> + * Copyright (C) 2022 Intel Corporation

2023?

> + */

...

> +#include <linux/acpi.h>
> +#include <linux/module.h>

> +#include <linux/kernel.h>

Not sure why you need this one instead of corresponding types.h and might be a
few others (seems list.h, string.h at least).

> +#include <linux/overflow.h>
> +#include <linux/slab.h>
> +#include <linux/sort.h>

-- 
With Best Regards,
Andy Shevchenko


