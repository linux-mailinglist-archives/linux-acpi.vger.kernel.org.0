Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3851B772
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 07:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbiEEF1t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 May 2022 01:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiEEF1t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 01:27:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449961CFFF;
        Wed,  4 May 2022 22:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651728251; x=1683264251;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CQBdDyKWYy/iEf2kk4r6gXfF52WkzPzsr1wq92EJL6A=;
  b=GKC8gnTjdMogCPrGCNA73O36ilVWBzw/HGU2E0XxHuHwQL3DJ89bL98d
   JHNiu9sHhOHBux4llDAbmYe1EdqoviYHUWyLMoC2SpB7OFMqIRAHVWNBA
   j8Z614JCdaVEKQm8DQyapX6R6Af6yOGHJzJAcxx8jfSZI9IzWE6HcoxyA
   859P90b9uxbR5sWetStOpcGGN4n0rvqxqhZyHc17EEmS8nd0IHYmMMDJ7
   CfbzkKwTuFNhmyy4RcnhgTcLEJ8kqnVIJGYkb/pKj/jAs5x289RaU3Pzu
   l4UlN77uvJD0T0K6ve2cqHRy+TJGhzcub7nfhAyxU2sssUBWamz+43a9U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354437405"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="354437405"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 22:24:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="585138203"
Received: from bfu-mobl3.ccr.corp.intel.com ([10.255.31.7])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 22:24:07 -0700
Message-ID: <2358992684eb37823378cb48de2775620ee42031.camel@intel.com>
Subject: Re: [PATCH 5/7] wil6210: remove debug message for unsupported PM
 event
From:   Zhang Rui <rui.zhang@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     rjw@rjwysocki.net, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Date:   Thu, 05 May 2022 13:24:04 +0800
In-Reply-To: <875ymkzj9e.fsf@kernel.org>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
         <20220505015814.3727692-6-rui.zhang@intel.com> <875ymkzj9e.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Kalle,

thanks for the quick response.

On Thu, 2022-05-05 at 07:38 +0300, Kalle Valo wrote:
> Zhang Rui <rui.zhang@intel.com> writes:
> 
> > Remove the useless debug message for unsupported PM event because
> > it is
> > noop in current code, and it gives a warning when a new event is
> > introduced, which it doesn't care.
> 
> It's a debug message, not a warning, and only visible when debug
> messages are enabled. Why do you want to remove it?

I'm concerning that people will report problems when they see new
messages which never shows up previously.

Deleting or keeping this message are both okay to me. But patch 6/7
indeed introduces a change to this piece of code and it's better for
you to be aware of it before people starts to complain.

> 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> 
> Is this really tested on a wil6210 device? Not that it matters, just
> surprised to see a Tested-by for a wil6210 patch. It's not really
> common
> hardware.

No, we just tested the whole patch series on a Dell 9360 laptop, and a
series of internal test machines. I didn't check if any of them has
this device or not. Maybe I should remove the tested by in this case?

thanks,
rui

