Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F037F58D57
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 23:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfF0Vr0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 17:47:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56687 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfF0Vr0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2019 17:47:26 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 6582fdce013de8bd; Thu, 27 Jun 2019 23:47:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1] ACPI / sleep: Switch to use acpi_dev_get_first_match_dev()
Date:   Thu, 27 Jun 2019 23:47:24 +0200
Message-ID: <1695720.PHZDijW4vG@kreacher>
In-Reply-To: <20190612100702.53736-1-andriy.shevchenko@linux.intel.com>
References: <20190612100702.53736-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, June 12, 2019 12:07:02 PM CEST Andy Shevchenko wrote:
> Switch the acpi_pm_finish() to use acpi_dev_get_first_match_dev() instead of
> custom approach.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/sleep.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 8ff08e531443..a94519207dc8 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -452,14 +452,6 @@ static int acpi_pm_prepare(void)
>  	return error;
>  }
>  
> -static int find_powerf_dev(struct device *dev, void *data)
> -{
> -	struct acpi_device *device = to_acpi_device(dev);
> -	const char *hid = acpi_device_hid(device);
> -
> -	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
> -}
> -
>  /**
>   *	acpi_pm_finish - Instruct the platform to leave a sleep state.
>   *
> @@ -468,7 +460,7 @@ static int find_powerf_dev(struct device *dev, void *data)
>   */
>  static void acpi_pm_finish(void)
>  {
> -	struct device *pwr_btn_dev;
> +	struct acpi_device *pwr_btn_adev;
>  	u32 acpi_state = acpi_target_sleep_state;
>  
>  	acpi_ec_unblock_transactions();
> @@ -499,11 +491,11 @@ static void acpi_pm_finish(void)
>  		return;
>  
>  	pwr_btn_event_pending = false;
> -	pwr_btn_dev = bus_find_device(&acpi_bus_type, NULL, NULL,
> -				      find_powerf_dev);
> -	if (pwr_btn_dev) {
> -		pm_wakeup_event(pwr_btn_dev, 0);
> -		put_device(pwr_btn_dev);
> +	pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
> +						    NULL, -1);
> +	if (pwr_btn_adev) {
> +		pm_wakeup_event(&pwr_btn_adev->dev, 0);
> +		acpi_dev_put(pwr_btn_adev);
>  	}
>  }
>  
> 

Applied, thanks!




