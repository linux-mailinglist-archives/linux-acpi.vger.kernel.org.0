Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA852106D2
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfEAKMj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 06:12:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59252 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfEAKMi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 May 2019 06:12:38 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 71a593e25621d482; Wed, 1 May 2019 12:12:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: event: replace strcpy() by strscpy()
Date:   Wed, 01 May 2019 12:12:35 +0200
Message-ID: <3853797.yZSUUGEqGl@kreacher>
In-Reply-To: <20190422163934.GA2636@embeddedor>
References: <20190422163934.GA2636@embeddedor>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, April 22, 2019 6:39:34 PM CEST Gustavo A. R. Silva wrote:
> The strcpy() function is being deprecated. Replace it by the safer
> strscpy() and fix the following Coverity warnings:
> 
> "You might overrun the 15-character fixed-size string event->bus_id
> by copying bus_id without checking the length."
> 
> "You might overrun the 20-character fixed-size string event->device_class
> by copying device_class without checking the length."
> 
> Addresses-Coverity-ID: 139001 ("Copy into fixed size buffer")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/acpi/event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
> index 5a127f3f2d5c..47f21599f2ab 100644
> --- a/drivers/acpi/event.c
> +++ b/drivers/acpi/event.c
> @@ -131,8 +131,8 @@ int acpi_bus_generate_netlink_event(const char *device_class,
>  	event = nla_data(attr);
>  	memset(event, 0, sizeof(struct acpi_genl_event));
>  
> -	strcpy(event->device_class, device_class);
> -	strcpy(event->bus_id, bus_id);
> +	strscpy(event->device_class, device_class, sizeof(event->device_class));
> +	strscpy(event->bus_id, bus_id, sizeof(event->bus_id));
>  	event->type = type;
>  	event->data = data;
>  
> 

Applied, thanks!




