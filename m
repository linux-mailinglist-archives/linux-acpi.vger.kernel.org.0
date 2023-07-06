Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D42749E0C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 15:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGFNnc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 09:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGFNna (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 09:43:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AEF1BE1;
        Thu,  6 Jul 2023 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688650996; x=1720186996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z8JzG+0pHRWzsIxrfE6vi7fgy3rjZUBCfJDI1U1jdzs=;
  b=UqmTOtQ3kmp6DuXRftzEBiX1tZ1ZAsC+1JpbERpU98sF7BPxLDDlNiJ6
   IvgYfdWyGJxPKzAhA6zDPKD/erD0LQdH2ZJ/kR4WEmPAgnHnLXXJbrt2U
   o7raXpGjIPZmxacFq0RZsSJake4ZBJvAz7rvhPYGiM3jJNvhWQ5JBdj1g
   F63PTPF3tfzT0eo3Buj4k8WiuzgKTCHGSeX5BB6cU1O8430cVkbqCn0kJ
   x/R79N9pgfozFT4i0rv+ojjzUsQ3TN411iL2uT2mW7WL0uJy8z4YpdbAy
   ljk/Gi6GkCN2MH1RwlXAzFzqHSxmm2i2hBEXddjb59x9yx8OF10ZKVrlj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="449961696"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="449961696"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 06:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893554245"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="893554245"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 06:43:12 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 32E4311F931;
        Thu,  6 Jul 2023 16:43:09 +0300 (EEST)
Date:   Thu, 6 Jul 2023 13:43:09 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 17/18] media: atomisp: csi2-bridge: Add dev_name() to
 acpi_handle_info() logging
Message-ID: <ZKbE7dZOtOTH/0vf@kekkonen.localdomain>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-18-hdegoede@redhat.com>
 <ZKaS2UbkbkbfYqAe@smile.fi.intel.com>
 <20230706111224.GA20921@pendragon.ideasonboard.com>
 <ZKayRcm83vMImkte@smile.fi.intel.com>
 <20230706130708.GD20921@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706130708.GD20921@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2023 at 04:07:08PM +0300, Laurent Pinchart wrote:
> On Thu, Jul 06, 2023 at 03:23:33PM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 06, 2023 at 02:12:24PM +0300, Laurent Pinchart wrote:
> > > On Thu, Jul 06, 2023 at 01:09:29PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Jul 05, 2023 at 11:30:09PM +0200, Hans de Goede wrote:
> > 
> > ...
> > 
> > > > > -			acpi_handle_info(adev->handle, "Using DSM entry %s=%s\n", key, val);
> > > > > +			acpi_handle_info(adev->handle, "%s: Using DSM entry %s=%s\n",
> > > > > +					 dev_name(&adev->dev), key, val);
> > > > 
> > > > Maybe (maybe!) it's a candidate to have something like
> > > > 
> > > > v4l2_acpi_log_info(adev, ...) which combines both and unloads the code from
> > > > thinking about it?
> > > 
> > > Or acpi_dev_info() that would take an acpi_device pointer.
> > 
> > (which is an equivalent to the below)
> > 
> > > Or just just dev_info(&adev->dev) ?
> > 
> > The point is to print ACPI handle *and* device name. There are no existing
> > helpers for that.
> 
> Then a new acpi_dev_info(struct acpi_device *adev, ...) could do that.
> It shouldn't be V4L2-specific in my opinion.

I certainy have no objections for having a helper for this, but IMO the
current code is fine, too.

-- 
Sakari Ailus
