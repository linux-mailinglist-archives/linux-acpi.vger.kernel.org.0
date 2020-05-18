Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A151D78C8
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgERMkw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 08:40:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62696 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgERMkw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2020 08:40:52 -0400
Received: from 89-64-86-21.dynamic.chello.pl (89.64.86.21) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 0d093ed2be4aae80; Mon, 18 May 2020 14:40:50 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>, kernel@collabora.com
Subject: Re: [PATCHv2 3/7] ACPI: button: Use input_device_enabled() helper
Date:   Mon, 18 May 2020 14:40:45 +0200
Message-ID: <1834268.b3YDLlcz4u@kreacher>
In-Reply-To: <20200515165327.29212-1-andrzej.p@collabora.com>
References: <20200515164943.28480-1-andrzej.p@collabora.com> <20200515165327.29212-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, May 15, 2020 6:53:27 PM CEST Andrzej Pietrasiewicz wrote:
> A new helper is available, so use it. Inspecting input device's 'users'
> member should be done under device's mutex, so add appropriate invocations.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/acpi/button.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 78cfc70cb320..7e081bae48ab 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -411,7 +411,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>  		input = button->input;
>  		if (button->type == ACPI_BUTTON_TYPE_LID) {
>  			mutex_lock(&button->input->mutex);
> -			users = button->input->users;
> +			users = input_device_enabled(button->input);
>  			mutex_unlock(&button->input->mutex);
>  			if (users)
>  				acpi_lid_update_state(device, true);
> @@ -456,13 +456,17 @@ static int acpi_button_resume(struct device *dev)
>  {
>  	struct acpi_device *device = to_acpi_device(dev);
>  	struct acpi_button *button = acpi_driver_data(device);
> +	struct input_dev *input = button->input;
>  
>  	button->suspended = false;
> -	if (button->type == ACPI_BUTTON_TYPE_LID && button->input->users) {
> +	mutex_lock(&input->mutex);
> +	if (button->type == ACPI_BUTTON_TYPE_LID &&
> +	    input_device_enabled(input)) {
>  		button->last_state = !!acpi_lid_evaluate_state(device);
>  		button->last_time = ktime_get();
>  		acpi_lid_initialize_state(device);
>  	}
> +	mutex_unlock(&input->mutex);
>  	return 0;
>  }
>  #endif
> 

This appears to conflate a fix (the introduction of the missing mutex locking)
with adding new functionality through input_device_enabled().

Please do the fix separately in advance so it can be backported.

Thanks!



