Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55D7767016
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jul 2023 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjG1PEG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jul 2023 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjG1PEG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jul 2023 11:04:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB432115
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2023 08:04:05 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40631c5b9e9so278641cf.1
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2023 08:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556644; x=1691161444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6/HfDaubTIMIFxeuAV36Gi20Ylyo7B3ON5TN39P2I4=;
        b=qBKfwSV+ZwQ6sEr259d4qUrgPzVfaTjCDprP1cGD9z1tWEiC/JSM47CJmsKWX7BmTx
         fiy812NI3OsnG5TAIKOTGxDcPfp8aDU+PYQoCiN1BlxL5+irXAfDCBFZz5HsuIQxp6Iw
         hgMN7FuAwHOQI3s4OhUVjz7PVURGp0XcBgRmTJ6Aub+8UEiHW2q/jyLOmviz60HAl0zC
         uLBxm7sg8JDlv1IwAjbOxYHIKmIThJmYnV/0xpqgYyi30l6fb+d/kHvq0Bfp7yMVUocu
         1JM9s/v49FQGXYHi32FJMlwWX0SNNiZ/Z2mINyxMI3h4EbhLEZIPGipHG4fqdnPySPmF
         OXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556644; x=1691161444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6/HfDaubTIMIFxeuAV36Gi20Ylyo7B3ON5TN39P2I4=;
        b=JfKLIMD8hmmOSjG8xkOEiN/ocUEviBFpgvk7lc+uWi/IxkOyAHtNMCnW3ssMQzukgR
         TwJt3HcCplk9pA5MqJuNG0tXZOmumu7MGN+n7KpTE2o0p1nwma1PZXgPjYWNFkEDEThQ
         Lz3G2uYEitoBHWU75QCKARrvVzaJPG5oImClI3ixqJAFV8pkBtruty2vsS1kG/0X4q4Z
         //FjmaG4rGH9HhMttZceCuBbIOd01TwurAyScOpRRTP4aEt2FmUAUBSTc1bEeYuzOeZe
         0UW4YVKghdGL+tcGRbpmz4afQIUmictnxZUgUNf08tmG3yh8PvGvm/Bw3TSHt+o5d0w2
         pAtg==
X-Gm-Message-State: ABy/qLbgwYjFNCw0TQC1umH98EvdL7bEEnj2KkaLvjvX+CHK4kq+oWWj
        j4Cp7NXSAU1ld0OE2MZcNoyU93sbtIwBhAHATPJ8cQmfgMbyO+HARhE=
X-Google-Smtp-Source: APBJJlHOs1cmIsvJup/NilltNKlcu9VKvvx28/8sGufxTG2GPnKmqYLl2df29lTIbwyOLT/wrpHOLFWvk817KYREl5M=
X-Received: by 2002:ac8:4e4f:0:b0:3f4:f0fd:fe7e with SMTP id
 e15-20020ac84e4f000000b003f4f0fdfe7emr244256qtw.3.1690556644425; Fri, 28 Jul
 2023 08:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230728065438.4026629-1-tzungbi@kernel.org>
In-Reply-To: <20230728065438.4026629-1-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 28 Jul 2023 08:03:50 -0700
Message-ID: <CABXOdTca9hmjWXNATeSkhZAV1PXh1ppt6ENEV23xUpO86ogu_w@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: chromeos_acpi: support official HID GOOG0016
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     rafael@kernel.org, lenb@kernel.org, bleung@chromium.org,
        groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, guillaume.tucker@collabora.com,
        denys.f@collabora.com, ricardo.canuelo@collabora.com,
        usama.anjum@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 27, 2023 at 11:55=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> Support official HID GOOG0016 for ChromeOS ACPI (see [1]).
>
> [1]: https://crrev.com/c/2266713
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from v1[2]:
> - Preserve the PNP ID GGL0001 for backward compatible to older firmwares.
> - Modify commit title and message accordingly.
>
> [2]: https://patchwork.kernel.org/project/chrome-platform/patch/202307280=
14256.3836298-1-tzungbi@kernel.org/
>
>  .../ABI/testing/sysfs-driver-chromeos-acpi    | 30 +++++++++----------
>  .../acpi/chromeos-acpi-device.rst             |  5 ++--
>  drivers/platform/chrome/chromeos_acpi.c       |  2 +-
>  3 files changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Docum=
entation/ABI/testing/sysfs-driver-chromeos-acpi
> index c308926e1568..8e8a5d6610b8 100644
> --- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> +++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> @@ -1,4 +1,4 @@
> -What:          /sys/bus/platform/devices/GGL0001:*/BINF.2
> +What:          /sys/bus/platform/devices/GOOG0016:*/BINF.2

Doesn't the description mean that both sysfs directories might be seen
in the field ?
If so, replacing one with the other would be wrong.

Thanks,
Guenter
