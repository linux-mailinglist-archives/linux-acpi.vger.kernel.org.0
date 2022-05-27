Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40830535DBF
	for <lists+linux-acpi@lfdr.de>; Fri, 27 May 2022 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350747AbiE0KCB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 May 2022 06:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350728AbiE0KCA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2022 06:02:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDDF5B3F0
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2022 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653645719; x=1685181719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AAr/czPNDSFNgpifeUkpIuwM+0tIfgiUZBVSrJjoKbs=;
  b=FGtSV9BHUJ0ia8MVtIyvJA/quLexnLT9YrbFdhleZstsfrSzKiAyLt/o
   ceNlQQ5ffl0zZomWxHj1iI3fdntJcRbcEiLzUxHxD2j50CE6+xDsjYC0+
   CKFEDYB2OPIUq1u70bTr6ji1u5g3n/pCh9ilx5ft6YaamXf9aPezJ3fDN
   orluRPVQIcDF0N/HboD58YKAIDVjOPkrF5a+Ijg9/zlmEHckTVag4FRkV
   jFE8fWZ6urLiRKAcaUapaeysP8Gua6+M8T7I/szKtFt2HKnuGULpWBq3d
   4ho8W78qyBh37D7V/MenuxnepzHBxrr8Q5ubyScLVND+a2I30wLtAxe1X
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335088311"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="335088311"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 03:01:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="560686081"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 03:01:58 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id DA4E6201A7;
        Fri, 27 May 2022 13:01:55 +0300 (EEST)
Date:   Fri, 27 May 2022 13:01:55 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 8/8] ACPI: property: Read buffer properties as integers
Message-ID: <YpChk8dtDe/xqMOQ@paasikivi.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-9-sakari.ailus@linux.intel.com>
 <Yo5pNjsb2oNX9Knf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo5pNjsb2oNX9Knf@smile.fi.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, May 25, 2022 at 08:36:54PM +0300, Andy Shevchenko wrote:
> On Wed, May 25, 2022 at 04:01:23PM +0300, Sakari Ailus wrote:
> > Instead of adding a new property type, read buffer properties as integers.
> > Even though the internal representation in ACPI is different, the data
> > type is the same (byte) than on 8-bit integers.
> 
> ...
> 
> > +	switch (proptype) {
> > +	case DEV_PROP_STRING:
> > +		break;
> > +	case DEV_PROP_U8 ... DEV_PROP_U64:
> > +		if (obj->type == ACPI_TYPE_BUFFER) {
> 
> > +			if (nval <= obj->buffer.length)
> > +				break;
> > +			return -EOVERFLOW;
> 
> Why not traditional pattern and be consistent with default case?
> 
> 			if (nval > obj->buffer.length)
> 				return -EOVERFLOW;
> 			break;

Agreed.

> 
> > +		}
> > +		fallthrough;
> > +	default:
> > +		if (nval > obj->package.count)
> > +			return -EOVERFLOW;
> 
> I would add break statement here.

Sounds good.

-- 
Sakari Ailus
