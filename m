Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01368679F01
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjAXQlk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 11:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjAXQlj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 11:41:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168C4DCC2;
        Tue, 24 Jan 2023 08:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674578479; x=1706114479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fOH7NxoP4cVjU8f4r4+AVTvxlf+jlLFB/2Uvl6zmgIE=;
  b=NJBwI9mdluMRjf9KEoz15j4BWtHT+CCloks4j4K82eaAoeQtF2Z0Bz8G
   wG1lWBJCtCnop5kvqK0opBHOosbm/exgF0vB/6QCH4EWKlpZrLfATdU4u
   OaFWeZugnEo/m5uWZ1wok8Pm3CAqLwswe8eC+Oe9E+xS3mF69U58Vfniv
   ZkwNbS/5xLEjJofn5MLadgfrgkLXKrPO2jotIqT4S3fiQh24U5JzmbkkK
   Pghx2X0mb+Ju5IfTLzbICgkwzcZYjB0mRiVzyNbO4q0vmhBBlpNhTl531
   6aO+caX/JNVu30BPro1sicuSJMFWQUqmSjIP7/Bv9nubWE2PMiR/Edz1X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="412571778"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="412571778"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="730743337"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="730743337"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2023 08:41:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKMMF-00ERGD-0c;
        Tue, 24 Jan 2023 18:41:15 +0200
Date:   Tue, 24 Jan 2023 18:41:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y9AKKlqx7qbkQMuS@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-8-sakari.ailus@linux.intel.com>
 <Y86ncn54H30xyjJU@smile.fi.intel.com>
 <Y8//GN6Eud77cicF@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8//GN6Eud77cicF@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 24, 2023 at 05:54:00PM +0200, Sakari Ailus wrote:
> On Mon, Jan 23, 2023 at 05:27:46PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 23, 2023 at 03:46:16PM +0200, Sakari Ailus wrote:

...

> > > -	{ "mipi-img-lens-focus", "lens-focus" },
> > > -	{ "mipi-img-flash-leds", "flash-leds" },
> > > -	{ "mipi-img-clock-frequency", "clock-frequency" },
> > > -	{ "mipi-img-led-max-current", "led-max-microamp" },
> > > -	{ "mipi-img-flash-max-current", "flash-max-microamp" },
> > > -	{ "mipi-img-flash-max-timeout", "flash-max-timeout-us" },
> > > +	{ MIPI_IMG_PREFIX "lens-focus", "lens-focus" },
> > > +	{ MIPI_IMG_PREFIX "flash-leds", "flash-leds" },
> > > +	{ MIPI_IMG_PREFIX "clock-frequency", "clock-frequency" },
> > > +	{ MIPI_IMG_PREFIX "led-max-current", "led-max-microamp" },
> > > +	{ MIPI_IMG_PREFIX "flash-max-current", "flash-max-microamp" },
> > > +	{ MIPI_IMG_PREFIX "flash-max-timeout", "flash-max-timeout-us" },
> > 
> > I don't thing it ads to the readability, so I don't know why this (part of the)
> > change is needed.
> 
> Ok, I'll drop this chunk.

Thank you. What you can do, though, is to make the second list on the same
column (in the previous patch) if you consider it would be better.

-- 
With Best Regards,
Andy Shevchenko


