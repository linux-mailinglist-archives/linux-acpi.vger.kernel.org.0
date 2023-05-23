Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82EF70E402
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbjEWQzo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 May 2023 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjEWQzm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 12:55:42 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288BADD
        for <linux-acpi@vger.kernel.org>; Tue, 23 May 2023 09:55:40 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id a4647b55-f98a-11ed-abf4-005056bdd08f;
        Tue, 23 May 2023 19:55:38 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 19:55:37 +0300
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, hdegoede@redhat.com, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com,
        Basavaraj.Natikar@amd.com
Subject: Re: [PATCH v2 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging
 messages
Message-ID: <ZGzwCdTO2LptPeQs@surfacebook>
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522200033.2605-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Mon, May 22, 2023 at 03:00:32PM -0500, Mario Limonciello kirjoitti:
> To make the GPIO tracking around suspend easier for end users to
> use, link it with pm_debug_messages.  This will make discovering
> sources of spurious GPIOs around suspend easier.

Unfortunatelly this has two regressions.

...

> -				dev_dbg(&gpio_dev->pdev->dev,
> -					"GPIO %d is active: 0x%x",
> -					irqnr + i, regval);
> +				pm_pr_dbg("GPIO %d is active: 0x%x",
> +					  irqnr + i, regval);

Regression 1: The device is now omitted from the output.
Regression 2: See https://stackoverflow.com/a/43957671/2511795

-- 
With Best Regards,
Andy Shevchenko


