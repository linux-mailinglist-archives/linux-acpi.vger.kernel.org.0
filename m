Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46B2AD3C8E
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfJKJlU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 11 Oct 2019 05:41:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46846 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJlU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 05:41:20 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id b8f52977fd553eb6; Fri, 11 Oct 2019 11:41:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kacper =?utf-8?B?UGl3acWEc2tp?= <cosiekvfj@o2.pl>
Cc:     rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: acpi_video: update doc for acpi_video_bus_DOS
Date:   Fri, 11 Oct 2019 11:41:17 +0200
Message-ID: <3045273.zdn4mdtSDm@kreacher>
In-Reply-To: <20191007154818.7416-1-cosiekvfj@o2.pl>
References: <20191007154818.7416-1-cosiekvfj@o2.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, October 7, 2019 5:48:18 PM CEST Kacper Piwiński wrote:
> commit:
> efaa14c
> 
> "Starting from win8, MS backlight control driver will set bit 2 of the
> parameter of control method _DOS, to inform firmware it should not
> perform any automatic brightness changes. This mostly affects hotkey
> notification deliver - if we do not set this bit, on hotkey press,
> firmware may choose to adjust brightness level instead of sending out
> notification and doing nothing."
> 
> win7:
> https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/BrightnessCtrl.docx
> 
> "To avoid problems that might occur if both the system firmware and
> the monitor driver control the brightness of the display, the display
> miniport driver should set bit 2 of the argument to the _DOS method.
> Setting this bit notifies the system firmware that it should not
> perform any automatic display brightness changes. The WDDM
> driver must set this particular bit because it controls the _DOS
> method. The other bits in the _DOS method control the behavior of
> the firmware in response to the display switch hot keys."
> 
> win8:
> http://read.pudn.com/downloads193/doc/907411/Brightness.doc
> 
> Signed-off-by: Kacper Piwiński <cosiekvfj@o2.pl>
> ---
>  drivers/acpi/acpi_video.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 4f325e47519f..2f380e7381d6 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -699,9 +699,13 @@ acpi_video_device_EDID(struct acpi_video_device *device,
>   *			event notify code.
>   *	lcd_flag	:
>   *		0.	The system BIOS should automatically control the brightness level
> - *			of the LCD when the power changes from AC to DC
> + *			of the LCD when:
> + *			- the power changes from AC to DC (ACPI appendix B)
> + *			- a brightness hotkey gets pressed (implied by Win7/8 backlight docs)
>   *		1.	The system BIOS should NOT automatically control the brightness
> - *			level of the LCD when the power changes from AC to DC.
> + *			level of the LCD when:
> + *			- the power changes from AC to DC (ACPI appendix B)
> + *			- a brightness hotkey gets pressed (implied by Win7/8 backlight docs)
>   *  Return Value:
>   *		-EINVAL	wrong arg.
>   */
> 

Applying as 5.5 material, thanks!




