Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACE04AC265
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Feb 2022 16:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiBGPEP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Feb 2022 10:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354580AbiBGOlS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Feb 2022 09:41:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E58C0401C1;
        Mon,  7 Feb 2022 06:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644244877; x=1675780877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6an4jAiHsQwI4lYWC4oybVTg/T4wKzhTcEyk1Sadmt8=;
  b=mCwD95xkqd+ftocs2/7p63CtoyZuJG/w6/qLMzg7av7HA7hE10D2wqgV
   Asmo4N6k8DtRhFBSSsoA0UePD1TgWhGBWW+Lm+VJs6XHLm3sSQKEpHcst
   CDzpQf7k7xTgYlhZ8lD8LLAHkRk9nabGxqgOTM0qO6bswqqUcQc6pymX8
   xZRWADIZqWfri8iou8RZcY2GRtgewsz1vo0U7AOoQQM5uVedAXgYrIATa
   TZtZd1UQvVTfFB6UmayhfIHJ1gepyoymLp8MJFVVnOpNKxHs1dgPgrIco
   OupdoIuG9YDlmMjhxCzRzGYOE63BaSXVfbkFxtkGkpWyNUzsGOkDZ5Nge
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248938826"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="248938826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:41:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="584850968"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:41:15 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 6A84320287;
        Mon,  7 Feb 2022 16:41:13 +0200 (EET)
Date:   Mon, 7 Feb 2022 16:41:13 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 0/4] Shovel firmware specific code to appropriate
 locations
Message-ID: <YgEviSv4l8BMCVgE@paasikivi.fi.intel.com>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
 <YgEQP3QGtqre+nCL@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgEQP3QGtqre+nCL@smile.fi.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Mon, Feb 07, 2022 at 02:27:43PM +0200, Andy Shevchenko wrote:
> On Sun, Feb 06, 2022 at 11:16:39AM +0200, Sakari Ailus wrote:
> > Hi folks,
> > 
> > This set moves the implementation of recently added device property API
> > functions to OF and ACPI frameworks, where the rest of such functionality
> > resides.
> > 
> > Compile tested.
> 
> All look good to me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> > Note that after some initial confusion, this set actually does depend on
> > Andy's patch "device property: Don't split fwnode_get_irq*() APIs in the
> > code" to appear in the linux-acpi tree.
> 
> Perhaps than you can add to your series the conversion of
> fwnode_irq_get_byname()?

It relies on other fwnode functions to do its job so there's nothing to fix
there.

-- 
Kind regards,

Sakari Ailus
