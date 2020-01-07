Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FCF13256D
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2020 12:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAGL6E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jan 2020 06:58:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33747 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgAGL6E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jan 2020 06:58:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so38698208lfl.0
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jan 2020 03:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xDan+NrzXoxR0IPHrL1TDLZarGAclLuRifX+nstdyLs=;
        b=ZPMn1nE42pxSFIb1/Jg5EmMBDBWfpJQgc8kIHzd/wnsIg2z055kAeJe7IZ2lGrc4VL
         5iOir8/YoGZBNkqMWNXaOcbg+N/r6+fBoQT6km2FvUpMk7pcIVvr8jxVeX0JbAzzGCZN
         iI49xWxMtMPuXPX0jJ2HosEiAOgGCEvLEVp4WJzyqu0yjdtWOLNiu7F8F7TIV++LYAZr
         uOhFfo5Xoefp+qWIgsAz4DVWy6WFyiBlgFZ5gTi7lZacYbdFEhKD6rb0esbk/bVgt7Kh
         ds63EIcLrBWwiztHDjS82JL3nJTbkG9Wgjt4BDhKFhlUtUkb1ZapxVFO3gsFt5mE4e6D
         w8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDan+NrzXoxR0IPHrL1TDLZarGAclLuRifX+nstdyLs=;
        b=lt3YaTHBkiYzc1v/eq0WyM79sraB/9SmM0ue37zwoP+DNcyPuTpK4i7VKCf4QJOLZi
         83ka/eFQsPcMW8AoGwp4tDSodTVyskxBJvlSby99JE88EJi7wEnTspQMFxalsDR54fgE
         EH67rMCrrHd9iDlFuDWMchZF7CeiweOl+5xWEGkOY3K5wA+sC9ss1Mq2WqSgVQ6iRiAt
         MlcXeQFsE4lFn8s+O3G0BlPozYXpMS+N65/Xo4T/Rt04HAIWqcLTPZUkg0qJO6tei7fk
         h0jjz7/qoIm9o7vIauhDxB9LM2erxGA5Nt18ijHirHehrm86YpC8yJpLNd7YCSGfFepl
         RstA==
X-Gm-Message-State: APjAAAWHqdDamNZlkaCXnvn+xvWrEuITuV8PLJ1UTfiLmxhgLgZ6Bw0Y
        LdBAyJIm8eX1h/TEMbmBq+Xi/Kl4e3fF/dYJlD45/LxZdtc=
X-Google-Smtp-Source: APXvYqwBV7Ee1u2/FkNJ0D4MbpRQIHVF3KeTSLqGk3g7UjA/Un7cz14I6dnnOSlGcQuSrKdeuZpBbnhTEHw44fEXAz0=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr59154614lfd.5.1578398282446;
 Tue, 07 Jan 2020 03:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20200105160357.97154-1-hdegoede@redhat.com> <20200105160357.97154-2-hdegoede@redhat.com>
In-Reply-To: <20200105160357.97154-2-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 12:57:51 +0100
Message-ID: <CACRpkdYx864UEo9-Bpiian4evJMrrCN-kp61s+Y1gc7BZ88KZA@mail.gmail.com>
Subject: Re: [PATCH resend v2 1/2] gpiolib: acpi: Turn dmi_system_id table
 into a generic quirk table
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 5, 2020 at 5:04 PM Hans de Goede <hdegoede@redhat.com> wrote:

> Turn the existing run_edge_events_on_boot_blacklist dmi_system_id table
> into a generic quirk table, storing the quirks in the driver_data ptr.
>
> This is a preparation patch for adding other types of (DMI based) quirks.
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied for fixes.

Yours,
Linus Walleij
