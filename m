Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599E3757F41
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jul 2023 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjGRORj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jul 2023 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjGRORi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jul 2023 10:17:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6810E4
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jul 2023 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689689854; x=1721225854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ndJ2ZCYsv8PN3b+nIcpF4xrUBJinW2y+6viHQRICrw=;
  b=FAOJ5Un3w/MqaSyC4GVhDlNHdbxwiuoCSkZT/wsX3clKwsYLRJQPZFao
   /FcMv2XC420YP0Eg1ZgcqMI7AkbTV10gL0KffPh5RhgeJltGNK1auLtiz
   EQ8TCsvMaGkE1DRxTTnLBnR532Wm8O4RntwOmusLmfrGUB4l8TqhG7HB8
   9LFWksVEPp3ea7xJOMQ1sHeMAorlDeUiiMjRMBXL64qyKxTzAF22jA9oF
   RVq++XizOEOaymgnVxBVxRd52jUMREbHMDTbqP2Dje1drLAiKBTA4WcJP
   oKMlinPbFTtnVrJJpQ1SLGcTx0qY9JhBrfOWWU3MgyZ2nUmMFhGL1zKB8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="351083191"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="351083191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="789061849"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="789061849"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2023 07:17:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlW2-00GkiN-0O;
        Tue, 18 Jul 2023 17:17:26 +0300
Date:   Tue, 18 Jul 2023 17:17:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        robert.moore@intel.com, pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com
Subject: Re: [PATCH 4/4] ACPI: NHLT: Add query functions
Message-ID: <ZLae9VTcJaVcjwSJ@smile.fi.intel.com>
References: <20230712091048.2545319-1-cezary.rojewski@intel.com>
 <20230712091048.2545319-5-cezary.rojewski@intel.com>
 <ZK7LadhJSBjJUNqs@smile.fi.intel.com>
 <3544e8dd-874e-4b26-cb37-04aad2a8332a@intel.com>
 <ZLUOTiLGE4NFAdnD@smile.fi.intel.com>
 <395ada91-9560-c001-c1e1-4b441ac9b7cc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <395ada91-9560-c001-c1e1-4b441ac9b7cc@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 18, 2023 at 01:11:03PM +0200, Cezary Rojewski wrote:
> On 2023-07-17 11:47 AM, Andy Shevchenko wrote:
> > On Mon, Jul 17, 2023 at 10:29:17AM +0200, Cezary Rojewski wrote:

...

> > I prefer to get rid of those.
> 
> Decided to do some manual tests on more exotic setups that are not part of
> our daily CI/CD routine and, completely getting rid of those ifs causes
> problems. Those setups are part of the market, expose DSP capabilities but
> have invalid BIOS configurations.
> 
> Rather than just bringing back the if-statement, different solution came to
> my mind:
> 
> static struct acpi_table_nhlt empty_nhlt = {
> 	.header = {
> 		.signature = ACPI_SIG_NHLT,
> 	},
> };
> 
> struct acpi_table_nhlt *acpi_gbl_NHLT;
> EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
> 
> acpi_status acpi_nhlt_get_gbl_table(void)
> {
> 	acpi_status status;
> 
> 	status = acpi_get_table(ACPI_SIG_NHLT, 0, (struct acpi_table_header
> **)(&acpi_gbl_NHLT));
> 	if (!acpi_gbl_NHLT)
> 		acpi_gbl_NHLT = &empty_nhlt;
> 	return status;
> }
> EXPORT_SYMBOL_GPL(acpi_nhlt_get_gbl_table);
> 
> What do you think?

I think it's wonderful what you found and I dunno how I missed this.
Go for this, definitely!

-- 
With Best Regards,
Andy Shevchenko


