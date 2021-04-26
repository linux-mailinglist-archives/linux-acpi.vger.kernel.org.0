Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83AA36B7DF
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhDZRQY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 13:16:24 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:46626 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbhDZRQX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2021 13:16:23 -0400
Received: by mail-oo1-f42.google.com with SMTP id a188-20020a4a4cc50000b02901f0ae7068a1so4416553oob.13;
        Mon, 26 Apr 2021 10:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tN3QdOxtX4DixsuKnkKMl6bjiMZJXBhh7VrG/N4ivTk=;
        b=fuBlTlwGc6nn9Ct9hX19VrprmxiZtwQbDj7Q0HbU4bOaFbPbF4F3CpsSXqNIlyBUdO
         jku0g34FOAgvXVIX9Cd4+yKktoLolfDz8jqONmJmvq2OAzczheuErboi/fYXQDeophLM
         NQY0+OvfCdY5qOnTF2RZ0ERInrbAMtiA8sjQIijO9zVYsFnawDbupxw892i3QYwNWY8b
         yWKbx0m3HfgtbXyQprhTe1TR8CccjkRg7oZlknd00/3jD3zSytfx3zO1CkcauacAiUvu
         v9edCZxhrk8OJjHKcD69ujhMciqEkPIbncXMFMjZKqQEuM30l+vRJm/SW2fkfV0sbxZp
         Nigw==
X-Gm-Message-State: AOAM532ocDoWxHqz0ixWXBzx+draCyB2gDpVkER3Wex0HVkf4VJNzyMu
        NOd0oFFTsBQOVtyIGgghh/oV/9ECBncNC9DwR0Y=
X-Google-Smtp-Source: ABdhPJxuu+GEVs9xKwmajcsfO2cj8Anla44rqUQkM27SuNNquudhfP9jr0s4mK0BOZ7oOh/wjRyaw7qa0rvgLjE3etg=
X-Received: by 2002:a4a:4c43:: with SMTP id a64mr8803975oob.1.1619457341750;
 Mon, 26 Apr 2021 10:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <11752259.O9o76ZdvQC@kreacher> <5faa46fb-3732-2ba1-9bbf-3108605c85de@oracle.com>
In-Reply-To: <5faa46fb-3732-2ba1-9bbf-3108605c85de@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Apr 2021 19:15:30 +0200
Message-ID: <CAJZ5v0g4CN3Oa_k5-ygEYv35VRJKptdNRrViF+A3vf9pf2_ZJQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Call acpi_boot_table_init() after acpi_table_upgrade()
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Dhaval Giani <dhaval.giani@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 26, 2021 at 5:51 PM George Kennedy
<george.kennedy@oracle.com> wrote:
>
> Rafael & Mike,
>
> Do you still need this patch tested in the failing scenario?

Well, it's been merged into the mainline, so please test 5.12.

Thanks!
