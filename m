Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237F566E0B7
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 15:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjAQObO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 09:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjAQOaw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 09:30:52 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243E940BF6;
        Tue, 17 Jan 2023 06:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673965786; x=1705501786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hV8lalrdGBF3Ewgns/6F4Jz0i36zNZYmMZiH/fP0kZc=;
  b=Doy8TF4C8PF3du/Evuk/sqXxuO4A+n89J0L7V/ISmjO+rzFua0S7MTqM
   OJfKPElCePtvJTb7PSkAPETkrSU22WBWudaRWamC9F/paFEWUbWP2KFz+
   bVxkwKTq+bMHMYt/QIOIjpiEtje6E0GGg5fm/Vmadq6+H6vsItGfgC3oK
   TEd/5aJv66t3EjudK699BE1JTaqZAAYVW3ovDZzwIkqgjCqn8KTK/p00F
   Wu4Yq/g9huW+nJvRnB/pyzxkV9aQSJgzQCyo1kElbmXtt46MmPAXDU/Tq
   SeCuAouZJ2pjK2bToGYNvjdoephbbia9C0qqf/JAm3fzWGle58VuXO2E8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326774209"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326774209"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 06:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="904667027"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="904667027"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2023 06:29:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHmy0-00Ac6N-20;
        Tue, 17 Jan 2023 16:29:36 +0200
Date:   Tue, 17 Jan 2023 16:29:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 1/8] ACPI: property: Parse data node string references in
 properties
Message-ID: <Y8aw0KdhM+KJqnj2@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117122244.2546597-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:37PM +0200, Sakari Ailus wrote:
> Add support for parsing property references using strings, besides
> reference objects that were previously supported. This allows also
> referencing data nodes which was not possible with reference objects.

...

> +		pr_err("ACPI: bad node type\n");


Looking at this I'm wondering what prevents us to have pr_fmt() defined as
it's done in ~60 modules under drivers/acpi already.

Other than that, LGTM.

-- 
With Best Regards,
Andy Shevchenko


