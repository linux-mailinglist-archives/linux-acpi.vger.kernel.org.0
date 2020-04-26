Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7491B91BC
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Apr 2020 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDZQbu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Apr 2020 12:31:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50178 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgDZQbu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Apr 2020 12:31:50 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id d4f95e24674149c7; Sun, 26 Apr 2020 18:31:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ACPI / CPPC: Make some symbols static
Date:   Sun, 26 Apr 2020 18:31:47 +0200
Message-ID: <2458050.BygcShJWPJ@kreacher>
In-Reply-To: <1587626518-97669-1-git-send-email-zou_wei@huawei.com>
References: <1587626518-97669-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, April 23, 2020 9:21:58 AM CEST Zou Wei wrote:
> Fix the following sparse warnings:
> 
> drivers/acpi/cppc_acpi.c:353:20: warning: symbol 'cppc_mbox_cl' was not declared. Should it be static?
> drivers/acpi/cppc_acpi.c:600:5: warning: symbol 'pcc_data_alloc' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 8b2e89c..f818400 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -350,7 +350,7 @@ static void cppc_chan_tx_done(struct mbox_client *cl, void *msg, int ret)
>  				*(u16 *)msg, ret);
>  }
>  
> -struct mbox_client cppc_mbox_cl = {
> +static struct mbox_client cppc_mbox_cl = {
>  	.tx_done = cppc_chan_tx_done,
>  	.knows_txdone = true,
>  };
> @@ -597,7 +597,7 @@ bool __weak cpc_ffh_supported(void)
>   *
>   * Return: 0 for success, errno for failure
>   */
> -int pcc_data_alloc(int pcc_ss_id)
> +static int pcc_data_alloc(int pcc_ss_id)
>  {
>  	if (pcc_ss_id < 0 || pcc_ss_id >= MAX_PCC_SUBSPACES)
>  		return -EINVAL;
> 

Applied as 5.8-candidate material, thanks!




