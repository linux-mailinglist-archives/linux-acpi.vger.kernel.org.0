Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147EF3046F4
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 19:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbhAZRSL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 12:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbhAZQi1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 11:38:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E7FC061574;
        Tue, 26 Jan 2021 08:37:47 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g1so20550008edu.4;
        Tue, 26 Jan 2021 08:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kK/uDkip+U03fuKdMMMWxAFTK++aFTandJ16wet7eQE=;
        b=LbIlyXwkci3GYJ9CBAz3Z+vW77MuoErdhYBGoAUYcBJWurTN81UnTPKdvy1y+UTaFU
         rd2yMYhLeSFHdBIVC+tnIOkqw8W+LtUhXWhHrNnuHNUXBWYN4mA/NegHbxYZvSgBLZNE
         4tsdTqpZVGWznBJ4g8NJXj2khbqa2JdGZiKET2oQ+6gJEwoJ1RGY21SGBq3weJQdXQni
         g0C8ZJcs4e9EQ7rhYd/wyxhvxNmQucIl2n/UbPyjVv7rCpgOh8UfFguoAwk3KUP2hIXj
         NgHR7MAX/JoZFhQTE+EJ67ZrqRGXKgWe+9a3Eg58lOqUe1JJ6Gs1w0HbOKlEbL2/wQH3
         TcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kK/uDkip+U03fuKdMMMWxAFTK++aFTandJ16wet7eQE=;
        b=eU8xmL0OxnQrnVR8+AITpwxosHyiaTyZHy+1L6PalN4VIj9/Jn1xXgz8qHT+YJm2ZO
         9o3RB2B+DkKeQMEx03FEECnpbmh6MWrTg2umYZdazs2/S7uKItH/T+SMRvdGEt/i92/8
         29UXhiaQLLk5Al76vLdL5GZTA/7IGWcUQZ9GZRYIJNYdMQjS9SBDGBWRPr3E/2d3wlw+
         AMxv+uqGJ2oZwU2+VTm+QD5cM5rG/eveh53YQZTxg5wi4/pJV7ttJWAgzznWsHHvvjNM
         FdFBWFXr8OXl0fc3FbeFngaD/E06i113qxCYwRthS5dZfNj+wLfVkTOIkr/dJL1twMSD
         4M3g==
X-Gm-Message-State: AOAM532/uMEFUlXVDtN4spB4lhG69gOf7MQqpG2Nia1afYTJLv3s8qDj
        hq/xUXIqrgFBzb4Gt4MYoLqp6XrRO3ApN8gLvifGWNn98ksGXg==
X-Google-Smtp-Source: ABdhPJxAcogkmcB6fEeeJ5/Dn7TH8sbXlq4bOcWspsaqW2XLPMPtPd+mALfJbn8VaRNhMehfayx8prjI4U41XLjeH3c=
X-Received: by 2002:a05:6402:4252:: with SMTP id g18mr5471851edb.231.1611679066212;
 Tue, 26 Jan 2021 08:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Tue, 26 Jan 2021 18:37:30 +0200
Message-ID: <CA+CmpXty1N+0zJoa9vOS6-pr-qQCv11PdtE5yyurEqna3rPkkw@mail.gmail.com>
Subject: Re: [PATCH 0/6] thunderbolt / ACPI: Add support for USB4 _OSC
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
> Hi all,
>
> The just released ACPI 6.4 spec [1] adds a new _OSC method that is used to
> negotiate OS support for native USB4 features such as PCIe tunneling. This
> patch series adds Linux support for the new _OSC and modifies the
> Thunderbolt/USB4 driver accordingly to enable/disable tunneling of
> different protocols.
>
> There is an additional setting in the firmware connection manager that
> allows the BIOS to disable PCIe tunneling, so we add support for this and
> also make the software connection manager to switch to this "nopcie"
> security level when the _OSC does not allow PCIe tunneling.
>
> This applies on top of thunderbolt.git/next.
>
> [1] https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.pdf
>
> Mario Limonciello (2):
>   thunderbolt: Fix possible NULL pointer dereference in tb_acpi_add_link()
>   ACPI: Execute platform _OSC also with query bit clear
>
> Mika Westerberg (4):
>   thunderbolt: Add support for PCIe tunneling disabled (SL5)
>   thunderbolt: Allow disabling XDomain protocol
>   ACPI: Add support for native USB4 control _OSC
>   thunderbolt: Add support for native USB4 _OSC
>

For Thunderbolt parts,

    Acked-by: Yehezkel Bernat <YehezkelShB@gmail.com>
