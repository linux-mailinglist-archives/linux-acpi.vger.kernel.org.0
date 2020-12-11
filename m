Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9634E2D7FC1
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 21:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392192AbgLKUCT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Dec 2020 15:02:19 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51010 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391859AbgLKUBz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2020 15:01:55 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 3292c34091204887; Fri, 11 Dec 2020 21:01:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / AC: used pr_info instead of printk
Date:   Fri, 11 Dec 2020 21:01:12 +0100
Message-ID: <4928277.aiZ1hTckIi@kreacher>
In-Reply-To: <1607669412-21491-1-git-send-email-tiantao6@hisilicon.com>
References: <1607669412-21491-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, December 11, 2020 7:50:12 AM CET Tian Tao wrote:
> printk(KERNEL_INFO) is same with pr_info, so used pr_info instead of
> printk.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/acpi/ac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 46a64e9..5e4b9c1 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -278,9 +278,9 @@ static int acpi_ac_add(struct acpi_device *device)
>  		goto end;
>  	}
>  
> -	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
> -	       acpi_device_name(device), acpi_device_bid(device),
> -	       ac->state ? "on-line" : "off-line");
> +	pr_info(PREFIX "%s [%s] (%s)\n",
> +		acpi_device_name(device), acpi_device_bid(device),
> +		ac->state ? "on-line" : "off-line");

What about defining a proper pr_fmt() for this file instead of using PREFIX
here?

>  
>  	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
>  	register_acpi_notifier(&ac->battery_nb);
> 




