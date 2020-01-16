Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCCF13D719
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2020 10:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAPJkW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jan 2020 04:40:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43259 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPJkW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jan 2020 04:40:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so18317182oif.10;
        Thu, 16 Jan 2020 01:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehZVRRgGA6K7LYKERYT9m9Kqby1XUIRO5leJf884LQg=;
        b=tbNAoalcCFQwchIcvadfmk38UTHM9PFnmL7tSpYsOE3/h2lG03b0xJwvX7mOr8KBIc
         lT/6p/Z4lv02ijdfMbmAy8NZA6jNue6nDAHb7bgULvVJT4HIAUWGvHiMxQE9cDru6Pm1
         L9usN7+QSl+6G6Em5TpjK+ZVZeqPzOAapVbNoOAt7CeVJ0RNl5X1e2ZCT8LlUAd/B/Dg
         XwGmssoLMrppPiyFR4eOH4q+sweyJhf6GhgObkY6OFfae/GYI2thu7OgEnuJadO+SxTF
         qngHnAuop9Rjdrt2FUd0jTd8G9i91SvKzsljYsRszHjTOc0FvDhJig8vx53Nm55CxU4v
         mNIA==
X-Gm-Message-State: APjAAAWmeHXe7hnEpWHG2IhbMfJqm4PLD5Xq+g7lJGLyhd6P70E4vBLL
        MV2zBaD6jKBpUPQ76sg9B4gXROh26jA4U/ooVzg=
X-Google-Smtp-Source: APXvYqycvvoo15q+FPGQpz1gedkk2HzrTF+WByd8rPEEEg6NgUkf5VAlB3qg+1sxI+fx5OiEllxn+V4E7zXAb2JHu2Y=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr3388803oig.68.1579167621279;
 Thu, 16 Jan 2020 01:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20200115232629.GA9231@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
In-Reply-To: <20200115232629.GA9231@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jan 2020 10:40:08 +0100
Message-ID: <CAJZ5v0iHVzDzS5zZSTWOdy2CCSkyW74+p2-Et0+EcysOvL2CDg@mail.gmail.com>
Subject: Re: [RESEND PATCH] ACPICA: Enable sleep button on ACPI legacy wake
To:     Anchal Agarwal <anchalag@amazon.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Singh, Balbir" <sblbir@amazon.com>, fllinden@amazon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 16, 2020 at 12:26 AM Anchal Agarwal <anchalag@amazon.com> wrote:
>
> Currently we do not see sleep_enable bit set after guest resumes
> from hibernation. Hibernation is triggered in guest on receiving
> a sleep trigger from the hypervisor(S4 state). We see that power
> button is enabled on wake up from S4 state however sleep button
> isn't. This causes subsequent invocation of sleep state to fail
> in the guest. Any environment  going through acpi_hw_legacy_wake()
> won't have sleep button enabled.
>
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
>                                     [ACPI_EVENT_POWER_BUTTON].
>                                     status_register_id, ACPI_CLEAR_STATUS);
>
> +       /* Enable sleep button */
> +       (void)
> +             acpi_write_bit_register(acpi_gbl_fixed_event_info
> +                                     [ACPI_EVENT_SLEEP_BUTTON].
> +                                     enable_register_id, ACPI_ENABLE_EVENT);
> +
> +       (void)
> +             acpi_write_bit_register(acpi_gbl_fixed_event_info
> +                                     [ACPI_EVENT_SLEEP_BUTTON].
> +                                     status_register_id, ACPI_CLEAR_STATUS);
> +
>         acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
>         return_ACPI_STATUS(status);
>  }

Erik, Bob, please pick this up if you don't have specific objections against it.

I'll wait for it to show up in an upstream release.
