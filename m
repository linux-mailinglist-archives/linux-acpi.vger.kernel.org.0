Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60607809DC
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353582AbjHRKRf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359745AbjHRKRV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 06:17:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB53330D6;
        Fri, 18 Aug 2023 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692353840; x=1723889840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AvsuYEsBzsDcN+MJ7GjND9On0WshWaM0MTCsl1J01hY=;
  b=fMb/K4PSRZp2HHhlLvSfuDNiO0bA/v+LiNxsN7z+gYZ/ms0AkChPslR6
   mpU3Wsk304oNtFeOD2kAX0OUsMg9sLKKrkR9osUsF17lpeRLCCcrcoDjZ
   bZ/bUV1B2bd6LpZjfOUsOrm3C/IyVmjFmye4H5wVTzSXQIxw46INtnQvr
   dXEZmqB1zdNbkvS5WD4fDjp+VuwBfX5JF9jAZfQQAAKBIy23Sbkx1WtT+
   dYDp9LngfP07Qq3QIRN5gMCyiezP8tv94N/L+tGFJ+jv9hjlelYepWB7C
   wXF4y+yErasJJC9t3HcRYGJfsXTQ49hFhsG3BNtVnwq6wOuvDBF1RR6Wh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352657320"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="352657320"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="770087611"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="770087611"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:17:17 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 3EF9E12035D;
        Fri, 18 Aug 2023 13:17:14 +0300 (EEST)
Date:   Fri, 18 Aug 2023 10:17:14 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Wentong Wu <wentong.wu@intel.com>, hdegoede@redhat.com,
        djrscally@gmail.com, laurent.pinchart@ideasonboard.com,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        bingbu.cao@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com
Subject: Re: [PATCH v10 3/3] ACPI: delay enumeration of devices with a _DEP
 pointing to IVSC device
Message-ID: <ZN9FKrxqQSeNqvl8@kekkonen.localdomain>
References: <1690631575-15124-1-git-send-email-wentong.wu@intel.com>
 <1690631575-15124-4-git-send-email-wentong.wu@intel.com>
 <ZMWIKTAuHqHZ3+dc@kekkonen.localdomain>
 <CAJZ5v0hjZXtkmYnt13E1jizSGu=kkkqYdeS3Y8hc5COUTJtN6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hjZXtkmYnt13E1jizSGu=kkkqYdeS3Y8hc5COUTJtN6w@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 17, 2023 at 06:30:54PM +0200, Rafael J. Wysocki wrote:
> On Sat, Jul 29, 2023 at 11:44 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Sat, Jul 29, 2023 at 07:52:55PM +0800, Wentong Wu wrote:
> > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > index 2743444..59c92a9 100644
> > > --- a/drivers/acpi/scan.c
> > > +++ b/drivers/acpi/scan.c
> > > @@ -796,6 +796,9 @@ static const char * const acpi_ignore_dep_ids[] = {
> > >  /* List of HIDs for which we honor deps of matching ACPI devs, when checking _DEP lists. */
> > >  static const char * const acpi_honor_dep_ids[] = {
> > >       "INT3472", /* Camera sensor PMIC / clk and regulator info */
> > > +     "INTC1059", /* IVSC (TGL) driver must be loaded to allow i2c access to camera sensors */
> > > +     "INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
> > > +     "INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
> > >       NULL
> > >  };
> > >
> >
> > Could this patch be merged via the ACPI tree? There's no direct dependency
> > to the two other patches in the set.
> >
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Applied (under a slightly edited subject) as 6.6 material, thanks!

Thanks, Rafael!

-- 
Sakari Ailus
