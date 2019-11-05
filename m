Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34455F0A4F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 00:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfKEXmF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Nov 2019 18:42:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55606 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKEXmF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2019 18:42:05 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id e32b34b1b09df63b; Wed, 6 Nov 2019 00:42:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6 11/15] software node: move small properties inline when copying
Date:   Wed, 06 Nov 2019 00:42:02 +0100
Message-ID: <47671501.dVG71sAca0@kreacher>
In-Reply-To: <20191023200233.86616-12-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com> <20191023200233.86616-12-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, October 23, 2019 10:02:29 PM CET Dmitry Torokhov wrote:
> When copying/duplicating set of properties, move smaller properties that
> were stored separately directly inside property entry structures. We can
> move:
> 
> - up to 8 bytes from U8 arrays
> - up to 4 words
> - up to 2 double words
> - one U64 value
> - one or 2 strings.

Yes, we can do that, but how much of a difference does this really make?

Also, how can one distinguish between a single-value property and an inline
array which this change?  By looking at the length?

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/swnode.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 18a30fb3cc58..49e1108aa4b7 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -280,6 +280,16 @@ static int property_entry_copy_data(struct property_entry *dst,
>  	if (!dst->name)
>  		goto out_free_data;
>  
> +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> +		/* We have an opportunity to move the data inline */
> +		const void *tmp = dst->pointer;
> +
> +		memcpy(&dst->value, tmp, dst->length);
> +		dst->is_inline = true;
> +
> +		kfree(tmp);

This would have been more useful if we had been able to avoid making the
allocation altogether.

> +	}
> +
>  	return 0;
>  
>  out_free_data:
> 




