Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61741640E41
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Dec 2022 20:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiLBTQl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Dec 2022 14:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLBTQl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Dec 2022 14:16:41 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2E2E61CC
        for <linux-acpi@vger.kernel.org>; Fri,  2 Dec 2022 11:16:40 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id x28so5435909qtv.13
        for <linux-acpi@vger.kernel.org>; Fri, 02 Dec 2022 11:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85nJwScF8R5QnE7gU0QRxg02sZkYjjNjShDimJu5NuM=;
        b=kqu2dnIv6T7XUwON4qNNv1vkVxJYI58zLaW4RFtHmurT4WknLqIEG0UMkbPtoRB+Qe
         teyAlw+kEWCWFUenUFMM3pW62fNgNlhC//KqxrykDjkwC1sgBv1i2o2rapfqP8auooqn
         ZsIBAkd1dsPfBxtdMtWE+30RJ0Sh2c9KNNE9108qU9D1K9HnsiE6h6k0qqYAanhpdbx+
         XNcg5pEakBOTx/kEAGajy/B55Y7fpG1MOOnZUhLCq5plJSAzy1piElJwjqWJlvujYAqC
         p9oKD0gTfssqoZhAapQ8+Aeyv+FztlETzz2UT8nWc1Dl5UhmaLpHuhJTne6/CrtVLum2
         2RPg==
X-Gm-Message-State: ANoB5pla27GILgYSBqwlU7ze+OJBoaGyWRv9pVur1tcZRVGzPPcIww9W
        xMGa0mMtKkaXuSOtSVqK6mwduvSqVlbQ7T8Y1hY=
X-Google-Smtp-Source: AA0mqf6vsyJbUJaFVlqL9D7SczD+gkhczLL8OqSel9YubpIpTwLbDcMYcQBFasJ1y6ZqMmAG+rHP+s9ilMEMr84Ak1A=
X-Received: by 2002:ac8:1482:0:b0:3a5:1e6f:7e05 with SMTP id
 l2-20020ac81482000000b003a51e6f7e05mr49674648qtj.357.1670008599524; Fri, 02
 Dec 2022 11:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20221124113023.4121023-1-liaoyu15@huawei.com>
In-Reply-To: <20221124113023.4121023-1-liaoyu15@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 20:16:28 +0100
Message-ID: <CAJZ5v0i-QmWmXd+i_XUziV18LEzn7o_i57+FRKDQ2OTkeC3tRQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/acpi: Fix memory leak in nouveau_acpi_edid()
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, rafael@kernel.org,
        lenb@kernel.org, bskeggs@redhat.com, linux-acpi@vger.kernel.org,
        devel@acpica.org, robert.moore@intel.com, liwei391@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 24, 2022 at 12:33 PM Yu Liao <liaoyu15@huawei.com> wrote:
>
> The ACPI buffer memory 'edid' should be freed as the buffer is not used
> after kmemdup(). But we can't free 'edid' directly because it doesn't
> point to acpi_object which should be passed to kfree(). Make
> acpi_video_get_edid() get the address of acpi_object instead, so we can
> free it to prevent memory leak.
>
> Fixes: 24b102d3488c ("drm/nouveau: we can't free ACPI EDID, so make a copy that we can")
> Reported-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/acpi/acpi_video.c              | 4 ++--
>  drivers/gpu/drm/nouveau/nouveau_acpi.c | 8 ++++++--
>  include/acpi/video.h                   | 5 +++--
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 32953646caeb..f050a755efef 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1441,7 +1441,7 @@ acpi_video_switch_brightness(struct work_struct *work)
>  }
>
>  int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
> -                       void **edid)
> +                       union acpi_object **edid)

I don't think you need to make this change.

>  {
>         struct acpi_video_bus *video;
>         struct acpi_video_device *video_device;
> @@ -1500,7 +1500,7 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>                         }
>                 }
>
> -               *edid = buffer->buffer.pointer;
> +               *edid = buffer;

Because this would still be valid without the previous one.

However, why can't you just free the buffer after storing the
buffer.pointer value under the address pointed to by edid?

>                 return length;
>         }
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index 8cf096f841a9..075ecad31572 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -365,7 +365,8 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
>  {
>         struct acpi_device *acpidev;
>         int type, ret;
> -       void *edid;
> +       union acpi_object *edid;
> +       void *ptr;
>
>         switch (connector->connector_type) {
>         case DRM_MODE_CONNECTOR_LVDS:
> @@ -384,7 +385,10 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
>         if (ret < 0)
>                 return NULL;
>
> -       return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
> +       ptr = kmemdup(edid->buffer.pointer, EDID_LENGTH, GFP_KERNEL);

Here you ccould do

ptr = kmemdup(((union acpi_object *)edid)->buffer.pointer,
EDID_LENGTH, GFP_KERNEL);

> +       kfree(edid);

But anyway I don't think you need to defer freeing the buffer
allocated by acpi_video_get_edid() till this point.

> +
> +       return ptr;
>  }
>
>  bool nouveau_acpi_video_backlight_use_native(void)
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index a275c35e5249..868749f95a34 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -19,6 +19,7 @@ struct acpi_video_device_brightness {
>  };
>
>  struct acpi_device;
> +union acpi_object;
>
>  #define ACPI_VIDEO_CLASS       "video"
>
> @@ -57,7 +58,7 @@ extern int acpi_video_register(void);
>  extern void acpi_video_unregister(void);
>  extern void acpi_video_register_backlight(void);
>  extern int acpi_video_get_edid(struct acpi_device *device, int type,
> -                              int device_id, void **edid);
> +                              int device_id, union acpi_object **edid);
>  extern enum acpi_backlight_type acpi_video_get_backlight_type(void);
>  extern bool acpi_video_backlight_use_native(void);
>  /*
> @@ -73,7 +74,7 @@ static inline int acpi_video_register(void) { return -ENODEV; }
>  static inline void acpi_video_unregister(void) { return; }
>  static inline void acpi_video_register_backlight(void) { return; }
>  static inline int acpi_video_get_edid(struct acpi_device *device, int type,
> -                                     int device_id, void **edid)
> +                                     int device_id, union acpi_object **edid)
>  {
>         return -ENODEV;
>  }
> --
> 2.25.1
>
