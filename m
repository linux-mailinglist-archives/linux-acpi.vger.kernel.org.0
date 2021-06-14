Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60F23A6A67
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhFNPc5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 11:32:57 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:40808 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhFNPck (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 11:32:40 -0400
Received: by mail-oi1-f174.google.com with SMTP id d19so10722094oic.7
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jun 2021 08:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eW2TvJuOd2gIwEAgjs8xYyNeVQdWjexW8SJNau00hmw=;
        b=o6JHXb02c4gAG4PoA56H7jriV303rhCg0WNiHyTkjAGX6MBOuYtBY5Juis6OV3VCFv
         k/m6BK9Y4GXFlXVSy7gb0rMb9utjdPSMbtxOBaWGrndiHbNwZbTgH9X+h/VvxvRD3/Yu
         V+GsesNW+TMAHlcge9sUXr+PfwvUieplggwbS6HmpcELQ3/gUWQOIDZVFQ1ImNZjyNag
         tkkTbKMJGfRJcqMArrqhDrNziYlrQcbXU1yvrIm9HyvKVJVvFFp9qzwYplp3rCcJTSor
         MgoErb3Ot0VcNC5t/ON+ZtIg7C/GWCek5JizrUO3dRPE/vDeJmzzFytR9qoOud3hqpFD
         ctfA==
X-Gm-Message-State: AOAM533LCoCCChn0H2IlgD35xaIwJe9O4msw2of0mhIjd+zITFQ00Hz2
        vobnGTZIJD7TzHvUKhcVOZ1ZjmqirT6WMbyawfSMtWww
X-Google-Smtp-Source: ABdhPJyfhwx3Bg9pYjnV+vzk9Ur50y0Ym8xAfN9LaOn0uDspuY+AXmXU8HUkIm7dho98SfHcuNrn/Q206uoBfGCLmyA=
X-Received: by 2002:aca:b406:: with SMTP id d6mr10860635oif.71.1623684636167;
 Mon, 14 Jun 2021 08:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210612200910.1094351-1-majortomtosourcecontrol@gmail.com>
In-Reply-To: <20210612200910.1094351-1-majortomtosourcecontrol@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jun 2021 17:30:25 +0200
Message-ID: <CAJZ5v0g1iO2_+Pp9j2Y366acnwfgPv9tLDH0PWFHKw+HFWULEw@mail.gmail.com>
Subject: Re: [PATCH] apci: sysfs: Fixed void function style code issues
To:     Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 12, 2021 at 10:10 PM Clayton Casciato
<majortomtosourcecontrol@gmail.com> wrote:
>
> Fixed coding style issues.
>
> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> ---
>  drivers/acpi/sysfs.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index d25927195d6d..d6626aba4a6a 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -582,8 +582,6 @@ static void delete_gpe_attr_array(void)
>                 kfree(counter_attrs);
>         }
>         kfree(all_attrs);
> -
> -       return;
>  }
>
>  static void gpe_count(u32 gpe_number)
> @@ -598,8 +596,6 @@ static void gpe_count(u32 gpe_number)
>         else
>                 all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
>                              COUNT_ERROR].count++;
> -
> -       return;
>  }
>
>  static void fixed_event_count(u32 event_number)
> @@ -612,8 +608,6 @@ static void fixed_event_count(u32 event_number)
>         else
>                 all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
>                              COUNT_ERROR].count++;
> -
> -       return;
>  }
>
>  static void acpi_global_event_handler(u32 event_type, acpi_handle device,
> @@ -914,8 +908,6 @@ static void __exit interrupt_stats_exit(void)
>         sysfs_remove_group(acpi_kobj, &interrupt_stats_attr_group);
>
>         delete_gpe_attr_array();
> -
> -       return;
>  }
>
>  static ssize_t
> --

Applied as 5.14 material with edited subject and changelog.

Thanks!
