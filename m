Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0245B66E0E9
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 15:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAQOhd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 09:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjAQOhc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 09:37:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF87ED4;
        Tue, 17 Jan 2023 06:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673966250; x=1705502250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kwjWHfUtjufkfTKgHWSyIXT1dESNl3DHo84g5hA3qcQ=;
  b=Cw3LCqqkzcB4mZ26trhpAgMHWltebBEVtXZJOFq4kZL6ITQkWT/72YSd
   55EAsfEGEC7abkufmqUSDhQhCLI/oDHwh13BDTj8TN5ZS/ePOjz1z+i5a
   iQoU02SRnrher1i3+J5suy1Dcht3+QgKzRM0zEsZ6QJdXsWvVDzoX9WxC
   4VxsNUPQmVVPhV6/0+o+ULHRk+48lsPz2Cg39xhbGXqrdSErv0BN01wL6
   q8Z3F8o6ec23uq39u63mMe1IskCOL9fG73C0Q7FKIAurV15Mlkb2E8ZCa
   R9ZrB/uvQW1h3N1cxgtCDiors8Rf0B5g8kUeiS7a0YfUCqnD0wLTAJWWz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326777244"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326777244"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 06:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="904671986"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="904671986"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2023 06:37:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHn5b-00AcHE-0V;
        Tue, 17 Jan 2023 16:37:27 +0200
Date:   Tue, 17 Jan 2023 16:37:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 3/8] device property: Add SOFTWARE_NODE() macro for
 defining software nodes
Message-ID: <Y8aypudRANnMLjn5@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-4-sakari.ailus@linux.intel.com>
 <Y8ayHuBaK2CZa0LD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ayHuBaK2CZa0LD@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 04:35:11PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 02:22:39PM +0200, Sakari Ailus wrote:

...

> > +		.name = _name_,				\
> > +		.properties = _properties_,		\
> > +		.parent = _parent_,			\
> 
> Missed parentheses?

Hmm... It seems the current style in the entire file like this.
Okay.

-- 
With Best Regards,
Andy Shevchenko


