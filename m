Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B9B749DC7
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 15:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjGFNcV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 09:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFNcU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 09:32:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E281BD2;
        Thu,  6 Jul 2023 06:32:12 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="348391468"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="348391468"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 06:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="832945839"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="832945839"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2023 06:31:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHP5E-000XZf-1X;
        Thu, 06 Jul 2023 16:31:44 +0300
Date:   Thu, 6 Jul 2023 16:31:44 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 15/18] ACPI: bus: Introduce acpi_match_acpi_device()
 function
Message-ID: <ZKbCQMqkQvOIkEmq@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-16-hdegoede@redhat.com>
 <ZKaHErGZOVXXDn9c@smile.fi.intel.com>
 <08825217-ff29-1f58-220d-617570836542@redhat.com>
 <CAJZ5v0imzHiNxff3RQJvMzvr_xWHXERoyzYmLyZS7hASO0qN+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0imzHiNxff3RQJvMzvr_xWHXERoyzYmLyZS7hASO0qN+A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2023 at 03:26:20PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 6, 2023 at 2:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > On 7/6/23 11:19, Andy Shevchenko wrote:
> > > On Wed, Jul 05, 2023 at 11:30:07PM +0200, Hans de Goede wrote:

...

> > > Looks like it's v1 of my original patch, anyway this is now in Linux Next as
> > > 2b5ae9604949 ("ACPI: bus: Introduce acpi_match_acpi_device() helper").
> >
> > Ah interesting, it does indeed look a lot like your version.
> > but it was developed independently.
> >
> > Unfortunately it seems that this is headed for 6.6-rc1 and the atomisp
> > changes in this series which rely on this are intended for 6.6-rc1 too.
> 
> No, the material Andy is talking about will be pushed for 6.5-rc1
> (probably even today), because it is part of a fix for systems that
> are broken in the field.

Oh, totally forgot about that.

> > So we still need to figure out how to merge this.
> 
> This shouldn't be a problem.

True, and thank you!

-- 
With Best Regards,
Andy Shevchenko


