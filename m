Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C9B401AF2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Sep 2021 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbhIFMIA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Sep 2021 08:08:00 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34766 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241694AbhIFMH4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Sep 2021 08:07:56 -0400
Received: by mail-ot1-f48.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso8538210otp.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Sep 2021 05:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43ig+aDRZdrINsAgqj2DdtVQxlNq521gMSntZgmEEFY=;
        b=NPYCLmwD3eRtodla/x/qPHYLGm9pEpUdMMpxVnpWvCTzTUDFppIp4DeZjpgmLIcKMX
         nCM/UPCI0DLa5ITru9iCyOW0RNfAxRRBztSykKZ0H4hmJDF4di4/qTaAGUwk9bIMXeHl
         emhrFy3MiY9DF//Vdhik6H+cKWQmd8pZ/SxLuqu16rhYFHJdjeVn2+lDmLAzWKI5bXt1
         BGd5LQpJ6VqV5spN4TJz2dgiPy8fx093hQOqB+RO7d5zfU9WMcN8zO8LVgjIE6RtMn/b
         Gn8XkWk3QeiYpyokjbFx/EKuTivgIm9gzW3bY638gM3YoIl5K6cFqPVJmHorbC8u/8Vo
         pRXA==
X-Gm-Message-State: AOAM5327Gu7oJJYXwtuk+oILwsypCsQDm4KayDSfZqQsfSeMLZuaxg2L
        i9u27uU98d+AmsuYEb1jdpIi4IUyxcCb++XIHGY=
X-Google-Smtp-Source: ABdhPJyhC5M+8XgRZdb2r3J2bNxKxjfkMkhjO78zMKGEDa1gwzjU226ZqzinMP1tVtpD7V+isjvrjJ1XRmypuW51yGU=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr10718377ote.319.1630930011959;
 Mon, 06 Sep 2021 05:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <eq3N7LWgv7nk-rKFg758nzHoA9q_iVmK3pZ9XiiWqDKTS-0W0hqxRSK1CiAYI84PiY-APIfnpdTofQqewqjLOKfJoHmCwOg4et9AXnAl4ys=@protonmail.com>
In-Reply-To: <eq3N7LWgv7nk-rKFg758nzHoA9q_iVmK3pZ9XiiWqDKTS-0W0hqxRSK1CiAYI84PiY-APIfnpdTofQqewqjLOKfJoHmCwOg4et9AXnAl4ys=@protonmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Sep 2021 14:06:36 +0200
Message-ID: <CAJZ5v0ipwCXhiBXWHeV3=tboGa+Sgmw6jJu+qLy3fbsH0pLSgQ@mail.gmail.com>
Subject: Re: ACPI errors on Linux distribution ISO boot up
To:     EpicLemon99 <EpicLemon99@protonmail.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 6, 2021 at 1:20 PM EpicLemon99 <EpicLemon99@protonmail.com> wrote:
>
> I have problems trying to use Linux distributions on my new machine, a HP Pavilion TG01-2856no. The CPU it has was released Q1 2021.
>
> My problem is that whenever I boot a Linux distribution ISO, it appears that my CPU stalls on tasks, and I get this error:
>  ACPI Error: Needed [Integer/String/Buffer] found [Device] 00000000d0fa616a (20200925/exresop-388)
>  ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName unavailable] (20200925/dswexec-431)

This means that the AML byte code interpreter in the kernel has
problems with the contents of the ACPI tables on the system.

> The most recent kernel version this has happened on is 5.13.13, with Arch Linux.

This should be recent enough.

> I could get journalctl logs from NixOS: https://ibb.co/album/9wMM0p
>
> The fact that I have the same problem on multiple distributions has led me to believe that it's something to do with the kernel or ACPI, but I could be wrong.
>
> I have set Secure Boot off in my BIOS settings and the SATA emulation is set to AHCI. I have tried with RAID.
>
> I have tried the following boot options: nomodeset, noacpi, noapic, acpi=off.

And what happened with acpi=off?

> The only distributions that I have managed to get working are Devuan and Gentoo.

Well, that doesn't help much as long as you don't know what additional
kernel patches they carry.
