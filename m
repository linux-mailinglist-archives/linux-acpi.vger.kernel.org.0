Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCBF2AD6E1
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 13:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKJMx1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 07:53:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37284 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJMx0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 07:53:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id m17so14181509oie.4;
        Tue, 10 Nov 2020 04:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ux2F0o8vzxMxPMNBAVBwUPgrkDr+3echZMMpgmNRQOE=;
        b=bsoNzx+NL3vK1kmX6NsjJTFwZZ26weSQb8MEzwfJLmsS9Inoo7zEtVzCsJKhHWeH6M
         FBNmJ2C0GkV3AqHnVw4QyTcsUob4NtPT68Nm2kDRLwlu+OC9AoLJ+bKRuiMgayOM5LJj
         /6QTuaa2H0nGKyx2TTshcObE7DKDPi3mjpGPGdnbHkERnzKAcc/xEqsgnnbDlhsQmB+o
         ckOwaofJtq8M8yd5MN3C0sgP3Zi0mR1Qj5zHnyixJtGMh15aAyqYeXvHDR1pvhboUPlt
         lMgTZSbjwoffMaHyRk7H4Y/hCVvcOqpgtYeZKQm+iPlxL7gqP16TfeKCoVdCxZ1lRSHq
         EWzQ==
X-Gm-Message-State: AOAM531jhapXuvb3dQFa/apWrkAsMUfIKSA6lkGAYE7BPFizxoX0b9+2
        EpzMX2FGAfPUwN4oAll9RJJzk7FKm9NGRycguQ8=
X-Google-Smtp-Source: ABdhPJxcIaODQGXC9/SHhpJ979pd7V1gAUkM0Nro2pzz6VlmVYf3IRk7dRRbOFvF83zUzIYHwdo97Efe8FEFsRNoQYo=
X-Received: by 2002:aca:1c0b:: with SMTP id c11mr2677839oic.71.1605012806095;
 Tue, 10 Nov 2020 04:53:26 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201110033124.3211-1-markpearson@lenovo.com>
 <20201110033124.3211-3-markpearson@lenovo.com>
In-Reply-To: <20201110033124.3211-3-markpearson@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 13:53:13 +0100
Message-ID: <CAJZ5v0jbnjf3vU7qmHjOrdNoki5A2wrTH2uLxQAzi3s6xScrvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: platform-profile: Add platform profile support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 4:32 AM Mark Pearson <markpearson@lenovo.com> wrote:
>
> This is the initial implementation of the platform-profile feature.
> It provides the details discussed and outlined in the
> sysfs-platform_profile document.
>
> Many modern systems have the ability to modify the operating profile to
> control aspects like fan speed, temperature and power levels. This
> module provides a common sysfs interface that platform modules can register
> against to control their individual profile options.
>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> ---
>  MAINTAINERS                      |   8 ++
>  drivers/acpi/Kconfig             |  19 ++++
>  drivers/acpi/Makefile            |   1 +
>  drivers/acpi/platform_profile.c  | 172 +++++++++++++++++++++++++++++++
>  include/linux/platform_profile.h |  36 +++++++
>  5 files changed, 236 insertions(+)
>  create mode 100644 drivers/acpi/platform_profile.c
>  create mode 100644 include/linux/platform_profile.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a54806ebf02..e731ac1c4447 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -436,6 +436,14 @@ S: Orphan
>  F:     drivers/platform/x86/wmi.c
>  F:     include/uapi/linux/wmi.h
>
> +ACPI PLATFORM PROFILE DRIVER
> +M:     Mark Pearson <markpearons@lenovo.com>
> +L:     linux-acpi@vger.kernel.org
> +S:     Supported
> +W:     https://01.org/linux-acpi
> +B:     https://bugzilla.kernel.org
> +F:     drivers/acpi/platform_profile.c

IMO it is premature to add a MAINTAINERS entry for this until it turns
out to be really necessary.
