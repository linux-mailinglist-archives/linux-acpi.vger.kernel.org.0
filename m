Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B43319FD7
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBLN1x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 12 Feb 2021 08:27:53 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:39788 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhBLN1v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 08:27:51 -0500
Received: by mail-oi1-f175.google.com with SMTP id l19so9942106oih.6
        for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2021 05:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7vt7BjZK889hGI8PEPs3DwGOQe0sOD+mOFoOiAY27wE=;
        b=fVq+0fqU7tH9kL7A1bO/SenhsgWLqNutlV1C6qLuC1tYNBTgog8YbGIWcEAvNX+IUC
         V6zIh9UGKgTQYYNNe7OH1MmLRPUPM6ChWWK7ZfD6kbwXqZAVI8RdWs5h7iVLL9S9y8ew
         6mx26giQcsjFHyDeVN7DyNw9RmsmiLgfKyNmjk+3y7ewBm/sezLo4i+ZBeoSQ4uQIBP8
         VcO2GpCbxMzm4s6lKKIUuyPhqvY1baKIOfpCEcp19fmBRIqtU18dTNQgotefpwkMNgid
         Nq0vqLGExZqXMn0oUZX5pze/1M0IpT1BukvMr3h2OGmL4ubQOJQQQ7CfWHx6QcMFwpiw
         aKWQ==
X-Gm-Message-State: AOAM533Zc9Q/M68TKxzOHA20D8FbC5KS+yeEQ53JQnfbtNsX1122LXow
        4K03RmCFLL/Ik+TBnaKqEVrlr6b8buElBtRsAE8=
X-Google-Smtp-Source: ABdhPJwNRNFZ4IK01G2THB902XPGDtEWWjskca3qJfu1JbQVWW/KIDmvgrGryMNW/HwdYIxBc7AMY+rVfuQTcBcWThs=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr1808760oia.157.1613136429694;
 Fri, 12 Feb 2021 05:27:09 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0jSqmpnbpahGBRSjddOecqA1f-9GfvNwjdV0pH7xQ3iVg@mail.gmail.com>
 <20210212122703.272005-1-marcin.slusarz@gmail.com>
In-Reply-To: <20210212122703.272005-1-marcin.slusarz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 14:26:57 +0100
Message-ID: <CAJZ5v0jzg8S3HX=_wFqFYHAMt+-FDUHEe+o=Aqeuf0XGTzLSYg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: update documentation of acpi_walk_namespace
To:     =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, marcin.slusarz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 12, 2021 at 1:27 PM Marcin Ślusarz <marcin.slusarz@gmail.com> wrote:
>
> From: Marcin Ślusarz <marcin.slusarz@intel.com>
>
> Make the documentation match the code and add a note regarding
> the return values of the callback function and the walk to it.
>
> Signed-off-by: Marcin Ślusarz <marcin.slusarz@intel.com>

Erik & Bob, I'm leaving this one to you, thanks!

> ---
>  drivers/acpi/acpica/nsxfeval.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
> index f9d059647cc5..7149c8f70a6e 100644
> --- a/drivers/acpi/acpica/nsxfeval.c
> +++ b/drivers/acpi/acpica/nsxfeval.c
> @@ -532,8 +532,8 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
>   *              return_value        - Location where return value of
>   *                                    user_function is put if terminated early
>   *
> - * RETURNS      Return value from the user_function if terminated early.
> - *              Otherwise, returns NULL.
> + * RETURNS      Returns status from the callback function if terminated early.
> + *              Otherwise, returns a status of the walk, AE_OK if succeeded.
>   *
>   * DESCRIPTION: Performs a modified depth-first walk of the namespace tree,
>   *              starting (and ending) at the object specified by start_handle.
> @@ -542,6 +542,11 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
>   *              a non-zero value, the search is terminated immediately and this
>   *              value is returned to the caller.
>   *
> + *              Note that both the callback functions and the walk itself
> + *              use overlapping return values (e.g. AE_OK), so user of this
> + *              function can't rely only on the return value to tell if
> + *              the callback function was called.
> + *
>   *              The point of this procedure is to provide a generic namespace
>   *              walk routine that can be called from multiple places to
>   *              provide multiple services; the callback function(s) can be
> --
> 2.25.1
>
