Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDED31FBAF
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Feb 2021 16:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSPJZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Feb 2021 10:09:25 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34121 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSPJY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2021 10:09:24 -0500
Received: by mail-oi1-f169.google.com with SMTP id j5so6147978oie.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Feb 2021 07:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XU9GRZDjG43k30K8bcy2ASfNWSd3qrAVk7Cix6nglRw=;
        b=AJhApN6K3zhzdl2sPyg5ufuds972qCK7yTNoM61vjgI1Yom6wFGiV1B79GMCYI66Se
         RQgC7lVBgzD4iqZclcl5Y7n1Ite/770zqumQ8zQnt5GAA7D4uEY+1WXqj0ONRxI9fCL1
         nNtgPPKCi5EZyPUFuuXAddqaw71yNnTzKY6czarGotYFeaVktrC3XkyzpSUehKhg6QYE
         jtdkzXhhnhxJQ5qfygWh1muz2jp2MbzC52LKVeK3U+E5p3iAVgcvle3mpwPtnn1incbu
         AToZCfmihVhXdK7YCH2t3tE7JwBZaeiS37ZSBePT7cU8ePxVS1/bFrLGNizEc+46hPis
         BgLA==
X-Gm-Message-State: AOAM530sq/FEDFUgnWfSUOzMAyUBM1dlzCGVkMZEzyP1oNI8an/GvqLE
        DNaD6eLdqkxbO8iZbfjMQu93ZL3qNbWi+S9kuVZOXBGL
X-Google-Smtp-Source: ABdhPJyB++IRJ9cUgYPjpTyZ/+23n2oyywAe4awb/klfDJxUNgSBNaKApEFTDqZzQ7hLoKie2bhOCBvdXWIYlDwjeTs=
X-Received: by 2002:aca:5dc4:: with SMTP id r187mr1101198oib.69.1613747319526;
 Fri, 19 Feb 2021 07:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20210218231708.1143640-1-erik.kaneda@intel.com>
In-Reply-To: <20210218231708.1143640-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Feb 2021 16:08:26 +0100
Message-ID: <CAJZ5v0iepscLNOisfwKz-KMVJ5afOQiMGHbdyKWvx-k5CwupzQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Hans's generic serial bus fix
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 19, 2021 at 12:49 AM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> Hi Hans and Rafael,
>
> Sorry about the late responses. I've accidentally dropped the ball on
> the comunication of this pull request. Bob has merged it now and here
> are the linux-ized versions of them.
>
> Rafael, if you haven't merged the patches, please consider taking
> these as it will keep things easier to maintain on my end..
>
> Thanks and apologies,
> Erik Kaneda
>
>
> Hans de Goede (2):
>   ACPICA: Fix race in generic_serial_bus (I2C) and GPIO op_region
>     parameter handling
>   ACPICA: Remove some code duplication from
>     acpi_ev_address_space_dispatch
>
>  drivers/acpi/acpica/acobject.h  |  1 +
>  drivers/acpi/acpica/evhandler.c |  7 ++++
>  drivers/acpi/acpica/evregion.c  | 69 ++++++++++++++++++++-------------
>  drivers/acpi/acpica/evxfregn.c  |  2 +
>  4 files changed, 53 insertions(+), 26 deletions(-)
>
> --

Both applied, thanks!

Note that I will send a pull request containing them only after the
previous ACPI pull request has been processed, though.
