Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B73340635
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 14:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhCRM73 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhCRM70 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2021 08:59:26 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC57C06174A
        for <linux-acpi@vger.kernel.org>; Thu, 18 Mar 2021 05:59:26 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so5082457otk.5
        for <linux-acpi@vger.kernel.org>; Thu, 18 Mar 2021 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flnuCJmkCbO9vOMN2hjdShCNNxwnOUuZwk9FVjH8m5M=;
        b=nsCy+deLyfGBS05VFAcKMVJGt+ggWZQNP08bL30rKRnqojA4mWbnnYircD5kWPGN1/
         M1su3GmvT1MbKGyYhHuVLnWlN+SraMOf7n/+5vTCl9cxdaPMPjpUQNNPK96GL6lGs03M
         MPTF38fzuCA8bYfHMQx8tpzDJBv1CLshOsi8wrMZLqxUxkfTp0eZrcwtSyLImQJNQlxB
         I+v60bnfMXjMKjCMidY89MuUXvLEa4Ywa9R7exRARKnsgqDStVEx0yxSmyLn7ONSIw8n
         Tnyv7S+fAgSipfsfmT9gExhE20S4PuimaBw9FateM3W3IVJ4l/RklaSa4zS9/CFt/7vj
         /jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flnuCJmkCbO9vOMN2hjdShCNNxwnOUuZwk9FVjH8m5M=;
        b=g/cKD6/tVt74yFE6uyg06FM7NKBQSP5ss1oaCvOAIvOKcOk1VoyRcFPhVnub/oJyIg
         Lel830I0Cqu92b4S0Qhy2xgdp8R0ljl+cbMO5HM9xuK4rC7pA6uBcLWV8i3Mr/GnvvMp
         /+1Pk2VBPenW6bwhK9aTlmR2zile/13TwsCKjY5zC1h2RockUahjWzFApDVnwFHTGKDO
         v71ZsA47ljSzSyPL3/ZXkH0YgAO4x34gmPB2dyFeAjj8noXqGEQgswvGrnVxLzippF9+
         kFvMG2r/5BkIChQIUK4L9OeuHGNCdnl7Gg+x2IM+9cZ4vA5fDAaS99cfRC6o1LbewR9B
         otkw==
X-Gm-Message-State: AOAM532ll6c69UwvIp52j0ipNcGCnKXMYmjmQM9HOo4f8cRhMtF7dyDc
        NF1T6lATH0s5h9kTceXnKuwGm0LZiRvgS39Ko5g=
X-Google-Smtp-Source: ABdhPJzp8F1vZtgbbElh/gnLKMk1rDljrrW0Y8LxFpIyWOr+bHZbmT3SJBW/my52EO8RdOVU84aU6CE4WmsIyOxdyiU=
X-Received: by 2002:a05:6830:408f:: with SMTP id x15mr7664234ott.132.1616072365558;
 Thu, 18 Mar 2021 05:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210317143842.786380-1-alexander.deucher@amd.com> <20210317143842.786380-2-alexander.deucher@amd.com>
In-Reply-To: <20210317143842.786380-2-alexander.deucher@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 18 Mar 2021 08:59:14 -0400
Message-ID: <CADnq5_MHC4nNwCuMYN_esMh15uaYuODS1d-u_+wLOM4-9yaGgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 V2] platform/x86: force LPS0 functions for AMD
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Prike Liang <Prike.Liang@amd.com>, Shyam-sundar.S-k@amd.com,
        Marcin Bachry <hegel666@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let's hold off on these patches for the time being.  At least one of
them seems to cause problems on another laptop.

Thanks,

Alex

On Wed, Mar 17, 2021 at 10:39 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD are supposedly not
> required for AMD platforms, and on some platforms they are
> not even listed in the function mask but at least some HP
> laptops seem to require it to properly support s0ix.
>
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>
> ---
>
> V2: rework the patch to just fix up the specific problematic
>     case by setting the function flags that are missing.
>
>  drivers/acpi/x86/s2idle.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2d7ddb8a8cb6..482e6b23b21a 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -368,6 +368,13 @@ static int lps0_device_attach(struct acpi_device *adev,
>
>         ACPI_FREE(out_obj);
>
> +       /*
> +        * Some HP laptops require ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD for proper
> +        * S0ix, but don't set the function mask correctly.  Fix that up here.
> +        */
> +       if (acpi_s2idle_vendor_amd())
> +               lps0_dsm_func_mask |= (1 << ACPI_LPS0_ENTRY_AMD) | (1 << ACPI_LPS0_EXIT_AMD);
> +
>         acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
>                           lps0_dsm_func_mask);
>
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
