Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C2358779
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhDHOvH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 10:51:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:55774 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhDHOvG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Apr 2021 10:51:06 -0400
IronPort-SDR: PyfR4KSRMWhwIODmzjvS2Ds8ZZmESnEeetwQV1Twb/Y+VQy5/9pN9fkvwzNfFks15IExRVhGW5
 1SA7FPuNHQAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193098223"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="193098223"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:50:54 -0700
IronPort-SDR: BS4SlAfK9CZiY//qxN6ZKNqI5YZNfe0ydolQv7hV/Jlm95wCYH1X2Wh1rWiwOuB1a+8dzJ0y3r
 5FT64U57HTrg==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="381748717"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:50:51 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lUVzc-002JWc-BM; Thu, 08 Apr 2021 17:50:48 +0300
Date:   Thu, 8 Apr 2021 17:50:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/6] software node: Free resources explicitly when
 swnode_register() fails
Message-ID: <YG8YSPHMBbBJadvp@smile.fi.intel.com>
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
 <YGRXmOMfCTxy31Rj@kuha.fi.intel.com>
 <CAJZ5v0jJCYD9+j57-CL-OqiZKL7bBQ7NetcewE_37wODOG_Jkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jJCYD9+j57-CL-OqiZKL7bBQ7NetcewE_37wODOG_Jkg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 08, 2021 at 04:15:37PM +0200, Rafael J. Wysocki wrote:
> On Wed, Mar 31, 2021 at 1:06 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Mon, Mar 29, 2021 at 06:12:02PM +0300, Andy Shevchenko wrote:
> > > Currently we have a slightly twisted logic in swnode_register().
> > > It frees resources that it doesn't allocate on error path and
> > > in once case it relies on the ->release() implementation.
> > >
> > > Untwist the logic by freeing resources explicitly when swnode_register()
> > > fails. Currently it happens only in fwnode_create_software_node().
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > It all looks OK to me. FWIW, for the whole series:
> >
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Whole series applied (with some minor changelog edits) as 5.13 material, thanks!

It seems Greg applied it already. Was it dropped there?

-- 
With Best Regards,
Andy Shevchenko


