Return-Path: <linux-acpi+bounces-4788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3FC89CFEC
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 03:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDA11C2411B
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4484DA0D;
	Tue,  9 Apr 2024 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTZuSg5D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A04F218
	for <linux-acpi@vger.kernel.org>; Tue,  9 Apr 2024 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626852; cv=none; b=D7dHdgO4FjvBFoFzdK8pPPccIysMiA3AJuCurp8x2B7znf2JHT0LyUvhcaP8n07kP6FUbfclyoznoZFdZShFJWAd6bFluPRby0KpcVrX8SLenSth6dVq23jnR70wNlmzmtXoF0ELAebNzsWFN7iUhImBimXiI+7IzULKfhI+//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626852; c=relaxed/simple;
	bh=r2zmZTpMnwocl++95x/nU/XIUjtwCpHeymDjMVB47PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzwiuagqefLD0NuGJrd+VtKxG5tzuJpA0RClXda74PB88I88dh5uOHYP4CDzDYVx3IT09/PIX33Z0xy7Dd8+M5mq7jKRteMU9v6dfgjpYq9c+VK6yD2wRDEO0vi6Hn3XNdravtTwexqKfbSu6AIIMgor+CtQyL3VWKG0fwxbiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTZuSg5D; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-434b5abbb0dso146171cf.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Apr 2024 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712626849; x=1713231649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMxjAHL/FWsCSnB+XuEJfb4SXECUjGEArxNQA5omnzs=;
        b=MTZuSg5D3Ffw24dW4kfZpfbgBdoXQkXsNLoHLgy4AVNYdvXB2BvNdcSGg2N7IpdNJw
         6D7I/jLlk4weXyU/6QPAdDflzWihjDwz1V4jOMLnlsPe1aWRRcbyoq92eJ/PiFoaG7Yk
         ceneISmtt5gNgb/04ccWXwdrMi9p0jquChHBEA1irziZABTFloiUwXQh9aI0rHa0y75S
         Ok1mdQAptXAldVjs2/CJrYd9cKbXeAdSjDwro7QDoVRG9T4yh8NjFHydjAuMvsBaj6yc
         ikdDm/VUQ2BQlgp7QaOFmlC3i6WSGmXF4mXE7tBRcf/hDoAUiVxZW8Dg9LoJ++hLY6ji
         scrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712626849; x=1713231649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMxjAHL/FWsCSnB+XuEJfb4SXECUjGEArxNQA5omnzs=;
        b=R5EdTTkPfiaDOjyX9qczkLeshGdMJymI6PEh/UeI4XkVihy+89Ozqn74+E86jde7lW
         K4Xa1Mxj0asKPPB9xN9didc9GD1QeBSMMh4nOeQopOqegexSj72xA2taKC9MZ+zECizH
         SaoULFkmgItHAtQv57AwykOf81kqFSb894vbvEEMaWxEB7rjRf1Ge5DNMjM+VFQT4/Tz
         uMi7NGWZJdJ7R7lFxH8JtU6ce2VlTonbfnNHbsL8CYVpt6mLQiX6Wcp/GUFUF2NpNokQ
         i8rowREKoZmMpYjBHw6cBNB03DbyimmeuLB5mIU8yVc3cxr7VQHACLN3MN6fmqVHZII5
         4C2w==
X-Forwarded-Encrypted: i=1; AJvYcCUuZkSvuqJ8/yl+wL6qEY9dP2CrT9dX5zxUAY9NI6fcmULbEbtFDxOj/r2A8elXSXfuDks1KJ8SnsZboFaI2hRxb19ReVMVS6nKcg==
X-Gm-Message-State: AOJu0YzFYxluXg5D0EVzFXfrMRioqxQY8xZb1lhFovmrYX2GjrRXhZoE
	Xr+5GKdqdmToIVTWx8AsPNXSqipZr3AJvrbMlMWRRo9NqrYJiJVEY9BlPl94rrk0Uovq9ocv6mF
	5wnrYKpJmB824C7GgFetclb96/NbIeNhio8Pz
X-Google-Smtp-Source: AGHT+IEfHMMkArtxOzJrm3HH4hiDp/NoiyU+a1zFBYZHw0wqk3suYz8SBSxh/O4d272loLH12QwJvlO1jB0eckScQqE=
X-Received: by 2002:a05:622a:4249:b0:432:b544:c38c with SMTP id
 cq9-20020a05622a424900b00432b544c38cmr74945qtb.21.1712626849300; Mon, 08 Apr
 2024 18:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231310.325451-1-saravanak@google.com> <20240408231310.325451-3-saravanak@google.com>
In-Reply-To: <20240408231310.325451-3-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 8 Apr 2024 18:40:11 -0700
Message-ID: <CAGETcx8gGcq01CwTZyn=Q0fSQkzMf6tshSmPr5YWYZuhhJVdXg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] of: dynamic: Fix probing of overlay devices
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:13=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> Get fw_devlink to work well with overlay devices.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 10 ++++++++++
>  drivers/of/dynamic.c   |  8 ++++++++
>  include/linux/fwnode.h |  2 ++
>  3 files changed, 20 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5f4e03336e68..d856f9c5d601 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -237,6 +237,16 @@ static void __fw_devlink_pickup_dangling_consumers(s=
truct fwnode_handle *fwnode,
>                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
>  }
>
> +
> +void fw_devlink_pickup_dangling_consumers(struct fwnode_handle *child,
> +                                                struct fwnode_handle *pa=
rent)
> +{
> +       mutex_lock(&fwnode_link_lock);
> +       __fw_devlink_pickup_dangling_consumers(child, parent);
> +       __fw_devlink_link_to_consumers(parent->dev);
> +       mutex_unlock(&fwnode_link_lock);
> +}
> +
>  static DEFINE_MUTEX(device_links_lock);
>  DEFINE_STATIC_SRCU(device_links_srcu);
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 19a1a38554f2..0a936f46820e 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -237,6 +237,7 @@ static void __of_attach_node(struct device_node *np)
>  int of_attach_node(struct device_node *np)
>  {
>         struct of_reconfig_data rd;
> +       struct fwnode_handle *fwnode, *parent;
>
>         memset(&rd, 0, sizeof(rd));
>         rd.dn =3D np;
> @@ -246,6 +247,13 @@ int of_attach_node(struct device_node *np)
>         mutex_unlock(&of_mutex);
>
>         of_reconfig_notify(OF_RECONFIG_ATTACH_NODE, &rd);
> +       fwnode =3D of_fwnode_handle(np);
> +       fwnode_for_each_parent_node(fwnode, parent)
> +               if (parent->dev) {
> +                       fw_devlink_pickup_dangling_consumers(fwnode, pare=
nt);
> +                       fwnode_handle_put(parent);
> +                       break;
> +               }

I'm clearly calling this in the wrong location. Please move this logic
to __of_changeset_entry_notify() and for the case
OF_RECONFIG_ATTACH_NODE. Haven't fully thought through the DETACH
case, but it should work correctly for that case too. If not, I'll
take care of that next.

-Saravana

>
>         return 0;
>  }
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 0d79070c5a70..4b3f697a90e8 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -220,6 +220,8 @@ int fwnode_link_add(struct fwnode_handle *con, struct=
 fwnode_handle *sup,
>                     u8 flags);
>  void fwnode_links_purge(struct fwnode_handle *fwnode);
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> +void fw_devlink_pickup_dangling_consumers(struct fwnode_handle *child,
> +                                         struct fwnode_handle *parent);
>  bool fw_devlink_is_strict(void);
>
>  #endif
> --
> 2.44.0.478.gd926399ef9-goog
>

