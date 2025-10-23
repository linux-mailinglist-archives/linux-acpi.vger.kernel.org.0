Return-Path: <linux-acpi+bounces-18138-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C12C0065C
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 12:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594253AAED1
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 10:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6FA303C85;
	Thu, 23 Oct 2025 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krt2trI/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B893009F0
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214051; cv=none; b=S/ie5iM49YLqshBnS0j0yGuQSpYvK7V7grykWsLSlTiQe7z7Ba7fb9nM3xMA1KKn9wFSeB4YI0F77fS9C3Jk4vghB4QeecnWFjbf9btURJ36riAzjti7J/T5otx0klNJfOOaZZ2B+AscQPBJj9S8yXazSxyhC9gOpgtiaZoGaS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214051; c=relaxed/simple;
	bh=B1PHNlrky4sCJBzOw3//MmXWGvDE05Rd2g/tIIXDc9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWP/66r+vPgqZByF5JLk1JIzOU78ukuGOKIGeCnID/5/CX1YDkAK0n9mPk1gnFrXcY2z5p/4jP5mITzqkHMZXPXl3NJ3S7ZbJcuXD4pOGij3AaZT6qmNBMJ+D+0ZqK3YQffrSOq5o912OHAQzUr0MqiTyQXqAHPVvVjPs7LLHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krt2trI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F5DC113D0
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 10:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761214051;
	bh=B1PHNlrky4sCJBzOw3//MmXWGvDE05Rd2g/tIIXDc9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Krt2trI/DhCMlTdYUss7+9FPxnAQZUWutxP8sCaRV9GwxLUpWCq75DzkGvfRvOik6
	 vWXdbarkOPw1UQfXcj1ELN8IUyfMSYwYOSuJwmclgDdsqCzMFSErhoUsvg6Jmgk1Ir
	 5DEjJVyKJszhxU1f6NRiJVKSXhCO/OH9fyZn+dcNmC9F5wZ0i0RLG0SpE0Uqb1EwPa
	 zSSiGZWShsZmqoLeYjEjuAC29q5E6rXAOMkwAdCa5bbw6o+S3Zj7N3Zs/o7+cB+KM1
	 9g3MXPt+Zgcr2hq64hOh/6ebD/JHabmu6KeoFrzPClc8vo5A1AyslTPBaTkfAtCKAw
	 TLYMMtbKhQKJQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c2804d48caso1244537a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 03:07:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeent7xHIdup2EF+NwOKCBwv+5+XU9+Q1uD9m5ir+zImuCYxQnVfXmPphLryBL22QCeShsLtzrEvQG@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLPUhMfOdL9jEdUkWf/1lCSAtLXQpE69sobtogAG4br5CEBze
	7bLHNG35ua9l1Bee0cBYgRHJWecJ9ijnDcYLReeaF8B8yP4fbQr8EPyTjARFcyYfLsWUen56JoU
	jar+MyLa1sX3I3kQ/vUFtXN5NgsbZqv8=
X-Google-Smtp-Source: AGHT+IG0ae7Qms3f1G1dE9GP3KrK4bkl4jN6bPTD+sZOvg405u8utM0JLlryffK8EiHfs9ilGOS0QPfDOwE2sixZ7jQ=
X-Received: by 2002:a05:6808:178d:b0:441:8f74:eff with SMTP id
 5614622812f47-4496556aef1mr2665901b6e.28.1761214050404; Thu, 23 Oct 2025
 03:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-3-lihuisong@huawei.com> <CAJZ5v0ikPpwKA4WLvwon3p+e8+53fOQuudOioOr-KD-Ee-E0dA@mail.gmail.com>
 <8c0057a7-24a2-493a-8054-904a89ca9f6d@huawei.com>
In-Reply-To: <8c0057a7-24a2-493a-8054-904a89ca9f6d@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 12:07:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jg5RGi-+i3LtwK6U8m+_C5Rs4OuRTBLTGi6g0aRq3LBQ@mail.gmail.com>
X-Gm-Features: AS18NWDg1bN7eNw3LoEF0h9s99kRoyakT3JZHHpUIWO0B3SwYGOYTFhXBckoMwE
Message-ID: <CAJZ5v0jg5RGi-+i3LtwK6U8m+_C5Rs4OuRTBLTGi6g0aRq3LBQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] ACPI: processor: idle: Return failure if entry
 method is not buffer or integer type
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:25=E2=80=AFAM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> =E5=9C=A8 2025/10/22 3:34, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.c=
om> wrote:
> >> According to ACPI spec, entry method in LPI sub-package must be buffer
> >> or integer. However, acpi_processor_evaluate_lpi() regeards it as succ=
ess
> >> and treat it as an effective LPI state.
> > Is that the case?  AFAICS, it just gets to the next state in this case
> > and what's wrong with that?
> The flatten_lpi_states() would consider the state with illegal entry
> method sub-package as a valid one
> if the flag of this state is enabled(ACPI_LPI_STATE_FLAGS_ENABLED is set)=
.
> And then cpuidle governor would use it because the caller of
> acpi_processor_ffh_lpi_probe() also don't see the return value.

So the problem appears to be that lpi_state increments in every step
of the loop, but it should only increment if the given state is valid.

