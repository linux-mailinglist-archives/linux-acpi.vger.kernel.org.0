Return-Path: <linux-acpi+bounces-17133-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8F2B8937C
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40051C84D4E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A9F309DCC;
	Fri, 19 Sep 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWcfFmck"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E32D7DDE
	for <linux-acpi@vger.kernel.org>; Fri, 19 Sep 2025 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280660; cv=none; b=R5VROQiriV977PE34bu+IYegg6+NVYahkclP2B9lpBzSiIOXM1cEz1uJOjc5QIh+W1a0M9J4MqtEZG9z/XT+UryZfZvmlN7ohOSsgWl6SBmYrOhzN/hjxAyD/rkPLR3gcQRM1tFKTQNAGQIKDTSMoh5mjiMNJrpZJRxcG23klew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280660; c=relaxed/simple;
	bh=Vaud0O8IF+cM6zsU7m0GAhHij4l8NSs29t6OEhwoN6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXTGqirtZAPg3UVCDYi2AQ35BndyJ3ya97pKx1z4Gxrejl75/bDpy8XOAabboD4GiNJwnsFeOl6sC/sYYDNasvioxd3NaSwGAeAzbpc6xqL7fHpoV7gQSlJVDUl78PxAYqLNe/qtr5cGWnFVyOT1uUdIVSYVlHcBZyGC1kQiDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWcfFmck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5896C4CEFC
	for <linux-acpi@vger.kernel.org>; Fri, 19 Sep 2025 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758280659;
	bh=Vaud0O8IF+cM6zsU7m0GAhHij4l8NSs29t6OEhwoN6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lWcfFmckr790LqTCMGYE+AL1AIF/8SqGJsge1klImtZm4DwB+eUUy6ey2bJaUGpSH
	 9HzDpUIy+MGtaSOwnIv+abNw0TIlujl4HnX/W47Wt2xyJT0quTLGDLNubTmwhskfAw
	 3WowSFJb9oJcWFu6QKSO66tz1HuTxQ2pN+xV6vWEREmXb7wsop7XsiFRt1n3kEprC7
	 xzYQGx/qpWbxM51DdtfWiq21cUhNcmQxSW4GFpbsWWWBSNqxG69vZEV4Tej/U66caY
	 SRHIVk7jjEgKAPH5QzX9447/eUrDujAMrw6U7vo8W5OVW9XnET9ULILO1uEDBRGQmD
	 kPr7Nr6clgpQQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74526ca7a46so774312a34.2
        for <linux-acpi@vger.kernel.org>; Fri, 19 Sep 2025 04:17:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZ2y347Ml8iiC83hK0riPrgmpqtv89BV/jVIS17Py1vCk4vJfn
	mAYZZNNqjTOe8/yTvzOWmC0x7IIVHGiHTLLjokQWXNF1og08dJ9D2X1qIqmR57M1GtRimXwaojS
	VRPxVsDOvFjRB4eWCmJ2kWd5RmelxxOk=
X-Google-Smtp-Source: AGHT+IFHub8sAhDtx00+bZA9mzQXjdt2cEFV/Pwup6zDiM5Pg/pEUPft9nLsR2ahNSrGmpZztuhjghOoJorynxxbYWQ=
X-Received: by 2002:a05:6808:4f11:b0:43d:1fcc:1f95 with SMTP id
 5614622812f47-43d6c1afb0cmr1227513b6e.17.1758280659033; Fri, 19 Sep 2025
 04:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5926523.DvuYhMxLoT@rafael.j.wysocki> <5044465.31r3eYUQgx@rafael.j.wysocki>
In-Reply-To: <5044465.31r3eYUQgx@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 13:17:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gXHedm9WwwMuTN7vYyf5fNB6yOGLp_-GxSoZAEhSx5aw@mail.gmail.com>
X-Gm-Features: AS18NWBm-VmRoWBy_7-K7-h195TkFeNXXbDtndqHGxwT6hO2srJMeO9xZMiNJqw
Message-ID: <CAJZ5v0gXHedm9WwwMuTN7vYyf5fNB6yOGLp_-GxSoZAEhSx5aw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: processor: Update cpuidle driver check in __acpi_processor_start()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Huisong Li <lihuisong@huawei.com>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
> driver registration") moved the ACPI idle driver registration to
> acpi_processor_driver_init() and acpi_processor_power_init() does
> not register an idle driver any more, so the cpuidle driver check
> in __acpi_processor_start() needs to be updated to avoid calling
> acpi_processor_power_init() without a cpuidle driver (in which
> case the registration of the cpuidle device in that function
> would fail anyway).

It's worse, it won't just fail, it'll lead to a NULL pointer
dereference in __cpuidle_register_device().

I'll update the changelog while applying the patch.


> Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver re=
gistration")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Commit 7a8c994cbb2d is only in linux-next at this point.
>
> ---
>  drivers/acpi/processor_driver.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -166,7 +166,7 @@ static int __acpi_processor_start(struct
>         if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>                 dev_dbg(&device->dev, "CPPC data invalid or not present\n=
");
>
> -       if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acpi_id=
le_driver)
> +       if (cpuidle_get_driver() =3D=3D &acpi_idle_driver)
>                 acpi_processor_power_init(pr);
>
>         acpi_pss_perf_init(pr);
>
>
>
>

