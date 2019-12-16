Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F512023A
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 11:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfLPKVt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 16 Dec 2019 05:21:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36607 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfLPKVs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 05:21:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id i4so8593409otr.3;
        Mon, 16 Dec 2019 02:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OII3NjIiWl2o2u6W1B64WkC8TWJwjs+GAAq7Ye3dihk=;
        b=IIbOK4cRCXOgtfjG35AQHaTIAKT1T0vahZnR3R8Mf0NKTDkRqR6FOy4NerkX6iv00u
         IMKPo8XaFIK6sxFqCWGnn6BBNi4Ca5u23PLSm+syyd6pddN2eEyeoho4jryLKtKfcbNu
         iEyySH7qzVkNb3bkEo6+82oCou6QLPsd0IYPISqJbjeZUxJZi6M/010hopctGazNZD+N
         OzBCA+IidsDt3TEMczDTa/wXYmIs/e2+ZSGxIs92Y5f395C7xwokBA0r7fT7TkRJzbWp
         3xDp/qy8Zjg7gqXGYk8SUKytSuBG7ILUz7CnQ1yWSNqjk57LjVA5rwgb8ByusURouCNt
         eFdw==
X-Gm-Message-State: APjAAAXgB+Nw9zoVwyn29DBnFdFZdhKVgD02sWSWuO9RHmrdwe7N8UsW
        8SbrgJqz47BtPWfwvNFqTyoKOIC4GbIabZotAmEv1g==
X-Google-Smtp-Source: APXvYqy/CCtY+rajdoo3mJyNMQycKMJhluSj2RpgiUcF+Cuuqvlk+W4loCIV1S/y+Uu1h8w1QLymsVADjv/D/Zw6LBQ=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr31895295otd.266.1576491707961;
 Mon, 16 Dec 2019 02:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20191211093728.4163-1-cosiekvfj@o2.pl>
In-Reply-To: <20191211093728.4163-1-cosiekvfj@o2.pl>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Dec 2019 11:21:36 +0100
Message-ID: <CAJZ5v0hDUD+wZg__=viL6+ZsbxrzzOC7id3OmKMc1zVUJT5VYw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acpi_video: fix typo in comment
To:     =?UTF-8?Q?Kacper_Piwi=C5=84ski?= <cosiekvfj@o2.pl>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 11, 2019 at 10:46 AM Kacper Piwiński <cosiekvfj@o2.pl> wrote:
>
> Signed-off-by: Kacper Piwiński <cosiekvfj@o2.pl>

Applying as 5.6 material, thanks!

> ---
>  drivers/acpi/acpi_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 4f325e47519f..9b4da4167a2b 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -2183,7 +2183,7 @@ int acpi_video_register(void)
>         if (register_count) {
>                 /*
>                  * if the function of acpi_video_register is already called,
> -                * don't register the acpi_vide_bus again and return no error.
> +                * don't register the acpi_video_bus again and return no error.
>                  */
>                 goto leave;
>         }
> --
> 2.24.0
>
