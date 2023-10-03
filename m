Return-Path: <linux-acpi+bounces-400-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC0E7B728C
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 22:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8FF542811BC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B03D962
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50163B7BC
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 19:21:23 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9CF9E;
	Tue,  3 Oct 2023 12:21:22 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57ddba5ba84so110251eaf.0;
        Tue, 03 Oct 2023 12:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696360881; x=1696965681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J07arKxPhBE5rnWHs+W7EtnjO5FU638RRkKT7+PaWpg=;
        b=KmU+P0Lz0Kqcb+CNQQoTEtK4pR6aTDrJK+wzSNoPmp1xLrhMUR3/tCvTJ/lK9+w3Hf
         ke+E/3vwKJqHOYqngeh7oc1J1hdzzSsryJSAEOzxzke5wGOAlhuzk7rn8e6pvX+KbXP0
         ufWsacyVK2a76CtHEEoHoGCa7YgzXJl9UWbzvAou0sRDNX4iZQQkf0eyrK1PPQIJ/rgc
         BbjRBhY6B73Gv46AYwDQ7PbUykfxb7dri08b1DOaRQiHC8Um4bf7Fx8hX7O5QBy7yLsE
         fSOY5xyQXevRWHn8caLhoxTx/UfdKAXGnzUPvC0aeU/VPByoa9OOBqdN4h0mPYdD0a9m
         kFGQ==
X-Gm-Message-State: AOJu0Yx/ed/V0yDCZOjrKyfj+jlU9bbzVpROTjsNsS67QCyw8vYAKFLr
	tXMSpmyuv3Am6UwGgZ7U4DlazkfTaZbQ9LH9POcdeKw8
X-Google-Smtp-Source: AGHT+IGFaRIXSHi99kNgDcHLm2UMpLuGWM/+wDAn3cApVRn6pa2cCI3SO0+MG4kvHsYCDhyIry2fRFOPz8oC1Tgh6JQ=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr331719ooo.0.1696360881692; Tue, 03 Oct
 2023 12:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13c70c43.85d.18ad53580c7.Coremail.chenguohua@jari.cn>
In-Reply-To: <13c70c43.85d.18ad53580c7.Coremail.chenguohua@jari.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 21:21:10 +0200
Message-ID: <CAJZ5v0hwn3AueWnxD37Ar04FAYrKE+MkUMg5MjjLki9nSu=w1g@mail.gmail.com>
Subject: Re: [PATCH] pnp: Clean up errors in pnp.h
To: chenguohua@jari.cn
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 8:31=E2=80=AFAM <chenguohua@jari.cn> wrote:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: space required after that ';' (ctx:VxV)
>
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>
> ---
>  include/linux/pnp.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index c2a7cfbca713..267fb8a4fb6e 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -291,7 +291,7 @@ static inline void pnp_set_drvdata(struct pnp_dev *pd=
ev, void *data)
>
>  struct pnp_fixup {
>         char id[7];
> -       void (*quirk_function) (struct pnp_dev * dev);  /* fixup function=
 */
> +       void (*quirk_function) (struct pnp_dev *dev);   /* fixup function=
 */
>  };
>
>  /* config parameters */
> @@ -419,8 +419,8 @@ struct pnp_protocol {
>
>         /* protocol specific suspend/resume */
>         bool (*can_wakeup) (struct pnp_dev *dev);
> -       int (*suspend) (struct pnp_dev * dev, pm_message_t state);
> -       int (*resume) (struct pnp_dev * dev);
> +       int (*suspend) (struct pnp_dev *dev, pm_message_t state);
> +       int (*resume) (struct pnp_dev *dev);
>
>         /* used by pnp layer only (look but don't touch) */
>         unsigned char number;   /* protocol number */
> @@ -492,7 +492,7 @@ static inline int pnp_start_dev(struct pnp_dev *dev) =
{ return -ENODEV; }
>  static inline int pnp_stop_dev(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV=
; }
>  static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV;=
 }
> -static inline int pnp_range_reserved(resource_size_t start, resource_siz=
e_t end) { return 0;}
> +static inline int pnp_range_reserved(resource_size_t start, resource_siz=
e_t end) { return 0; }
>
>  /* protocol helpers */
>  static inline int pnp_is_active(struct pnp_dev *dev) { return 0; }
> --

Applied as 6.7 material with edited subject and changelog.

That said, checkpatch.pl is for checking patches.  Applying it to the
existing code is questionable and sending patches based on that is
even more so.

Thanks!

