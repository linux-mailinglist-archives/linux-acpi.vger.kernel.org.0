Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1211D911
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 23:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfLLWKf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 17:10:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63468 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfLLWKe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Dec 2019 17:10:34 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b488f049766fb159; Thu, 12 Dec 2019 23:10:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     Balbir Singh <sblbir@amazon.com>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: Re: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Date:   Thu, 12 Dec 2019 23:10:32 +0100
Message-ID: <5749186.Fh4Yg0zt7g@kreacher>
In-Reply-To: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
References: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, October 29, 2018 6:52:16 PM CET Anchal Agarwal wrote:
> Currently we do not see sleep_enable bit set after guest resumes
> from hibernation. Hibernation is triggered in guest on receiving
> a sleep trigger from the hypervisor(S4 state). We see that power
> button is enabled on wake up from S4 state however sleep button
> isn't.

I'm not against this change in principle, although it may change behavior
in a somewhat unexpected way on some systems.

> This causes subsequent invocation of sleep state to fail
> in the guest.

However, can you explain this in a bit more detail?
 
> Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
> Reviewed-by: Balbir Singh <sblbir@amazon.com>
> Reviewed-by: Frank van der Linden <fllinden@amazon.com>
> ---
>  drivers/acpi/acpica/hwsleep.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> index b62db8ec446f..a176c7802760 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -300,6 +300,17 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
>  				    [ACPI_EVENT_POWER_BUTTON].
>  				    status_register_id, ACPI_CLEAR_STATUS);
>  
> +	/* Enable sleep button */
> +	(void)
> +	      acpi_write_bit_register(acpi_gbl_fixed_event_info
> +				      [ACPI_EVENT_SLEEP_BUTTON].
> +				      enable_register_id, ACPI_ENABLE_EVENT);
> +
> +	(void)
> +	      acpi_write_bit_register(acpi_gbl_fixed_event_info
> +				      [ACPI_EVENT_SLEEP_BUTTON].
> +				      status_register_id, ACPI_CLEAR_STATUS);
> +
>  	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
>  	return_ACPI_STATUS(status);
>  }
> 




