Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72D52834F2
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgJEL3W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 07:29:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40714 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJEL3V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 07:29:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id m128so8359164oig.7;
        Mon, 05 Oct 2020 04:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6lFl31eFcV62mdRSrgqi2jVtVPOBQr2Cb4J+E02tlE=;
        b=jrcwWR5MA8Feq0FiFnGUs/a88kUFrJUhHgXCpDDkBcZw0rOrXKiUrD0TBvtc2H8VXV
         NKNzZurOkbfpNz8pIXMdTcEGURKn+uDqge5OaLjP8kYfmL/4hRUGga9zXjLwh/G6UL4a
         UXe+nzRCnrNO1w2Qw53T/ktHDsmwVWoFlk9+922XFKvJcsqiyBtPEbgoLRSMVRu1NecF
         LqP7hdNzwsmsWH5F6s31sdapAqVxe9GU0lxOGaElMvYoaned4tKC8SU2i7AkJrIs3e0g
         pC2aeU1oQ0ljMGoNvXnePD5UgjKhXxn4iOIq4YT6w/K1t0N5sXfrR68WePvTE0E4bt7R
         +DEQ==
X-Gm-Message-State: AOAM532XuUTekUkt/zqM6Xn/+eA3dngBYy4/kNltbwxaTdEb02ilaCk2
        5PIWPqG7memUd9fAvfbMfb/VBKmJE1tV/uKACJD0y/kV
X-Google-Smtp-Source: ABdhPJy5oSVbn/jgSCcVTW/SgVTLyIBbPb9dm+QZNnpgcfqTsHrmEjvS2hF2S6R94ZvtzUnNvj2TPHwTAOJdxQnL4r0=
X-Received: by 2002:aca:5c84:: with SMTP id q126mr5556700oib.71.1601897360718;
 Mon, 05 Oct 2020 04:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201005051125.GA3245495@dtor-ws>
In-Reply-To: <20201005051125.GA3245495@dtor-ws>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Oct 2020 13:29:05 +0200
Message-ID: <CAJZ5v0jTXNYwLcUcaOHk89WVxWCZEZJhMUd94KBdsTK41Eo-5g@mail.gmail.com>
Subject: Re: [PATCH] ACPI / button: fix handling lid state changes when input
 device closed
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 5, 2020 at 7:11 AM <dmitry.torokhov@gmail.com> wrote:
>
> The original intent of 84d3f6b76447 was to delay evaluating lid state until
> all drivers have been loaded, with input device being opened from userspace
> serving as a signal for this condition. Let's ensure that state updates
> happen even if userspace closed (or in the future inhibited) input device.
>
> Note that if we go through suspend/resume cycle we assume the system has
> been fully initialized even if LID input device has not been opened yet.
>
> This has a side-effect of fixing access to input->users outside of
> input->mutex protections by the way of eliminating said accesses and using
> driver private flag.
>
> Fixes: 84d3f6b76447 ("ACPI / button: Delay acpi_lid_initialize_state() until first user space open")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/acpi/button.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 78cfc70cb320..b8dd51d8f96d 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -154,6 +154,7 @@ struct acpi_button {
>         int last_state;
>         ktime_t last_time;
>         bool suspended;
> +       bool lid_state_initialized;
>  };
>
>  static struct acpi_device *lid_device;
> @@ -384,6 +385,8 @@ static int acpi_lid_update_state(struct acpi_device *device,
>
>  static void acpi_lid_initialize_state(struct acpi_device *device)
>  {
> +       struct acpi_button *button = acpi_driver_data(device);
> +
>         switch (lid_init_state) {
>         case ACPI_BUTTON_LID_INIT_OPEN:
>                 (void)acpi_lid_notify_state(device, 1);
> @@ -395,13 +398,14 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
>         default:
>                 break;
>         }
> +
> +       button->lid_state_initialized = true;
>  }
>
>  static void acpi_button_notify(struct acpi_device *device, u32 event)
>  {
>         struct acpi_button *button = acpi_driver_data(device);
>         struct input_dev *input;
> -       int users;
>
>         switch (event) {
>         case ACPI_FIXED_HARDWARE_EVENT:
> @@ -410,10 +414,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>         case ACPI_BUTTON_NOTIFY_STATUS:
>                 input = button->input;
>                 if (button->type == ACPI_BUTTON_TYPE_LID) {
> -                       mutex_lock(&button->input->mutex);
> -                       users = button->input->users;
> -                       mutex_unlock(&button->input->mutex);
> -                       if (users)
> +                       if (button->lid_state_initialized)
>                                 acpi_lid_update_state(device, true);
>                 } else {
>                         int keycode;
> @@ -458,7 +459,7 @@ static int acpi_button_resume(struct device *dev)
>         struct acpi_button *button = acpi_driver_data(device);
>
>         button->suspended = false;
> -       if (button->type == ACPI_BUTTON_TYPE_LID && button->input->users) {
> +       if (button->type == ACPI_BUTTON_TYPE_LID) {
>                 button->last_state = !!acpi_lid_evaluate_state(device);
>                 button->last_time = ktime_get();
>                 acpi_lid_initialize_state(device);
> --

Applied as 5.10 material with the R-by from Hans, thanks!
