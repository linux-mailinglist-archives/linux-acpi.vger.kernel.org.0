Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E96753FE
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 12:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjATL7M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 06:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjATL7L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 06:59:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB1DA294B;
        Fri, 20 Jan 2023 03:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674215937; x=1705751937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Az7CQB0S/rJR5u39GAijSzxym8dad1ckNpRDc3eEEz0=;
  b=G+kV9qBbvJ01PQUWGko1J4wrxWV+gksdENHKGveCoYFOHyG4ymaRUMdB
   F/phBeLoopmqZUvhnDhcEYxUFmxlJWAU1+SX3Go2ErCGp/tXVfXDVVFmR
   jqGzCFCLr1s3kr6xIFF3F4E6EH9ebRsuqNd8MYEN97bZRzANDM6l+nvcW
   2I16OUUNpoq7pcGA8iO/chagenQadpJ2zYx8XrthfP217USODtaEFaqSD
   V6H4c952au3xrLzx9mV9GGVMRqh3LHtyPZdLBPQLx0VY6opyfFzv3deix
   ocrbqev5NOLLPqI4hwQVHBPCEjPJLC/lRUnIqEaCBiKeQzSkjzJ+IUBk2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="309137643"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="309137643"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 03:58:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="691027653"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="691027653"
Received: from turnipsi.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 03:58:55 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id DD38020397;
        Fri, 20 Jan 2023 13:58:52 +0200 (EET)
Date:   Fri, 20 Jan 2023 11:58:52 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8qB/B5NfTWRi7Ma@paasikivi.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
 <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
 <Y8lnBeamT90z4aKY@paasikivi.fi.intel.com>
 <Y8lrNe9S4eIdWbXu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lrNe9S4eIdWbXu@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 19, 2023 at 06:09:25PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 19, 2023 at 03:51:33PM +0000, Sakari Ailus wrote:
> > On Tue, Jan 17, 2023 at 05:29:54PM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 17, 2023 at 02:22:43PM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > +	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
> > > > +		   sizeof(MIPI_IMG_PREFIX) - 1))
> > > 
> > > str_has_prefix()
> > 
> > str_has_prefix() calls strlen() on prefix on every call. sizeof() will
> > generate much less code --- it's just a number.
> 
> Have you tried that? Because the strlen() over const string literals will be
> optimized away on compilation time.

Actually not. There seem to be an implementation of strlen() in
include/linux/fortify-string.h that would seem to be capable of doing that.
However its use is conditional to kernel configuration.

-- 
Sakari Ailus
