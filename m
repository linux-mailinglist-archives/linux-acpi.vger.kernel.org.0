Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E02FB40E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 09:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbhASI2K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 03:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730691AbhASI1k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Jan 2021 03:27:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED87C2311C;
        Tue, 19 Jan 2021 08:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611044819;
        bh=+Q+XPSElQgpBDAKZynrp8adUrT0O6HKRNCJn++9NB2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3y+bNhPsgZySuRFBVeWqJZKvWn7F9xTrD/4sJXpl8dxZFSJUZ0ch67wuwoBBm3ue
         uaJGFQLRyhPSxkTVB11yGqn86IIQbdEAnwJgIIaZsQsk0LqS1THH3trbHLCRiIqs8E
         7Eu//fwIItYRjJOFE7hxzh0DAEOFjMPhL7FXa5uo=
Date:   Tue, 19 Jan 2021 09:26:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     rjw@rjwysocki.net, AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / device_sysfs: Use OF_MODALIAS for "compatible"
 modalias
Message-ID: <YAaXz9Pg5x3DsCs3@kroah.com>
References: <20210119081513.300938-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119081513.300938-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 19, 2021 at 04:15:13PM +0800, Kai-Heng Feng wrote:
> Commit 8765c5ba1949 ("ACPI / scan: Rework modalias creation when
> "compatible" is present") may create two "MODALIAS=" in uevent file if
> conditions are met.
> 
> This breaks systemd-udevd, which assumes each "key" in uevent file is
> unique. The internal implementation of systemd-udevd overwrites the
> first MODALIAS with the second one, so its kmod rule doesn't load driver
> for the first MODALIAS.
> 
> Right now it doesn't seem to have any user relies on the second
> MODALIAS, so change it to OF_MODALIAS to workaround the issue.
> 
> Reference: https://github.com/systemd/systemd/pull/18163
> Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/acpi/device_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 96869f1538b9..c92b671cb816 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -260,7 +260,7 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
>  	if (!adev->data.of_compatible)
>  		return 0;
>  
> -	if (len > 0 && add_uevent_var(env, "MODALIAS="))
> +	if (len > 0 && add_uevent_var(env, "OF_MODALIAS="))

Who will use OF_MODALIAS and where have you documented it?

thanks,

greg k-h
