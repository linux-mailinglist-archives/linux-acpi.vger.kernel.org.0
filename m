Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A489F2CFE50
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Dec 2020 20:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgLETWq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Dec 2020 14:22:46 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42888 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgLETWe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2020 14:22:34 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 7e1b4f5eab2a3e4d; Sat, 5 Dec 2020 16:21:52 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH] acpi: resource: Use AE_ABORT_METHOD to terminate acpi_dev_get_resources()
Date:   Sat, 05 Dec 2020 16:21:51 +0100
Message-ID: <2246133.BJYN6MDhT9@kreacher>
In-Reply-To: <20201204002740.300109-1-djrscally@gmail.com>
References: <20201204002740.300109-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, December 4, 2020 1:27:40 AM CET Daniel Scally wrote:
> Switching this function to AE_CTRL_TERMINATE broke the documented
> behaviour of acpi_dev_get_resources() - AE_CTRL_TERMINATE does not, in
> fact, terminate the resource walk because acpi_walk_resource_buffer()
> ignores it (specifically converting it to AE_OK), referring to that
> value as "an OK termination by the user function". This means that
> acpi_dev_get_resources() does not abort processing when the preproc
> function returns a negative value.
> 
> Revert to AE_ABORT_METHOD
> 
> Fixes: 8a66790b7850 ("ACPI / resources: Use AE_CTRL_TERMINATE to terminate resources walks")
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

This is simply a revert of the above commit, so it would be better to present
it as a revert explicitly.

> ---
>  drivers/acpi/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ad04824ca3ba..f2f5f1dc7c61 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -541,7 +541,7 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
>  		ret = c->preproc(ares, c->preproc_data);
>  		if (ret < 0) {
>  			c->error = ret;
> -			return AE_CTRL_TERMINATE;
> +			return AE_ABORT_METHOD;
>  		} else if (ret > 0) {
>  			return AE_OK;
>  		}
> 




