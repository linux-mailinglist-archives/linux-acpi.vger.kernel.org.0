Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF964B51AA
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Feb 2022 14:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354141AbiBNNbq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Feb 2022 08:31:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344785AbiBNNbp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Feb 2022 08:31:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA2517C8;
        Mon, 14 Feb 2022 05:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644845498; x=1676381498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y96b8f/pQJU6phYk9vLPVtS3w06gqAZOxKS7YK/5+Lo=;
  b=E0iu1peoY65ZBZll4OedkMo3DRz/sT+n8c4y/OEimv+K/7HWiwW4+BBc
   +DX0op235iOZZWZ0g0YxeV3mt+r+UOs5P7pVY68slqQPfr85KzNmW7xfW
   0FHPewmjyyOvG7eTJPAnyyz0g+BYkS8Z9M6Kk0aARToZdVq+cSSWphXkg
   TO3ScZ4uAXIl9GfVhmZs/wnpFEZTdtwYD59QkYU8fG22K2GAAlMSqvnt8
   Xc7lTikkOkuerCXaX9Qn6sNZxg5JHc/P/Xtbi5j2/yxvIvYgT8i4vhbMb
   UMUI9msuZB3+XvRDljmz2kmMHaauliyWEO8CqqQzet8Mp6FDMb3UAb0sv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250035170"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250035170"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:31:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="538610916"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:31:35 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 80845201DB;
        Mon, 14 Feb 2022 15:31:33 +0200 (EET)
Date:   Mon, 14 Feb 2022 15:31:33 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/4] device property: Convert
 device_{dma_supported,get_dma_attr} to fwnode
Message-ID: <YgpZtZwtE0kKupu4@paasikivi.fi.intel.com>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
 <20220206091643.276833-2-sakari.ailus@linux.intel.com>
 <YgaG6sQjKs+ZxNm6@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgaG6sQjKs+ZxNm6@robh.at.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rob,

On Fri, Feb 11, 2022 at 09:55:22AM -0600, Rob Herring wrote:
> On Sun, Feb 06, 2022 at 11:16:40AM +0200, Sakari Ailus wrote:
> > Make the device_dma_supported and device_get_dma_attr functions to use the
> > fwnode ops, and move the implementation to ACPI and OF frameworks.
> > 
> > Depends-on: ("device property: Don't split fwnode_get_irq*() APIs in the code")
> 
> Is this some new convention? What's wrong with 'base-commit' and 
> shouldn't it be below the '---'?

I guess that could be possible, too. There are different practices it
seems.

I'll add commit id in v2 (or drop the tag if the dependent patch hits the
linux-acpi tree soonish).

> 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/property.c | 14 ++++++++++++++
> >  drivers/base/property.c | 25 ++++---------------------
> >  drivers/of/property.c   | 17 +++++++++++++++++
> >  include/linux/fwnode.h  |  3 +++
> >  4 files changed, 38 insertions(+), 21 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks!

-- 
Sakari Ailus
