Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8837AC9F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhEKREc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 13:04:32 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:42645 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKREc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 13:04:32 -0400
Received: by mail-ot1-f41.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso18100974otg.9
        for <linux-acpi@vger.kernel.org>; Tue, 11 May 2021 10:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rayJNnm/a5KMzHPAUIx+3+winCCnrizYXF59IZKaP78=;
        b=XN8eu9jLZ69cT/Ykvdd6MhrY65nK/V2kv/V8HbJmwIGdPpGvKY+h56BMvgQjNXoHx3
         55kGTwZD0IHdHnjvUxzVZ+FWA0jZ0dupVUSxvRfNro2EBPAvhoVrRLpp9+SopoBQVN5O
         jVucU+TY7HLeMya80g/tObBw/vZNx8nygO0SoU+8i0CD3Xh4NTbAdTvrcg+ghVNcMpKj
         ZSU2yMuJcPp6BbrTBkWmSjNSruEKgX979qyxz+MK3Vz1kClApkXSsn4M0xvz7CXvfbmG
         wXcEob5Ca+4sWAS6faG2G9P6/vVNGQRVlGnppuYipKzGYa4I8kASIfXu+yrLLAZCPWX8
         zf8A==
X-Gm-Message-State: AOAM530r4ZFTq5lrfSgwShAb4ltkd80n5u8wC4xSWKzyYGgMIg3mlUti
        nqfXT4rfXIVwWYKfGIWQMpK+4bJtVlP8PJVFJJI=
X-Google-Smtp-Source: ABdhPJxGVAgxvmSDKLve9rYfYLCfKSUizkXPX5YixZBh1fFiQ3UyDccMJLraAo7Pbi8cGmgqou9DeQhANJizSMHSpNw=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr27240895otd.321.1620752604465;
 Tue, 11 May 2021 10:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210511025024.10083-1-mario.limonciello@amd.com>
 <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
 <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <CAJZ5v0jRSUV7_MN6Ru0R6tNq11Qe7Swv3Wy4sfZYbrn0H8r-tw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jRSUV7_MN6Ru0R6tNq11Qe7Swv3Wy4sfZYbrn0H8r-tw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 19:03:13 +0200
Message-ID: <CAJZ5v0i=Zx_LOR1yZ0EkgrH4jy9+j=++kRBOJm_da3_a1=HDTw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 11, 2021 at 6:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, May 11, 2021 at 5:21 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > > Well, if find_deepest_state() looked at the target residency instead
> > > of the exit latency, this would work I suppose?
> >
> > Unfortunately I don't think this would help - from an OEM system the following
> > target residency values:
> >
> > # cat /sys/devices/system/cpu/cpu0/cpuidle/*/residency
> > 0
> > 2
> > 800
> > 700
>
> But this means that not just S0ix, but cpuidle in general doesn't work
> correctly on those systems and the latency quirk doesn't help here.
>
> Well, it looks like the driver needs to sort the C-states table, then.

But that wouldn't help, because the 700 us idle state is in fact deeper, right?

Are the values just swapped or are they completely bogus?
