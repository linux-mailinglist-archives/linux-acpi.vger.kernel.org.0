Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB67768BF
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 21:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjHIT0z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 9 Aug 2023 15:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjHIT0m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 15:26:42 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135B4495;
        Wed,  9 Aug 2023 12:26:02 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-56d75fb64a6so32613eaf.0;
        Wed, 09 Aug 2023 12:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609162; x=1692213962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bV5Wpjam6CMkVYlxjsN/MHAlgODzju590XBq5bff4X4=;
        b=VpYAQztXR0miKnRTlzwV1VGtl6n0hSiPPCnm+emIOzgjeVxir0y7epBIGBrhxTlPQc
         mnqEWkaaZ5RXYcrM93B6GNa+zG5fohFAZdFwqQlBHUgedqjfDTGCxv1xPrP2/MiFyxUi
         41j8Ifqdgk4fvKKRrNS3/9CKZJJAgCz4TrpVPgYVUGnWXmTecibB1sdCBjQZK30L9pOw
         oCkeP0IkEsQSwUNweNn4qMi10vwB/564V6BJVWAz+HFifRdAjqSi6ZpRWprpxPHUjnq5
         P6U4+zvgCNz1oWPc3kVgZMz5DP/l1B/sSzzqoMgBZ4I0o3AyF9jJwyxOlGee6nuvdH5J
         GFIw==
X-Gm-Message-State: AOJu0Yxq0OsL1qGqhg9/n7rwPsOCiGAutRNPLmfv8gRZh8pEUZ9ZAIap
        Vl1zrMnu8YKWvKxC0PU6DuVoHLF87DMzrNl3gtQ=
X-Google-Smtp-Source: AGHT+IEZ4QpU4CaYGsNeWctCX7/OICx+wHmjYw0hnpQ0Yg8DkB3QkVcd8RjePvFpfu7RXFRfykEnAIJfusNd/VM50vo=
X-Received: by 2002:a4a:de86:0:b0:560:b01a:653d with SMTP id
 v6-20020a4ade86000000b00560b01a653dmr264884oou.0.1691609161835; Wed, 09 Aug
 2023 12:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230809085526.84913-1-hdegoede@redhat.com> <20230809085526.84913-4-hdegoede@redhat.com>
 <6a6fa2ba-c07d-45b2-96c5-b0f44f5f288b@augustwikerfors.se> <c3684f00-27bd-d4dd-93dd-18936c006de9@redhat.com>
In-Reply-To: <c3684f00-27bd-d4dd-93dd-18936c006de9@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Aug 2023 21:25:50 +0200
Message-ID: <CAJZ5v0gx_vu_Pip3rkUo_78mNnUbp++hpRfpa-iDaZP9r6_4sw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings
 for IRQ1 on AMD Zen
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     August Wikerfors <git@augustwikerfors.se>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 9, 2023 at 9:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 8/9/23 17:58, August Wikerfors wrote:
> > On 2023-08-09 10:55, Hans de Goede wrote:
> >> On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
> >> settings over the MADT settings.
> >>
> >> This causes the keyboard to malfunction on some laptop models
> >> (see Links), all models from the Links have an INT_SRC_OVR MADT entry
> >> for IRQ 1.
> >>
> >> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217336
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217406
> >> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> > One of the laptops fixed by a9c4a912b7dc, PCSpecialist Elimina Pro 16 M [1], seems to have no INT_SRC_OVR entry for IRQ 1 [2]:
> >
> >> [    0.084265] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> >> [    0.084266] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> >
> > I'm not sure if it was IRQ 1 that needed to be overridden for that model though, so it may work anyway with patch 2 of this series.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=217394#c18
> > [2] https://bugzilla.kernel.org/attachment.cgi?id=304338
>
> Good catch, thanks. So it looks like this one needs a DMI quirk (until we have a better generic solution.
>
> I'll reach out to the reporter and ask for dmidecode output and prepare a follow-up patch. Still I think
> that we should move forward with this series to fix the 6 bugs which are linked to from PAtch 1's
> commitmsg and those are likely just the top of the iceberg.

You are probably right, but it would be good to get a fix for this
ASAP, as I would prefer it to go in along with the series, if
possible.
