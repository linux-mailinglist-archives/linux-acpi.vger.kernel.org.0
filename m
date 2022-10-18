Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A6602876
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Oct 2022 11:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJRJfa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Oct 2022 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiJRJfZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Oct 2022 05:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C5B88A2D
        for <linux-acpi@vger.kernel.org>; Tue, 18 Oct 2022 02:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 736C8614E6
        for <linux-acpi@vger.kernel.org>; Tue, 18 Oct 2022 09:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8535EC433D6;
        Tue, 18 Oct 2022 09:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666085710;
        bh=B1+DGoOHB/0so+xzV8ypxyu9PNtevljZ5PFUoDeCH74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiBI2WfPZzbb0xDkA5Gle+NQQQmiaTdQTZN8MZ1evGVe0b3kIKSF9cOOBZ97cCcrf
         /s0pOIMGr7nni1QVFt2HGbkUFpi30PnEjoBIusSKeZSTQrj+NkntDNmglBpFRrBgkg
         J9PgZoX3ggzMzTp2+SKc5ZHToyoCmMOY8fvLClAii5Jpr3+T414osn6q4/NpTid2he
         vRJL48Bt4NuAQetxhTNY4CyeN4p+5X8ZBF4774f0yW4G71wb78B4vrMFPcdWCInTcb
         XUg6WdqsVTk9hyKiDcFQtWlAXlpZ1cV5FNXsryPt3iGzdsjZU/m4VASH8EosfaDXEH
         UvFsWWO+QfntQ==
Date:   Tue, 18 Oct 2022 11:35:04 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, james.morse@arm.com
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] ACPI: AGDI: Improve error reporting for problems during
 .remove()
Message-ID: <Y05zSNDbt94ejpzm@lpieralisi>
References: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[+James]

On Fri, Oct 14, 2022 at 06:06:23PM +0200, Uwe Kleine-König wrote:
> Returning an error value in a platform driver's remove callback results in
> a generic error message being emitted by the driver core, but otherwise it
> doesn't make a difference. The device goes away anyhow.
> 
> So instead of triggering the generic platform error message, emit a more
> helpful message if a problem occurs and return 0 to suppress the generic
> message.
> 
> This patch is a preparation for making platform remove callbacks return
> void.

If that's the plan - I don't have anything against this patch.

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> note that in the situations where the driver returned an error before
> and now emits a message, there is a resource leak. Someone who knows
> more about this driver and maybe even can test stuff, might want to
> address this. This might not only be about non-freed memory, the device
> disappears but it is kept in sdei_list and so might be used after being
> gone.

I'd need James' input on this. I guess we may ignore
sdei_event_disable() return value and continue anyway in agdi_remove(),
whether that's the right thing to do it is a different question.

Lorenzo

> Best regards
> Uwe
> 
>  drivers/acpi/arm64/agdi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index cf31abd0ed1b..f605302395c3 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -64,8 +64,11 @@ static int agdi_remove(struct platform_device *pdev)
>  	int err, i;
>  
>  	err = sdei_event_disable(adata->sdei_event);
> -	if (err)
> -		return err;
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to disable sdei-event #%d (%pe)\n",
> +			adata->sdei_event, ERR_PTR(err));
> +		return 0;
> +	}
>  
>  	for (i = 0; i < 3; i++) {
>  		err = sdei_event_unregister(adata->sdei_event);
> @@ -75,7 +78,11 @@ static int agdi_remove(struct platform_device *pdev)
>  		schedule();
>  	}
>  
> -	return err;
> +	if (err)
> +		dev_err(&pdev->dev, "Failed to unregister sdei-event #%d (%pe)\n",
> +			adata->sdei_event, ERR_PTR(err));
> +
> +	return 0;
>  }
>  
>  static struct platform_driver agdi_driver = {
> 
> base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
> -- 
> 2.37.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
