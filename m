Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13B33132AA
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 13:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhBHMop convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 8 Feb 2021 07:44:45 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41287 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhBHMo3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 07:44:29 -0500
Received: by mail-ot1-f42.google.com with SMTP id s107so13998514otb.8
        for <linux-acpi@vger.kernel.org>; Mon, 08 Feb 2021 04:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8HAzaz/gp8Ny3U3vTeQA+VApcyhTcxZN/39VG1rw62k=;
        b=DSWu9NecxargUmHgH+wJFkG2IuQZx6hIUXzFtmuPn+8itBM80f5Y1DPqgflJUcS1bB
         YAfUyAovwh2ODgTrN+RP+pzXDtHdwmmr8416T8rxfoc6Kol/bWYoA7p4U5scJ29iPK9g
         A8D5ZuqOmlxTbxr6EUlKjEcG2f8ofHsSb5JD3uPJsLqwZ8d43hRKU4tYFChWx3xqHw4F
         idR122rhvdr9/Kyt8aM07V6KRilSLlbEDzTDhaOJvvhMB1Q+wadmm13K/+B9I8XV5mLn
         1jt5IqJDJ4iydgQIjs9QFzufPnE0xt2PAniNxI6AZ5H10Z/ZI7xGVUOO/pfDocmbj9e5
         QvZQ==
X-Gm-Message-State: AOAM532a/rSaQmIrKgVOO4SvzsYNtrkx9lNn/9rbbat8N4J9adwvRDIG
        GyDHepellAoV6nyWdD0Se/lZmHbhR0OXTtktT/fIxgYg
X-Google-Smtp-Source: ABdhPJyaocC2wPjxtuBfb3tJQyp9gfJbIpUQFwdV8WVqECi83WVtLzs81p+E1k2jfFBg9ipQnByYuf8GinCabEjq0hY=
X-Received: by 2002:a05:6830:1481:: with SMTP id s1mr952387otq.206.1612788221158;
 Mon, 08 Feb 2021 04:43:41 -0800 (PST)
MIME-Version: 1.0
References: <a3f01a5d-d7a5-8280-4091-b2486b01a782@linux.intel.com>
 <20210208120104.204761-1-marcin.slusarz@gmail.com> <20210208120104.204761-2-marcin.slusarz@gmail.com>
In-Reply-To: <20210208120104.204761-2-marcin.slusarz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Feb 2021 13:43:25 +0100
Message-ID: <CAJZ5v0jSqmpnbpahGBRSjddOecqA1f-9GfvNwjdV0pH7xQ3iVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPICA: update documentation of acpi_walk_namespace
To:     =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        marcin.slusarz@intel.com, Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 8, 2021 at 1:01 PM Marcin Ślusarz <marcin.slusarz@gmail.com> wrote:
>
> From: Marcin Ślusarz <marcin.slusarz@intel.com>
>
> Signed-off-by: Marcin Ślusarz <marcin.slusarz@intel.com>

A changelog would be appreciated, something like "Make the
documentation match the code and add a note regarding the return
values of the callback function and the walk to it".

Anyway, this is ACPICA material, so it should go to Erik & Bob (CCed).

Thanks!

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
