Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5A678091
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjAWPyM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjAWPyL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:54:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3F535A4;
        Mon, 23 Jan 2023 07:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674489250; x=1706025250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ScOdPjf2pYLAZxeWCWhIsJeyc/9tzW9eBFfnmUNFF40=;
  b=NkTGihHYtsuYWyzTrSoRKiNeqGn7WL5dE3wJui/y1ZWFVR1ez+UjGj/6
   SWz1ZKF8M24w66VCDTz2huxtLQP1GpeoHw8yqM+vmX50Et8L43b/bQJbl
   KABSFIf41zroXmiAWDgcF6feaN0FbkYS+Hbt+Vrw//jAQMJ+AnGkq7WNi
   Hrsn6tU2vGri/2Juv/39OGkNCeDO3CUiRwPTZUMnVWo7+HISJ0gz0fs3J
   HH3DQfMcUf4tePwxKqO0kdBsYDflRCDPCP9QOo7hg3vij/uCl0MLTlJ73
   yibmAZ7RUmSLbkvl+MrqPiy/aLBYobZwGDhbLY81dppXwGnNyQTYlGSMD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="309647973"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="309647973"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 07:54:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="693955728"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="693955728"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 07:54:02 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id DFD3D11F782;
        Mon, 23 Jan 2023 17:53:59 +0200 (EET)
Date:   Mon, 23 Jan 2023 17:53:59 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 1/8] ACPI: property: Parse data node string references
 in properties
Message-ID: <Y86tl2YIP5ZX5W7p@kekkonen.localdomain>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-2-sakari.ailus@linux.intel.com>
 <Y86e9YeHXrNLfwHY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86e9YeHXrNLfwHY@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Mon, Jan 23, 2023 at 04:51:33PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 23, 2023 at 03:46:10PM +0200, Sakari Ailus wrote:
> > Add support for parsing property references using strings, besides
> > reference objects that were previously supported. This allows also
> > referencing data nodes which was not possible with reference objects.
> > 
> > Also add pr_fmt() macro to prefix printouts.
> > 
> > While at it, update copyright.
> 
> ...
> 
> > - * Copyright (C) 2014, Intel Corporation
> > + * Copyright (C) 2014--2023, Intel Corporation
> 
> Isn't one dash enough? 
> 
> $ git grep -n 'opyright.*[0-9]--[0-9]' | wc -l
> 37
> 
> $ git grep -n 'opyright.*[0-9]-[0-9]' | wc -l
> 15064

This is a range, not hyphenation. There's no different character in the
ASCII character set for the former, commonly two regular dashes are used.
There probably would be a correct Unicode character though.

> 
> 
> >   * All rights reserved.
> >   *
> >   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> >   *          Darren Hart <dvhart@linux.intel.com>
> >   *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > + *	    Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Seems wrong indentation in comparison to the others.

Tabs are preferred for intendation. I can change all the lines to use tab.
How about that?

> 
> >   */
> 
> ...
> 
> > +static struct fwnode_handle *
> > +acpi_parse_string_ref(const struct fwnode_handle *fwnode, const char *refstring)
> > +{
> > +	acpi_handle scope, handle;
> > +	struct acpi_data_node *dn;
> > +	struct acpi_device *device;
> > +	acpi_status status;
> > +
> > +	if (is_acpi_device_node(fwnode)) {
> 
> > +		scope = to_acpi_device_node(fwnode)->handle;
> 
> Interestingly that we have a helper for this -- ACPI_HANDLE_FWNODE()...
> 
> > +	} else if (is_acpi_data_node(fwnode)) {
> 
> > +		scope = to_acpi_data_node(fwnode)->handle;
> 
> ...but not for this.

I'd either prefer to keep them as-is, as it's easy to see what's being done
there, or add a new macro --- or a function to do this.  Say,
acpi_fwnode_acpi_handle(), as this is clearly ACPI specific and to
differentiate between ACPI handles and fwnode handles.

ACPI_HANDLE_FWNODE()'s name suggests it would do something else than it
does, if you consider the current fwnode API.

-- 
Kind regards,

Sakari Ailus
