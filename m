Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2AA51C424
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 17:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbiEEPsG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 May 2022 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiEEPsG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 11:48:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E4532E2;
        Thu,  5 May 2022 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651765466; x=1683301466;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/K27mxZVpjV2wVe4/S1pgizw/HTC8KiYO9tIqdJDhro=;
  b=PYL7hq5OsEEpdMOVmkYyI1NSZsdKTEkDoWM/RT57PqS7WZbpPmoius0h
   Q1QjnDamKW+pe545yKrwH7WLHlSBod3uKQpqpKnX7cjk4Cn+KpQzje2yi
   Drk283JZqSOVxMxieHLK6FcqntyprVJC61+aKruIOKKw0OzDpNk6O8WbL
   eiPECPreg6wOgiW113ZLLz3oCnPeLr/zf3KcDa03Gi21khpOmVBu27TYC
   wgDpHS2a4iLaS2rf/m+BiDm7bbBP2TWKlWXOlebQhgDpWq+O0eUR81Qpw
   d13OSkCaXqfYIvsJH9L0EmdL0xzakO/EhJGCao99ZYjZmbVGLasosOdid
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268297952"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="268297952"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 08:18:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="563286371"
Received: from bfu-mobl3.ccr.corp.intel.com ([10.255.31.7])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 08:18:05 -0700
Message-ID: <0f39c2be651d75895d3dfca1d8afc7cad2d4a1af.camel@intel.com>
Subject: Re: [PATCH 0/7] PM: Solution for S0ix failure caused by PCH
 overheating
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, kvalo@kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        merez@codeaurora.org, mat.jonczyk@o2.pl,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Len Brown <len.brown@intel.com>
Date:   Thu, 05 May 2022 23:18:02 +0800
In-Reply-To: <CAJZ5v0hceDVkv05=SFbO53wsmHWkrs1SSoxZ=FuErYsnNutGWg@mail.gmail.com>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
         <40b8ad06-6ef2-113c-fffb-2fa001603b3f@suse.com>
         <CAJZ5v0hceDVkv05=SFbO53wsmHWkrs1SSoxZ=FuErYsnNutGWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Neukum,

Thanks for your response, I missed your original reply in my Inbox.

On Thu, 2022-05-05 at 14:02 +0200, Rafael J. Wysocki wrote:
> On Thu, May 5, 2022 at 10:23 AM Oliver Neukum <oneukum@suse.com>
> wrote:
> > 
> > 
> > 
> > On 05.05.22 03:58, Zhang Rui wrote:
> > > On some Intel client platforms like SKL/KBL/CNL/CML, there is a
> > > PCH thermal sensor that monitors the PCH temperature and blocks
> > > the system
> > > from entering S0ix in case it overheats.
> > > 
> > > Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due
> > > to PCH
> > > temperature above threshold") introduces a delay loop to cool the
> > > temperature down for this purpose.
> > > 
> > > However, in practice, we found that the time it takes to cool the
> > > PCH down
> > > below threshold highly depends on the initial PCH temperature
> > > when the
> > > delay starts, as well as the ambient temperature.
> > > 
> > > This patch series has been tested on the same Dell XPS 9360
> > > laptop and
> > > S0ix is 100% achieved across 1000+ s2idle iterations.
> > > 
> > 
> > Hi,
> > 
> > what is the user experience if this ever triggers? At that stage
> > the
> > system will appear to be suspended to an external observer, won't
> > it?
> > So in effect you'd have a system that spontaneously wakes up, won't
> > you?
> 
> No, you won't.
> 
> It will just go ahead and reach S0ix when it can.  It will only wake
> up if there's a legitimate wakeup even in the meantime.

Please correct me if I misunderstand your question, Oliver.

Without the patch, the system becomes suspended and stays in PCx.
With the patch, the system first stays in PCx during suspending (in the
intel_pch_thermal driver' cooling delays), and then becomes suspended
and stays in S0ix.

thanks,
rui

