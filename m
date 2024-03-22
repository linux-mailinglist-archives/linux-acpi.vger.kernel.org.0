Return-Path: <linux-acpi+bounces-4426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A2886E81
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Mar 2024 15:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B591C21F06
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Mar 2024 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E471481BF;
	Fri, 22 Mar 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLeuuvT6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7243E47F59
	for <linux-acpi@vger.kernel.org>; Fri, 22 Mar 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117701; cv=none; b=TE6LR3MCb/tTf3Ft3J0QHviktXZ/kCbyNK9hBLoflntiJRAUaw7j0OkzwVoQry/080bT+vanLFnY9z7iiguYlNKf1wYLe/TkzEg2AMI9JNtXqR46BGzo5voXxrye4BcXQ9wGI2tCRIz2iVv0HG1In6J6K2Fj0iODFrlgIISi3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117701; c=relaxed/simple;
	bh=BSRa5G43mi7MP+cPzwPAx8XvxMHOExGKnRxZJXFXEKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJrzsyNnvMXycGkgY6k0KI06tJ34RAmXALXDG3N8Pv2gDB1nSbReUMsIWMvVaB9CLTBgLMlC2kt1pq83QyK0RIaBO6QtXEKOwiFO1I/nSPFQNDIJs/9GIm5/9JR/HLEdET7VxQAEkKBoi4vafPfPWh3z4mqKLsNp/9LyLaSvaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLeuuvT6; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so2196262276.2
        for <linux-acpi@vger.kernel.org>; Fri, 22 Mar 2024 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711117698; x=1711722498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSRa5G43mi7MP+cPzwPAx8XvxMHOExGKnRxZJXFXEKM=;
        b=vLeuuvT6G/phlZZtOpqaDnbCp9AccDlki47Zwz9z3aR3LKtZGvC27XHwGs8G3K55jb
         yEjNFKfd8ssFprZGPoooshMwt8d6W8FqrvjaPwaT25NoODY0gbnLHdP58OHFIJw5AKlp
         Kl6IkkkPB1KwmaVm+oQHUkKidldOPVzYGzspNZrMDwzQDXp77y0s4ukF4h/Zj59/Jz1J
         iw6qeS1m2Ij6W+yRuqIyQ1kJqULDwYj/vfuYtC9IqgQuZkJ+qBqMXk5M0QLLIGsyYsDm
         30aPtY4Z+j9JdUaRUvZYA5DztLaKrXtX2yhC83KCfVxaFe0KdRz4UpPhvpTL/Y22P1YO
         C8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711117698; x=1711722498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSRa5G43mi7MP+cPzwPAx8XvxMHOExGKnRxZJXFXEKM=;
        b=lU57V5MRPZDiBDSGy9bZbreO0mOcQ+hN9IeE9raEPy6YD5jgmba95gcKO9EOyD+FuR
         /aFkbTJsuTuaDu/3mWG3IYnsIfm1/H3AMH2xCkcAgnTYODa8cRFq9ewlJt1LHin1XCbI
         1No9gVl8G/c9r4YNs1DAOlK5hqlW6CVuRS4oZwTRFunQSGkuKdlDcEcbk7zv7v8gTpuS
         k0mGoUWIyqnMmJInPzY+tayUjYyIreRbZRM9pvKe7yjnl/pWzrnPCyOchSnX+LnZ71wI
         6E3MwdPqbsMWDzX1W4yFuk/CkszQV6lj/79logeKkuyW1v/dp3jqKey2Wzdf9ZjxAa45
         ZaEw==
X-Forwarded-Encrypted: i=1; AJvYcCXICvQBOGLGiAdzfujXjjqFwb5lgCuNwIP/4s/eXhAB7JySFveNpY4bTpInvy10CkvaXBv2Bhpn38wxcaXqnL2+EBm0O/blimGsBg==
X-Gm-Message-State: AOJu0YwOdZZPULK4xHWsB/ZL7DnSEjyK1ObgTqphsmfzzxPU1SDmg4Kr
	lREWTk5Yr1tRRCu93n3qRXWkbC3iq5HA/7CGCowFcoXRGY82e4P9jbFnL7koRRVWRFk0IfGG+4y
	U3M0mLTgTuOBOl8NIkzN5QqnpIWRTrE80DJGkdQ==
X-Google-Smtp-Source: AGHT+IGqQVjMZHkKIJlkFsR4RJeZUKLo2QeeLI2k4huSnpcBnZUsNA0a45bgAtTQ7oz24BVUerld1XlhOi12G93O+Ho=
X-Received: by 2002:a25:83c1:0:b0:dcb:fb49:cb96 with SMTP id
 v1-20020a2583c1000000b00dcbfb49cb96mr2127472ybm.31.1711117697064; Fri, 22 Mar
 2024 07:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
 <36198864-579e-41f0-baf6-917f0a7f4bfa@intel.com> <5767438.DvuYhMxLoT@kreacher>
 <5770245.DvuYhMxLoT@kreacher>
In-Reply-To: <5770245.DvuYhMxLoT@kreacher>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Mar 2024 15:28:05 +0100
Message-ID: <CACRpkdby5dY7j9=r_dq+at_sqFduJWo15zt4tj4fvhY-KgCUYg@mail.gmail.com>
Subject: Re: Bug report: probe of AMDI0040:00 failed with error -16
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Francisco Ayala Le Brun <francisco@videowindow.eu>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ulf.hansson@linaro.org, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:33=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:

> We actually can get away without defining a new IRQ flag, as in
> the patch below.
>
> It is not super-clean, but should do the work.
>
> Linus, what do you think?

Uhhh I rather not, the other approach will cover the invariably recurring
instances of this, it will not be the last time we see something like this.

We need tglx input on this, I could merge the patch below with some
big TODO to fix it properly if the discussion about the proper solution
takes too much time.

But I rather not hack around with IRQs without tglx (or marcz, but he
got overloaded) input.

Yours,
Linus Walleij

