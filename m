Return-Path: <linux-acpi+bounces-13696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB92AB4FA7
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E028A188FBC2
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C166213E9C;
	Tue, 13 May 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8SnbIPY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED320468C
	for <linux-acpi@vger.kernel.org>; Tue, 13 May 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128197; cv=none; b=kEYVlSoQHk0Ckv/U9v6bdaIw0i9hrRGCFTYF9mZOsjrJp2XvnymwzVtKGzTeA/s93uL5R0plDYeelRhO+/DJvV0bkQDsfPgHvhdBnFNNHO7WFTk/gjd+3ilG+JHIfIMd8AxBeyhOWQWi4ogL9PgzUmTZpJKpm66BqTMU2O+IIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128197; c=relaxed/simple;
	bh=PUZdM1h8WI1vqC/o9GJnYO6sqlQvrPktbx07wyl5Imc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpKwI0bfyDCt620Is1tmlRlIVjIDk866m+YC3A2skxgZaJpZ9kQ57C8pe+V7LTXSEglKYv4nRh4eNukXZ1Kr814ydZ+KdyW708dY+kLi9MSLZqVkwfvAr5t6x1g7FD6/hXEyWLPj+E8B7tFGNjKyPI5UityMMrQGDNZP/YU4CK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X8SnbIPY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54b10594812so6683600e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 May 2025 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747128193; x=1747732993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUZdM1h8WI1vqC/o9GJnYO6sqlQvrPktbx07wyl5Imc=;
        b=X8SnbIPYMfVAzs5kZ2Hfs7BjnVNEnljduCrMqkyWSt1XZQK8XQinlzhXx0CI0smPFk
         HI+JRIG+4b/ktseLIMSa7UgpZ4ycRWlTk2OOjfSMiYp2nX9Pr2W+KfUeOTFI4cDYwS9x
         Qn0/jrdmRct7fglUKE6c4/2/ALpNOi+dHhwQbvJfjaoOx152ipOTyllOi1FrjdXYcOQn
         jipBemN/GHYO6xVNnNNfRKo6zLUA01Ppj16jpBa82YL/Y4QdBMtscjc5Wdb1FhD/VNUR
         AniHqDQaujOSNMHZNkc9q7eEnXko4LVEats/oP7UZBe5iTbFpTZu5r4RdpnDYu5Q0oI3
         bmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747128193; x=1747732993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUZdM1h8WI1vqC/o9GJnYO6sqlQvrPktbx07wyl5Imc=;
        b=WQipTKwjRcRPDJUlbVZz9HrsbvIi+DtxIZUqo39nEkTWLtSoBTD+LUC/8rkmJFbLKs
         lTJToqejvs3qtyeYpOHgF0tSwK3vjmHGhoZh4dXiNnzjmuZ6DuypMPUT1vSbikvZ11xT
         WrI20TJp4gl0UYhAuBLqT/Y78zoDcO90/YfdoDkfaEyUAI/a2zaF3jKAtEEM4aKSILmS
         tKSELwWl7y95m0hLGkcSsdv+Q7VWS59zTR9oB8zcC3xzkTO9VVY2M06/EP3tZGsJP95M
         GaLrGA34tygd7edqhWvEgsxHv9/KyvC6m1aozqV/MFocJcoL8DBgd9j1lCJutWjRDG5T
         eBaw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4Gkm77EKG1qo0sMrBCjWXgp+f5j7d1mOo8KO7MOf7T5UcACE1MQaLuNi66oxZDxoWfz/HJE9WBhp@vger.kernel.org
X-Gm-Message-State: AOJu0YyywjLO+rHV4fhZ8d+wKReXohUgZMY1vqhTvSFLNqM8EQaTP87C
	f6HwppA9g9/eepGP4nF5hMpvEthZNiQI4E7kRemPkpkNSe9IRhRZOms+6moXA2OL2gKYCAHO3Nk
	Vji0wEOQVtVMm2qrIdECrKu0oKgfWmkM/OHS6rw==
X-Gm-Gg: ASbGncvEm2anrMY2tZbgYWhTrKz4J7oEnGSE190JRoii3gCqFWR4UbTmcrHUsPhHepc
	bnIqcU1jN90DD+MSK5lEBMqBJp7+uTseM0r6Pi6ZRExQJHZyTCk/BxWgzJRIvmWVsTYqgkHEzbz
	sBQMMPVu4yCIC0sO0LNvottYI8a8DoxC7t
X-Google-Smtp-Source: AGHT+IG3yJ2I/gSRbNR8Yc9mQ5D3H3jOM524XFmnhYp45I4Txi2GP3DWvoHzF8HaXmyZuGDfMmUhius5uFgg07Xw0xs=
X-Received: by 2002:a05:6512:660d:b0:54e:9c8d:bdc3 with SMTP id
 2adb3069b0e04-54fc67eba75mr4238045e87.49.1747128193339; Tue, 13 May 2025
 02:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5889368.DvuYhMxLoT@rjwysocki.net>
In-Reply-To: <5889368.DvuYhMxLoT@rjwysocki.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 May 2025 11:23:01 +0200
X-Gm-Features: AX0GCFuBGgsy8OIbyZ_iRPj1JK6HiLr8l-sZYvuduHVP_RhHrCBW63Oul_hd7iM
Message-ID: <CACRpkdY57K7_rhQiXKbOpTGneQRvpJ33E-fG8ejMHzcBaTQE9g@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: amd: Fix hibernation support with
 CONFIG_SUSPEND unset
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mario Limonciello <superm1@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	linux-gpio@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 8:27=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After recent changes, pinctrl-amd will not support hibernation when
> CONFIG_HIBERNATION is set and CONFIG_SUSPEND isn't because it will not
> register amd_gpio_pm_ops then.
>
> Address this by restoring dependencies on CONFIG_PM_SLEEP where
> necessary for hibernation support.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Mario, this is on top of:
>
> https://patchwork.kernel.org/project/linux-acpi/patch/20250414203551.7793=
20-1-superm1@kernel.org/
>
> which is currently in my bleeding-edge branch only.

It seems the prerequisites are in your tree so take it there!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

