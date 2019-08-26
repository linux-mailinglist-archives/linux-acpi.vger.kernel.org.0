Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA69CC24
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 11:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfHZJFf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 05:05:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42514 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfHZJFf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Aug 2019 05:05:35 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 49f11178a4d35fea; Mon, 26 Aug 2019 11:05:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] ACPI / processor: don't print errors for processorIDs == 0xff
Date:   Mon, 26 Aug 2019 11:05:33 +0200
Message-ID: <5372815.QC7b48KNX5@kreacher>
In-Reply-To: <20190807111037.27182-1-jslaby@suse.cz>
References: <20190807111037.27182-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, August 7, 2019 1:10:37 PM CEST Jiri Slaby wrote:
> Some platforms define their processors in this manner:
>     Device (SCK0)
>     {
> 	Name (_HID, "ACPI0004" /* Module Device */)  // _HID: Hardware ID
> 	Name (_UID, "CPUSCK0")  // _UID: Unique ID
> 	Processor (CP00, 0x00, 0x00000410, 0x06){}
> 	Processor (CP01, 0x02, 0x00000410, 0x06){}
> 	Processor (CP02, 0x04, 0x00000410, 0x06){}
> 	Processor (CP03, 0x06, 0x00000410, 0x06){}
> 	Processor (CP04, 0x01, 0x00000410, 0x06){}
> 	Processor (CP05, 0x03, 0x00000410, 0x06){}
> 	Processor (CP06, 0x05, 0x00000410, 0x06){}
> 	Processor (CP07, 0x07, 0x00000410, 0x06){}
> 	Processor (CP08, 0xFF, 0x00000410, 0x06){}
> 	Processor (CP09, 0xFF, 0x00000410, 0x06){}
> 	Processor (CP0A, 0xFF, 0x00000410, 0x06){}
> 	Processor (CP0B, 0xFF, 0x00000410, 0x06){}
> ...
> 
> The processors marked as 0xff are invalid, there are only 8 of them in
> this case.
> 
> So do not print an error on ids == 0xff, just print an info message.
> Actually, we could return ENODEV even on the first CPU with ID 0xff, but
> ACPI spec does not forbid the 0xff value to be a processor ID. Given
> 0xff could be a correct one, we would break working systems if we
> returned ENODEV.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpi_processor.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 24f065114d42..2c4dda0787e8 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -279,9 +279,13 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	}
>  
>  	if (acpi_duplicate_processor_id(pr->acpi_id)) {
> -		dev_err(&device->dev,
> -			"Failed to get unique processor _UID (0x%x)\n",
> -			pr->acpi_id);
> +		if (pr->acpi_id == 0xff)
> +			dev_info_once(&device->dev,
> +				"Entry not well-defined, consider updating BIOS\n");
> +		else
> +			dev_err(&device->dev,
> +				"Failed to get unique processor _UID (0x%x)\n",
> +				pr->acpi_id);
>  		return -ENODEV;
>  	}
>  
> 

Applied, thanks!




