Return-Path: <linux-acpi+bounces-14495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6408AAE29E2
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 17:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83FC3B204A
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1F2206BE;
	Sat, 21 Jun 2025 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CT5VV+2m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912A21FF50
	for <linux-acpi@vger.kernel.org>; Sat, 21 Jun 2025 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750520150; cv=none; b=kHglOhuoG9zUSh+YO8+H3Sb+ipTtvzd1QNWCwdXDb2U+8sWiihwaX1jI3f1Hcz7C9u1VyzNtKFw0ddZ9eoQ+Y8HuHF3aGhZeWRKkGwJ2mm3uJatI5HEG+RZ+qiBw5Tr1WTKD7lJzwgwCDOTrIPN6qN9bL9bVA6c1C2hdkav/8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750520150; c=relaxed/simple;
	bh=Z0YvMrEXahV6Bau7dFtEzJFPdcZeXuaz5bkrjlZVLCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAOS8IgdEdx0210jG25DyZtZoZ8ZYwyJcSKU7nimKThPodnvaazWFsh1BZ37Ebkg0cf0DkKJvg6yk/G46JMLX9ktwg1BUGitILxvpxz0STcJ8RK0CAhfXwwqJy32MJNY4r6mJK4O21OyJ5uq+hhgtytm9DtM5j71V4WpXlAuWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CT5VV+2m; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso5362001a12.2
        for <linux-acpi@vger.kernel.org>; Sat, 21 Jun 2025 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750520146; x=1751124946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3/J+4tuN+K5ETkGh73Z2WxB3VAuuxIUgavzZX0gT9Qc=;
        b=CT5VV+2mB0Sm9ewjUD+9HdFIjbt4t1zzciLGQS6+abKSh9CT20f7L1z09INvlrutk1
         ZNgMCtuG5cy2j+gnYByxuBmYbqrDeVDfZTndJkYsrVRkwKoYnRwcB7Boe8Yl3xvDQehS
         U7OyM1ZeKIOvU81UL/yQSl//y45CWy97Cmzak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750520146; x=1751124946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/J+4tuN+K5ETkGh73Z2WxB3VAuuxIUgavzZX0gT9Qc=;
        b=HRy6KdivBYZboAoEA1Yh6CvIemeMfKEVsLXxfBTCOhG3sNKyLOo7/DLNvvqvmb4PLl
         UWcurZPe63f7wEQYWfuC1kJe8nP5iE/hzsl1WGVrHP+kvtiPoHz4JyZ4CjlZN7PSp3os
         0ABkx6ALB01bKaL6c2uyE3924hzjMYY/ftgPy/rhqho6qfdqtZkon+S5FGW8v3G0J7Mq
         vMA8Wt0NAx/kYYsxVFI90Ou3QIEdoKvkSDOMyxHbCXf1u7/Dd5AKIwgIoGpox6ukuO+I
         lYOAjcMmArou7dGQg9uzdHrqqImX9so5fz0nAhiGYLNHDxHHnNjOPmCBZ9mo96f0srJo
         fdHA==
X-Gm-Message-State: AOJu0Yz5agBTwxKbIzzFkY65DZj1ssf2JSHXJLLhBMBfYfjHyd6Hwd5B
	ZvQTvLqHMnKnVTpGv5ZYc1XCrCxBYg+FJWVrEwAbWJ3Wcgftuz6wkgzxDPm7kk/cr6EJXbvrrPY
	NQi8XblQ=
X-Gm-Gg: ASbGnctSjjHP69S6nclPc+Up9ZKe2EkoyP8PWQ/KfC2CcrJwEV+MgPwoh7xtO9Ht/cL
	mXwuJ7qwSwCoPmf3AUCMPrCfqscdPmBA9KgBdsFGm4vsAJLLpmGyXL1cyAdB7oeDajeKe7E6/hT
	axnyDZrpIrpes6QnoK9ycTPQNIKF/mCraRu/qyHJsyRf2/h00/KVgp0GK/ToNbHGrt+O3LpMNBq
	doVlRF4YQnSIBnJ/VQ6GffXB04Mtn7g1zh7E11HqoQNTPJr7+jekwVzMwXZ5VLSJ9ety0t5uT+N
	U4GUyGoDGAdaroZVkovVh+cJNcgmxCG5WiqD632VVJaDSoj2rV8KT/Lf9wkDOEh9cqS0H/l5PwA
	d4XFW/imJS/3ghQBw23e3ahoA9YuxgUTqq0vG
X-Google-Smtp-Source: AGHT+IEXPOmbhIP37gD7tx/rYzGRdjlgkgAMa8NyGk5RwwUDMN0tj+AZQH1WdCpH1rMqizloTOPTtg==
X-Received: by 2002:a17:907:7214:b0:ade:7bd:e0ec with SMTP id a640c23a62f3a-ae057fa0dfemr640038366b.56.1750520146092;
        Sat, 21 Jun 2025 08:35:46 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209a52sm391301866b.179.2025.06.21.08.35.45
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jun 2025 08:35:45 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad89ee255easo520238466b.3
        for <linux-acpi@vger.kernel.org>; Sat, 21 Jun 2025 08:35:45 -0700 (PDT)
X-Received: by 2002:a17:906:f5a9:b0:ad8:a935:b905 with SMTP id
 a640c23a62f3a-ae057d7a6b1mr515906766b.22.1750520144897; Sat, 21 Jun 2025
 08:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iNVFFJVgzeMx=+UMw5MTOUgdu_WGpJxE3qjHikQ4Sp4A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iNVFFJVgzeMx=+UMw5MTOUgdu_WGpJxE3qjHikQ4Sp4A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 21 Jun 2025 08:35:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPwhqr7mwmXDzYkfAcMRu3zyKRxz3hh-wfg-BQxj+UZg@mail.gmail.com>
X-Gm-Features: AX0GCFtfvCldbS-qaKxG9GOLReH4rkHdVfY5_ZteJ4VslcEcSQtyhd00NZjb348
Message-ID: <CAHk-=wgPwhqr7mwmXDzYkfAcMRu3zyKRxz3hh-wfg-BQxj+UZg@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fix for v6.16-rc3
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Jun 2025 at 04:31, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> This fixes a crash in ACPICA while attempting to evaluate a control
> method that expects more arguments than are being passed to it, which
> was exposed by a defective firmware update from a prominent OEM on
> multiple systems.

Christ. Reading the ACPI issues page makes me go "D'oh".

Does anybody know what the heck Windows does in this situation? Does
it just happen to work because it uses random arguments and happily
dereferences bogus things without realizing, or does it do the "zero
out missing arguments" thing?

Because clearly that firmware bug must have passed entirely unnoticed
by people testing that thing on Windows...

              Linus

