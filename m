Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73EC51D9F8
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356317AbiEFOMo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 10:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiEFOMo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 10:12:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D126542F
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651846141; x=1683382141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/YPvqktr//b1XeoXWbV8Zi9QyR9BUpe+t6hYsGQGNE0=;
  b=MKWnP+MyJ1QT4R2qQSzQMKjzUfTtVlaxGuDYlNF0jjydwY7FlJMNVg1d
   9RCseE77b2JxD+3akDR0gAq+ixgC5VsAXLW5jwEvfkB6GdJXcIQZ3Xn4j
   vpmDc8aYZXCFrxcEZieEylVhtRQf5a7rZtgfXxvYtVSWe31kLreIhskc/
   wpNiKxQRStlET1gzufXuekKm2QRIyHkMSdV1xchvjrZQMVN0mh/0RyTCn
   f/9YBiBh3YZP+4XF9U4LVupV21mwkDIX8u542y96cYiqe6JTzvUOXDArJ
   m3C7oErNpTG7Ut6n3W9znQeSjhjzpRP5ENvDrxAuYeXS+LHZ4J6aQjVvi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="293683539"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293683539"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 07:09:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="632943584"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 07:08:59 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C9F21202C2;
        Fri,  6 May 2022 17:08:57 +0300 (EEST)
Date:   Fri, 6 May 2022 17:08:57 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 07/11] ACPI: Initialise device child list early to access
 data nodes early
Message-ID: <YnUr+b1KB57ps926@paasikivi.fi.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
 <20220506130025.984026-8-sakari.ailus@linux.intel.com>
 <CAJZ5v0gQR+zFdWqst1D-XYkwwZJkNuBen1-acxFWRY=2Ty6Sdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gQR+zFdWqst1D-XYkwwZJkNuBen1-acxFWRY=2Ty6Sdw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Fri, May 06, 2022 at 03:28:10PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 6, 2022 at 2:58 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > The properties, including data nodes, are initialised in
> > acpi_init_device_object(). Traversing the data nodes also requires the
> > device's child list to be initialised which happens much later in
> > __acpi_device_add(). The function also makes the device visible in the
> > system, so setting up its properties and nodes is too late by then.
> >
> > To address this, move the child list initialisation before
> > acpi_init_properties() in acpi_init_device_object().
> >
> > Note that this is currently not an issue as the properties will only be
> > accessed by drivers. In the near future accessing the properties will be
> > done in the ACPI framework itself, and doing so requires this change.
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> There is a problem with this that the children list is redundant and
> not really safe to use and so it will be dropped.  I actually have a
> series of patches to do that in the works.
> 
> I'm also unsure why it would be necessary to initialize the list of
> the device's children earlier, because adding anything to that list
> requires a child device object to be registered with cannot happen
> before registering the parent itself.

I actually intended to send this one later if it were to be still relevant.
Please ignore it for now, I'll drop it from v2.

It is currently needed needed for accessing device's data nodes before
registering the device.

-- 
Sakari Ailus
