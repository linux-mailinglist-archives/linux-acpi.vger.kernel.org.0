Return-Path: <linux-acpi+bounces-5714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07908C203E
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 11:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4A7282077
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277D1607B2;
	Fri, 10 May 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cn+6fzU9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9438396
	for <linux-acpi@vger.kernel.org>; Fri, 10 May 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332182; cv=none; b=flaoZQ7uZDn3LzOu3v9hlMbQQXOqWJdYjQC9LIHN5qARlfT5jOlFE6DysPqRKA0G5JEbXLJTmQ8UnlNMBt/pOW6YTrFKeULSrzmRk9f/xw0EZujpP7X8TUnuEbT6ioizPHhd2BL1DKThXZWVkaqu02o6RqRWhK2N/S/R1obhx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332182; c=relaxed/simple;
	bh=9yIdtQp3ur1f9Zjf3zmNi4wTquzd2hcg9pPvEGak2SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAdwWHV1aSgVxhLNpdsJNeyTU5VtaD9lbCYl8tR8NFjNtTCts9MaZlbLyLAGywgl8F2fgsJgUUKZw9DeD9U9boXr5w7RnMamsB5FkjOC3PySUSV3urddjCQES6l6CtgTzqweOKPYalhUZlo/POdZG2rqQUizbM1xUYeVXTr5TB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cn+6fzU9; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f0e79215a9so496199a34.3
        for <linux-acpi@vger.kernel.org>; Fri, 10 May 2024 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715332180; x=1715936980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yIdtQp3ur1f9Zjf3zmNi4wTquzd2hcg9pPvEGak2SI=;
        b=cn+6fzU9CQbKSFu+3w/g/5GrIUNAywHSk3egpBiaip5T2mB3gXKAR1R1PtDaUEtJmY
         b/GUCk0x1qJvdp4t4DcHaYsYHYrpmT/z5Y5gMk3MpdfW2dczAzr+Mex1ElWfnjqfMRZT
         Tna9AQODstVHiiFmY6YAv3afkfbZ0sUWNf95HS/tqqfpgtzlq3h13Uf0iY+L4MhpzfBJ
         KHSFUbm1vQbGrIxdCwVZXFUsOJXrRn6EA6C1qu6gCSnqcbYZGTIlE5hOLoefhFLRftIB
         6gpSGhtvOCfVcqzFkONQGFtTtkvKWh1DJ/GaxeX4Nz9UJfsL+OnQAuB05HDMcLxrnblN
         0EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715332180; x=1715936980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yIdtQp3ur1f9Zjf3zmNi4wTquzd2hcg9pPvEGak2SI=;
        b=ZG+WDI7Hx/S5hIcA8jnqj2ioKfYhUWAoTjyTDtabVw2hkTlCp8G9GgjsON6MOrf9r2
         kBGA88jG/8Z+N/kfuWXURPv9x20s72LguRIEPgUi3BmRlk1IXGJvdW27vtfDfK07tyiW
         pZ4ARRj3eLXlaS5U202dnscyoz9NghutPZh/o733F+yDnwT66lM9r5RioP1TWcoUMnPy
         H4wzYhqHqZbZ1EgieIiPwOb+f3fw/sMVYrwnxqACZt2R0tLqsY9FCspc7lzoj/1Oi2+A
         pXG8tgiaWGhvGQBoyZMmuMSikBTXWWEkc5RaPtXMr/Nm/IaXebK0aRXSQH/w7Ec2mnZZ
         A/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCV3oEg2QHAavWtHeS2wXdWk6/RaTUA8UDpV/eTbWNwUSnz1YKuLyg3Atj8mHugkd4WMsicNrc1GuSEAZTO/VXpugwL4TVfu0Rd/hw==
X-Gm-Message-State: AOJu0YxfRq7UW1UpIwEECH0cKA6gSC5C9qQVvBRMv2g2Zc8bGsocvGUC
	BKKG8KJdy5SdveHyt/aRdxQvpTnbKqTjpt+PKNorTopZMLpIi/Abnytcte2JbOOhY0HWRj3iyfA
	Zoq8d6z8lJ61AipSx+Ic/yBEwWchY2o0bPEL42w==
X-Google-Smtp-Source: AGHT+IFJUZsn5cCFuDu7+oE0uV3M2KrJJj2xWvL4ycCzP3mzWGKzZ6Zvm6RZSzXcZCEZoX2rhgdaX1mskMRMuYwjnB4=
X-Received: by 2002:a05:6870:6387:b0:233:5f71:4461 with SMTP id
 586e51a60fabf-24172fc60b6mr2387986fac.55.1715332179485; Fri, 10 May 2024
 02:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509073300.4968-1-cuiyunhui@bytedance.com>
 <20240509073300.4968-2-cuiyunhui@bytedance.com> <ZjzrXnOc5AAost4O@bogus>
In-Reply-To: <ZjzrXnOc5AAost4O@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 10 May 2024 17:09:28 +0800
Message-ID: <CAEEQ3wkHc-EaRPKLivZoxO6jKXv9bigbYhacWouL7+KbgbwWpQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Sudeep Holla <sudeep.holla@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, 
	sunilvl@ventanamicro.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	jhugo@codeaurora.org, jeremy.linton@arm.com, john.garry@huawei.com, 
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, tiantao6@huawei.com, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

There are already related Reviewed-by, Gentle ping...

On Thu, May 9, 2024 at 11:27=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, May 09, 2024 at 03:32:59PM +0800, Yunhui Cui wrote:
> > Before cacheinfo can be built correctly, we need to initialize level
> > and type. Since RISC-V currently does not have a register group that
> > describes cache-related attributes like ARM64, we cannot obtain them
> > directly, so now we obtain cache leaves from the ACPI PPTT table
> > (acpi_get_cache_info()) and set the cache type through split_levels.
> >
> > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>
> I am not sure why you have not added my reviewed-by as I was happy with
> v3 onwards IIRC. Anyways, I will give it again =F0=9F=98=84
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> --
> Regards,
> Sudeep

Thanks=EF=BC=8C
Yunhui

