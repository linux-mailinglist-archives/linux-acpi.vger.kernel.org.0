Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C182C681D20
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 22:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjA3VqN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 16:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjA3VqL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 16:46:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B1C49431;
        Mon, 30 Jan 2023 13:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675115163; x=1706651163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmCCSZ7EUYBKRLybCtb7/j5vKBXVYnjNgQjXvcl29wo=;
  b=fYZTpB+aOHCrGdmbiW1yVBpRfOR7wONieMdnwavtlzSdP19/eTFlOzPj
   I3ZFz2L9kvJxndlkSljUSCEQlePnnn1MkQiuQbl5/JetMe7beFqw8557l
   O6Ne6tLxDifKrGD2qtx2fI8EqEpXn5Y/0f1q293r/dzRZRftb5l7zKfA/
   osKXSRxwToxQJmnTxibEY5D26BV2Lo7cz+anirYScOpoDZx2Pf9zpbjh1
   61kQ90eI2j+vIlxDFP0hPV4qYZ5EG7yYU4FFbcg7uTIU7StxgbG2tywLM
   aTNBBip1mSbSgV+aP3X0NMrltcXDXldDOPpW5vBkb/wTTCfNhwrZ8TXiD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390046961"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="390046961"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:46:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="664239804"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="664239804"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:46:01 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 621FC1202B0;
        Mon, 30 Jan 2023 23:45:58 +0200 (EET)
Date:   Mon, 30 Jan 2023 23:45:58 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y9g6lkE1Yakjc07U@kekkonen.localdomain>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-3-sakari.ailus@linux.intel.com>
 <Y9Oip7cLqWgdzKry@smile.fi.intel.com>
 <Y9g0JvBWvn9Rsi7Q@kekkonen.localdomain>
 <Y9g4sSdDgplq1niN@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9g4sSdDgplq1niN@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 30, 2023 at 11:37:53PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 30, 2023 at 11:18:30PM +0200, Sakari Ailus wrote:
> > On Fri, Jan 27, 2023 at 12:08:39PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jan 26, 2023 at 12:40:55AM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > +	/* Collect the devices that have a _CRS CSI-2 resource */
> > > > +	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,
> > > 
> > > Other serial buses limit the DEPTH by 32, why do we need more here?
> > 
> > I'm using the same value as for scanning devices to be added. Effectively
> > this is not a practical limit but it doesn't need to be.
> 
> Hmm... Theoretically one may supply a malformed table, quite compact, but with
> huge amount of "fake" devices. I would limit this the same way. If we got a
> report of the depth not being enough we may bump based on the reality. This also
> may limit scanning time.

Then this should be done also for scanning ACPI devices below.

I'd like to have Rafael's opinion before making such changes. I'll prepend
such a patch to the series in that case.

-- 
Sakari Ailus
