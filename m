Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC2673DF6
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 16:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjASPvu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 10:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjASPvt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 10:51:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E283C3;
        Thu, 19 Jan 2023 07:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674143509; x=1705679509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xy6l2X+dEkwOdo2FNcoF44iRE9KKxdXQD7DoE2dX/6M=;
  b=JTDJdZIani2nMxal0b4EhIUl82VZWsjGILGRNtcjMkhRrPp/ZxsA+TzZ
   6AuY74jVmdEJJyMuA8fPs/hWWA2J2+vfgGmpOW2AAR7/noWFSoK3aboA0
   PeR4KAp0+4Z2LSpkRLmAcS9MAR5hY90eaZbk+ivpQOABx73Iq8/+e4EhD
   SXTmfGzBqkRSpEpjgSg+QxIdHpBl1Ht1ItbpPnD5uR9nrw33hEHEF963M
   nU7uUoqnqsmY4MvFj4i6+TcZYFplnkobxtMW8KYHjRcXXu7Pi26rQQU7P
   cxkLGDLHG/61w9WSvoDR+7EFxCBdGUFn+QJzCN6JkTIGE0biTmSpJRS3l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327418020"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="327418020"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:51:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="653430187"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="653430187"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:51:36 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C39D620497;
        Thu, 19 Jan 2023 17:51:33 +0200 (EET)
Date:   Thu, 19 Jan 2023 15:51:33 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8lnBeamT90z4aKY@paasikivi.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
 <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jan 17, 2023 at 05:29:54PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 02:22:43PM +0200, Sakari Ailus wrote:
> > For all _DSD properties, skip going through the MIPI DisCo for Imaging
> > property name substitution table if the property doesn't have "mipi-img-"
> > prefix.
> 
> ...
> 
> > +#define MIPI_IMG_PREFIX "mipi-img-"
> 
> I don't think this is good for readability.

It should be used at least below, where it is referred twice.

I'm open to removing this from the table though.

> 
> ...
> 
> > +	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
> > +		   sizeof(MIPI_IMG_PREFIX) - 1))
> 
> str_has_prefix()

str_has_prefix() calls strlen() on prefix on every call. sizeof() will
generate much less code --- it's just a number.

> 
> > +		return;

-- 
Regards,

Sakari Ailus
