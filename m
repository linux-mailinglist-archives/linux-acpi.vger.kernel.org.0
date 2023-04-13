Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39496E1056
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Apr 2023 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDMOsh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Apr 2023 10:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjDMOsg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Apr 2023 10:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F62A250
        for <linux-acpi@vger.kernel.org>; Thu, 13 Apr 2023 07:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 179AC63F27
        for <linux-acpi@vger.kernel.org>; Thu, 13 Apr 2023 14:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9F0C433EF;
        Thu, 13 Apr 2023 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681397288;
        bh=ugl8yGbnDmkq/AT/cxdFkf+RlcznXX7JwIhOX/bHntc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtTfVHi6EGEWOf6Ef8F+4GLCKXltYxpcZ1vzc2p8nl04IBXpLXpF7LuvmVusxLjLb
         8/CllB7GUHeKvyoWtRPH4JwrE8kfouU7snTx0eBfGbkxOVb4spAB8fuXToi+bSkcFL
         6WFl1lEWZUOtgsCX8xKAAJpHPA0EdJfJgIvQEHT6hPVzoQI96FIvUHU0pZz+lOaPlI
         F1ZX3/R3B4s3XzFblxNFakqtqC8BCfPKES6iFFDPLJ8xkscGd8xNW+wHHYLf5b4UCT
         LW8clz7NBfjUZNWK+nMTE5+XnBQOOuMp4j0EmRWQPWQHGeG5riLTS7qrGtfZ9qHeSS
         B1XV93+R4faCQ==
Date:   Thu, 13 Apr 2023 15:48:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        catalin.marinas@arm.com
Subject: Re: [PATCH] ACPI: AGDI: Improve error reporting for problems during
 .remove()
Message-ID: <20230413144802.GB26421@willie-the-truck>
References: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
 <Y05zSNDbt94ejpzm@lpieralisi>
 <e5080938-11e5-44c0-0434-f8d06a0cd953@arm.com>
 <ZDe8FpBlHRbQkS7m@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDe8FpBlHRbQkS7m@lpieralisi>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 13, 2023 at 10:23:50AM +0200, Lorenzo Pieralisi wrote:
> [+Catalin, Will: ACPI arm64 changes are sent through arm64 tree]
> 
> On Wed, Oct 26, 2022 at 05:09:40PM +0100, James Morse wrote:
> > Hi guys,
> > 
> > On 18/10/2022 10:35, Lorenzo Pieralisi wrote:
> > > On Fri, Oct 14, 2022 at 06:06:23PM +0200, Uwe Kleine-K�nig wrote:
> > >> Returning an error value in a platform driver's remove callback results in
> > >> a generic error message being emitted by the driver core, but otherwise it
> > >> doesn't make a difference. The device goes away anyhow.
> > >>
> > >> So instead of triggering the generic platform error message, emit a more
> > >> helpful message if a problem occurs and return 0 to suppress the generic
> > >> message.
> > >>
> > >> This patch is a preparation for making platform remove callbacks return
> > >> void.
> > > 
> > > If that's the plan - I don't have anything against this patch.
> > > 
> > >> Signed-off-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>
> > >> ---
> > >> Hello,
> > >>
> > >> note that in the situations where the driver returned an error before
> > >> and now emits a message, there is a resource leak. Someone who knows
> > >> more about this driver and maybe even can test stuff, might want to
> > >> address this. This might not only be about non-freed memory, the device
> > >> disappears but it is kept in sdei_list and so might be used after being
> > >> gone.
> > 
> > > I'd need James' input on this. I guess we may ignore
> > > sdei_event_disable() return value and continue anyway in agdi_remove(),
> > > whether that's the right thing to do it is a different question.
> > 
> > The unregister stuff is allowed to fail if the event is 'in progress' on another CPU.
> > Given the handler panic()s the machine, if an event is in progress, the resource leak
> > isn't something worth worrying about. The real problem is that the handler code may be
> > free()d while another CPU is still executing it, which is only a problem for modules.
> > 
> > As this thing can't be built as a module, and the handler panic()s the machine, I don't
> > think there is going to be a problem here.
> 
> Thanks James, I think though that's something we may want to handle in a
> separate patch.
> 
> This one looks fine to merge to me:
> 
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

Cheers, Lorenzo. I'll pick this one up.

Will
