Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071CA535CB0
	for <lists+linux-acpi@lfdr.de>; Fri, 27 May 2022 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbiE0JHV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 May 2022 05:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351055AbiE0JFr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2022 05:05:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60AD939E4
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2022 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653642143; x=1685178143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eYsKa4e6mwgarVAZTBWD6inWdHMk22CA5K+u/TXbC2U=;
  b=HowRhLrPKmGp7z0kyvV26JpkYRTpRE8V3gf0ISAc0hvCx9fy+gznlGxk
   /GM2LK9CZ0JHi1YmZ4led/UxLBIN0mmsquxfOIhpSTkyDLX+exYHYUhVq
   G2yV6LVgq6/Jsl6WUqsjMWdevUJ2fViFICGzMxUEW0sGx5xg9wE5awzpR
   yjfa1SoxNdj6Sq7KkawHTLWn2XbSBeWIiRzDFr/y4+FaMNUr1SxWSaKuN
   6NDm3n7mVyiXT6bkVsMW/TAzonvPX6tFYER4zqOVxHOYS1dZ35LirWhBk
   ktB8osbrCDDB+Iw5srr0SuuUjg7YthsKAbLnIPLtlvjGU2mSVXsjkbf3C
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="273239453"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="273239453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 02:02:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="718800217"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 02:02:08 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id ADB88201A7;
        Fri, 27 May 2022 12:02:06 +0300 (EEST)
Date:   Fri, 27 May 2022 12:02:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/8] ACPI: property: Tie data nodes to acpi handles
Message-ID: <YpCTjhncY4fhDjMq@paasikivi.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0jrFQk2aH78Fg=W+6KAzhony3yZ+NjYy8ki5atKoaPwLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jrFQk2aH78Fg=W+6KAzhony3yZ+NjYy8ki5atKoaPwLw@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Thu, May 26, 2022 at 09:19:17PM +0200, Rafael J. Wysocki wrote:
> > +static int acpi_tie_nondev_subnodes(struct acpi_device_data *data)
> > +{
> > +       struct acpi_data_node *dn;
> > +
> > +       list_for_each_entry(dn, &data->subnodes, sibling) {
> > +               acpi_status status;
> > +               int ret;
> > +
> > +               status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
> > +               if (ACPI_FAILURE(status)) {
> > +                       acpi_handle_err(dn->handle, "Can't tag data node\n");
> > +                       return 0;
> > +               }
> > +
> > +               ret = acpi_tie_nondev_subnodes(&dn->data);
> > +               if (ret)
> > +                       return ret;
> 
> Is it actually possible that this returns anything different from 0?

acpi_attach_data() involves allocating memory and resolving a reference.
Both can fail.

-- 
Regards,

Sakari Ailus
