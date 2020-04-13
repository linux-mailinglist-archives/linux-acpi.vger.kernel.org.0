Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C020F1A6D71
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Apr 2020 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbgDMUmF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Apr 2020 16:42:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43196 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388484AbgDMUmE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2020 16:42:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id g14so2307237otg.10;
        Mon, 13 Apr 2020 13:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRFeWFWwCCqcI7eucZBwMTgLizIVM/dXU/cAgTGHHJU=;
        b=o6GIIBMi34TbSemOhYMpQ7ieZPJyfbq9RuEPJiR5KzHnGtNdci/m7it+3uxA17tHnW
         WGsR2xkz4FuqKXpYfzw6zmZdqO6VN5Gn6BXsfkxbVt3H3GakeF6NELRb/7V9j9VA0173
         GDCdIY1mDuJzifEyLAMmiq3kHVx2/fgeHuO70GVmlfgFIgQQTd9bAq+JMNjGwsfAOkFe
         dsks9IF3c4rKFUgNJIAJ9sShirBe3ISylUyZVj+wvEnThuC3iDIVNvk2uf7KqSpwT/GM
         8Y5iqm5krVwD6y2gd7eh8Zt0wY8qBawWfCnD1iKVLvLarj4Itu3jjfmMcDy5eSCvR/O/
         cZqg==
X-Gm-Message-State: AGi0PuYAT1QyJ56L8HD0nbSUzfC7XVQQLFZk4+raIdYHcpJAiChCKt+U
        ODVCGvNAk4BcudclkXSxIdlYCyagRcIXctUGRnE=
X-Google-Smtp-Source: APiQypI13k4FU1rbI9tpqx/S5x8UC7FNBJy1Jg19qDl8KNTYGy87R/Z3yXkK5FpGGQWLFWdMSwAqJ3+6G1dte6N0Zx4=
X-Received: by 2002:a05:6830:215a:: with SMTP id r26mr15152484otd.118.1586810523587;
 Mon, 13 Apr 2020 13:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
In-Reply-To: <20200413134611.478441-1-enric.balletbo@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Apr 2020 22:41:51 +0200
Message-ID: <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 13, 2020 at 3:46 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> This driver attaches to the ChromeOS ACPI device and then exports the values
> reported by the ACPI in a sysfs directory. These values are not exported
> via the standard ACPI tables, hence a specific driver is needed to do
> it.

So how exactly are they exported?

> The ACPI values are presented in the string form (numbers as decimal
> values) or binary blobs, and can be accessed as the contents of the
> appropriate read only files in the standard ACPI devices sysfs directory tree.

My understanding based on a cursory look at the patch is that there is
an ACPI device with _HID equal to "GGL0001"  and one or more special
methods under it that return values which you want to export over
sysfs as binary attributes.  They appear to be read-only.

I guess that these data are to be consubed by user space?
