Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C69679EF1
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 17:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjAXQkO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 11:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjAXQkK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 11:40:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3E9A279;
        Tue, 24 Jan 2023 08:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674578409; x=1706114409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IksX4wpcB+MFIUinNI6e5TYnsevlGCPZHT63PmhJRAA=;
  b=n3EC5dyXzXIFR2VlJ74/21Si7syNIq0HxsLUkZn1AKxnOhHO5uQBwfzN
   3Ytd4BGu/H4tTLrUwpEDZz/gxJTmJ64QN35mtpEKSaR0UMt8vaN8XqaVK
   f+7mIpJSH0dLByF6lvoflKADU9Sp47wmqe9mZNUgnYoLZSf194FioFWdd
   w3ir8oFVyCk/AyV6Znpu0olTY/Db8fnP64sPcXonTzho8hZ2wogOsZNXI
   RXlG9aPj+6eCeyqe+U6oSo6sUyS7Rl4G5urNaRLFwWl2JVaqWkdntcWYP
   cUxEx8Avf4fFJ5/VV0cQf/f8udWwPFoi3udyY1tCCMSTGEcAorKwwT74V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="325015521"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="325015521"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:40:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="694410665"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="694410665"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2023 08:40:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKML7-00EREl-1v;
        Tue, 24 Jan 2023 18:40:05 +0200
Date:   Tue, 24 Jan 2023 18:40:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y9AJ5fRWHIqIKnpj@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-3-sakari.ailus@linux.intel.com>
 <Y86inXQ+nEoFiosr@smile.fi.intel.com>
 <Y86wzwrlvro3RFto@kekkonen.localdomain>
 <Y87DBSUo1IJZmMDO@smile.fi.intel.com>
 <Y8/+qHPNKYaQmTCv@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/+qHPNKYaQmTCv@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 24, 2023 at 05:52:08PM +0200, Sakari Ailus wrote:
> On Mon, Jan 23, 2023 at 07:25:25PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 23, 2023 at 06:07:43PM +0200, Sakari Ailus wrote:
> > > On Mon, Jan 23, 2023 at 05:07:09PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Jan 23, 2023 at 03:46:11PM +0200, Sakari Ailus wrote:

...

> > > > > +	memcpy(inst->remote_name, csi2->resource_source.string_ptr,
> > > > > +	       csi2->resource_source.string_length);
> > > > 
> > > > Why don't we use strscpy()? Is it really strings? Or is it some abuse of
> > > > the ACPI object type?
> > > 
> > > I didn't find a guarantee it would be nil terminated. Albeit I'm fine
> > > switching to strscpy() if there's such a guarantee.
> > 
> > Following this logic neither memcpy() (and especially memcpy()!) call
> > guarantees that. But hold on, have you actually read strscpy() documentation?
> 
> Yes. And there is such a guarantee, too. The string_length contains the
> length of the string, including the terminating nil character. I have no
> problem with strscpy() but it won't affect the end result in any way. :-)

At run time won't be any differences, at reading and maintaining it has a lot.
It gets rid of the confusion: "is this actually string or not?"

-- 
With Best Regards,
Andy Shevchenko


