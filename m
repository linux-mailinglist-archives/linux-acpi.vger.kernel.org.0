Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADB132D72E
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 16:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhCDPzA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 10:55:00 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43485 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbhCDPyY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 10:54:24 -0500
Received: by mail-ot1-f48.google.com with SMTP id v12so26577888ott.10
        for <linux-acpi@vger.kernel.org>; Thu, 04 Mar 2021 07:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4wpCNVjj5JqEmCmRtbE5zcHMJ5lKGtfC2x+tZg2uag=;
        b=fAZ6HSjvbwAJi3VQTq0Wg1awKWPcW/iOgYI5CtC3aGUoncfQHS6yb3eUFHCyaqJJ+0
         yxwtyhWdMZKbT4+VTKCsWD0OH3hQQo/u9EFX3Dothtd9/CxFblaXK1XsM+hZIXbsdSle
         h39F2fJFbDpNyPW9OAbrGJpqCGseJJIph8J3ciR9dG4gDbe0kMeqKPrKr2K4J/KpGn+q
         hQ/Vu6HWJw36XhncBMVdNT8naWDc7S8WmRwZSyGCaThulKb0m+nszfwiQyJp36XfWu+W
         beuxqLeAKILeEdcYQroVX2yrfmXWYZ+5Ts2P+qqTKgbGamyj1PUQDAWVreqSgkaKQKn/
         j+fw==
X-Gm-Message-State: AOAM532Bewm463i0FwjojyjX8Nb622yK941L3fEqKRwsHM2fbVypHDfm
        ggTtfycFgLsZkz+1ozAnfk4ZP3v9sGXt5kdujSo=
X-Google-Smtp-Source: ABdhPJza5vm2Wo0FDd9EA+wo2f83jonxo6jsIjYTQ50lR/XoCT8ImoI5WzUdC7VM6k+inBh6Pgy2thJiilDYBTJoS8A=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr3887091otr.260.1614873221368;
 Thu, 04 Mar 2021 07:53:41 -0800 (PST)
MIME-Version: 1.0
References: <15858590-7be3-67d0-ccca-a55f20a7873a@redhat.com>
In-Reply-To: <15858590-7be3-67d0-ccca-a55f20a7873a@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Mar 2021 16:53:30 +0100
Message-ID: <CAJZ5v0guBZzV9198xfpmq9re9cSKDN7TjG1JUrD9KeTq5oDK_A@mail.gmail.com>
Subject: Re: Meaning / use of acpi_driver.class and acpi_device_class() fields ?
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Thu, Mar 4, 2021 at 4:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> While reviewing a new acpi-driver:
> https://patchwork.kernel.org/project/platform-driver-x86/patch/CAFysUkSztjJpSjKA92a=3j3Nj7vfQy5TCsiJtNmfjegxLBvFSA@mail.gmail.com/
>
> I was wondering what the meaning / use of the acpi_driver.class and
> acpi_device_class() fields is and if these should be set to anything
> specific ?

The latter is passed to acpi_bus_generate_netlink_event() in multiple
places and that's the only use of it I'm aware of.

The former - I can't recall ATM.

> I did a quick grep and most drivers seem to set this to a string describing
> the driver / to the driver-name and they seem to set the 2 fields to the
> exact same value. But some drivers also use different values for
> acpi_driver.class and acpi_device_class() ?

I don't generally want acpi_driver to be used at all, if that's possible.
