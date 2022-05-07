Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830B951E2FE
	for <lists+linux-acpi@lfdr.de>; Sat,  7 May 2022 03:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445161AbiEGB1T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 21:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiEGB1T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 21:27:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1978D7092F;
        Fri,  6 May 2022 18:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651886613; x=1683422613;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5QLsHFyXUFmImXTHj9gckTtQ5H1fnqGlBkqRwszLNuw=;
  b=iGzPCr9mqPLEZUqqMPEa3CS4Q+dFActVs4L7PseG4fMkh6DjcJOAw8T/
   H3ASHs41d/rsXbsQdhOxq/Ym6sYK51Xni8L1cfrkdDLvq2cPW07B5x3YY
   NwpzCMwKGFROzRxrEUrqVkqUwx1xxAqoMaQ2xX2PQNl8kBvRUYMxpGEfT
   3jKoNVyp7pl476HgxqkCA+xMb2dixXOMQA0qjR8sKDzJBxam9tSELdWez
   8elsAvCb0ube6CRGUWTZCLn0A6gbDDQqP1j/zsUwdaDVT07rxCsIpCx0h
   up4qBa4gHxtJNoN/7yiWX1Zbbjn3HyUl1FYzH13AA9//qsOOeiLFz8KdB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="250631339"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="250631339"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 18:23:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="538137724"
Received: from xinmeigo-mobl.ccr.corp.intel.com ([10.255.29.106])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 18:23:28 -0700
Message-ID: <163750123fe8868a34f963daf137d592edc0acd7.camel@intel.com>
Subject: Re: [PATCH 5/7] wil6210: remove debug message for unsupported PM
 event
From:   Zhang Rui <rui.zhang@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     rjw@rjwysocki.net, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Date:   Sat, 07 May 2022 09:23:26 +0800
In-Reply-To: <87tua292pp.fsf@kernel.org>
References: <20220505015814.3727692-1-rui.zhang@intel.com>
         <20220505015814.3727692-6-rui.zhang@intel.com> <875ymkzj9e.fsf@kernel.org>
         <2358992684eb37823378cb48de2775620ee42031.camel@intel.com>
         <87tua292pp.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2022-05-06 at 17:04 +0300, Kalle Valo wrote:
> Zhang Rui <rui.zhang@intel.com> writes:
> 
> > Hi, Kalle,
> > 
> > thanks for the quick response.
> > 
> > On Thu, 2022-05-05 at 07:38 +0300, Kalle Valo wrote:
> > > Zhang Rui <rui.zhang@intel.com> writes:
> > > 
> > > > Remove the useless debug message for unsupported PM event
> > > > because
> > > > it is
> > > > noop in current code, and it gives a warning when a new event
> > > > is
> > > > introduced, which it doesn't care.
> > > 
> > > It's a debug message, not a warning, and only visible when debug
> > > messages are enabled. Why do you want to remove it?
> > 
> > I'm concerning that people will report problems when they see new
> > messages which never shows up previously.
> > 
> > Deleting or keeping this message are both okay to me. But patch 6/7
> > indeed introduces a change to this piece of code and it's better
> > for
> > you to be aware of it before people starts to complain.
> > 
> > > 
> > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> > > 
> > > Is this really tested on a wil6210 device? Not that it matters,
> > > just
> > > surprised to see a Tested-by for a wil6210 patch. It's not really
> > > common
> > > hardware.
> > 
> > No, we just tested the whole patch series on a Dell 9360 laptop,
> > and a
> > series of internal test machines. I didn't check if any of them has
> > this device or not. Maybe I should remove the tested by in this
> > case?
> 
> I think it's best to drop this wil6210 patch. The driver is orphaned
> anyway and if anyone complains, they will do that to me :)
> 
Sure, I will drop this patch.
Thanks for reviewing.

-rui


