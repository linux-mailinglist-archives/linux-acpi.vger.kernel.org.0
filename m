Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0B52C059
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiERQPA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiERQO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 12:14:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB30A1E38BF
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652890497; x=1684426497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRTgI+oXKAB31dIXzPjabyuWoBQHHD4lTRJrWLn8qNE=;
  b=BRzDm0CFXXdUjxhDnSDEuvQ3yKGNnN4a8o7UD/k4abcFepffEjNh2WOp
   LRnAdUg6P3TVjVfv8RGAUDW6Rn5Vfst+rbbmIz+7FuKlV8sCVUQhvZGqx
   /nJCha5lDLIosw9IVLE0ZSaAVK6DXymCWk6UBEUIc1PAxGxS6cCki2FTJ
   Wswuwj6JI+dbgYYALByNpIcf6ptfqInhDy4tnCg+1IY8+DDPiIgnSDLLY
   9VNjyFbqgpuWV9QHs1l516SV4VeF+6U6Fp5k1wGOIvd2ftNkgAhGgPmjO
   JvZQbpDy3gcHkbSB7qk6NQ046bQFUfdrNoSFMq6cKc378HN6anQ4w4cXB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="358159129"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="358159129"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:14:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="661224552"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:14:11 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 145D320387;
        Wed, 18 May 2022 19:14:09 +0300 (EEST)
Date:   Wed, 18 May 2022 19:14:09 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 02/11] ACPI: acpica: Constify pathname argument for
 acpi_get_handle()
Message-ID: <YoUbUQkjKATrgf6n@paasikivi.fi.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
 <20220506130025.984026-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0ip==ZYopb3sJvyrNpErpa1gGaJLk+OfLgff3x2tH98Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ip==ZYopb3sJvyrNpErpa1gGaJLk+OfLgff3x2tH98Og@mail.gmail.com>
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

On Tue, May 17, 2022 at 06:21:44PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 6, 2022 at 2:58 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > acpi_get_handle() uses the pathname argument to find a handle related to
> > that pathname but it does not need to modify it. Make it const, in order
> > to be able to pass const pathname to it.
> >
> > Cc: "Moore, Robert" <robert.moore@intel.com>
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Which patches in the rest of the series depend on this one?

"ACPI: property: Parse data node string references in properties", i.e.
patch 8 in this set.

-- 
Sakari Ailus
