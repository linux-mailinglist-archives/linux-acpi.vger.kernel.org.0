Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209D560828
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfGEOoU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 10:44:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37305 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGEOoU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 10:44:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so589351ljn.4;
        Fri, 05 Jul 2019 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7KgAyQowANlphvuJcvefk4JoB8cIIbciEehkbcGJKE=;
        b=fxB1Q9Gf3qr8zXsgafNXTpZesztA2sfVuxBUoIJYzv2n708SjhhGIR0dH+CLA7ros5
         2U0rQu/CcCfWPt430p/EZAAWi9zD3FJsWABd1IiFvj7de/RW+3H3J667T8TKrBjAXwRr
         TM1Ghy16jFwAP0mVUM0r27OYrmQASLz2Xtev3Xi5D0B3VZFeOaRi/x3KL1tCaMB7d/OI
         HpEmVZz1+dGswD5iitTWscZYrxRLB5mqwnUx5nsqCdrn9Mu4x9i0iGUszu2G4kewJ/+o
         5daGtAGzxW+FCMtIONrU/XwxWh4cgFT2xPegHFiq9chZ/kO+a2faPLBXyGv1BRJQLKUm
         LcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7KgAyQowANlphvuJcvefk4JoB8cIIbciEehkbcGJKE=;
        b=nb6v7WKDPOfj3WUp1Mwx089+b+Qdnt5kmkpP2TpW9fROH9IdT+RwmQHo02+l8kcjxs
         zscTD7ma0OLOhtlIgtxDBgZSDtYx6fWUJB//Yr/SW+w8HaDoGOAh86FDWRtE2m5AMlSv
         b6LaCQVigZrOZen11uEeXDgudZu5DP8GMj33RB93VxKuWUJjbPEnieAtalzKYmVsvZxu
         JxZtYMuO4SAd+V9Irb9yhr82YPvRZ6CXksRsb+q/uxdoUwFeckPC3e7FBiWb4Ix+z6zQ
         ZKQjK6PFzd167duc2Mk/z3Djkcc9mF3cO9vyy3Vx80A2T5p3h0r8buGGBuxS+spEKbQG
         5pVw==
X-Gm-Message-State: APjAAAX5Cu/0WkhoFEJiFA5zSLkwoyclOu8Gtl+jiDvT5yCWQrsncT9I
        LcAi42MfMlCgE4gnL6ZY1mi6hjE1g2PBCGz0xLY=
X-Google-Smtp-Source: APXvYqyiee4ILyxX9t5MQfQGUDJ/lishcEqamLJaDf4E7OL5egDnLxIkIgBSU2P/QboKIJAhZmzPj1te1Ebd5PCrx6A=
X-Received: by 2002:a2e:900c:: with SMTP id h12mr2286212ljg.197.1562337858382;
 Fri, 05 Jul 2019 07:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com> <20190705095800.43534-8-mika.westerberg@linux.intel.com>
In-Reply-To: <20190705095800.43534-8-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Fri, 5 Jul 2019 17:44:01 +0300
Message-ID: <CA+CmpXsak9Rvkq_RNzoxRecMercUPKqdK+KzbHv_fJC59inaHA@mail.gmail.com>
Subject: Re: [PATCH 7/8] thunderbolt: Add support for Intel Ice Lake
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, raanan.avargil@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 5, 2019 at 12:58 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> +static void icm_icl_rtd3_veto(struct tb *tb, const struct icm_pkg_header *hdr)
> +{
> +       const struct icm_icl_event_rtd3_veto *pkg =
> +               (const struct icm_icl_event_rtd3_veto *)hdr;
> +       struct icm *icm = tb_priv(tb);
> +
> +       tb_dbg(tb, "ICM rtd3 veto=0x%08x\n", pkg->veto_reason);
> +
> +       if (pkg->veto_reason) {
> +               if (!icm->veto) {
> +                       icm->veto = true;
> +                       /* Keep the domain powered while veto is in effect */
> +                       pm_runtime_get(&tb->dev);
> +               }
> +       } else {
> +               if (icm->veto) {
> +                       icm->veto = false;
> +                       /* Allow the domain suspend now */
> +                       pm_runtime_mark_last_busy(&tb->dev);
> +                       pm_runtime_put_autosuspend(&tb->dev);

Handling the removal of the veto is duplicated below. Worth introducing as a
helper function?

> +               }
> +       }
> +}
> +

...

> @@ -1853,6 +1943,18 @@ static void icm_complete(struct tb *tb)
>         if (tb->nhi->going_away)
>                 return;
>
> +       /*
> +        * If RTD3 was vetoed before we entered system suspend allow it
> +        * again now before driver ready is sent. Firmware sends a new RTD3
> +        * veto if it is still the case after we have sent it driver ready
> +        * command.
> +        */
> +       if (icm->veto) {
> +               icm->veto = false;
> +               pm_runtime_mark_last_busy(&tb->dev);
> +               pm_runtime_put_autosuspend(&tb->dev);
> +       }
> +

Here is the duplication.


> +static int nhi_suspend_power_down(struct tb *tb)
> +{
> +       int ret;
> +
> +       /*
> +        * If there is no device connected we need to perform an additional
> +        * handshake through LC mailbox and force power down before
> +        * entering D3.
> +        */
> +       ret = device_for_each_child(&tb->root_switch->dev, NULL,
> +                                   nhi_device_connected);
> +       if (!ret) {
> +               lc_mailbox_cmd(tb->nhi, LC_PREPARE_FOR_RESET);
> +               ret = lc_mailbox_cmd_complete(tb->nhi,
> +                                             LC_MAILBOX_TIMEOUT);
> +               if (ret)
> +                       return ret;
> +
> +               return nhi_power_down(tb->nhi);

Just to be sure: unforce power is done only if no device is connected?
My understanding of the comment above was that unforce power should be done
anyway (so it should be outside of this if block), and the difference between
the cases is only about the additional LC mailbox message. I guess I misread it.

> +       }
> +
> +       return 0;
> +}
> +
