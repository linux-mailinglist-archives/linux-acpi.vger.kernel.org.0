Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8895E77521B
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 07:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjHIFA5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 01:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjHIFA4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 01:00:56 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA12172A
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 22:00:52 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id b1333d4d-3671-11ee-b3cf-005056bd6ce9;
        Wed, 09 Aug 2023 08:00:43 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 9 Aug 2023 08:00:42 +0300
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        robert.moore@intel.com, amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v4 1/4] ACPI: NHLT: Device configuration access interface
Message-ID: <ZNMdertpWWvoAJM3@surfacebook>
References: <20230721154813.310996-1-cezary.rojewski@intel.com>
 <20230721154813.310996-2-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721154813.310996-2-cezary.rojewski@intel.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fri, Jul 21, 2023 at 05:48:10PM +0200, Cezary Rojewski kirjoitti:
> Device configuration structures are plenty so declare a struct for each
> known variant. As neither of them shall be accessed without verifying
> the memory block first, introduce macros to make it easy to do so.
> 
> Link: https://github.com/acpica/acpica/pull/881

Thinking of this over night (as I replied in the above)...

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorry, but seems I have to retract my tag and even more, NAK to the ACPICA changes.

I have thought that this is something new to the header there, but it appears that
it duplicates (in a wrong way in my opinion) existing data types.

Existing data types are crafted (as far as I get them) in a way to be able to be
combined in the union. In the similar way how _CRS is parsed in DSDT (first that
comes to my mind). Hence that "simplification" is quite wrong in a few ways:
- it breaks ACPICA agreement on naming schema
- it duplicates existing data
- it made it even partially
- it is fine and correct in ACPICA to have long dereferenced data, again see
  for the union of acpi_object

I trully believe now that the above change in ACPICA must be reverted.

Again, sorry for this late bad news from my side. I have no clue why
it was merged, perhaps lack of review? Or anything subtle I so miserably
missed?

-- 
With Best Regards,
Andy Shevchenko


