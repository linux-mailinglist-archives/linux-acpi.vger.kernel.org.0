Return-Path: <linux-acpi+bounces-6587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188D91369A
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Jun 2024 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA3B2848FB
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2024 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B13D6F2F0;
	Sat, 22 Jun 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw4SP/R6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23805EE8D;
	Sat, 22 Jun 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095038; cv=none; b=Xx4wUtPzNFOwjVoZkjYZ7zS51/3/T2IZeX8Yr47ouoCFNZTTXmQHGZdgLmvIiCk+cJbboPsO3SZ6Mn5WPuUR2Hg2jzV6/wDGTBUpNyA5E5kCiapW0Z6LlR21vR/UtbgaqIEi5EZxO6hnl2jKsst3d1VzxpDHYfd3byqjaDO/ykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095038; c=relaxed/simple;
	bh=EqV1qFCG++Nzhr7AacdvIDDpDmZjV9W7typc/BXWX20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baCR93NXdIIxm8Uh47SgVuob5YoKPa0Hckvi3uot4+I4oHmwPazTkSchHNx7e//iD3BxGHJ1pMsTkF3JSh1B+IGCMM1VKj5c/38iqLnM6fihXGOIcyRlJAvrI5j+S+XYTj4GKpbQ8nKdnBX455UtFmvigyZdlvlXVHdxtDm29VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw4SP/R6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a72477a6096so17208666b.1;
        Sat, 22 Jun 2024 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719095035; x=1719699835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9caasNtPciKtQdTeYYYLBrHobFYeJt44kO2irBcxd70=;
        b=Kw4SP/R6P+r/jrYRUFDPVbMCSGobv048Cumi0Wh0/SWFzVTcpb18Eif2jt//DqeLxI
         Of7IaAIYLnbTxtPWu5HoHhpM79E3e93tYfhsyiwj8JUe+sNaYfKvScE54a6DVOFx0KE+
         +OUfamCjPtw6UpyPRQ2kvghMvMkgzxvUJs1dW/GgBREu2rmhSbCkQs1jDeYDZTImPmVo
         KLslXDtAeT+ZWhcgbEDaRRMePOpJotnolY+4WIfCCJjjCBw1Baw2mJNDpJcT0vFiPROu
         YIXzBVg/ZW+d2sOP+s1jLJEwnvOFXWYnZZz0pT8rmpX0wlEFC3jqxhcuAMczOzD3j2R9
         6msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719095035; x=1719699835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9caasNtPciKtQdTeYYYLBrHobFYeJt44kO2irBcxd70=;
        b=pHvrVI3UceUnQxB6mkrvcAuCgbcA6MgC7gEHJVt40s/bRG+lIpCotQB22/mPv0xoEY
         juq3XJORXhKKa1uq2YyufOSiY28SSvX2moXEWoSe8HUau1Gvwfe8KXpamzx2O9ZvGnvI
         VW0dKOPQoAMENKRlEMOUogvGKBwcL1/Sk3XlNuwApJ2yjHOQqu1h8ROu2BbxZPUg/NMH
         gI35I34mdac616gnDAKFllElj7kNrNeRPR8N9a/mpGRuV781JEEaPKIw19GR9jhrgKK5
         Xg3nGNqcbJJLQl5QXzXCBDyzU7MyrUtt19alFRAZhE8bGwf6zd038fP2QbrL3UcFGITU
         g6gA==
X-Forwarded-Encrypted: i=1; AJvYcCX5ic85xpvcb7EsBackmKxfV9Mn26TK+LAis2Lm4zyzdJJFQzCNyECLEFMIOKzTDdHdFV8Z+bZezXb9Z7AS0cAfDGP28Ve9F2EyUZCV/PIBBfmL1bN9hb55mKq8nMVDVXCG9O59/w2YceAzVFn6lBf9KdEjwyYtIr0R7KC5AsDb2KPTwZo=
X-Gm-Message-State: AOJu0Yw6q83HBV8XyCchMg4cIFvVQ9VHcDlaNDV6ZdcT1vTKbgcArUM5
	A/fMNByWVD905Au5vUh51Z/A1eJHHBaoKTAMAUiPKxfzdzLWryIWvMREDeEarlygV542S8elFFc
	pt7HVmh60mIAHe8EfJVM7beCUdWs=
X-Google-Smtp-Source: AGHT+IEKr2CGX/X++Hn4E16EBYaSb0Q6Q7lHDkmdWRWksxAExg4pWThLuqgYIiIDj6bT7jw2IsluN1TGHXGOQYF6r1E=
X-Received: by 2002:a17:907:d409:b0:a72:4a48:7e89 with SMTP id
 a640c23a62f3a-a724a488300mr5784666b.26.1719095034815; Sat, 22 Jun 2024
 15:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718994350.git.robin.murphy@arm.com> <0dc14431c8a495e1135fc1d9c4500d4cb96b4e39.1718994350.git.robin.murphy@arm.com>
In-Reply-To: <0dc14431c8a495e1135fc1d9c4500d4cb96b4e39.1718994350.git.robin.murphy@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 23 Jun 2024 00:23:18 +0200
Message-ID: <CAHp75VdnoOyKYbaNtr_UKn9NMSzXR1Syn9W7u0qtLgGuwYX6-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] OF: Simplify of_iommu_configure()
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 8:47=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> We no longer have a notion of partially-initialised fwspecs existing,
> and we also no longer need to use an iommu_ops pointer to return status
> to of_dma_configure(). Clean up the remains of those, which lends itself
> to clarifying the logic around the dma_range_map allocation as well.

...

> +       if (!err && dev->bus)
> +               err =3D iommu_probe_device(dev);
>
> +       if (err && err !=3D -EPROBE_DEFER)
> +               dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);

Hmm... I'm wondering if dev_err_probe() can be used here.

>         return err;

...

> +       dev_dbg(dev, "device is%sbehind an iommu\n",
> +               !ret ? " " : " not ");

Why not a positive test?

--=20
With Best Regards,
Andy Shevchenko

