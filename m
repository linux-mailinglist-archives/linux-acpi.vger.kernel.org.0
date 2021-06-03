Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD5239A99A
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 19:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFCR7E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 13:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhFCR7E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Jun 2021 13:59:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 265FD60FE7;
        Thu,  3 Jun 2021 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622743019;
        bh=DAu8F058O9l9sBiuN4xnkBqSM2ZO6F4LaCF4K1LgmBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UlipMuJlfy3ZEWlIDPcd/ubG6t9VvpPnG7q4wnCDzSMNhVRU+6g69itQVpMKzDDBl
         k76MKIRUuXRSQ60vJFTsI9RbPLv50g1/La4yEmQxmD9/XnL0uZcWv9oeG45PSGmgf8
         A6igPPv2+iZuXriaDSmB6NuVRjaS/6AfXPP1TJU6zttzVkqA6FnTXj6Tn0ziNu3t4a
         Hwto2HM825DP9E5Do47mqZ93EHRPA4Ev6nVxzHxiDGIGmT5t0DFmRf5QCbxEHZh/BN
         nPFqoO+U0D7xOK7pZXqUUDC+pjlnVLp1rBciUTltWTsA9BDRTFXnLk+OhGuAp8AUjQ
         IClvPYk4vr8WA==
Date:   Thu, 3 Jun 2021 12:56:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lance Ortiz <lance.ortiz@hp.com>,
        Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: sysfs: Fix a buffer overrun problem with
 description_show()
Message-ID: <20210603175657.GA2128066@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603171201.801071-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 03, 2021 at 05:12:01PM +0000, Krzysztof Wilczyński wrote:
> Currently, a device description can be obtained using ACPI, if the _STR
> method exists for a particular device, and then exposed to the userspace
> via a sysfs object as a string value.
> 
> If the _STR method is available for a given device then the data
> (usually a Unicode string) is read and stored in a buffer (of the
> ACPI_TYPE_BUFFER type) with a pointer to said buffer cached in the
> struct acpi_device_pnp for later access.
> 
> The description_show() function is responsible for exposing the device
> description to the userspace via a corresponding sysfs object and
> internally calls the utf16s_to_utf8s() function with a pointer to the
> buffer that contains the Unicode string so that it can be converted from
> UTF16 encoding to UTF8 and thus allowing for the value to be safely
> stored and later displayed.
> 
> When invoking the utf16s_to_utf8s() function, the description_show()
> function also sets a limit of the data that can be saved into a provided
> buffer as a result of the character conversion to be a total of
> PAGE_SIZE, and upon completion, the utf16s_to_utf8s() function returns
> an integer value denoting the number of bytes that have been written
> into the provided buffer.
> 
> Following the execution of the utf16s_to_utf8s() a newline character
> will be added at the end of the resulting buffer so that when the value
> is read in the userspace through the sysfs object then it would include
> newline making it more accessible when working with the sysfs file
> system in the shell, etc.  Normally, this wouldn't be a problem, but if
> the function utf16s_to_utf8s() happens to return the number of bytes
> written to be precisely PAGE_SIZE, then we would overrun the buffer and
> write the newline character outside the allotted space which can have
> undefined consequences or result in a failure.
> 
> To fix this buffer overrun, ensure that there always is enough space
> left for the newline character to be safely appended.
> 
> Fixes: d1efe3c324ea ("ACPI: Add new sysfs interface to export device description")
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Looks right to me.  I think the critical part of the commit log is the
fact that utf16s_to_utf8s() may put up to PAGE_SIZE bytes in the
buffer, and we add a newline *after* that.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/device_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index fa2c1c93072c..a393e0e09381 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -448,7 +448,7 @@ static ssize_t description_show(struct device *dev,
>  		(wchar_t *)acpi_dev->pnp.str_obj->buffer.pointer,
>  		acpi_dev->pnp.str_obj->buffer.length,
>  		UTF16_LITTLE_ENDIAN, buf,
> -		PAGE_SIZE);
> +		PAGE_SIZE - 1);
>  
>  	buf[result++] = '\n';
>  
> -- 
> 2.31.1
> 
