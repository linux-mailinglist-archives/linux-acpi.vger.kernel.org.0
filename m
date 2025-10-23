Return-Path: <linux-acpi+bounces-18139-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E41C00665
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 12:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADFDB4E1B27
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E143009F0;
	Thu, 23 Oct 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTzR00gE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F97C2FB966
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214195; cv=none; b=Yh6ylyXAPc4BJSva90WzuI9Drb/QN3RBEnCNpsOIlq5L7JquiDfeuAJrlqYiiRcpEQT5lpvepk9LSfZ1b51w6cFILlNgofKNqZ+DPwB8No9WMI9ysqcgoyMxfPWbAZPtyDeFSOtK+cQ4+YKIkl/KcoAdwaHgPEpaH/jVCA8mMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214195; c=relaxed/simple;
	bh=hKwNMDfmL3T5qvk1MtGjKrG7bIQZsdaNVJEQAd1doIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu2Xc2HOinuPp/ZLKbdEJfZBvQAnML2Hf0e5iTHzRVawt7YhkRDQsr/w949GqzmMwL23n++Sev2WwISBOCwMS8vQZJLYlC01JGdKJThGj+XdvXIqRmvUy+6ugnoHrlSxeC2ubAjthxEhVp9G82aKrz46o/EhidUwusnUCXcF7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTzR00gE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA962C116D0
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 10:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761214194;
	bh=hKwNMDfmL3T5qvk1MtGjKrG7bIQZsdaNVJEQAd1doIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PTzR00gEdmgnykF73hJM1gmlYCoYKGsUzPYALQyoal+wwmQzzc76oYlT5E/Afl0S2
	 7Fh8HNwqpsxYZ8N/vQOJkXCNa7cS4IthTlDQRF0rOj8SOa+h6fKJ6UuKdrULTlf6YC
	 HYuKlW4Kx/AYR8OyfaDyScC8tZcCG4jd9TvkNrwrvVZL1xOC41EK4PZ6vS8BBvzhJc
	 Q6SF0Zl3AOi0AdsI/PiA/RdVz5v0SSlTMjfysub05ptiqd8SAvqfNIuXCXE4Nn6QhR
	 p6u8ULLEqHmMkVuznzK8vrRgdldVwdcrZ0BWBPiILcfmQUpEpG54x0sapCUBtd3lUZ
	 t9pmwbIkBw0SA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-443ac891210so296813b6e.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 03:09:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKCNjzpRtS+Wj64nvPIvnhRSkZywF+CByL/AjL2lVH8ApfqPBVgP8tQmKSVkpzI+J8Z0QRrGr+Ijfw@vger.kernel.org
X-Gm-Message-State: AOJu0YyS24wDGda3jpxfMcmtrS2rER0fbPw2JvR3+aUUguGhCd/alFXp
	bm7J1r8wTdRK4ly0BJlQRAFKbmU6jK1hzUNhKN1TWPEyqfctn3x7a9Kvc/H8hdj4jq0yIHNkK81
	tVM8RSMjJduj0cii7xNwHY7ywlqEKKw8=
X-Google-Smtp-Source: AGHT+IEjkqOio7lYamy/gjqOExHmFZfHeTGT8KkF7QrE37Pnkk7sstV+btTyQqkstdQSOgWa2ULZG2YnXym8MucJpL0=
X-Received: by 2002:a05:6808:4442:b0:43f:ba16:9fa1 with SMTP id
 5614622812f47-443a2f1b95emr10628027b6e.20.1761214194042; Thu, 23 Oct 2025
 03:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-4-lihuisong@huawei.com> <CAJZ5v0hNj817g=rr8+YTGaeBkkfNuuU7FGuZyyb1j61BMOKTGA@mail.gmail.com>
 <5caae4ef-e259-47cc-b0b7-f383dce4a334@huawei.com>
In-Reply-To: <5caae4ef-e259-47cc-b0b7-f383dce4a334@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 12:09:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ivydYPk8yxEUdXJe=uATq_1=__J560v3VApcXAv=f_7Q@mail.gmail.com>
X-Gm-Features: AS18NWBnpWRfnvZFYrmE5iws7xkscuUm3xX35DJh-iGD92yxIvp_1Qf-OqMzVIE
Message-ID: <CAJZ5v0ivydYPk8yxEUdXJe=uATq_1=__J560v3VApcXAv=f_7Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] ACPI: processor: idle: Return failure when get
 lpi_state->arch_flags failed
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:59=E2=80=AFAM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> =E5=9C=A8 2025/10/22 3:36, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.c=
om> wrote:
> >> The architecture specific context loss flags is important for ARM.
> >> And this flag is used to control the execution of different code
> >> flows in acpi_processor_ffh_lpi_enter().
> >>
> >> So it is better to return failure when get lpi_state->arch_flags
> >> failed.
> > A failure means no idle states at all.
> Actually, I didn't know why driver should continue to do cpu idle
> scaling if the idle state doesn't meet the developer's expectations.=F0=
=9F=99=82

There may be a firmware bug in one state description, but it doesn't
mean that the other states are unusable, does it?

> > Wouldn't it be better to skip the state with invalid arch flags?

> This arch flags is important.  And acpi_processor_ffh_lpi_enter will use =
it.
> There is no other place to verify its validity. so here do it.
> This check is just to prevent potential issues in cpuidle scaling later.

I'm saying to treat this particular state as invalid and skip it
without rejecting all of the other states that may be valid.

