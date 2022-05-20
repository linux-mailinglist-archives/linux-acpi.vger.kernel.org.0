Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477852E4DD
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 08:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiETGNP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 02:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiETGNL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 02:13:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58E39968E
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653027190; x=1684563190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BDnHfBv+T1QPEXfV0OiKK5Ll3lbmuIQ3FhPcb7EgSGU=;
  b=j0TpjxaL9ZjYkcWB9/+4XEm5+x9HuQvGgD0E+vRt5VNQgjK0PCJhDF4v
   x0rccb9ZW64dEd+Z6qqIz4fmucnDqo2zYQCiGZE9RYo13q8YTFkhTZwGN
   dh0fVrNt72O+vTSFEkGG1VxcQiOxyPBRUEFIDRcEtJBaGUm+pPZpTEEq8
   bZbNB9je0zNXf98LeEuK/jIhwE45kNq7lJ9b0szDGkJiEKxT1aw1InpM3
   P8KdAKRWktoakmeSPBAXv76TRGOt0OKuHp9eQWCtB0bi8Mf58hlgxGuQu
   w2mrY/GvgsGeOmWBbVvCCWvADKi2owVNf17gM0xs0X4s4Oy2a77B6qtdi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="270089178"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="270089178"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:13:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="701590916"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 23:13:08 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 964F9203C9;
        Fri, 20 May 2022 09:13:06 +0300 (EEST)
Date:   Fri, 20 May 2022 09:13:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 02/11] ACPI: acpica: Constify pathname argument for
 acpi_get_handle()
Message-ID: <YocxciJSTkc5leZa@paasikivi.fi.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
 <20220506130025.984026-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0ip==ZYopb3sJvyrNpErpa1gGaJLk+OfLgff3x2tH98Og@mail.gmail.com>
 <YoUbUQkjKATrgf6n@paasikivi.fi.intel.com>
 <CAJZ5v0jvzHbD6fxNKYJ75eCc3A008fDTf8kA4nP5FK5EvuTS-w@mail.gmail.com>
 <YoVL/uDnwpfoVQwV@paasikivi.fi.intel.com>
 <CAJZ5v0i2UfBKdD1uHa8R-cuHiTbX1Fc3+ow=Pz1tcpfDhpWS3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i2UfBKdD1uHa8R-cuHiTbX1Fc3+ow=Pz1tcpfDhpWS3w@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Rafael,

On Thu, May 19, 2022 at 08:05:00PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 18, 2022 at 9:41 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Wed, May 18, 2022 at 09:07:31PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, May 18, 2022 at 6:14 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > On Tue, May 17, 2022 at 06:21:44PM +0200, Rafael J. Wysocki wrote:
> > > > > On Fri, May 6, 2022 at 2:58 PM Sakari Ailus
> > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > >
> > > > > > acpi_get_handle() uses the pathname argument to find a handle related to
> > > > > > that pathname but it does not need to modify it. Make it const, in order
> > > > > > to be able to pass const pathname to it.
> > > > > >
> > > > > > Cc: "Moore, Robert" <robert.moore@intel.com>
> > > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > >
> > > > > Which patches in the rest of the series depend on this one?
> > > >
> > > > "ACPI: property: Parse data node string references in properties", i.e.
> > > > patch 8 in this set.
> > >
> > > So I think I can apply the rest of the series, except for patch 8 and
> > > patch 7 (as per the previous discussion) for the upcoming merge
> > > window.
> > >
> > > Would that work?
> >
> > I suppose it would apply to this one, too?
> 
> Patch [2/11] will come to the kernel from upstream ACPICA at one point.
> 
> > Postponing these works for me.
> 
> So I tried to apply the series without patches [2,7-8/11], but that
> didn't work (patch [9/11] did not apply).
> 
> Please resubmit without them or let's defer the entire series until we
> get patch [2/11] from ACPICA.

v2 sent, with these three patches dropped. Funnily enough, I saw no
conflicts with your linux-next branch. git am is more picky than git rebase
though.

-- 
Kind regards,

Sakari Ailus
