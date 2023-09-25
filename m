Return-Path: <linux-acpi+bounces-81-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7F7AD607
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 97BFE282A0C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5015EA2
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:32:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86013FFA
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 09:55:15 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4980A3;
	Mon, 25 Sep 2023 02:55:13 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57b691f0fbfso545167eaf.0;
        Mon, 25 Sep 2023 02:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695635713; x=1696240513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEzI9WPuDjrFxx8ftRmrx4d1R9NKDCnLQme3cQmWWOY=;
        b=O0a32u666FYJlJUsNHWf6jOpEwqKBhm6o5rfNZI6c7EaVSU7ntqkKmmJL7B54nPqcy
         xPu1kg/Um2LknljHcMyA1i7FVWK36su7ZG32Sb2PHgr0DoxG2GeRNJG1FysJ2oKebaUG
         EaSy7Wmvrl/46/+nYFvTA4pkDzP9nouWXkGlNhsP72PAaKSgwsXWuaEqpWxG9R/TqeHU
         3bUFBXHE2tfIJk4H2ozLThEfk8e3QUnHF1ZTz977g2r1WrfU88t3awIvhtuE9Nz0hwf6
         Ihjf3nPeLsAtkt14syWkpowG6O1UL37pUBl7PDkSEOHbKfdm0eVLJ2U2dm699EWNECMe
         XkkQ==
X-Gm-Message-State: AOJu0Yyaz04mpuKOZiI1WUdwnXnz2n1hhCTja3bdDClnIze0IIk/DfsV
	mvLLTKssdrmoRz68ZQUrq8fRfpJfHAEx4Ewhkpk=
X-Google-Smtp-Source: AGHT+IFQuNgA6Z9e4uCs/Kc8Qas1hrsT6y0DcjsUC0WuJyF4Pwb5ZDueOYhB3sfY7knlsbCeSuiTI4JeLrn8ZXExPR8=
X-Received: by 2002:a05:6820:1a9f:b0:573:4a72:6ec with SMTP id
 bt31-20020a0568201a9f00b005734a7206ecmr4733855oob.1.1695635712946; Mon, 25
 Sep 2023 02:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925080844.32699-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20230925080844.32699-1-dinghao.liu@zju.edu.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Sep 2023 11:54:57 +0200
Message-ID: <CAJZ5v0imXkvc2WbZtYGwVa3Z2NavhYZ8z=_Z=yZhcnyEeUjw3A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Fix a null-pointer-dereference in acpi_video_bus_add
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 10:09=E2=80=AFAM Dinghao Liu <dinghao.liu@zju.edu.c=
n> wrote:
>
> acpi_video_bus_add_notify_handler() could free video->input and
> set it to NULL on failure, but this failure will be missed in its
> caller acpi_video_bus_add(). As a result, when an error happens in
> acpi_dev_install_notify_handler(), acpi_video_bus_add() will call
> acpi_video_bus_remove_notify_handler(), where a potential null pointer
> video->input is dereferenced in input_unregister_device().
>
> Fix this by adding a return value check and adjusting the following
> error handling code.
>
> Fixes: 6f7016819766 ("ACPI: video: Install Notify() handler directly")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/acpi/acpi_video.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 948e31f7ce6e..b411948594ff 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -2057,7 +2057,9 @@ static int acpi_video_bus_add(struct acpi_device *d=
evice)
>             !auto_detect)
>                 acpi_video_bus_register_backlight(video);
>
> -       acpi_video_bus_add_notify_handler(video);
> +       error =3D acpi_video_bus_add_notify_handler(video);
> +       if (error)
> +               goto err_del;
>
>         error =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOT=
IFY,
>                                                 acpi_video_bus_notify);
> @@ -2067,10 +2069,11 @@ static int acpi_video_bus_add(struct acpi_device =
*device)
>         return 0;
>
>  err_remove:
> +       acpi_video_bus_remove_notify_handler(video);
> +err_del:
>         mutex_lock(&video_list_lock);
>         list_del(&video->entry);
>         mutex_unlock(&video_list_lock);
> -       acpi_video_bus_remove_notify_handler(video);
>         acpi_video_bus_unregister_backlight(video);
>  err_put_video:
>         acpi_video_bus_put_devices(video);
> --

Applied as 6.6-rc material, thanks!

