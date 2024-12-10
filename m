Return-Path: <linux-acpi+bounces-10056-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3149EBB35
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 21:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1661889457
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39322CBF6;
	Tue, 10 Dec 2024 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vohvuk7P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20822CBCA
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864093; cv=none; b=B5yMWccv2fmT8yNANmZB3zwKUD6rjRBTwVhTsmG/LiyWp5V52TEQx+m6NWvjF6USmDtCvQelxXnT7kXorYimOqU5HepD3EsHe/ONohuMNEZtP3s+qkTAdhkCTRuoCPXhVl1xrnzBuLZfRzGa+TU0ko1r6Olx273SlzxlDU9lLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864093; c=relaxed/simple;
	bh=mYCw5zFdaYamjNq7yWm1N3ddyHnywTLmXo/dBHAWXWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Byr75dfPD5erbsTvWdIY30OSl70bAhEmph1kGfFjsy6fFU2Vx5VxUuhzgqqoAUWoO5Gn221+XWxj38SDFLOK9/2N5i93NozD6jYOu6aqqgF9oB0nQaVHEsJ7K06rSfHiqFNBv/NLtYfegV0JtX/r4SqJacGkjGFHZ4Y6GyI/pwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vohvuk7P; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ef0397aeso2353641b3a.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733864091; x=1734468891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4ORuy0JI3fjhylUMikWO4DqO9jPwo1uX07vpSEDYjw=;
        b=Vohvuk7P53xXIT3G8Hy1oycFWfi25n3lJQgFbuY+uj5/YUa57u+eeUCOQX/03yfCu5
         Pm4JreIVQAude1Mu99zqN5yq3HFiJwxTLi23TOprjkD4WjvpYTjUyjJ+juE2+ztu10EW
         q7wVJ4SQaU2gfLy9iKGxC/7OVPHJ5oP+HBfWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864091; x=1734468891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4ORuy0JI3fjhylUMikWO4DqO9jPwo1uX07vpSEDYjw=;
        b=aHnPVLWOs/w3mu195ygXXUpnsxmrHQzTGsABQt1QMuZ1lAN1cjOPu1iOWROMoWGMKx
         RsysQEioy45nYz0DqBJweimv6aIxDX8TmDiCX5rlcY3qMnepXMliOEEEmaubTXZPZWgR
         Z3+1ldGTbfkjkg4+HsTIuhQzT0XZ33H72faAoG3thmHVNP4JrE1EtUEB//PZrm4C4bMn
         aKReuenxRAvecQIDX6SoRNlVENPwVeGpMpTdEEJz8nrRrUvrZO1Zd2qJX+Awk354+UGa
         7Az0xYmRDEEnRuGiW6PILtnTVL7+k/W9Tys727eEVAp7CHvle/cNi1hQTwx86LuzUvzV
         wjnA==
X-Forwarded-Encrypted: i=1; AJvYcCX3dqAVNf6/cR49eAd9n0Y6a4Q9ur4MOrCXFFIscsLgYxTqAj3N4BMsBQLea0n1IiN2pF2MruyvKMRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzmtFZJwPLKwKKaSzuF59w41ZDask+T6+WWhUxcRK2UK7eUS3hJ
	WQjhvWwLwbaK7XcWbbMjZl1iUNp8P2HTumcAGUzBpGNnIiGQ/4g0yb71ef4zlyIgdbKAn4ZNdGc
	=
X-Gm-Gg: ASbGncv9YRpsnm+SRVoTEdty5Gnsf4heJ9VozvmmSN3a807p/bf5eYaYmz/7+mv3SaX
	9VqkiV0wK/qducMwOREND7ywo351UpdSdFpCXnXE8TmbdJMm4WGZMsPVYob+RBnOb9A+haIiQBo
	xKlH5PgGor114Y5lTKgJq38VfRirJ1cQr/QXbov0lQEtM03kqVJ4+uh2hS+OiltfsD4sS9a5MKJ
	aP+wYBrcrxGGN3e5TAxEf/W1AzK6eh9ayhnW8ig6HWIdpaOPSfDNvX1th7HGQ48TYPCotsoWZ/N
	dE2SoM5nwJtGeimv
X-Google-Smtp-Source: AGHT+IEB7ZXBDOj6nxmNxMDbX0M8CH6vbb42Q9j7rSj2tsAtt9wKyH9ZvqiM/lT2DIr1sKfLqvbBeg==
X-Received: by 2002:a05:6a00:10c8:b0:728:eb62:a132 with SMTP id d2e1a72fcca58-728ed3e2988mr575579b3a.15.1733864090716;
        Tue, 10 Dec 2024 12:54:50 -0800 (PST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7260adb61acsm3427716b3a.94.2024.12.10.12.54.49
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 12:54:49 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so4535203a91.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 12:54:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9KrTNxsT8zIl7ONga/e+dN9g3Cr43paRK/HS16W+Ldy3/tzdrUrW33M/nEHh1BFWgtHykA6Wg4L8L@vger.kernel.org
X-Received: by 2002:a17:90b:1847:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-2f127e2ad4amr750621a91.0.1733864088749; Tue, 10 Dec 2024
 12:54:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org> <Z1iqTe5_tiJ_ehzU@kekkonen.localdomain>
In-Reply-To: <Z1iqTe5_tiJ_ehzU@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 21:54:37 +0100
X-Gmail-Original-Message-ID: <CANiDSCtPg7i_xfUuC7fR+c8A6-EQEoyEDttKP0U1HMg_BUrSdg@mail.gmail.com>
X-Gm-Features: AZHOrDnfdIek0WgcOyPHb9bMVRu7gZ-lsusONuIHTchFVSzbluwkZ1W9KCGCwsI
Message-ID: <CANiDSCtPg7i_xfUuC7fR+c8A6-EQEoyEDttKP0U1HMg_BUrSdg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 21:53, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:56:00PM +0000, Ricardo Ribalda wrote:
> > Provide an implementation of acpi_get_physical_device_location that can
> > be used when CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >
> > dasadsd
>
> Yes?
Leftovers from a squash :)

I will fix it on the next version if needed.
>
> Apart from this,
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

