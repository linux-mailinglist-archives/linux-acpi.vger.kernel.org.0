Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0C675421
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 13:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjATMHr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 07:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjATMHr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 07:07:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539997DFB4;
        Fri, 20 Jan 2023 04:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674216466; x=1705752466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wGsL+FRlPGOUktRxfw3uWphKrQUIp+u9wRu1aYmf4w=;
  b=lP+cjgnOXW6d/R8hwvzLrkFTtGDI1cZMYuPLy0q1WfjkB5i9+xlOC+4Z
   iPyTgWhesjhqSp0fZs5pevXH6tQhBt/K8Q+L0fiSSOBrdDEwxMFoe2wbY
   kUpLGTr3ombriCVlkFfbtc3S6DEuRN/D8xW3LhhAdJ+y+k6zXtNjuuHam
   ZAAtYAzh0D4kuXSLD6R/Q4u0Lo9jwNmLPWR+kyBDDGURycCTo0q1UtVZM
   xcZw9+w1kXqbUHXaOzLsVE+b6u+NrlsS0zjNMttGLQplX3wmhQ0goCV0K
   pEHZVUya8/1zdNXIlCjAx5HmtM9dBtxFwp8c/ArwINudV/fVc9QC+zgcA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323255650"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="323255650"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:07:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="723936023"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="723936023"
Received: from turnipsi.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:07:43 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 86DE520397;
        Fri, 20 Jan 2023 14:07:41 +0200 (EET)
Date:   Fri, 20 Jan 2023 12:07:41 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8qEDXxKS8VO8NLv@paasikivi.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
 <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
 <Y8lnBeamT90z4aKY@paasikivi.fi.intel.com>
 <Y8lrNe9S4eIdWbXu@smile.fi.intel.com>
 <Y8lrn0P0+CRPWUOV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lrn0P0+CRPWUOV@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 19, 2023 at 06:11:11PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 19, 2023 at 06:09:26PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 19, 2023 at 03:51:33PM +0000, Sakari Ailus wrote:
> > > On Tue, Jan 17, 2023 at 05:29:54PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Jan 17, 2023 at 02:22:43PM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > > +	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
> > > > > +		   sizeof(MIPI_IMG_PREFIX) - 1))
> > > > 
> > > > str_has_prefix()
> > > 
> > > str_has_prefix() calls strlen() on prefix on every call. sizeof() will
> > > generate much less code --- it's just a number.
> > 
> > Have you tried that? Because the strlen() over const string literals will be
> > optimized away on compilation time.
> 
> Probably that's the reason behind __always_inline for that function.

For str_has_prefix() the reason probably is that inlining that function
generates less code than when not doing so.

-- 
Sakari Ailus
