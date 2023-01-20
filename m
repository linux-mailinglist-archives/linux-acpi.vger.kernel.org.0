Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADAE67602D
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 23:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjATWeM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 17:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjATWeL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 17:34:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC6E63E3C;
        Fri, 20 Jan 2023 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674254047; x=1705790047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zo5M3gHxFkisjU6k7e7ZgCPdIm/H9EaePh8Ny1GQ5KA=;
  b=OloH04B/Qqh3dDQVPt12TJFB6rSqZGmwND5AP1E6nfMdhsRw5A1/wrK7
   HYi767GMvmxwASEI3YkBNJUtAtZbwBrNgnP9QfaogLAq8G1ac7tyJ/03a
   oejElFYASMhIuq2lYqThXhNebxmcD7m59IZTNDOiDk2eGliKWT2X4Fqed
   ov2umFmg/Sa1JnNK0WAZmmQF/iBYH24GXYcjpP3j/S737zE+ZhH29uiyi
   IO4ENv20vshXgdof9NOQqNDmO7gw8JOtctnTyZ11edMZD0UYthtRD3e3A
   c35XuE82MVtG4j5JiNQCJ16i5OigBfUB2bng1y0dF5Y8Lxxj4KmwdsWjo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="327802019"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="327802019"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 14:34:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="724104009"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="724104009"
Received: from turnipsi.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 14:34:05 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 048A4201C4;
        Sat, 21 Jan 2023 00:34:03 +0200 (EET)
Date:   Fri, 20 Jan 2023 22:34:02 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8sW2ud+Ae3VeSuM@paasikivi.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
 <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
 <Y8lnBeamT90z4aKY@paasikivi.fi.intel.com>
 <Y8lrNe9S4eIdWbXu@smile.fi.intel.com>
 <Y8qB/B5NfTWRi7Ma@paasikivi.fi.intel.com>
 <Y8qvHzbs1J9pS9nj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qvHzbs1J9pS9nj@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 20, 2023 at 05:11:27PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 20, 2023 at 11:58:52AM +0000, Sakari Ailus wrote:
> > On Thu, Jan 19, 2023 at 06:09:25PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jan 19, 2023 at 03:51:33PM +0000, Sakari Ailus wrote:
> > > > On Tue, Jan 17, 2023 at 05:29:54PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Jan 17, 2023 at 02:22:43PM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > > > +	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
> > > > > > +		   sizeof(MIPI_IMG_PREFIX) - 1))
> > > > > 
> > > > > str_has_prefix()
> > > > 
> > > > str_has_prefix() calls strlen() on prefix on every call. sizeof() will
> > > > generate much less code --- it's just a number.
> > > 
> > > Have you tried that? Because the strlen() over const string literals will be
> > > optimized away on compilation time.
> > 
> > Actually not. There seem to be an implementation of strlen() in
> > include/linux/fortify-string.h that would seem to be capable of doing that.
> > However its use is conditional to kernel configuration.
> 
> Ah, you missed probably the ability of the complier to find constant literals
> and replace the strlen() with plain number.

It seems GCC does this if -foptimize-strlen (included in -O2) is given.
Fair enough, I'll replace it with str_has_prefix() for v2.

-- 
Sakari Ailus
