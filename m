Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A0827A406
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Sep 2020 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI0U1r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Sep 2020 16:27:47 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:34435 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI0U1q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Sep 2020 16:27:46 -0400
Received: from [192.168.42.210] ([93.22.39.148])
        by mwinf5d36 with ME
        id Z8Th230063BnMZH038ThwF; Sun, 27 Sep 2020 22:27:44 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Sep 2020 22:27:44 +0200
X-ME-IP: 93.22.39.148
Subject: Re: [PATCH 12/18] ACPI: use semicolons rather than commas to separate
 statements
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
 <1601233948-11629-13-git-send-email-Julia.Lawall@inria.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <446ee567-ecc1-fcc9-2691-d4160fdf2150@wanadoo.fr>
Date:   Sun, 27 Sep 2020 22:27:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601233948-11629-13-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Le 27/09/2020 à 21:12, Julia Lawall a écrit :
> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>   drivers/acpi/processor_idle.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index f66236cff69b..85502143f506 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1077,7 +1077,9 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>   		/* flatten all the LPI states in this level of hierarchy */
>   		flatten_lpi_states(pr, curr, prev);
>   
> -		tmp = prev, prev = curr, curr = tmp;
> +		tmp = prev;
> +		prev = curr;
> +		curr = tmp;
>   
>   		status = acpi_get_parent(handle, &pr_ahandle);
>   	}
> 
> 
swap(prev, curr)?

CJ
