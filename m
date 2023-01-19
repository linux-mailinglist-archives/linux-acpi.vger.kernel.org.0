Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62436673B60
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 15:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjASOL7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 09:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjASOLX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 09:11:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8483B829A5;
        Thu, 19 Jan 2023 06:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674137389; x=1705673389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PNmoKYRJVjDp4F17/eUveCKQAApp+O2ZjxB9O8O8wrg=;
  b=hgyugTjKw7I53S+5Vl8pekG7zY5XHdmtEEdXX01A0rGAi9MbL9JGz9uG
   HSBUPlJ8w5QWkkzuS3AlucMXTq+4LNFaXZ0tE7ly9ciVoK9xOPirtkMSX
   9p022+D8XthVHs9zgsA/OOuG6+618jM3BjzbtThuTQijViK2VAnxRv55p
   5rJyKDnRx4GsEP2MNpRzLlv9qvmApx8KgFPbDyFi3dD1VluY5ro5CE0xg
   hLpQXcbCgMcxOZBCBrHJ/pizXrOAL4394iAhH3/3gXLNVdPDz8/WRE7M/
   At/zH2Lte8y/6c3svA2j9fBVRqNbj/gBYaBfFLCvN/fhCHxwd/MSIlT9g
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327369183"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="327369183"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:04:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="690636743"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="690636743"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:04:10 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id A7F4C20497;
        Thu, 19 Jan 2023 16:04:08 +0200 (EET)
Date:   Thu, 19 Jan 2023 14:04:08 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y8lN2FuKZksOlS0J@paasikivi.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-3-sakari.ailus@linux.intel.com>
 <Y8ax6TUtTCO6qQmz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ax6TUtTCO6qQmz@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jan 17, 2023 at 04:34:17PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 02:22:38PM +0200, Sakari Ailus wrote:
> > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > configuration. For now, only figure out where the descriptor is present in
> > order to allow adding information from it to related devices.
> 
> ...
> 
> > +/*
> > + * MIPI DisCo for Imaging support.
> > + *
> > + * Copyright (C) 2022 Intel Corporation
> 
> 2023?

Yes.

> 
> > + */
> 
> ...
> 
> > +#include <linux/acpi.h>
> > +#include <linux/module.h>
> 
> > +#include <linux/kernel.h>
> 
> Not sure why you need this one instead of corresponding types.h and might be a
> few others (seems list.h, string.h at least).

Good catch.

I'll fix these for v2.

> 
> > +#include <linux/overflow.h>
> > +#include <linux/slab.h>
> > +#include <linux/sort.h>

-- 
Sakari Ailus
