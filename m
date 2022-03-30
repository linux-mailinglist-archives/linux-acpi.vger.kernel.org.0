Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F464EBF73
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 13:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbiC3LDj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 07:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245717AbiC3LDh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 07:03:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81D4BF501;
        Wed, 30 Mar 2022 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648638102; x=1680174102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QMp8wovDI+Z82ZMrv+Dz8OObU/SJH/JXlq0BCZ6Bhhw=;
  b=YQERTWjvQ6njBDlGnhbVhC3iuG5t2JTwZa+5A3TupEgorO2wb5iMAg/+
   UcpbQv4qSGn665bUD1K/oNmI8azxuD37rGjkXGPQpiHzpAEFg9LnvIPms
   69J9V2Yt2D0r6w9dSMbcnb9VEHAQvIAGNvYzYwAw6ysBnOPDo8l5pMf9s
   XF1WTxNNvCTX6BRNz4env67gBsYwnfyBoCq36WnBZVRqwmihsmVLRvjO3
   jKZA3ISGNAsheedhsvgOHbIdVFeJcdWReiLja4KHPRfYdgFSyq0vWCDDE
   IMWkdtN+nULqCF+XVRFANHZheIeYFTLSkeXSCnSOaiVtG6ZewluO0Ce4m
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284421314"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="284421314"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:01:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="695065540"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:01:38 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id BC307203C9;
        Wed, 30 Mar 2022 14:01:36 +0300 (EEST)
Date:   Wed, 30 Mar 2022 14:01:36 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 0/4] Shovel firmware specific code to appropriate
 locations
Message-ID: <YkQ4kEqf7/uhpbyw@paasikivi.fi.intel.com>
References: <20220323154737.169483-1-sakari.ailus@linux.intel.com>
 <YjtI22BnRjfNOVhG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjtI22BnRjfNOVhG@smile.fi.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 23, 2022 at 06:20:43PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 23, 2022 at 05:47:33PM +0200, Sakari Ailus wrote:
> > Hi folks,
> > 
> > This set moves the implementation of recently added device property API
> > functions to OF and ACPI frameworks, where the rest of such functionality
> > resides.
> > 
> > Compile tested.
> 
> Thanks!
> 
> It would be nice to use --base when creating a cover letter.
> Because it has been sent during merge window, I'm not sure
> what base you have chosen for it (v5.17 or latest Linus'
> master or ...).

As noted below, Rafael's devprop branch. But I'll use --base on the next
time. It seems v3 will be needed in any case.


> 
> > The dependencies can be found in Rafael's devprop branch now.
> > 
> > changes since v1:
> > 
> > - Drop wrongly placed Depends-on: tag from the first patch.
> > 
> > - Drop IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode) check (3rd
> >   patch).
> > 
> > Sakari Ailus (4):
> >   device property: Convert device_{dma_supported,get_dma_attr} to fwnode
> >   ACPI: property: Move acpi_fwnode_device_get_match_data() up
> >   device property: Add iomap to fwnode operations
> >   device property: Add irq_get to fwnode operation
> > 
> >  drivers/acpi/property.c | 36 +++++++++++++++++++++++++++++++----
> >  drivers/base/property.c | 42 ++++++-----------------------------------
> >  drivers/of/property.c   | 30 +++++++++++++++++++++++++++++
> >  include/linux/fwnode.h  |  5 +++++
> >  4 files changed, 73 insertions(+), 40 deletions(-)
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Sakari Ailus
