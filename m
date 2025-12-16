Return-Path: <linux-acpi+bounces-19598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE6CC06D2
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Dec 2025 02:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9613E3018943
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Dec 2025 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB723C516;
	Tue, 16 Dec 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ari1B+D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1AF2147FB
	for <linux-acpi@vger.kernel.org>; Tue, 16 Dec 2025 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765847667; cv=pass; b=l0ir8V2+ngv2uhFkU2R9cvM5QL9Cqv/JLgzsK0dNkJmo79R5/vq36agqnGjTYK0PBTxj3Lr3n87kVN2mAprFBwT1wEhNDiefFv3dUDBN2yP13BsFZyb16qt9D85weHsfH06TM33kdfdD65ACKyB5KWyNGMweWM3VSxcpy0Ys/Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765847667; c=relaxed/simple;
	bh=RYQZPJfFMxqkp+1nngNLsMaHBFm6+xCUj4KkP21+dYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCHi/BaYcJZLDG1Wz9wGmsJMErDEHQEO3a80tuPpFUGoaZlqtfdFk3VLfpWg074WoEa1JwwVHuWejuCexjkjQ5k72+gnHNZ07H9DLckweuPSUqKcKgY8zd1yEwEVibBJUBqZ/4WZdlrqHUTaS9za2vlhtM57cm+zQHsdyCh/aGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ari1B+D; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee147baf7bso52221cf.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 17:14:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765847663; cv=none;
        d=google.com; s=arc-20240605;
        b=AtrM7C9nsJPNmeT0cPe0SFbINbo2i2QwU0GEnAFiYi3y6jDgSw0dJeZumP8Wsj+PH0
         QwBZTpPJTDNx9YzJFhqjwgdZXHUEpHBO8Qd1Fxy3CYfn6rZZWUzWGIlUmphHEuS2piv2
         sKTJ4v4ziOOnkCjHpA0fMj+dHCvowQUA54beZx2lg6j52NYjX4CjOS63TwYTivWbj3wP
         EtCI1pD2j6JR7VQjAJrCV+CySCHU++fLUl3ORjjyyaZxa8DaLMrDVGW9og6hYPvhqgJE
         AKtK4MEb8KQVOP1EBRGQWy1lGx722/PSrmIc81P8A9MBzAIQP3Iw5fqL9tdL9ZPz405o
         DNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nNRSgDqjGCHm0cCbv9mH9lJK6eTAVlNyMNzHMF8cYvc=;
        fh=biB5mHEawk0Fy3SQQlE20r3QPZhw2dMlsFeSMyaZ/6c=;
        b=bedoBkaip8IIhPu5C5gGXMv4Uiun0XS6isYInnbmH6+iwCOLaL5jvp2VoHWmDk8Kat
         1flPmSTtFb3jjOvGsENflsV2Rph5rGvz+frzjnolrEufHvR0n0TgKVGemONxrYxV4cT1
         DFzcl1NFv0x6eUAa+NL1cPrbxcOilnVdy9WpEkFMnOgRz27ln7VShGN5lYpR+JhXXHBr
         6QyQGlWHeSVhoPoJS91E7Y1JMkxKPpM/wsSjDSa7lsw+m+5+TBwgsCIHxsKeskLfAITu
         UIOncn1oQDWxYk8rsSqDyPNfb9S2oj/N2OTK47WT++dZdXcVtrYEdxnpyUzyNyDUG75b
         +zRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765847663; x=1766452463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNRSgDqjGCHm0cCbv9mH9lJK6eTAVlNyMNzHMF8cYvc=;
        b=3ari1B+DFeL77dgRqQXsmkwyt3RpD5yA/XqttCV8veBhDTk0MUnXiBVw2Ka7+3hlsv
         VCY/3P8wYJlCxLpohyYwMLEQOPeSCAYbDV5tjZmS7qnzRhMkAlDsbSdeE3SuVy1fwIc8
         lA5NHOCM5dN6iBptDP/Np5epV8nrLcRkPk066yRGIc4OhzyHlea71C5x+1oq2Wr9COyG
         x3GNW9+tN8N8H8Ui056BJG3Ma/F/hiP9CP6YYrSqkgzIVtB+3vjiIIIhx90AKBiK3MT6
         7bpDrHk0oYwU2KQ5XzO5+XNO9qeugqgUZPYQ/XQ0I+QVY+GmD9JYYC6zfLTXi4IAeeH2
         Kw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765847663; x=1766452463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNRSgDqjGCHm0cCbv9mH9lJK6eTAVlNyMNzHMF8cYvc=;
        b=gfxSOgk96JF0tSUQBC+7TZ/GbIXNsPoFRz/AGU3Mq3972FOheX7X1w7Lsedtgs9ijb
         VUojyMU13mmOT/K4a+CmJgrhDczlD635Z5aL/lnxLFq4NOsqtE/ggxJ0rCwP9Uk5QeCy
         vs+P/DH8Bi8g48VSK70qibp+VNhRDhleR+TmbgLGhHybW7eWIsBiizb8suUakruJ6lQ2
         Ro/jdgb4IZWYBmwbggmb9ImtAGgOZgoJm1Vw3pEEpoiYmocBJmXdk6YBI5rO7IH4Dflf
         DctiR7g4hMX19Zd+Jf7Fr4Gmfp6EkAjTuC47UJF3k747YSWXwyzXbRq37Pf1FNu2aU9m
         O+cw==
X-Forwarded-Encrypted: i=1; AJvYcCV4VmaxPJvQiUTKPNL4LuxInymzrVwDDgMkxJHIwzeB9OiguJorUtLa8rwCP3JLBXqZMAnXFubyUEna@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUwxwCWjwtARX+WNhJ9/51NGwss2MfHIotlr+8tE2nyYugJqe
	YyysnOjafkZ/qLNWIJck3C2GrelMBl1xfKIRQFG59P1wHSexNNJFgMATT9TwgO54ohHkYJdXAAr
	/U20qA1DADcTggeJJ956CpLawcPdUh0gRkokAoYVv
X-Gm-Gg: AY/fxX4QXtGi5lLpEcMq4T+QcwuZRELyd7dIFWpF2ZasykjknPl42rdihmmlKH2F/eG
	Su9trISd+0Q5KecVXr5X/UcacXupnJngMh+r3CsyDDoqQwZHQaWnMCx8n2B+m5QOMXWSpvjsITJ
	p8TIYoctVvPqosxNQMbvgzj568izuLmttXL8KMl6nUSVp++7cj7P44IfhAamfVDwXcz5suPyzED
	95HM/yNS7Tg9WxR1bk0/dTNOQhHruxI+b9WizqdZc+lDxyzHMPlM1mDf21dOLBtoFZHrnawX3AL
	l+ZEO4IkCCBtfOPAtDzcSySg+g==
X-Google-Smtp-Source: AGHT+IHDK9Nx0ZJG9GA2+hWOGyWZ73qxIXF4H8RaWSuD2ofLYKrM3Tu07Foy0ZrKHXYTXOo9Ba7m6bZ0z05T+81FVJI=
X-Received: by 2002:a05:622a:8a:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-4f347f93f08mr1579311cf.9.1765847662514; Mon, 15 Dec 2025
 17:14:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765834788.git.nicolinc@nvidia.com> <cb38f91526596f4efd0cd1cffa50b4c1b334f7a4.1765834788.git.nicolinc@nvidia.com>
In-Reply-To: <cb38f91526596f4efd0cd1cffa50b4c1b334f7a4.1765834788.git.nicolinc@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 15 Dec 2025 17:14:10 -0800
X-Gm-Features: AQt7F2pGryc6oZ72KleXBeas9fEej802hxD59J2edZO4aLe2-OI0GRs2t7Q1jUY
Message-ID: <CAAywjhSzKM_bEm_VbPZFffY9sR3-p==gbVppSL+555D1kPg_3Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] iommu: Lock group->mutex in iommu_deferred_attach()
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, afael@kernel.org, 
	lenb@kernel.org, bhelgaas@google.com, alex@shazbot.org, jgg@nvidia.com, 
	kevin.tian@intel.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, patches@lists.linux.dev, 
	pjaroszynski@nvidia.com, vsethi@nvidia.com, helgaas@kernel.org, 
	etzhao1900@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 1:42=E2=80=AFPM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> The iommu_deferred_attach() function invokes __iommu_attach_device(), but
> doesn't hold the group->mutex like other __iommu_attach_device() callers.
>
> Though there is no pratical bug being triggered so far, it would be bette=
r
> to apply the same locking to this __iommu_attach_device(), since the IOMM=
U
> drivers nowaday are more aware of the group->mutex -- some of them use th=
e
> iommu_group_mutex_assert() function that could be potentially in the path
> of an attach_dev callback function invoked by the __iommu_attach_device()=
.
>
> Worth mentioning that the iommu_deferred_attach() will soon need to check
> group->resetting_domain that must be locked also.
>
> Thus, grab the mutex to guard __iommu_attach_device() like other callers.
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2ca990dfbb88..170e522b5bda 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2185,10 +2185,17 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>
>  int iommu_deferred_attach(struct device *dev, struct iommu_domain *domai=
n)
>  {
> -       if (dev->iommu && dev->iommu->attach_deferred)
> -               return __iommu_attach_device(domain, dev, NULL);
> +       /*
> +        * This is called on the dma mapping fast path so avoid locking. =
This is
> +        * racy, but we have an expectation that the driver will setup it=
s DMAs
> +        * inside probe while being single threaded to avoid racing.
> +        */
> +       if (!dev->iommu || !dev->iommu->attach_deferred)
> +               return 0;
>
> -       return 0;
> +       guard(mutex)(&dev->iommu_group->mutex);
> +
> +       return __iommu_attach_device(domain, dev, NULL);
>  }
>
>  void iommu_detach_device(struct iommu_domain *domain, struct device *dev=
)
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

