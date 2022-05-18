Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05C52C39B
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbiERTl5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 15:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbiERTlz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 15:41:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43386F49A
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 12:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652902914; x=1684438914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LnpJx/XkP9sNggOyn9xGGPVlppO639xUEc+UGjeupgo=;
  b=fVGczIHfxfW7TH4mvgZBldSHa+MXMMFseuUyvDR43qtvhCZPc+DSrGkn
   y1aJB1bCXnG7KDCumQpS1H+M4D89/cHr+HI9PdiOi38upwZilQHWODCcb
   b4fLWqH+0Y4b9loblGYeY6MPLP9ABcR8A+KzA8vmOlYqRE8TDFDdw6RHD
   Up4YM7OcDL3MSrE0wyxajfy9TyVBsB/6afBukdFS+GYWXODL7n5jg1Zg/
   UkdSt24Tx5trWXqK+TqHs2iX9sArwzd2DfCx+QK5tdSscDLCDQSo5chjQ
   /evf/6Dn0yjO/rGT5PDQG/vATj8LCNeZ8NJuXu/J7OBCcvnlLu3O3Qldn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="358272001"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="358272001"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 12:41:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="523685966"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 12:41:52 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 5660E20387;
        Wed, 18 May 2022 22:41:50 +0300 (EEST)
Date:   Wed, 18 May 2022 22:41:50 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 02/11] ACPI: acpica: Constify pathname argument for
 acpi_get_handle()
Message-ID: <YoVL/uDnwpfoVQwV@paasikivi.fi.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
 <20220506130025.984026-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0ip==ZYopb3sJvyrNpErpa1gGaJLk+OfLgff3x2tH98Og@mail.gmail.com>
 <YoUbUQkjKATrgf6n@paasikivi.fi.intel.com>
 <CAJZ5v0jvzHbD6fxNKYJ75eCc3A008fDTf8kA4nP5FK5EvuTS-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jvzHbD6fxNKYJ75eCc3A008fDTf8kA4nP5FK5EvuTS-w@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Wed, May 18, 2022 at 09:07:31PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 18, 2022 at 6:14 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Tue, May 17, 2022 at 06:21:44PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, May 6, 2022 at 2:58 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > acpi_get_handle() uses the pathname argument to find a handle related to
> > > > that pathname but it does not need to modify it. Make it const, in order
> > > > to be able to pass const pathname to it.
> > > >
> > > > Cc: "Moore, Robert" <robert.moore@intel.com>
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > >
> > > Which patches in the rest of the series depend on this one?
> >
> > "ACPI: property: Parse data node string references in properties", i.e.
> > patch 8 in this set.
> 
> So I think I can apply the rest of the series, except for patch 8 and
> patch 7 (as per the previous discussion) for the upcoming merge
> window.
> 
> Would that work?

I suppose it would apply to this one, too?

Postponing these works for me.

-- 
Kind regards,

Sakari Ailus
