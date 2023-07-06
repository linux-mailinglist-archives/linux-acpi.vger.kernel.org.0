Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C5749A26
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjGFLDE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjGFLCz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 07:02:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B63DC;
        Thu,  6 Jul 2023 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688641375; x=1720177375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AJXYjx1sypt0ytjRsD7DaVxFsjXMfNk4Gg/BXtepThk=;
  b=EIP5FRCxv8Xp5rpdvdr5Qjb+I/3V5c608RQd3GyF/5pxJjur1oK2yMCt
   QUpcWl2R7ATo1Y13HwGLR88dRcFPFXoqr7mV+Mb13B/bQpmGiO4kaVEa8
   gwQA5z3MpohHfExeKxxvS9SdJEv90f+L8VquzYEbg8cldXJgZS4wjQpFi
   fQ40XnEk/yLyI5K7Wd4q2cL5QyeXGmOynGUiNv9g3T86DDogqVCo/cexR
   i2Wmdpw8iTYxsu4jqxbbnLxi42mmxuKRwE2P+okLTQJ/C9BYWVTsAMK2q
   Q+ZSp7ltzK7iofplGt0I5UaOmGbRDU+ATFFfKthxwxWd8mU4/GMADwUOj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363607503"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363607503"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="864072852"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="864072852"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:02:51 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id AE33911F9ED;
        Thu,  6 Jul 2023 14:02:48 +0300 (EEST)
Date:   Thu, 6 Jul 2023 11:02:48 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v3 14/18] media: i2c: Add driver for DW9719 VCM
Message-ID: <ZKafWMVSelJAXd2y@kekkonen.localdomain>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-15-hdegoede@redhat.com>
 <ZKaSD0CHRBd+zu/T@smile.fi.intel.com>
 <ZKaXK3uRQxB7UTo0@kekkonen.localdomain>
 <ZKab+VVFvF0qcIOw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKab+VVFvF0qcIOw@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Thu, Jul 06, 2023 at 01:48:25PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 06, 2023 at 10:27:55AM +0000, Sakari Ailus wrote:
> > On Thu, Jul 06, 2023 at 01:06:07PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > +	dw9719->regulator = devm_regulator_get(&client->dev, "vdd");
> > > > +	if (IS_ERR(dw9719->regulator))
> > > > +		return dev_err_probe(&client->dev, PTR_ERR(dw9719->regulator),
> > > 
> > > With
> > > 
> > > 	struct device *dev = &client->dev;
> > > 
> > > code may look neater.
> > 
> > I prefer it as-is.
> 
> May I ask what the technical rationale behind your preferences? Esp. taking
> into account how picky you are for 80 character limit.

The device is already available via &client->dev. Sure, you do remove a few
characters per line but also introduce a new variable to be aware of. In
this case there's no line break that would be affected.

That being said, I certainly don't have a strong opinion on this. If Hans
prefers to have a local variable for this I'm totally fine with that. I
just think there's no need to.

-- 
Kind regards,

Sakari Ailus
