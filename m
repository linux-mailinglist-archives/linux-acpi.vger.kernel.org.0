Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C107D2CBEC2
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 14:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgLBNx1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 08:53:27 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:41847 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgLBNx1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 08:53:27 -0500
Received: by mail-oo1-f65.google.com with SMTP id i7so367764oot.8
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2020 05:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOSrrS+anA2dLe5EAQpj6J+Ngar+zpk0GUQ1/JhBgIs=;
        b=n2WGtwMaL4VH3QXIGPwAdztVWKGaNNAh5q+cwL1/XhLuEFch50Jr2V+JDbj/eh3s1G
         /T9UFg8vAddp/3MBefpq0I9pd96VeeKVlVj7DAL8y4xoeorhUEf9Vi72EYn7BE+pQ5nF
         NAIIP6f0HTWoAHY5UTPQOoWvmanCvGWFMuwASGcNhI5PWhpM+RCUXpZVQ2wMn5Ab+fnU
         pPhA8etAZ33mMZjy7pGZr+cFhZl6HILLiCRA77g5LsU9eMG4jlVyMaixoHbPYGdqyoj0
         pUq8Jho7sAI407XpJh9WuKJGEo+vm9CghAhD72u46Rxhmeitkaj+gCM4fT5KUhSuZnVl
         Tr4g==
X-Gm-Message-State: AOAM531C50rpwq8Q+qUkuS1E2IkFXA32YvWlNbbLtkNb84kSHSvWIhr2
        vCWfz5Nx6QrbgaBcQCqvehvBx0oOsXFQGfyogj0=
X-Google-Smtp-Source: ABdhPJy6R2QUWyZukLmBcaPbg2VnjdQIemXKW3MRs7FEnniIdFMF/xGyqLRbDHTYWScSwoDKk1oqGvZkO8nuFl9MUCY=
X-Received: by 2002:a4a:aac4:: with SMTP id e4mr1741517oon.2.1606917166488;
 Wed, 02 Dec 2020 05:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20201121203040.146252-1-hdegoede@redhat.com> <20201121203040.146252-7-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-7-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Dec 2020 14:52:35 +0100
Message-ID: <CAJZ5v0gcg+vjKv-OevStsO0AajAR9maL_U6UGUEBzJZ6B6yEmA@mail.gmail.com>
Subject: Re: [PATCH 6/7] ACPI: scan: Fix battery devices not working with acpi.defer_scan_based_on_dep=1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 21, 2020 at 9:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> When battery devices get added during the second step of the now 2 step
> scan-process, then acpi_walk_dep_device_list() may have already been
> called for some deps during the first step.
>
> In this case acpi_device_dep_initialize() should not add these deps to
> the acpi_dep_list; and it should not increase adev->dep_unmet.
>
> Add a check for already registered (and bound to a driver) devices to
> acpi_device_dep_initialize(). This fixes battery devices (which honor the
> dep_unmet value) not working with acpi.defer_scan_based_on_dep=1.

I'd rather avoid having to fix this issue at all ...
