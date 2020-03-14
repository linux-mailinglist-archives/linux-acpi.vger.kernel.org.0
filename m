Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53FA18588C
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Mar 2020 03:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgCOCN5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Mar 2020 22:13:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43081 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgCOCN5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2020 22:13:57 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 4685d5ea9f201b09; Sat, 14 Mar 2020 11:13:56 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: fan: Use scnprintf() for avoiding potential buffer overflow
Date:   Sat, 14 Mar 2020 11:13:55 +0100
Message-ID: <6805885.HkWLXbPDYh@kreacher>
In-Reply-To: <20200311070851.3731-1-tiwai@suse.de>
References: <20200311070851.3731-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, March 11, 2020 8:08:51 AM CET Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Also adjust the argument to really match with the actually remaining
> buffer size.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/acpi/fan.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index aaf4e8f348cf..873e039ad4b7 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -276,29 +276,29 @@ static ssize_t show_state(struct device *dev, struct device_attribute *attr, cha
>  	int count;
>  
>  	if (fps->control == 0xFFFFFFFF || fps->control > 100)
> -		count = snprintf(buf, PAGE_SIZE, "not-defined:");
> +		count = scnprintf(buf, PAGE_SIZE, "not-defined:");
>  	else
> -		count = snprintf(buf, PAGE_SIZE, "%lld:", fps->control);
> +		count = scnprintf(buf, PAGE_SIZE, "%lld:", fps->control);
>  
>  	if (fps->trip_point == 0xFFFFFFFF || fps->trip_point > 9)
> -		count += snprintf(&buf[count], PAGE_SIZE, "not-defined:");
> +		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
>  	else
> -		count += snprintf(&buf[count], PAGE_SIZE, "%lld:", fps->trip_point);
> +		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->trip_point);
>  
>  	if (fps->speed == 0xFFFFFFFF)
> -		count += snprintf(&buf[count], PAGE_SIZE, "not-defined:");
> +		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
>  	else
> -		count += snprintf(&buf[count], PAGE_SIZE, "%lld:", fps->speed);
> +		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->speed);
>  
>  	if (fps->noise_level == 0xFFFFFFFF)
> -		count += snprintf(&buf[count], PAGE_SIZE, "not-defined:");
> +		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
>  	else
> -		count += snprintf(&buf[count], PAGE_SIZE, "%lld:", fps->noise_level * 100);
> +		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->noise_level * 100);
>  
>  	if (fps->power == 0xFFFFFFFF)
> -		count += snprintf(&buf[count], PAGE_SIZE, "not-defined\n");
> +		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined\n");
>  	else
> -		count += snprintf(&buf[count], PAGE_SIZE, "%lld\n", fps->power);
> +		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld\n", fps->power);
>  
>  	return count;
>  }
> 

Applied as 5.7 material, thanks!




