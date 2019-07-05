Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7F604C1
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfGEKxI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 06:53:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41721 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfGEKxH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 06:53:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id 205so8840379ljj.8;
        Fri, 05 Jul 2019 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8gIVLlJGyzOZpvjymn0qndBI/DyFM3MnfYbrUU7cLfg=;
        b=OA2PnFR3Tq37k/UFYwFzRwjmKtHHjpPm1KOu2EZ2zfy4XJnDqIUxkz6TOSv87f2Cm2
         VvNvXX3OmA6EWINmFxVXk7cy5aD1jRGNTtL5WUQGgU5JQDB02djNhsXceZWYcul0YJ7W
         3t93vxkqdYwTlXk5I9xpGcairN+6Cx1cdRea/kRYjym8eDKer0rE1VvNV5RcCP9UZKx1
         7Q5Atd62ugXFb3LXMZkjz0ZsE1ZEFNXRvtkQYTCnn/oWN/MW3jzIHgbdDjLRzJ8YXffs
         czIcA/nPmtcENuDAkJQikgmcb2XbWTZXplSszq7+28y/hT3+u+K3026w4pVDrv4O+2GJ
         tWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gIVLlJGyzOZpvjymn0qndBI/DyFM3MnfYbrUU7cLfg=;
        b=I6RFra5dq1JxB3sBO/56jGgyfVhEV6+NN4Ei9L6WswswGWloW6p3Oi/ENsWP3iS/rY
         0T10rjLvXodAjwvomyWC0QPn0S1LpyH8Z0Vz96iFZpsCoXmCTmKZZSSH7ngIdm0YRCla
         TpCzbpT81jW+ONu7G8NyFe5UOEH9bz6gL5Rjs8G7g6TCeQjlB5k8tOH/KCwn3kusi5Aw
         y++N6zg4v3gKaC8v6aG+TkVt6Z8faJjYYe1q6UvPGWRDv5s61qYbMP1s4BrbTx8wD3Mk
         Yy8kyaLMoNs3k+MvVazosOd1A5Y+AvAwHaeWNPuI1KaIOvVGB6Tf7OVTCsTNRuTPJT9U
         FuAA==
X-Gm-Message-State: APjAAAVqZybHgtseNPJ9f/o6McB2NVGkJavCsWbO5MIx+Cy9MDVGpKHh
        SvfpabR1InuW7leajZwFvN+eojYyyl8fLFMe0kU=
X-Google-Smtp-Source: APXvYqz6ZY+WPH/vHYMs8HE/XsQEqzjygvkCpC2gpWEDQgnwjxE3DGgLoRNh6dulgUEU0YsKTi8QZAHzKJNR45mtFGA=
X-Received: by 2002:a2e:3013:: with SMTP id w19mr1811339ljw.73.1562323985628;
 Fri, 05 Jul 2019 03:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com> <20190705095800.43534-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20190705095800.43534-3-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Fri, 5 Jul 2019 13:52:49 +0300
Message-ID: <CA+CmpXt5q93e2TQJzfY4afSEMPWijPU+Ks+cgrVDVqUM4=y3Cw@mail.gmail.com>
Subject: Re: [PATCH 2/8] thunderbolt: Move NVM upgrade support flag to struct icm
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 5, 2019 at 12:58 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> @@ -1913,12 +1915,7 @@ static int icm_start(struct tb *tb)
>         if (IS_ERR(tb->root_switch))
>                 return PTR_ERR(tb->root_switch);
>
> -       /*
> -        * NVM upgrade has not been tested on Apple systems and they
> -        * don't provide images publicly either. To be on the safe side
> -        * prevent root switch NVM upgrade on Macs for now.
> -        */
> -       tb->root_switch->no_nvm_upgrade = x86_apple_machine;
> +       tb->root_switch->no_nvm_upgrade = !icm->can_upgrade_nvm;
>         tb->root_switch->rpm = icm->rpm;
>
>         ret = tb_switch_add(tb->root_switch);
> @@ -2021,6 +2018,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
>         switch (nhi->pdev->device) {
>         case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
>         case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
> +               icm->can_upgrade_nvm = true;
>                 icm->is_supported = icm_fr_is_supported;
>                 icm->get_route = icm_fr_get_route;
>                 icm->save_devices = icm_fr_save_devices;
> @@ -2038,6 +2036,13 @@ struct tb *icm_probe(struct tb_nhi *nhi)
>         case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_NHI:
>         case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_NHI:
>                 icm->max_boot_acl = ICM_AR_PREBOOT_ACL_ENTRIES;
> +               /*
> +                * NVM upgrade has not been tested on Apple systems and
> +                * they don't provide images publicly either. To be on
> +                * the safe side prevent root switch NVM upgrade on Macs
> +                * for now.
> +                */
> +               icm->can_upgrade_nvm = !x86_apple_machine;
>                 icm->is_supported = icm_ar_is_supported;
>                 icm->cio_reset = icm_ar_cio_reset;
>                 icm->get_mode = icm_ar_get_mode;
> @@ -2054,6 +2059,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
>         case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
>         case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
>                 icm->max_boot_acl = ICM_AR_PREBOOT_ACL_ENTRIES;
> +               icm->can_upgrade_nvm = true;

Shouldn't this be also !x86_apple_machine just like AR?
(For FR, we don't use ICM on Apple machines, as much as I remember, so it's fine
to enable it there unconditionally for ICM code path.)

>                 icm->is_supported = icm_ar_is_supported;
>                 icm->cio_reset = icm_tr_cio_reset;
>                 icm->get_mode = icm_ar_get_mode;
> --
> 2.20.1
>
