Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C8A1B91B1
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Apr 2020 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDZQ2R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Apr 2020 12:28:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61014 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgDZQ2R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Apr 2020 12:28:17 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 10a16a981ec5835b; Sun, 26 Apr 2020 18:28:14 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: processor: allowing probing on platforms with one ACPI C-state
Date:   Sun, 26 Apr 2020 18:28:14 +0200
Message-ID: <3014980.06ggM8U1O4@kreacher>
In-Reply-To: <20200422072607.18179-1-rui.zhang@intel.com>
References: <20200422072607.18179-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, April 22, 2020 9:26:07 AM CEST Zhang Rui wrote:
> It is possible for ACPI _CST to return only one ACPI C-state, for
> example, when deep cstate disabled in the BIOS.
> And it is better for the acpi_idle driver to probe in this case as well
> for consistency.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/processor_idle.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index dcc289e30166..75534c5b5433 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -308,11 +308,7 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * It is expected that there will be at least 2 states, C1 and
> -	 * something else (C2 or C3), so fail if that is not the case.
> -	 */
> -	if (pr->power.count < 2)
> +	if (!pr->power.count)
>  		return -EFAULT;
>  
>  	pr->flags.has_cst = 1;
> @@ -468,8 +464,7 @@ static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
>  	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
>  		if (pr->power.states[i].valid) {
>  			pr->power.count = i;
> -			if (pr->power.states[i].type >= ACPI_STATE_C2)
> -				pr->flags.power = 1;
> +			pr->flags.power = 1;
>  		}
>  	}
>  
> 

Applied as 5.8-candidate material, thanks!




