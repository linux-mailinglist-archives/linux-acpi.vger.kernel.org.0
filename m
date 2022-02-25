Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76DB4C4B50
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 17:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiBYQuA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 11:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiBYQuA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 11:50:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13549151C64;
        Fri, 25 Feb 2022 08:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645807768; x=1677343768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/V6Rkz4qrzPb0qaYl8Es66TcJ5wfc4o7wMc/lyvh4JA=;
  b=H95sBGQ2Srp5b4z8/a4ePnNA+nfZ2UjfxDeZcODFav18gvrNjEFGs4bY
   FtSEaqzLhHS9xeH0so7CNplGxqOyaPCvbwLf7Mc7sXLvQRBdcf43F+aPG
   VeyofTgi0l6RhaPPRR6UB9+7a6woSJ2HC2Rfz4kRAaNRSQU+r1/3LoVgE
   wWbSaycMjRKkwUzKjpKTtW9n+TXAS1viUrhHIIVlnYQUP3FG9NoladaUp
   WTbNEk7n2b2Fg1tPMUke9CNmeHGpEJ4QXdg1r1GUsaIiCighICXtbXCLC
   /1tstdxxb4NJ93pRcBsJHADZUI9rIY1T4Enc5DIvAGws5ptr/OTE8VMyh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233155531"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="233155531"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:49:27 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="707917880"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:49:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nNdlj-008Gjl-Ir;
        Fri, 25 Feb 2022 18:48:35 +0200
Date:   Fri, 25 Feb 2022 18:48:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: Replace surface3_button code with
 soc_button_array
Message-ID: <YhkIY6Vz5fL1ThQt@smile.fi.intel.com>
References: <20220224110241.9613-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224110241.9613-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2022 at 12:02:39PM +0100, Hans de Goede wrote:
> Hi All,
> 
> I noticed that the surface3_button code was pretty much a 1:1 copy of
> soc_button_array. This series adds support to soc_button_array for the
> MSHW0028 device on the Microsoft Surface 3 (non pro) and removes the
> now no longer needed surface3_button driver.

Thanks, I like esp. patch 2 in this series.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Rafael, this includes an addition to ignore_serial_bus_ids[] in
> drivers/apci/scan.c, may we have your ack for merging this through
> the input or pdx86 tree please ?
> 
> Dmitry, I believe it would be best to keep these 2 patches together
> and merge both through either the input or the pdx86 tree. If you
> are ok with me merging this through the pdx86 tree may I have your
> Ack for that ?
> 
> If you prefer merging this through the input tree please consider
> this my ack for also merge 2/2 through the input tree.
> 
> Note both patches can also be merged through separate trees without
> issues but keeping them together seems better to me.

-- 
With Best Regards,
Andy Shevchenko


