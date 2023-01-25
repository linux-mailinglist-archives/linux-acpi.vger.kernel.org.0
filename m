Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E2D67AB89
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 09:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjAYIZY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 03:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjAYIZX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 03:25:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDAE366AF;
        Wed, 25 Jan 2023 00:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674635122; x=1706171122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZFH6AIXUG3Khdy2PuJCZy25UsEoVFhP6akiXK/BqRTw=;
  b=eucErUzAO4unLNTgwkUC/76P9fGK2Q1QEyUp5+sx6RkMwxPt6v11rkyF
   PUzUhOKbtuIwpQS2YD/g1IrL6/ctltFErlx0IBWFiid3BONvCVskgOMj9
   ltX8o+3EHBipZe7aDi/wx0348zdlMD96EkUBcbQBP0ndwj90eyz2UcyS8
   fNsmkJVW9Vv68sHNzY19n1BQUIl6/1ZZtQikscHwA/Ta2V89MICgBH5Ab
   CcveqUuw7RHGUQSUSWnZFP1Mx15BD1qc69wpo0KdplWqxmIX59dGJDHtA
   s6DXte1+Eoun23KRJ5VmLaq0GCKLhIHpAZxAv80YU8ZauEQn5C9462ELI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="326537407"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="326537407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 00:25:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="612343166"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="612343166"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 00:25:20 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 5A8691219F5;
        Wed, 25 Jan 2023 10:25:17 +0200 (EET)
Date:   Wed, 25 Jan 2023 10:25:17 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y9DnbWI2ikUZwfht@kekkonen.localdomain>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-8-sakari.ailus@linux.intel.com>
 <Y86ncn54H30xyjJU@smile.fi.intel.com>
 <Y8//GN6Eud77cicF@kekkonen.localdomain>
 <Y9AKKlqx7qbkQMuS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9AKKlqx7qbkQMuS@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 24, 2023 at 06:41:14PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 24, 2023 at 05:54:00PM +0200, Sakari Ailus wrote:
> > On Mon, Jan 23, 2023 at 05:27:46PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 23, 2023 at 03:46:16PM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > -	{ "mipi-img-lens-focus", "lens-focus" },
> > > > -	{ "mipi-img-flash-leds", "flash-leds" },
> > > > -	{ "mipi-img-clock-frequency", "clock-frequency" },
> > > > -	{ "mipi-img-led-max-current", "led-max-microamp" },
> > > > -	{ "mipi-img-flash-max-current", "flash-max-microamp" },
> > > > -	{ "mipi-img-flash-max-timeout", "flash-max-timeout-us" },
> > > > +	{ MIPI_IMG_PREFIX "lens-focus", "lens-focus" },
> > > > +	{ MIPI_IMG_PREFIX "flash-leds", "flash-leds" },
> > > > +	{ MIPI_IMG_PREFIX "clock-frequency", "clock-frequency" },
> > > > +	{ MIPI_IMG_PREFIX "led-max-current", "led-max-microamp" },
> > > > +	{ MIPI_IMG_PREFIX "flash-max-current", "flash-max-microamp" },
> > > > +	{ MIPI_IMG_PREFIX "flash-max-timeout", "flash-max-timeout-us" },
> > > 
> > > I don't thing it ads to the readability, so I don't know why this (part of the)
> > > change is needed.
> > 
> > Ok, I'll drop this chunk.
> 
> Thank you. What you can do, though, is to make the second list on the same
> column (in the previous patch) if you consider it would be better.

Yes, makes sense.

-- 
Sakari Ailus
