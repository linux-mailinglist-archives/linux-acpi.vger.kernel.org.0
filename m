Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA131BB2F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 15:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBOOfp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 09:35:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230030AbhBOOfn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Feb 2021 09:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613399653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2J+8Tfem94WsFrszmXvqkgjRa934v/heCKhqM64Y7M=;
        b=YVGhrcbhk5OK6PDPl3nvrjMTmBOeGWzZ4RIkm4p5EhCkYA99uODN+A8BxKmUbkYIWjSEum
        yDrA1JHOkx+bqX2gKb3LvvjL6sLmFI5GJEpLE0NLp6GDu1dJroVpi8y2uPf5DTVilRyRIL
        Qxfqhs2zcEzajGiG6FoO8pu3mBc2NP0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-p_YE8AsGO3yeQe2awl0FmA-1; Mon, 15 Feb 2021 09:34:11 -0500
X-MC-Unique: p_YE8AsGO3yeQe2awl0FmA-1
Received: by mail-ej1-f71.google.com with SMTP id p1so4463036ejo.4
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2021 06:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d2J+8Tfem94WsFrszmXvqkgjRa934v/heCKhqM64Y7M=;
        b=snsqw2+XesAj1Fih9ITSHo6qSFZXfyNWAWkkCszxWNramPgvdsqSpk1fVJB47GP1Lx
         001uvFTBkShzbnat4R32XMsDGAiKAqILD8r15bPmtpxhJMRSby8B8NyOYjvci0Vdz32g
         735vGla0yMQCiRpS79HydgiN/oLBZXBmxpMaqITczvKPZPFLtK5sKraUr8L5lUbsZekJ
         yZa2THgfBi9YoMuRz1krEslaHIFJrSeE/pfvrTMeMz1tfcgM8ft+Sb0kcH3+MUGWlwUH
         xy6wtKWSeibVRjTy9FJiCvmpblMqwoyGa7+K6hLDWyeg+1nOUcjCstGssEeBSfC7SMO3
         xz6w==
X-Gm-Message-State: AOAM533s6hVxvbNBbCAXqMmERRblJKCKA58S36RdvzszXxH2IMyCYtm5
        iLbwnqPQnaypK6Q4rXVXVnKK1YWRfFfwfLrwrzyBnK7qWSQf5geHI9cMmjbSN3fU6jEUJVi7iij
        p8mBBlpxyI7HztV0ZFHSmmQ==
X-Received: by 2002:a05:6402:3069:: with SMTP id bs9mr15921823edb.151.1613399649826;
        Mon, 15 Feb 2021 06:34:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNUE1ybmiPJKS3BTRwzixs3/QMCzPSsX2m5S3uk+QJ1dTn5R58eECNp2pJwtfpKd7T/RVaag==
X-Received: by 2002:a05:6402:3069:: with SMTP id bs9mr15921804edb.151.1613399649641;
        Mon, 15 Feb 2021 06:34:09 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v9sm775630edj.89.2021.02.15.06.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 06:34:09 -0800 (PST)
Subject: Re: [PATCH v2 0/4] platform/surface: Add platform profile driver for
 Surface devices
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mark Gross <mgross@linux.intel.com>, Len Brown <lenb@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210211201703.658240-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <898aa498-8256-d59f-9e72-0e1199b3a62a@redhat.com>
Date:   Mon, 15 Feb 2021 15:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211201703.658240-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/11/21 9:16 PM, Maximilian Luz wrote:
> This series adds a driver to provide platform profile support on 5th-
> and later generation Microsoft Surface devices with a Surface System
> Aggregator Module. On those devices, the platform profile can be used to
> influence cooling behavior and power consumption.
> 
> To achieve this, a new platform profile is introduced: the
> 'balanced-performance' profile.
> 
> In addition, a couple of fix-ups are performed:
> - Hide CONFIG_ACPI_PLATFORM_PROFILE and change drivers so that it is
>   selected instead of depended on.
> - Fix some references to documentation in a comment.
> 
> Note: This series (or more specifically "platform/surface: Add platform
> profile driver") depends on the "platform/surface: Add Surface
> Aggregator device registry" series.
> 
> Changes in v2:
>  - Introduce new 'balanced-performance' platform profile and change
>    profile mapping in driver.
>  - Perform some fix-ups for the ACPI platform profile implementation:
>    - Fix some references to documentation in a comment.
>    - Hide CONFIG_ACPI_PLATFORM_PROFILE

Thanks, the entire series looks good to me, so for the series:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, can you (once 5.12-rc1 is out) pick 1-3/4 and then provide a
stable branch for me to merge?

Then I will pick up 4/4.

Regards,

Hans




> 
> Maximilian Luz (4):
>   ACPI: platform: Hide ACPI_PLATFORM_PROFILE option
>   ACPI: platform: Fix file references in comment
>   ACPI: platform: Add balanced-performance platform profile
>   platform/surface: Add platform profile driver
> 
>  .../ABI/testing/sysfs-platform_profile        |  18 +-
>  MAINTAINERS                                   |   6 +
>  drivers/acpi/Kconfig                          |  16 +-
>  drivers/acpi/platform_profile.c               |   1 +
>  drivers/platform/surface/Kconfig              |  22 ++
>  drivers/platform/surface/Makefile             |   1 +
>  .../surface/surface_platform_profile.c        | 190 ++++++++++++++++++
>  drivers/platform/x86/Kconfig                  |   4 +-
>  include/linux/platform_profile.h              |   6 +-
>  9 files changed, 237 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/platform/surface/surface_platform_profile.c
> 

