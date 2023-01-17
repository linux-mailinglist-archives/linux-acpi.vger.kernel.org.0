Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A28366E22C
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 16:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjAQPaO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 10:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjAQP36 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 10:29:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358230EBF;
        Tue, 17 Jan 2023 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673969398; x=1705505398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XxwipVAWmJahkeSSitKzk+AnKlTFXO268/T6NIHA6o8=;
  b=djATvUziNWaiB9bxexKCpHGChtP8ZV6RIEYHpTiEi5j6S6bLkV17nsiN
   iAZYh6mNPViPvxbWQFf0o+uhXdRQ8rd/Bk0fVetz+S/HZdbw8uKcxCA+F
   KkfIyrwQerjcRycuNuhqHuth6eiuYdHgiBwtzndBsdP2iBYdP3p7mK9mL
   VHjv2JMfDMPWbGO4JKcYMGXr4AnPSQcAURZaxmEZSEhn/QR4D0VUAHhqM
   uQdYQIc2AlqVtmnobxo2e9JLUovZuUJN0bZLUrJdF4Xd6/khbQsr+gURZ
   SCE6QSYsFXmOKjH1gJr7LhGD7Ai+/w5/hcZB1Szsn+rXp7sbxqbpmaTl0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410958474"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="410958474"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:29:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783270861"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783270861"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2023 07:29:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHnuM-00AdWl-2y;
        Tue, 17 Jan 2023 17:29:54 +0200
Date:   Tue, 17 Jan 2023 17:29:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:43PM +0200, Sakari Ailus wrote:
> For all _DSD properties, skip going through the MIPI DisCo for Imaging
> property name substitution table if the property doesn't have "mipi-img-"
> prefix.

...

> +#define MIPI_IMG_PREFIX "mipi-img-"

I don't think this is good for readability.

...

> +	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
> +		   sizeof(MIPI_IMG_PREFIX) - 1))

str_has_prefix()

> +		return;

-- 
With Best Regards,
Andy Shevchenko


