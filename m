Return-Path: <linux-acpi+bounces-1630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362E7F1CC3
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 19:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190D21F25CD6
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6F41CA98
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6820FC3
	for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 08:48:25 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-280b06206f7so851582a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 08:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700498905; x=1701103705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGpH+LZhC1tp0YladTfv4FobGtJqwf2OTtghtz3nhBU=;
        b=FjVtDWSpV4HwTSdhG4gvo7+U3m8ea4bCbS0+XVuJgpsoBzEAOCP59uHNgJYjCnA32G
         MddfSnyf68zbPej1kfYdU/Jiu84e9cGjfzM/Ofuh3i6cnZCUSYbBuXikb+fJHl/VJL1e
         AYlHbW2CF3tQCT7wZ5dqn/q8buCYrpeRu5u8h4i2Ya9o6R5ijOneUP/1NjeU1YBBXt3E
         2DksIFsUztnyfx4xoMkFzLD6a96+eyCSm/OzY0EUxpBDWClOYcNdPv60jP78Jjkv6MVo
         X1udGr9+Rg/dUpuzs57tEw6HVwPbrOfOun63U/7LD/P3c8iAJIKAWqtLEpkp8BR2EU75
         3EnQ==
X-Gm-Message-State: AOJu0YzWHf/CBZnQIiT4kmFlxYIUbt4PLqnMWpCZRQ1w1yJQpxPcTo9I
	nlsORLU5fTZyq8RaPn/LSx9cWX9lWKQ/MYjEZRo=
X-Google-Smtp-Source: AGHT+IGFoVq0aYbeWHiMJElmItg1CmT/sAhyUh1ah8rBOs9g84jr8FHcUHmke/3a/zUENmcidbHKR7rT791hA374nzs=
X-Received: by 2002:a17:90b:8a:b0:27d:2762:2728 with SMTP id
 bb10-20020a17090b008a00b0027d27622728mr7728104pjb.0.1700498904796; Mon, 20
 Nov 2023 08:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026135303.48757-1-hdegoede@redhat.com>
In-Reply-To: <20231026135303.48757-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Nov 2023 17:48:12 +0100
Message-ID: <CAJZ5v0jNUUhsVrYUGqQKeCn8X1r3q-p9G1o8qTL=7wcBX5cpLA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add comment about acpi_video_backlight_use_native()
 usage
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 3:53=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Add a comment explaining that acpi_video_backlight_use_native() MUST
> only be used by GPU drivers and that it must NOT be used on other places.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> The main reason for writing this patch is that some recent submitted
> patches actually were using acpi_video_backlight_use_native() wrong.
> ---
>  include/acpi/video.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index 4230392b5b0b..3d538d4178ab 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -75,6 +75,15 @@ static inline enum acpi_backlight_type acpi_video_get_=
backlight_type(void)
>         return __acpi_video_get_backlight_type(false, NULL);
>  }
>
> +/*
> + * This function MUST only be called by GPU drivers to check if the driv=
er
> + * should register a backlight class device. This function not only chec=
ks
> + * if a GPU native backlight device should be registered it *also* tells
> + * the ACPI video-detect code that native GPU backlight control is avail=
able.
> + * Therefor calling this from any place other then the GPU driver is wro=
ng!
> + * To check if GPU native backlight control is used in other places inst=
ead use:
> + *   if (acpi_video_get_backlight_type() =3D=3D acpi_backlight_native) {=
 ... }
> + */
>  static inline bool acpi_video_backlight_use_native(void)
>  {
>         return __acpi_video_get_backlight_type(true, NULL) =3D=3D acpi_ba=
cklight_native;
> --

Applied as 6.8 material, thanks!

