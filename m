Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63E44447CB
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 18:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhKCR6F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 13:58:05 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:41874 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhKCR6E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 13:58:04 -0400
Received: by mail-ot1-f51.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so4615552ote.8
        for <linux-acpi@vger.kernel.org>; Wed, 03 Nov 2021 10:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVkHXY5MP5lH7iOFtYIJQz0uwZylrE0zqF8bZJr9HZI=;
        b=7C67yq0rXH2tAvcJn9ZfZo4O35PQhPgyNVW+mudjwWcTwdpEu2I0jHReSLT7sLgejH
         TkfJX4MpQvBEGqodLCKvcM8bdVC+W7hfpZBRFO/mwVycI2AwCc3QZGEEMbwm3DIiZo6E
         TCrEkWjecA+cYNGIx91C3320cNTfM8Hy6FC36tziKOX+TyX2R5THKEYmikN1gsA/Su7Y
         xSxli9WdyhQOKj6dcu7UYT+vKMtZnyjIhUbgE7LZjdCTwEUrhr4b0rAF2gRTT2LZowbQ
         l4OmCjJ7kucpR7G727tQA3IzBZ8+21TfXDPsmCx12Tog4znVorkbW6pKQ4eRNj+0HWG5
         1HqQ==
X-Gm-Message-State: AOAM532w3M43kIHxRX+pY06InHfc5cunJQRxOC/2xYzKtViSFUFXOabc
        NMnARw5s35bcS25RQogKDxYSOPLwWK8+EOscXPU=
X-Google-Smtp-Source: ABdhPJzhYf5RHbCkvowwQbxB2nfeG+RbRZZdzMWYe1x7n9iGMa2BR4tqJu0iHgrMYZIepDOMgSZSvsTOJxDWTKzSNCo=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr32397683otd.16.1635962127801;
 Wed, 03 Nov 2021 10:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com> <20211103133406.659542-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20211103133406.659542-2-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Nov 2021 18:55:17 +0100
Message-ID: <CAJZ5v0i4ZqKPUw1oHT9kt9F6OnZE9AjHZ89tzGm2OHFp-88-YQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: Make acpi_fwnode_handle safer
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 3, 2021 at 2:33 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Check that the fwnode argument passed to acpi_fwnode_handle is non-NULL,
> and return NULL if it is, otherwise the fwnode. Thus the caller doesn't
> have to ensure the argument is a valid non-NULL fwnode.
>
> Cc: stable@vger.kernel.org # v5.15 and up

Why?

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

That's because you want to avoid a NULL check in the second patch and
it adds a ton of redundant NULL checks all over the place.

Like for example in include/acpi/acpi.h:

#define ACPI_COMPANION_SET(dev, adev) set_primary_fwnode(dev, (adev) ? \
            acpi_fwnode_handle(adev) : NULL)

You should at least get rid of this one.

> ---
>  include/acpi/acpi_bus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 53b6e9f9de7b4..c34d94521d40c 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -445,7 +445,7 @@ static inline bool acpi_data_node_match(const struct fwnode_handle *fwnode,
>
>  static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
>  {
> -       return &adev->fwnode;
> +       return adev ? &adev->fwnode : NULL;
>  }
>
>  static inline void *acpi_driver_data(struct acpi_device *d)
> --
