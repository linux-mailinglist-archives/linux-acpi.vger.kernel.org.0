Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA444C29F
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 14:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhKJOAM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 09:00:12 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36597 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhKJOAM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Nov 2021 09:00:12 -0500
Received: by mail-ot1-f46.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so4017465otl.3
        for <linux-acpi@vger.kernel.org>; Wed, 10 Nov 2021 05:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fr2bpSHOu1Zl6WrcF4lN/FtbjxOSIPCEko2EXKrzupM=;
        b=VRyyDeEd+Y+a7yfO2J2FTAY0PggXcdYrJr6YZqeqG0NUPMsYtm404TCCsRiswnpGqd
         ieT+RdWuTdT5r7HpEnR8yivallcAdZ1jSPzesCjqp4R6OGNVZfnqOcos4TVBrKe7TBCx
         DD4F2by/cNZJIv46AipZC5atygAM/9YDqB3uRyLwG1xCZONZfde1lIn4HWp6s24ca5Q/
         dNV9Sl6qi4ia1Tw7YjdZwL4DGbxRpPMWbyEMpfQCmXaJriQg1TeSB3BNeARy2ZLc8xSj
         GR2Dp1w1T66uWA44iK3DlN3oEDP3r+tea9SAgf9okI2FNZkko+kXseFxgV/+Up1mX2cr
         0NzA==
X-Gm-Message-State: AOAM5333g+WGoGYqHhxP2TYYuzx6gywyVdYREmNOLEsrkduE5Ts9MMe8
        v2eiSuB20RcLSTHt/SUnP63sFdexAZ14hSyk2rs=
X-Google-Smtp-Source: ABdhPJwPAKki8cACr08rMtk4A0Sy6OhfrIJqTbwiaHfr6Yis2+cQWq7Ua25dNkCmS+7UqMbazKfQaOawN1NsVgHUK4w=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr80566otj.16.1636552644422;
 Wed, 10 Nov 2021 05:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20211110121014.1908531-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20211110121014.1908531-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Nov 2021 14:57:13 +0100
Message-ID: <CAJZ5v0hXMmOH9-bNRp=OEvewp4T=KxX+VPg5EO70W1nV5Pwz7Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: ACPI: Fix non-D0 probe _DSC object example
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bingbu Cao <bingbu.cao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 10, 2021 at 1:10 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> The original patch adding the example used _DSC Name when Method was
> intended. Fix this.
>
> Also replace spaces used for indentation with tabs in the example.
>
> Fixes: ed66f12ba4b1 ("Documentation: ACPI: Document _DSC object usage for enum power state")
> Reported-by: Bingbu Cao <bingbu.cao@intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  Documentation/firmware-guide/acpi/non-d0-probe.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/non-d0-probe.rst b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> index 78781e1ab6a3d..7afd16701a02e 100644
> --- a/Documentation/firmware-guide/acpi/non-d0-probe.rst
> +++ b/Documentation/firmware-guide/acpi/non-d0-probe.rst
> @@ -62,7 +62,7 @@ objects not relevant from the example point of view have been omitted.
>  .. code-block:: text
>
>         Device (CAM0)
> -        {
> +       {
>                 Name (_HID, "SONY319A")
>                 Name (_UID, Zero)
>                 Name (_CRS, ResourceTemplate ()
> @@ -71,8 +71,8 @@ objects not relevant from the example point of view have been omitted.
>                                      AddressingMode7Bit, "\\_SB.PCI0.I2C0",
>                                      0x00, ResourceConsumer)
>                 })
> -               Name (_DSC, 0, NotSerialized)
> +               Method (_DSC, 0, NotSerialized)
>                 {
>                         Return (0x4)
> -                }
> +               }
>         }
> --

Applied as 5.16-rc material, thanks!
