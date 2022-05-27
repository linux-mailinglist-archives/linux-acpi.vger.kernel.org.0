Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64719536851
	for <lists+linux-acpi@lfdr.de>; Fri, 27 May 2022 22:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiE0U7S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 May 2022 16:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiE0U7S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2022 16:59:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44A13274A
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2022 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653685157; x=1685221157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qVG5S73qlUdvHseErthJtZSxDkw3Yb6PhoP1G+1dxXU=;
  b=FAgSID09nr2nNa7Lv+etOBmsfrTbT76MS3SrVlPDWJy28O3bMcS+iag/
   cI5nf9z41ExFGDCzw6smd5E7QSQ+I1PIsUeBJKKIxtbYXHnZD27cuK+Ax
   DFJU88eGYrxxeF9OfkilE1piye6u3BWsjuO59QdSLfgL795QtJmyRNckE
   TsKJ+cV/Yyt4K+HSoSXIwAO/YIi4XjqCu4aFHCNqM0pcH339r7G42RQv4
   Z20tPqpiw4K24SBgtzdyhPwiLI/Wj0wFGBvqJ6l+8F6lywbAHVWUVcVb5
   v2cBHvGkGZ7/Zl92KZx5hQjpZ7PnnM6yuu2watulk4b/v42k/N47dzulo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274583749"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="274583749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:59:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="665626565"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:59:15 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id A1B612064F;
        Fri, 27 May 2022 23:59:13 +0300 (EEST)
Date:   Fri, 27 May 2022 23:59:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/8] ACPI: property: Tie data nodes to acpi handles
Message-ID: <YpE7oTE5iy97jbjZ@paasikivi.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0jrFQk2aH78Fg=W+6KAzhony3yZ+NjYy8ki5atKoaPwLw@mail.gmail.com>
 <YpCTjhncY4fhDjMq@paasikivi.fi.intel.com>
 <CAJZ5v0jM3rayEkAT21aReau+n-mZsNzVeQjH0wS5c1F+s5OgsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jM3rayEkAT21aReau+n-mZsNzVeQjH0wS5c1F+s5OgsQ@mail.gmail.com>
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

On Fri, May 27, 2022 at 07:04:39PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 27, 2022 at 11:02 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Thu, May 26, 2022 at 09:19:17PM +0200, Rafael J. Wysocki wrote:
> > > > +static int acpi_tie_nondev_subnodes(struct acpi_device_data *data)
> > > > +{
> > > > +       struct acpi_data_node *dn;
> > > > +
> > > > +       list_for_each_entry(dn, &data->subnodes, sibling) {
> > > > +               acpi_status status;
> > > > +               int ret;
> > > > +
> > > > +               status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
> > > > +               if (ACPI_FAILURE(status)) {
> > > > +                       acpi_handle_err(dn->handle, "Can't tag data node\n");
> > > > +                       return 0;
> > > > +               }
> > > > +
> > > > +               ret = acpi_tie_nondev_subnodes(&dn->data);
> > > > +               if (ret)
> > > > +                       return ret;
> > >
> > > Is it actually possible that this returns anything different from 0?
> >
> > acpi_attach_data() involves allocating memory and resolving a reference.
> > Both can fail.
> 
> Yes, they can, but the value returned by acpi_attach_data() is
> effectively ignored above (except for printing the error message,
> which BTW could be "info" and provide more information).

Oops. Good point.

I intended this to return an error here. I don't have strong opinion on
which way to go though. How about changing that to -ENOMEM?

I think this is basically a decision on whether any subnodes could be
referenced if ore or more of them could not. I don't expect this to happen
in practice.

> 
> I don't see how acpi_tie_nondev_subnodes() can produce a nonzero return value.

-- 
Kind regards,

Sakari Ailus
