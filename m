Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5746732D519
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 15:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbhCDOQv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 09:16:51 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37842 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbhCDOQr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 09:16:47 -0500
Received: by mail-ot1-f45.google.com with SMTP id g8so23704890otk.4;
        Thu, 04 Mar 2021 06:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzWNIBuVfLxYj2PJbGktT8ZZ7J3vD+7LTuk7a6dg7KE=;
        b=GdjWuaDaw9HsKp7/QeaSFXOaD7Viy9TEHCD39H+K3sskPOkyulkk19H39WPov19Xh3
         yf9/LLJohUGCv7ceYyqbyhMZAA2sVl6S/NkXahKqQYiGsPUOuPYDM1fDYnLvTLbmNp8d
         Dj5nwGbLQDXGJo5gcAs0j8UTo9fZEhm1K+AsREo0UFjjzskgpKfEPd0TARAKiVV5k+wu
         LcI6tKoV7mN3PXZe9m4bY1XM8KlK6g/0AbThk7bhSg9nstibFfGkzegsEKJRXJF3ZCh6
         AkzTRoZzjJt8n95Eb+HkEeq4fo8Cmc3CpJlayVWfTt7PgzoQzL641T5LLFoF2ipziGyw
         jGiA==
X-Gm-Message-State: AOAM531rJ09YIhyVvUaONuClg8/DHh6D5GEvhByw5xO8DRCjCEouhsfr
        QDfAsQDc1G7kUR3kXRegvHQS0w7RL92ZWY4lk6w=
X-Google-Smtp-Source: ABdhPJzuYTopDwmiC4/JX4x6XQY1NonOaPvW74gwTS1M+gyJ41qpY6KspXMC9JMHvEsJLQXK72gvFfSWL/Q8/TIcc48=
X-Received: by 2002:a05:6830:1057:: with SMTP id b23mr3760190otp.206.1614867367021;
 Thu, 04 Mar 2021 06:16:07 -0800 (PST)
MIME-Version: 1.0
References: <2074665.VPHYfYaQb6@kreacher> <77955b4c-eca1-afe9-5fbc-ceddc39cb397@redhat.com>
In-Reply-To: <77955b4c-eca1-afe9-5fbc-ceddc39cb397@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Mar 2021 15:15:55 +0100
Message-ID: <CAJZ5v0iDVp3H=4ap0Mw=QCkE=zPVV21a335GA7j4OdpjJ2Q3RQ@mail.gmail.com>
Subject: Re: [PATCH v1] platform: x86: ACPI: Get rid of ACPICA message printing
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 4, 2021 at 3:14 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/24/21 7:41 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > A few x86 platform drivers use ACPI_DEBUG_PRINT() or ACPI_EXCEPTION()
> > for printing messages, but that is questionable, because those macros
> > belong to ACPICA and they should not be used elsewhere.  In addition,
> > ACPI_DEBUG_PRINT() requires special enabling to allow it to actually
> > print the message, which is a nuisance, and the _COMPONENT symbol
> > generally needed for that is not defined in any of the files in
> > question.
> >
> > For this reason, replace the ACPI_DEBUG_PRINT() in lg-laptop.c with
> > pr_debug() and the one in xo15-ebook.c with acpi_handle_debug()
> > (with the additional benefit that the source object can be identified
> > more easily after this change), and replace the ACPI_EXCEPTION() in
> > acer-wmi.c with pr_warn().
> >
> > Also drop the ACPI_MODULE_NAME() definitions that are only used by
> > the ACPICA message printing macros from those files and from wmi.c
> > and surfacepro3_button.c (while at it).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thank you.
>
> I've merged this into my review-hans branch now, minus the
> acer-wmi.c changes because a similar patch was already merged for those.

Thanks!
