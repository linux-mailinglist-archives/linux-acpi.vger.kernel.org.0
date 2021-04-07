Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDA23572DC
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347904AbhDGRNh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 13:13:37 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:41767 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbhDGRNf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 13:13:35 -0400
Received: by mail-oi1-f178.google.com with SMTP id z15so19462936oic.8
        for <linux-acpi@vger.kernel.org>; Wed, 07 Apr 2021 10:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhogcI3e2a0s0TpHg1uoICzncg9zexl4RCRVjjXhp/0=;
        b=J4LHSxssBvY2uOnvEGv+mNKNIAThNQ24jjOnSMYPZcZnP8HI2PXj/iBf4zQ7IIB15C
         6uv3YUgwh0MG+ifgKBoumypbyFJcC06MfTh6b0vzyyoADITcw+nOyPPW0AtidA/A//4Y
         iWMPo2MXWb0ocHSncqdQGFMYqxgwS+FAWtdMqZGRknAbTZ42Y7QVamQ+pQ6fygeQ2b+s
         EFrWRod7aVq+FG808sSqNuQ+7l5YH6VKDVYW61R+4b4E7hJknTSexT711kkZbxhgQmPh
         SiAEiTLu0nlO9habhsH4AH0QqmoxVqG7U72c8yh+F1tvJ8lnVKwfeFbtK9uijYdXYiA8
         ObsA==
X-Gm-Message-State: AOAM53364KlprbyVl3WsNXiN2kPh5MPeDAO5FGVdqEs1qwbOeVxAeZLw
        JmTpFEKhT1ezkBJuoBBx8QiJNNFz0gM9yA7NhUA=
X-Google-Smtp-Source: ABdhPJxBuwo60giwH76t01hOXqtUegHgOCZkDLEtaF+sKOJ4fN31d81+tgJ6rzVXSJ6QGjfrE3V8WJwy8GssTYjLi3s=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr3003358oie.157.1617815604553;
 Wed, 07 Apr 2021 10:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210406211653.182338-1-hdegoede@redhat.com>
In-Reply-To: <20210406211653.182338-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Apr 2021 19:13:13 +0200
Message-ID: <CAJZ5v0h6=_U+_=G8YL5rA701pTLGfyg4PmBudc3tFRKG=Wxh4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: utils: Add acpi_reduced_hardware() helper
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 6, 2021 at 11:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add a getter for the acpi_gbl_reduced_hardware variable so that modules
> can check if they are running on an ACPI reduced-hw platform or not.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/utils.c    | 11 +++++++++++
>  include/acpi/acpi_bus.h |  1 +
>  include/linux/acpi.h    |  5 +++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 682edd913b3b..4cb061d3169a 100644
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
> +EXPORT_SYMBOL(acpi_reduced_hardware);

EXPORT_SYMBOL_GPL()?

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
> 2.30.2
>
