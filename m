Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5BFAF12
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 11:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKMK4W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 05:56:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55415 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMK4W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2019 05:56:22 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 84cabe2e8f322837; Wed, 13 Nov 2019 11:56:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] ACPI: OSI: Shoot duplicate word
Date:   Wed, 13 Nov 2019 11:56:19 +0100
Message-ID: <1893397.DovUig9K4z@kreacher>
In-Reply-To: <20191105101501.3291-1-ruansy.fnst@cn.fujitsu.com>
References: <20191105101501.3291-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, November 5, 2019 11:15:01 AM CET Shiyang Ruan wrote:
> From: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> "this" is duplicated.
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  drivers/acpi/osi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index bec0bebc7f52..9f6853809138 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -473,9 +473,9 @@ static const struct dmi_system_id acpi_osi_dmi_table[] __initconst = {
>  	 */
>  
>  	/*
> -	 * Without this this EEEpc exports a non working WMI interface, with
> -	 * this it exports a working "good old" eeepc_laptop interface, fixing
> -	 * both brightness control, and rfkill not working.
> +	 * Without this EEEpc exports a non working WMI interface, with
> +	 * this it exports a working "good old" eeepc_laptop interface,
> +	 * fixing both brightness control, and rfkill not working.
>  	 */
>  	{
>  	.callback = dmi_enable_osi_linux,
> 

Applying as 5.5 material, thanks!




