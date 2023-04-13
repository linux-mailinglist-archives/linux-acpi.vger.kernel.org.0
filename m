Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2026E08DC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Apr 2023 10:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjDMIYA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Apr 2023 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDMIX7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Apr 2023 04:23:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5372F98
        for <linux-acpi@vger.kernel.org>; Thu, 13 Apr 2023 01:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E381B63C5C
        for <linux-acpi@vger.kernel.org>; Thu, 13 Apr 2023 08:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF7C433EF;
        Thu, 13 Apr 2023 08:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681374237;
        bh=YwBtyp5u0T+H72IrutmXiT238Xv6PUZCuhLHx1bE7QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJoSREGMgLZGneaJDW9UzfQH0eGaOHn/6TAaVIlGegS6pUm9dkBv9NWRU8ENuZQQf
         R2/Ii7YDhaOXvuZv+QL6OyF9iMD0/97ROpjsJG9+WHaakYhpxtCTVWgUr8plITc/fy
         7YNQrfKTJad/B6VrjcuZv5mVZ6pw6IOKsp6tkHFzBQTvaAO/GGn0Y+4s/3cjpdhYOD
         uEwHBY5Tdzu2fjew+dewk9d4yeIdC63vrA2TdloGNXuFlaudcctqROBdZYuwu0dmOU
         WF1pE22NNx6fztK3k/tcx5lJ3jPMvYwnRpjbgekiO1U6U1OM13e0Vbq7we/BmPCgg7
         RRbe1YyG1tbtw==
Date:   Thu, 13 Apr 2023 10:23:50 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH] ACPI: AGDI: Improve error reporting for problems during
 .remove()
Message-ID: <ZDe8FpBlHRbQkS7m@lpieralisi>
References: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
 <Y05zSNDbt94ejpzm@lpieralisi>
 <e5080938-11e5-44c0-0434-f8d06a0cd953@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5080938-11e5-44c0-0434-f8d06a0cd953@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[+Catalin, Will: ACPI arm64 changes are sent through arm64 tree]

On Wed, Oct 26, 2022 at 05:09:40PM +0100, James Morse wrote:
> Hi guys,
> 
> On 18/10/2022 10:35, Lorenzo Pieralisi wrote:
> > On Fri, Oct 14, 2022 at 06:06:23PM +0200, Uwe Kleine-K�nig wrote:
> >> Returning an error value in a platform driver's remove callback results in
> >> a generic error message being emitted by the driver core, but otherwise it
> >> doesn't make a difference. The device goes away anyhow.
> >>
> >> So instead of triggering the generic platform error message, emit a more
> >> helpful message if a problem occurs and return 0 to suppress the generic
> >> message.
> >>
> >> This patch is a preparation for making platform remove callbacks return
> >> void.
> > 
> > If that's the plan - I don't have anything against this patch.
> > 
> >> Signed-off-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>
> >> ---
> >> Hello,
> >>
> >> note that in the situations where the driver returned an error before
> >> and now emits a message, there is a resource leak. Someone who knows
> >> more about this driver and maybe even can test stuff, might want to
> >> address this. This might not only be about non-freed memory, the device
> >> disappears but it is kept in sdei_list and so might be used after being
> >> gone.
> 
> > I'd need James' input on this. I guess we may ignore
> > sdei_event_disable() return value and continue anyway in agdi_remove(),
> > whether that's the right thing to do it is a different question.
> 
> The unregister stuff is allowed to fail if the event is 'in progress' on another CPU.
> Given the handler panic()s the machine, if an event is in progress, the resource leak
> isn't something worth worrying about. The real problem is that the handler code may be
> free()d while another CPU is still executing it, which is only a problem for modules.
> 
> As this thing can't be built as a module, and the handler panic()s the machine, I don't
> think there is going to be a problem here.

Thanks James, I think though that's something we may want to handle in a
separate patch.

This one looks fine to merge to me:

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> Thanks,
> 
> James
> 
> 
> >> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> >> index cf31abd0ed1b..f605302395c3 100644
> >> --- a/drivers/acpi/arm64/agdi.c
> >> +++ b/drivers/acpi/arm64/agdi.c
> >> @@ -64,8 +64,11 @@ static int agdi_remove(struct platform_device *pdev)
> >>  	int err, i;
> >>  
> >>  	err = sdei_event_disable(adata->sdei_event);
> >> -	if (err)
> >> -		return err;
> >> +	if (err) {
> >> +		dev_err(&pdev->dev, "Failed to disable sdei-event #%d (%pe)\n",
> >> +			adata->sdei_event, ERR_PTR(err));
> >> +		return 0;
> >> +	}
> >>  
> >>  	for (i = 0; i < 3; i++) {
> >>  		err = sdei_event_unregister(adata->sdei_event);
> >> @@ -75,7 +78,11 @@ static int agdi_remove(struct platform_device *pdev)
> >>  		schedule();
> >>  	}
> >>  
> >> -	return err;
> >> +	if (err)
> >> +		dev_err(&pdev->dev, "Failed to unregister sdei-event #%d (%pe)\n",
> >> +			adata->sdei_event, ERR_PTR(err));
> >> +
> >> +	return 0;
> >>  }
> >>  
> >>  static struct platform_driver agdi_driver = {
> >>
> >> base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
> >> -- 
> >> 2.37.2
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
