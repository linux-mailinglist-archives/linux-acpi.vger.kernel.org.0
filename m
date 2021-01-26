Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC23043C7
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 17:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391021AbhAZQ0Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 11:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391137AbhAZQ0G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 11:26:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26CFC061574;
        Tue, 26 Jan 2021 08:25:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bl23so3182248ejb.5;
        Tue, 26 Jan 2021 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTb57WaXs9+RToXoyfP0nmHHPNlNXV/8n6vT36KFqWk=;
        b=C0lIxIvzqJlAgD5F1KLFkqG9mvUHLETFM0BiU8i9zEk3rCqG+rWWdJvZ7QlHfOnOep
         ER7oSzmIyUyCd9A1lALdwjvtAqR7XrJu+9F+lWKoLtgGbQzHfj9/GcoPoT0rAL3v+dA4
         7Y5KSphaWR1J0qDMCOVqdq9dYSbASAaE3i8FzMWW9FS9GM9n4ywTjDOoCFhaKkYlUiNm
         BYtarTEKYmnw7pPyF86n/375ZGz/WMRKxIldCnHLTtINFQ7Xnbvbtl1MiBxCeSZKxIBD
         9eWL0nNqdireY2qe+Nxe6j6LTxq769kBhsar/b/Zj5c59azU0By+vEKpsS4ct4iqgtfU
         LB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTb57WaXs9+RToXoyfP0nmHHPNlNXV/8n6vT36KFqWk=;
        b=EO0GTCbNvoIHw6sHYtm3bm33XWn6KmPUijILkTJnTu3gtIVWLBsZk0sFYvfOPyTIcn
         wmEe9JiWWH77qBNtIaxeJ4kZAXkG3yQuF0qjHo3kdnB9rkOD0jE3hf51bRk5vYPhSiGB
         82O9exo29Q/NWKR+0iiWtf1z0Ar553eKzXRrMYTn02lWjKJkei15NG0jYuL6UdAXzjfs
         f+lGk9A29SIK3gVPEjNrgHgDtJq2G1r/4iDpjDlioQ7mRU7Xy/AngMk901ZXTXSoGTRg
         xwqWhqM3wnsG+7JqEZCIE5aym6YGneP3jnPSbzB+y4ETYaHaHgVMdhOLd4cXCQkxw2kv
         UGnw==
X-Gm-Message-State: AOAM530DDXyoP+IzmkBHdcYFob+jD72ZljoxRSfozlCZVhWEtyNvBSeM
        hsCBicCQGFkHHtuRElGiZQwix+Xie7yCxEDcwi4=
X-Google-Smtp-Source: ABdhPJy/0EQcVlEXvZLyWsRSSML5wxyWRPUcvErggT4htJLMR110Eibr5lvQi1zgrc4b024GhN+UhIZtAc0DNx4kuTo=
X-Received: by 2002:a17:906:cc89:: with SMTP id oq9mr3921954ejb.154.1611678324621;
 Tue, 26 Jan 2021 08:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com> <20210126155723.9388-5-mika.westerberg@linux.intel.com>
In-Reply-To: <20210126155723.9388-5-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Tue, 26 Jan 2021 18:25:08 +0200
Message-ID: <CA+CmpXu-LQZyEiAD_1Nb+SntnTojn-T_HPSa=K_6-u2WC7biNQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit clear
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 5:57 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> From: Mario Limonciello <mario.limonciello@dell.com>
>
> The platform _OSC can change the hardware state when query bit is not
> set. According to ACPI spec it is recommended that the OS runs _OSC with
> query bit set until the platform does not mask any of the capabilities.
> Then it should run it with query bit clear in order to actually commit
> the changes. At the moment Linux only runs the _OSC with query bit set
> and this is going to cause problems with the USB4 CM (Connection
> Manager) switch that is going to commit the switch only when the OS
> requests control over the feature.
>
> For this reason modify the _OSC support so that we first execute it with
> query bit set, then use the returned valu as base of the features we

Totally out of my depth here, but just noticed the typo (valu => value).

> want to control and run the _OSC again with query bit clear.
>
> Also rename the function to better match what it does.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
