Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C031674B33
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 05:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjATEuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 23:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjATEtl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 23:49:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8D9CE21B;
        Thu, 19 Jan 2023 20:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189814; x=1705725814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mC6/yLW/v5eP5n1rZOeQjtsj6ZTV75jbF/wAVyUTX8w=;
  b=MxCmbRMq20IxmcsEeRTfy0VGCoHtyc657jvFpXdeEvhuNUu3FfXXecm4
   t+VE9CU9G5jgEOntw67TnmksSFSUW3SB2GOhMTzjr4jH04IzAxnY6sjlU
   pw1Y4xUdpYL++RVMTcWUr15EEOsPCyBRWowmXo4yP3MJqrslDX7ilknY3
   GJRuvs6iqulIaca5g0QcWaP0QMoFxhE2MaCTbz3/xang+36s8MsaXx2d6
   QQqPep97pzNdcK6HJIZK2nudKl1EJOjszjnZ4fMHcrmsruxD3wP3Apzt3
   47HWtzyJfl+PMaKwbJkV2wvASlec5eMkFhNwCbgWQx6snlijC+jhvxt4n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="387637452"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="387637452"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:03:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="833990074"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="833990074"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:03:30 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 3C89D20497;
        Thu, 19 Jan 2023 16:03:28 +0200 (EET)
Date:   Thu, 19 Jan 2023 14:03:28 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 1/8] ACPI: property: Parse data node string references in
 properties
Message-ID: <Y8lNsP1B6e+jiCjv@paasikivi.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-2-sakari.ailus@linux.intel.com>
 <Y8aw0KdhM+KJqnj2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8aw0KdhM+KJqnj2@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jan 17, 2023 at 04:29:36PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 02:22:37PM +0200, Sakari Ailus wrote:
> > Add support for parsing property references using strings, besides
> > reference objects that were previously supported. This allows also
> > referencing data nodes which was not possible with reference objects.
> 
> ...
> 
> > +		pr_err("ACPI: bad node type\n");
> 
> 
> Looking at this I'm wondering what prevents us to have pr_fmt() defined as
> it's done in ~60 modules under drivers/acpi already.
> 
> Other than that, LGTM.

Thanks for the review.

I'll add pr_fmt() here, plus print the name of the troubling node.

-- 
Sakari Ailus
