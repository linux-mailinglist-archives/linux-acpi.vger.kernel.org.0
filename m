Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24B360345
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfGEJli (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:41:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61712 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfGEJli (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 05:41:38 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 78a8ff33240e7ec0; Fri, 5 Jul 2019 11:41:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: APD: remove redundant assignment to pointer clk
Date:   Fri, 05 Jul 2019 11:41:35 +0200
Message-ID: <2921052.OUaa6v4X4N@kreacher>
In-Reply-To: <20190702131029.9621-1-colin.king@canonical.com>
References: <20190702131029.9621-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, July 2, 2019 3:10:29 PM CEST Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer clk is being initialized with a value that is never
> read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/acpi_apd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index ff47317d8ef1..7cd0c9ac71ea 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -57,7 +57,7 @@ struct apd_private_data {
>  static int acpi_apd_setup(struct apd_private_data *pdata)
>  {
>  	const struct apd_device_desc *dev_desc = pdata->dev_desc;
> -	struct clk *clk = ERR_PTR(-ENODEV);
> +	struct clk *clk;
>  
>  	if (dev_desc->fixed_clk_rate) {
>  		clk = clk_register_fixed_rate(&pdata->adev->dev,
> 

Applied, thanks!




