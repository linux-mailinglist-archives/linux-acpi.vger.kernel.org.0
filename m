Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A569F1D94E9
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgESLHa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 07:07:30 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36731 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgESLHa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 07:07:30 -0400
Received: by mail-ot1-f43.google.com with SMTP id h7so3778516otr.3
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2020 04:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QA2rHolsn+tJibnYNXvUISvhxpI4nCOUMELeH1kwuOw=;
        b=um6TR7l7WV/oRzNF7TkZ0dTcsCK2uKCeyF4ZalmTI4eSCX4JWEcOUGbExSJLAyf24b
         x9AWIYmlkH/WoI+474ZPjVbhEr7eXqLdUkFBVzXya8SvZeZoycOZU6Ut7++sXcFb5RPi
         394F8KAfdKCaUW9rUAgQ/+8cyAt3/XMIHqmsCHaHlQbq+BTqsD6Tu5aniMHKi99f4Jds
         3SUc2kbW04APghYyVwzymcy9AJXW5g3/c7FHKzRF1vHpQ85qJb6+CHqILfMzk5E6Z7BD
         mRx+74CK9UN7th5v1flwxDpetBbTdUtkjv4uCYcWNNPnUtUB6/JltC5d89NnUeYgA5Wl
         5Y3Q==
X-Gm-Message-State: AOAM531YocmfBxxpig2NpBIapA7/VDZQU3fSmIruLfRnkRJ5ZsBty6BX
        lzUDQ568GQ1f6FW+fNlzEU/ZeKk9oUuZf9Kbsy8=
X-Google-Smtp-Source: ABdhPJzUEaLivSBf/kObnSg0Ut+3rE56HNahK9iJ86MapeaNnKuls/d5X7+FMHtDu4MkuQucUGkhc1y1jy4TcB+xy6o=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr4584915otc.262.1589886448560;
 Tue, 19 May 2020 04:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <c61a713e-2d4b-91ba-26fa-e3c2f3c50b44@huawei.com>
In-Reply-To: <c61a713e-2d4b-91ba-26fa-e3c2f3c50b44@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 May 2020 13:07:16 +0200
Message-ID: <CAJZ5v0i8qwmJEGEDbHwuaVUGK7PWgnS9o91sqFxni96uSUVfKw@mail.gmail.com>
Subject: Re: Question about ACPI_THERMAL_HID of thermal
To:     "shenyang (M)" <shenyang39@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 19, 2020 at 12:40 PM shenyang (M) <shenyang39@huawei.com> wrote:
>
> Hi,
>
> Sorry for disturbing you.

No worries.

> I want to use the driver thermal.ko. But here I got a question:
> the ACPI_THERMAL_HID does not comply with ACPI spec. So I want to know
> if any device is using this driver.

Yes.

ACPI_THERMAL_HID is automatically given to ACPI objects of the
ACPI_TYPE_THERMAL type that represent thermal zones.

> And if no one is using this driver,
> can I modify this HID to comply with ACPI specifications?

This artificial device ID is used internally by the kernel and there's
no need for you to manipulate it.

In order for the ACPI thermal driver to be used, at least one thermal
zone needs to be declared in the ACPI namespace.

Thanks!
