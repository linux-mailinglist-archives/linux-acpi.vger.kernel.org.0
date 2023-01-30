Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA7681CD0
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjA3Ve6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 16:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjA3Ve5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 16:34:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C20C17C;
        Mon, 30 Jan 2023 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114497; x=1706650497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=91mT2guxtmssZqSQ3Oq8hCF3hLtVVz8v9dZYenx0D8Q=;
  b=a/irUYxuYjqjjCa+ULz1fTCSYHBZfhGvWgzpbzYQQne7+OP2ctoSCzK1
   EwItjNKUjQWLDyV2/hCKsq7Oq2yqd2ZiZ1B++2x3jwZrjnyufBv7XWm+/
   e9WX3pPH1Q2F3phBXpuoA2MMBc3DI538EQDWa1H8FxTVnmza1eeHDILmP
   Kv1DzkqZ8TCxWH5gGOutdkJAPCQb26nnSZYjDBgylPFbh1NkzrLLy+lR5
   mk01ok3Q3Q1g4KKjZjWrXoJzNGKidrxvpqY5878fI14rH+MVbocqNeDcE
   +JoWYiplbpwJzWW64BaZo/2I6d3DAkvs6iCouPxaqauQsW3P354G7xg/M
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326342302"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="326342302"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:34:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909652876"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="909652876"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jan 2023 13:34:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMbnh-00HYuB-2T;
        Mon, 30 Jan 2023 23:34:53 +0200
Date:   Mon, 30 Jan 2023 23:34:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 1/8] ACPI: property: Parse data node string references
 in properties
Message-ID: <Y9g3/fSDdBDVwQ+W@smile.fi.intel.com>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-2-sakari.ailus@linux.intel.com>
 <CAJZ5v0g_KhDHRSOu_0tCtJPy9W1vMcXUF=qxc_6YJ=ADRNUv0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g_KhDHRSOu_0tCtJPy9W1vMcXUF=qxc_6YJ=ADRNUv0g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 30, 2023 at 07:21:12PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 25, 2023 at 11:41 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Add support for parsing property references using strings, besides
> > reference objects that were previously supported. This allows also
> > referencing data nodes which was not possible with reference objects.
> >
> > Also add pr_fmt() macro to prefix printouts.
> >
> > While at it, update copyright.
> 
> While there is some design documentation in the last patch, at least
> some pieces of it should go into the changelog of this patch IMO.
> 
> Also the spec-related information from the cover letter would be
> useful here, because cover letters don't go into the git record.

Interestingly if a maintainer starts using `b4` tool it has the mode in which
the series is represented as a pull request and cover letter contents go as a
commit message into the merge commit. That said, it depends on the maintainer's
workflow.

-- 
With Best Regards,
Andy Shevchenko


