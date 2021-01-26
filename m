Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9E3304CA4
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 23:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbhAZWtt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 17:49:49 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42594 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391846AbhAZS0Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 13:26:24 -0500
Received: by mail-ot1-f53.google.com with SMTP id f6so17144853ots.9;
        Tue, 26 Jan 2021 10:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aw+v8EPGOB2icVmWAx7H2SDUM2JNnk/fQiCa4ACAITE=;
        b=WkzpIiLEteP4ACkiTHh6Q0jYUOoUZIw4Kvv8CC81nVoFk6vUuTOsm8+f/oYT9y40HR
         0FgVUCeMDrng4eqqck+rjUVWFQ0PYcv2EuuYLnzs8ee2P8facuRE/JbCyLmIjBUUTLmX
         SEfw8wNuZD8GY8n39DZ53bmBYUuuSdtevye9Tsn7ahZakGiKuJvmIQcITlvx8jQsRQUy
         72pTgzq3YtN4PTak/NZzZ+u9n8lWiwAp85oSJVBRGy9vj7l0hS8Vvyc3nkTyeyNWdV3T
         hJ25h4/90dvTMysaqgtInLdLObUF2njsidw6lz7Vzte22vH2iQkZlwD0mO76QkCpgGnI
         MQ6g==
X-Gm-Message-State: AOAM531sJWDAMag0wkjrYu/DR0gydiJIxEUrGAC7bQnpJcDj5DvmPwI8
        0qsKwXsVE9Zo4bX+93RMG2ftCb9dBwqB0Uyao9A=
X-Google-Smtp-Source: ABdhPJxScx1svFOJcyPuy1Rr7dp4CdvenPfqTgSIG5qrM5xoHpXFbZB6dkQ3tlQ6EIlAVwMPeBX6nrZGYSbLz22OyFY=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr5044691otm.206.1611685537478;
 Tue, 26 Jan 2021 10:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-6-mika.westerberg@linux.intel.com> <CAJZ5v0jT4crr7fyQE4oVijvTU0hhKOEUvDLziPZZ7J0Hvjrj2w@mail.gmail.com>
 <20210126174649.GE1988617@lahna.fi.intel.com>
In-Reply-To: <20210126174649.GE1988617@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jan 2021 19:25:25 +0100
Message-ID: <CAJZ5v0iGEdegM1+rk4OUOFRBOgVKDRg=Ab-zE3nS12=FUvMrRw@mail.gmail.com>
Subject: Re: [PATCH 5/6] ACPI: Add support for native USB4 control _OSC
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 6:46 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Tue, Jan 26, 2021 at 06:35:20PM +0100, Rafael J. Wysocki wrote:
> > > +       capbuf[OSC_QUERY_DWORD] = 0;
> > > +       capbuf[OSC_SUPPORT_DWORD] = 0;
> > > +       capbuf[OSC_CONTROL_DWORD] = control;
> > > +
> > > +       status = acpi_run_osc(handle, &context);
> >
> > This is the same _OSC that is evaluated in
> > acpi_bus_osc_negotiate_platform_control(), right?
>
> Yes, but different UUID.

I've missed that, sorry for the noise.
