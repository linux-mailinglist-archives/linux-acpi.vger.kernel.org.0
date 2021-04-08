Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8442F358BB7
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 19:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhDHRw5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 13:52:57 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38779 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHRw5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Apr 2021 13:52:57 -0400
Received: by mail-ot1-f46.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so3137388otk.5
        for <linux-acpi@vger.kernel.org>; Thu, 08 Apr 2021 10:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMorx01lhfeSRcCBPwGAFNFnf1r2FmfEdDXYVCwsphM=;
        b=N+g0UfiZNzI3JZ/OkStF+1lL6HtOV+Rx7OxST7O3Q8oCz6YANXrkMo/VJ/3MKIcuvI
         BOOAnQ3YKzS+Gl3HgP6n2LogAdvh0BX7kabHMPUAiT1W8KMm3yOfghExfyA8GEc9gcOK
         sNsZECMlAgK1VB8ADgvFRsdhkNB0qavQnbbJRLr5uYe168wJK9Kbc6C80d1fXUh46ywb
         9Q8yMplhROVoZH2vJOlKhDsRJZfMZvqfxNG4jrhHrx+DYcPa2DYIPWGchEWnmC54iaFv
         XBOP7nZjZoRNMOScAAI3fD9q+3uKpmCPm1Vzpdui66U3E0aKcQ4X/L2PHKz8ttwvIAsN
         uZug==
X-Gm-Message-State: AOAM532pWjKMBHMmX/ui6+Q7jv4LrmNntZt9boPbf9tn9ug+hyySP7be
        spFn1Kq+szZhBh+cFcE1Bs0j54gy36Jslaex3iE=
X-Google-Smtp-Source: ABdhPJyLmHRDIlRjxpQTEWesEH+0DShWtontDVyczDVPyqKeNXgHfaFt9q5dfRv7ygC5Y6YMWLB0ATnwPhM2CCWmeDk=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr9011916otf.206.1617904365579;
 Thu, 08 Apr 2021 10:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210407175820.447847-1-hdegoede@redhat.com>
In-Reply-To: <20210407175820.447847-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:52:34 +0200
Message-ID: <CAJZ5v0g8cSm-ctYneOOmYy6gz4957AkrXQkTynZ_YRTsHprTCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: utils: Add acpi_reduced_hardware() helper
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 7, 2021 at 7:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add a getter for the acpi_gbl_reduced_hardware variable so that modules
> can check if they are running on an ACPI reduced-hw platform or not.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
> ---
>  drivers/acpi/utils.c    | 11 +++++++++++
>  include/acpi/acpi_bus.h |  1 +
>  include/linux/acpi.h    |  5 +++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 682edd913b3b..b20774c48c74 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -872,6 +872,17 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>  }
>  EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
>
> +/**
> + * acpi_reduced_hardware - Return if this is an ACPI-reduced-hw machine
> + *
> + * Return true when running on an ACPI-reduced-hw machine, false otherwise.
> + */
> +bool acpi_reduced_hardware(void)
> +{
> +       return acpi_gbl_reduced_hardware;
> +}
> +EXPORT_SYMBOL_GPL(acpi_reduced_hardware);
> +
>  /*
>   * acpi_backlight= handling, this is done here rather then in video_detect.c
>   * because __setup cannot be used in modules.
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index f28b097c658f..d631cb52283e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -78,6 +78,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>
>  bool acpi_dev_found(const char *hid);
>  bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
> +bool acpi_reduced_hardware(void);
>
>  #ifdef CONFIG_ACPI
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 3bdcfc4401b7..e2e6db8313c8 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -748,6 +748,11 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>         return NULL;
>  }
>
> +static inline bool acpi_reduced_hardware(void)
> +{
> +       return false;
> +}
> +
>  static inline void acpi_dev_put(struct acpi_device *adev) {}
>
>  static inline bool is_acpi_node(const struct fwnode_handle *fwnode)
> --

Applied along with the [2/2] as 5.13 material, thanks!
