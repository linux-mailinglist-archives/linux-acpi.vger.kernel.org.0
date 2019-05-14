Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25C61D144
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2019 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfENV2D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 May 2019 17:28:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60728 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENV2D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 May 2019 17:28:03 -0400
Received: from 79.184.255.148.ipv4.supernova.orange.pl (79.184.255.148) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 5516b80e513c2c6a; Tue, 14 May 2019 23:28:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Rajat Jain <rajatja@google.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        furquan@google.com
Subject: Re: [RFC PATCH] ACPI: PM: Enable wake-up device GPEs for suspend-to-idle
Date:   Tue, 14 May 2019 23:28:00 +0200
Message-ID: <17514687.kF9exGCLEa@kreacher>
In-Reply-To: <20190513191708.87956-1-rajatja@google.com>
References: <20190513191708.87956-1-rajatja@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, May 13, 2019 9:17:08 PM CEST Rajat Jain wrote:
> I noticed that recently multiple systems (chromebooks) couldn't wake
> from S0ix using LID or Keyboard after updating to a newer kernel, I
> bisected and the issue is seen starting the following commit:
> 
> commit f941d3e41da7 ("ACPI: EC / PM: Disable non-wakeup GPEs for
> suspend-to-idle")
> 
> and found that the issue gets fixed if I revert it. I debugged and
> found that although PNP0C0D:00 (representing the LID) is wake capable
> and should wakeup the system per the code in acpi_wakeup_gpe_init()
> and in drivers/acpi/button.c:
> 
> localhost /sys # cat /proc/acpi/wakeup
> Device  S-state   Status   Sysfs node
> LID0      S4    *enabled   platform:PNP0C0D:00
> CREC      S5    *disabled  platform:GOOG0004:00
>                 *disabled  platform:cros-ec-dev.1.auto
>                 *disabled  platform:cros-ec-accel.0
>                 *disabled  platform:cros-ec-accel.1
>                 *disabled  platform:cros-ec-gyro.0
>                 *disabled  platform:cros-ec-ring.0
>                 *disabled  platform:cros-usbpd-charger.2.auto
>                 *disabled  platform:cros-usbpd-logger.3.auto
> D015      S3    *enabled   i2c:i2c-ELAN0000:00
> PENH      S3    *enabled   platform:PRP0001:00
> XHCI      S3    *enabled   pci:0000:00:14.0
> GLAN      S4    *disabled
> WIFI      S3    *disabled  pci:0000:00:14.3
> localhost /sys #
> 
> On debugging, I found that its corresponding GPE is not being enabled.
> The particular GPE's "gpe_register_info->enable_for_wake" does not have any
> bits set when acpi_enable_all_wakeup_gpes() comes around to use it. I
> looked at code and could not find any other code path that should set the
> bits in "enable_for_wake" bitmask for the wake enabled devices for s2idle
> (I do see that it happens for S3 in acpi_sleep_prepare()).
> 
> Thus I used the same call to enable the GPEs for wake enabled devices,
> and verified that this fixes the regression I was seeing on multiple of
> my devices.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203579
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/acpi/sleep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 403c4ff15349..e52f1238d2d6 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -977,6 +977,8 @@ static int acpi_s2idle_prepare(void)
>  	if (acpi_sci_irq_valid())
>  		enable_irq_wake(acpi_sci_irq);
>  
> +	acpi_enable_wakeup_devices(ACPI_STATE_S0);
> +
>  	/* Change the configuration of GPEs to avoid spurious wakeup. */
>  	acpi_enable_all_wakeup_gpes();
>  	acpi_os_wait_events_complete();
> @@ -1027,6 +1029,8 @@ static void acpi_s2idle_restore(void)
>  {
>  	acpi_enable_all_runtime_gpes();
>  
> +	acpi_disable_wakeup_devices(ACPI_STATE_S0);
> +
>  	if (acpi_sci_irq_valid())
>  		disable_irq_wake(acpi_sci_irq);
>  
> 

Applied, thanks!




