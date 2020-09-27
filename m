Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7456327A2E5
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Sep 2020 21:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgI0Toj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Sep 2020 15:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0Toi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Sep 2020 15:44:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BBAC0613CE
        for <linux-acpi@vger.kernel.org>; Sun, 27 Sep 2020 12:44:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so5476301eja.2
        for <linux-acpi@vger.kernel.org>; Sun, 27 Sep 2020 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7byhznMTDMGNZWyHHBM3w4db+dAkh5PJbFVolAq7xGs=;
        b=XL9bbz2OVNOBaK4lzhkkFWRXVTJdIeeEe3fV4JrdrDk5RMWSM5q4fm+HPV88TQDmjg
         Qaw7IU/gSAcEcL0J5tjDdo33ic7AMvm/hm8Zdtsc6G0cfhySFoGp65ZXaopI0oJ3iQsJ
         skGeiqApTPUpUkpd8ki9nVFrLM3W5S3/lUEVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7byhznMTDMGNZWyHHBM3w4db+dAkh5PJbFVolAq7xGs=;
        b=KKbqqyGCRskYRoNW7WKErPIsCyLSNPcKt8PF10ZwPs0yZJL2EhjL2dnrSbia+lsreJ
         4K3sS7x5nFXVvUHwxgb2DmE9q0fMzPxe9OuLe/5z0qVVk+iyy7e3DL6SrqeoVKtdzYvS
         Bwt5pfnUkS6m1CP8ZMvdYc/PuNFjIVa4Mt8sDFXYXS7PVTWoXuwLPbUkS7fapOcq8a5c
         h7kf6N5aS6aRCwjj9sd+z2MZqUtJ7uzn2iVrC5pOsQ6yUJXRVSeilpYBy4wKa0FjiMF3
         HfiVUl3IarP5/4IrNTFS90kuFkTu4it+0Rd06e5LiIx8acohFU9SaodXP9529JHv+g7F
         G86g==
X-Gm-Message-State: AOAM533AHvkImUAOX54VXXj8bCFBk82Rmp0h+w4/muf93TJWvY9Xhx9C
        lUCdZwuSppHqxCFNbZliNuFtwaInkUg3Mg==
X-Google-Smtp-Source: ABdhPJxuXd0Tkk6MtR5ATzwbwfqK8hEdoQD421k6zX4uJLDfqlIjmyST7uNGvSdk6+ycAR/T8Dh4WQ==
X-Received: by 2002:a17:906:4a8c:: with SMTP id x12mr12857779eju.271.1601235877033;
        Sun, 27 Sep 2020 12:44:37 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id j18sm8781467edj.62.2020.09.27.12.44.34
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 12:44:35 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id x14so9529311wrl.12
        for <linux-acpi@vger.kernel.org>; Sun, 27 Sep 2020 12:44:34 -0700 (PDT)
X-Received: by 2002:a5d:6552:: with SMTP id z18mr14720929wrv.32.1601235874347;
 Sun, 27 Sep 2020 12:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200903081550.6012-1-sakari.ailus@linux.intel.com>
 <f4b82baa-66b7-464e-fd39-66d2243a05ef@lucaceresoli.net> <20200911130104.GF26842@paasikivi.fi.intel.com>
 <6dea1206-cfaa-bfc5-d57e-4dcddadc03c7@lucaceresoli.net> <20200914094727.GM26842@paasikivi.fi.intel.com>
 <20200926123807.GA3781977@chromium.org> <20200927193900.GA30711@kunai>
In-Reply-To: <20200927193900.GA30711@kunai>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sun, 27 Sep 2020 21:44:19 +0200
X-Gmail-Original-Message-ID: <CAAFQd5Be5sUQYtXapcSOu8CVffW2LuLog9qh71-+mxze9WYUVQ@mail.gmail.com>
Message-ID: <CAAFQd5Be5sUQYtXapcSOu8CVffW2LuLog9qh71-+mxze9WYUVQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Support running driver's probe for a device
 powered off
To:     Wolfram Sang <wsa@the-dreams.de>, Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Sep 27, 2020 at 9:39 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > I think we might be overly complicating things. IMHO the series as is
> > with the "i2c_" prefix removed from the flags introduced would be
> > reusable as is for any other subsystem that needs it. Of course, for
> > now, the handling of the flag would remain implemented only in the I2C
> > subsystem.
>
> Just to be clear: you are suggesting to remove "i2c" from the DSD
> binding "i2c-allow-low-power-probe". And you are not talking about
> moving I2C_DRV_FL_ALLOW_LOW_POWER_PROBE to struct device_driver? I
> recall the latter has been NACKed by gkh so far.
>

I'd also drop "I2C_" from "I2C_DRV_FL_ALLOW_LOW_POWER_PROBE", but all
the implementation would remain where it is in the code. IOW, I'm just
suggesting a naming change to avoid proliferating duplicate flags of
the same meaning across subsystems.
