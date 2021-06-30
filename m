Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE963B862D
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 17:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhF3PZN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Jun 2021 11:25:13 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:43937 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhF3PZM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jun 2021 11:25:12 -0400
Received: by mail-lf1-f43.google.com with SMTP id a18so5773749lfs.10;
        Wed, 30 Jun 2021 08:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=aNsbaawHSZdLzNi+kcO4dCrPNqRYibLDyVHy8t4TKZk=;
        b=YAS17x46bmWWiYyzjOq3sriaKSsCuxpeUMiOL70tFkK3toxvnTOBjNAefB0NEb8ui0
         Gsy0DanRScaeRkce03LGyfOEdJWpxM6ijnDrtrgh2ElxDShJPux6JldN6hVw0RBwPqp3
         AHuxPLXXzj314MzkeUGQswNI655YpzA6owscrRw2xqqaqPMGHN5BWS+bMqddhBxVEP1T
         E4boMfdGQybAV4iEXJdkbR//v+/aYoQo3D69tg/OwNGmoPMIPVb/X5CUmvU20dyolVze
         TnBjLGHyuVdSW5sCDPJxYrCWjevef3kAunTnEkK6mZcbQpUKyWy1G0oh1ynyyi/++Gkl
         +VXw==
X-Gm-Message-State: AOAM532hFUSwNUd4Y6SqjiwrzepegkNfvkvBs2UNQCyRzCjSD3LfygK8
        PS+vQRluGiq0xe7jP1ukzfi2Gat93H941A==
X-Google-Smtp-Source: ABdhPJyEnLhzsH4r/aLzItyar6QlVFv5xV2AqV0gm5FeyxBUcoLjKcTTMdIwCgqf48F4sGKWjqvydQ==
X-Received: by 2002:a19:520b:: with SMTP id m11mr28294950lfb.548.1625066561628;
        Wed, 30 Jun 2021 08:22:41 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id r81sm1955032lff.249.2021.06.30.08.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 08:22:41 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id t17so5915929lfq.0;
        Wed, 30 Jun 2021 08:22:40 -0700 (PDT)
X-Received: by 2002:a19:7414:: with SMTP id v20mr27452708lfe.203.1625066560684;
 Wed, 30 Jun 2021 08:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210629171239.6618-1-hdegoede@redhat.com>
In-Reply-To: <20210629171239.6618-1-hdegoede@redhat.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 30 Jun 2021 23:22:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v661FZ0J4VjmDsLaM6KK8DGrxZv8ej0yna4EpOVB3jMgrw@mail.gmail.com>
Message-ID: <CAGb2v661FZ0J4VjmDsLaM6KK8DGrxZv8ej0yna4EpOVB3jMgrw@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: axp20x: Update AXP288 volatile ranges
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-acpi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Clamshell <clamfly@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 30, 2021 at 1:12 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> On Cherry Trail devices with an AXP288 PMIC the external SD-card slot
> used the AXP's DLDO2 as card-voltage and either DLDO3 or GPIO1LDO
> (GPIO1 pin in low noise LDO mode) as signal-voltage.
>
> These regulators are turned on/off and in case of the signal-voltage
> also have their output-voltage changed by the _PS0 and _PS3 power-
> management ACPI methods on the MMC-controllers ACPI fwnode as well as
> by the _DSM ACPI method for changing the signal voltage.
>
> The AML code implementing these methods is directly accessing the
> PMIC through ACPI I2C OpRegion accesses, instead of using the special
> PMIC OpRegion handled by drivers/acpi/pmic/intel_pmic_xpower.c .
>
> This means that the contents of the involved PMIC registers can change
> without the change being made through the regmap interface, so regmap
> should not cache the contents of these registers.
>
> Mark the regulator power on/off, the regulator voltage control and the
> GPIO1 control registers as volatile, to avoid regmap caching them.
>
> Specifically this fixes an issue on some models where the i915 driver
> toggles another LDO using the same on/off register on/off through
> MIPI sequences (through intel_soc_pmic_exec_mipi_pmic_seq_element())
> which then writes back a cached on/off register-value where the
> card-voltage is off causing the external sdcard slot to stop working
> when the screen goes blank, or comes back on again.
>
> The regulator register-range now marked volatile also includes the
> buck regulator control registers. This is done on purpose these are
> normally not touched by the AML code, but they are updated directly
> by the SoC's PUNIT which means that they may also change without going
> through regmap.
>
> Note the AXP288 PMIC is only used on Bay- and Cherry-Trail platforms,
> so even though this is an ACPI specific problem there is no need to
> make the new volatile ranges conditional since these platforms always
> use ACPI.
>
> Fixes: dc91c3b6fe66 ("mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as volatile")
> Fixes: cd53216625a0 ("mfd: axp20x: Fix axp288 volatile ranges")
> Reported-and-tested-by: Clamshell <clamfly@163.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
