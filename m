Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E489C64FE09
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Dec 2022 08:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiLRH3h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 18 Dec 2022 02:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLRH3h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Dec 2022 02:29:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A24DF30
        for <linux-acpi@vger.kernel.org>; Sat, 17 Dec 2022 23:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671348576; x=1702884576;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GubYVETvr+oCFOxnsG+KuDF40Ss4WvUWHVwA17XBRdM=;
  b=IoRJfyrjKaKZV6JdzgUf1Xo+VEXaC/oLpPftQ+hEvy51FHPIj18Jrvo1
   5z5xSclzTLs3l2Ufx7Ygits4151bWCJqGpos0zLSpG3fbrsP5qNSQKzAk
   uQc2pEEUKQhfv3t/W3+HI0zuTiDDoKP4nUqUBLF518s7Qx9JAnjQVHssU
   CCLqLqhECwAjCbvVqvEw4ZbuT1tuAU3MYwzB+BPUqRTfIpX53V9c1d1BN
   jW1gJc8e7G5JX/L3ZdBjURlC5YE9O3t7bBtZb/rogMJpd6if6KaNQ2tiH
   jjotcFDPQNobIrxb8QNfD3qnAWsFg68s1HaUODDFWgmWP8hOEn6ajwDWA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="298858544"
X-IronPort-AV: E=Sophos;i="5.96,254,1665471600"; 
   d="scan'208";a="298858544"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 23:29:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10564"; a="643679754"
X-IronPort-AV: E=Sophos;i="5.96,254,1665471600"; 
   d="scan'208";a="643679754"
Received: from xum1-mobl1.ccr.corp.intel.com ([10.254.215.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 23:29:33 -0800
Message-ID: <4ffee0538c2922bd5712a0a9302ee1d35c2b8b74.camel@intel.com>
Subject: Re: intel_idle Jasper Lake Support
From:   Zhang Rui <rui.zhang@intel.com>
To:     Maciej Koszanski <maciejkoszanskibusiness@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, "Wang, Wendy" <wendy.wang@intel.com>
Date:   Sun, 18 Dec 2022 15:29:30 +0800
In-Reply-To: <CAL4jJSgx4W_=6zQt-uNDdZPskcgP4JYpMMz-JPPi90E-H+FWFw@mail.gmail.com>
References: <CAL4jJSh8tKxZc-6qO6oyPm=MrRPwuvkQkQMNmwLbuXX4GAuJ9g@mail.gmail.com>
         <e4df2651-7201-ff43-c3f1-68767f2579cf@intel.com>
         <CAL4jJShcJB9yHnWL+k4C0cjVW0hFtc=3tx1_0Uz4zbkzaaE_7g@mail.gmail.com>
         <CAJZ5v0h-8RR0YLQ3w86JC4DypW-Kcu=snyqtup1wr_-0yzBJKA@mail.gmail.com>
         <0ed28936706e508cb66f85fb8d5ce80e32c8d180.camel@intel.com>
         <CAL4jJSgx4W_=6zQt-uNDdZPskcgP4JYpMMz-JPPi90E-H+FWFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 2022-12-17 at 10:31 +0000, Maciej Koszanski wrote:
> Hi Rui,
> 
> Attached is the output from turbostat. I managed to get the system
> down to about 16W when I configured APM/HDD spindown. I am using an
> external power meter. 

The CPU Package power is around 2.44W according to the RAPL energy
counter, with 90%+ PC2 and no PC3 and deeper. CPU is not the main
problem of your high idle power.

You can try with https://github.com/intel/S0ixSelftestTool
to see if you can enable deeper Package Cstate or even S0ix on your
platform or not, that may save 1W ~ 2W if you succeed.


thanks,
rui

