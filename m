Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764E335CFEE
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbhDLSBi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 14:01:38 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:45588 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbhDLSBi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 14:01:38 -0400
Received: by mail-oo1-f44.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so3233504oop.12
        for <linux-acpi@vger.kernel.org>; Mon, 12 Apr 2021 11:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvhTMHKInMwXzhoIcHQcXRz48yqflhkxtKT7QZDKngw=;
        b=Pc6r3iq6U+TKBocg9JwAOgF7UEYib7KTOvCHCwjOGn2MF5ZR29IIWeRUf+CXov0x1Y
         BrSu5TjiQBR/SB/FN6gZ3geBNV3ZYPh/9UAsRyqFpc9EW5Q4HxuYREsgTJ1WladDN0GA
         1NgTE4uXJE9Oq8ZTl/9dagmpWccJAqlRlhppogMiZQG+/7N63fYgv2n2G81zRVKQZBSl
         4k1eIsQpE9h2igOtbMmHlikrfxeib4wuPayb50eNjeIpIM+CuN4HZ3VjbVOyNkQ5Tluj
         /erFwLLzZ4yabIY784Ea29LVF8VTdJygh1Q/c3jKqGcSyVbJ31NmN7sBICVPkJ93daNt
         Tqew==
X-Gm-Message-State: AOAM5317Ip0BweD9cS0v4+FJ/c+t/4Gmnu/R11FV8JJtJ4OraVpLL/KJ
        OhdNxi55Sd/RlZD5Or5zQ0IYY48Og132mO8fr+RkYKTU
X-Google-Smtp-Source: ABdhPJwCSVoGI4Kx0lB1yFX43INou0dJDrFa6U3FT3WKpZLroOD+rz62rEAfo5S3eP9bYinTGZtRYyAk/Lev/ysKBbo=
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr23668241oos.2.1618250479583;
 Mon, 12 Apr 2021 11:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <7d941a3c-bced-09cf-27a1-b61f0d20ef4c@redhat.com>
In-Reply-To: <7d941a3c-bced-09cf-27a1-b61f0d20ef4c@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Apr 2021 20:01:08 +0200
Message-ID: <CAJZ5v0iLSbfRH9A3EMUTrY5=vPdp=uVOF2XQnWkAbko9NjPqJg@mail.gmail.com>
Subject: Re: [5.12 regression] DSDT overriding from initrd no longer works
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 12, 2021 at 7:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> Sorry about the timing of reporting this regression.

Oh well.

> I just noticed that overriding the DSDT (*) from the initrd will not work in 5.12,
> this is caused by:
>
> commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
>
> This makes the initial acpi_locate_initial_tables() call happen earlier
> then before, but the acpi_table_upgrade) call in arch/x86/kernel/setup.c is
> not moved up, so the tables in the initrd are now only parsed and saved
> after the initial ACPI table scanning has already been done.
>
> I guess fixing this might be as easy as moving the acpi_table_upgrade) call
> higher in arch/x86/kernel/setup.c but I'm not sure if that is save to do.

Why do you think it may not be safe?

Have you tried to do that?
