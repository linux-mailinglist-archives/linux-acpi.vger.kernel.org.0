Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5F3BA1E4
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhGBOFl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 10:05:41 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36658 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhGBOFl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 10:05:41 -0400
Received: by mail-ot1-f42.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10144649otl.3;
        Fri, 02 Jul 2021 07:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz8sqvK+LwTIlmS6VotPE2o9ldJl7oB6So4nHS6DHBE=;
        b=Ejyy0ORx4yUX/22+LbQeWI9JvA0CNe2hqwAYCazf9RIpnvSj6b2qIEPcRPBt8Hmq8X
         BSfGcWfTJl/tfy9cJFpx6UvuzfDH3DwzGupY5AiqkvvvrjhPB6EnFrW1M+WItnokD9jc
         Ssf4Zv9P8pK5m4KP07OWWJDMYDE+eQ0kSTLqcd9c1c4vnssg3VV+WGC6MTfwZMIV4spe
         cp5sJMJiE95YtSW7QGYxE4Z8O2S3qmoiios5OS37Ib5y7rJYzP+QrT0zi7EGlxdSmBC6
         X895nubebo/oQNtpCoDXMlBth5bMq/HA4lCOacMT57lA9mL2C/2YMFmT1+WjfHrf+vSv
         vjKw==
X-Gm-Message-State: AOAM5323cJjmeQTQNmFlXkc4LYcT/VC/b9d3Voo00+n79dHO1QnTHuPK
        +0fJucWxNvUK9PLTUDqmwDAGxtqRfsYvetw+gAo=
X-Google-Smtp-Source: ABdhPJzoKSKF9xSd7DywDnTBC1E4Ktuvc/kc2JQrTjfjJzLRuw6EVvOXe5HwqGOpHiSPmgBL30gt2Tj02JjKlVO6dFE=
X-Received: by 2002:a05:6830:1d8:: with SMTP id r24mr4865674ota.206.1625234588272;
 Fri, 02 Jul 2021 07:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <1625209430-19934-1-git-send-email-aubrey.li@intel.com>
 <1625209430-19934-2-git-send-email-aubrey.li@intel.com> <CAJZ5v0jq=-97bW_s7dx2U=y-3rZoJsLtFre2XXYAaQgAdbQdXA@mail.gmail.com>
 <f8f0b7ee-b225-eff0-cfcc-bb43e9e520dc@linux.intel.com>
In-Reply-To: <f8f0b7ee-b225-eff0-cfcc-bb43e9e520dc@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Jul 2021 16:02:56 +0200
Message-ID: <CAJZ5v0gO0jMTr_X__NKfo+SX0ygyN2C7CQiz03Vo-WObo_ZZNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: let BIOS fall back to legacy handling if PRM disabled
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 2, 2021 at 4:02 PM Aubrey Li <aubrey.li@linux.intel.com> wrote:
>
> On 7/2/21 7:37 PM, Rafael J. Wysocki wrote:
> > On Fri, Jul 2, 2021 at 9:03 AM Aubrey Li <aubrey.li@intel.com> wrote:
> >>
> >> Based on _OSC PRM bit, BIOS can choose switch from legacy handling
> >> to using PRM. So if CONFIG_ACPI_PRMT is disabled, this bit should
> >> not be set to let BIOS fall back to the legacy handling (such as SMI).
> >>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> >> ---
> >>  drivers/acpi/bus.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >> index 60fb6a84..30a3d4a 100644
> >> --- a/drivers/acpi/bus.c
> >> +++ b/drivers/acpi/bus.c
> >> @@ -303,7 +303,9 @@ static void acpi_bus_osc_negotiate_platform_control(void)
> >>
> >>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
> >>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
> >> +#ifdef CONFIG_ACPI_PRMT
> >>         capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
> >> +#endif
> >
> > What about using if (IS_ENABLED()) instead of #ifdef?
>
> aha, sorry, using if (IS_ENABLED()) is better, will come up with a new version soon.

No need (see my other reply).

Thanks!
