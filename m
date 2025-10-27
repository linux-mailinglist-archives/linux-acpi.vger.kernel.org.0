Return-Path: <linux-acpi+bounces-18260-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC167C114A5
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 20:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1F41A61242
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721D31B81C;
	Mon, 27 Oct 2025 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpR5Uy6w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC53191CC
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595096; cv=none; b=NzlNv2wT0Jg88tGyb12d0fi4/K4/317dE+D3AGkfgSwcLZA+Fg1V6AHSzVow+7Bz8lZ3MdWqpPR96kqzh6Z6/nN5UsE/8fSDAHr4/cDIMD0azpYKUqrQtHZyn0OsWq9xJ4Jg6G5/Ppi5Phjef6LupKXpoMIoChY2Psoj2ZC4zgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595096; c=relaxed/simple;
	bh=21xoq8e2YTTavQ6QdYsPHyalJVLnJhPRkenyLIv5SbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nz/uzkwGvtUh5/kDJwPsl6jjOkN8t34qVZeOssqsEL+kR/h1TbW7sTXMNKfCBAg/nVpMGKwgzeKRe32Vww/zCfRMKy8ukHScV3D81VEJoUsFdi3Y4WzOpss9vz2kwSPi9YzMlE8mCE0/J5LphlbsyqxuBt6WzGkM6cGCgQNfh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpR5Uy6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468F6C113D0
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595096;
	bh=21xoq8e2YTTavQ6QdYsPHyalJVLnJhPRkenyLIv5SbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UpR5Uy6w6hBiFRCVd27VosrKk88eElfQrSGG6pc+age10GdCLj4gzRE9ZPR1Has+4
	 gvGujHlRoFvY0COjbnouzE2OyQPFt8qmNKHDu5cMvUQlhXkVvlmRlpw2xF8vJa7VbP
	 4lcZeSrUxXlx2a89CPsFfj1vZV6oI3tF+GaeFaxiKVqsKazEPQE/sIm1aMp+25k2sZ
	 ER7JQKFke0h/V0tvBJB05gy4sFeXuwZVVz/mnBxKp7Iiw4IFR5PkG337kioI8PBBho
	 WBt8rHR2YS56734GG/1/mVDuteJtI00FwnDnohH1mlyG95Ul8o1ghkbieV9hI/dpOm
	 n/FpyR8VnV7ew==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c53038fd99so608806a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:58:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGv/4u/tdSThrUNlbWlC/0WFw3mcJq8Nab8OU3fFnVjqCFbczeauvDg3nt/NaXRUq0WM2F+MhRCcra@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2VxwczgYuJxGcRuK/QyW430H4EzpJpSUH7smJQfHBo7h2nER
	XRH5MHgwCjkz8Uz5IOo3p3mCjpUm55Ztk/Kb/yghGYlnIY5Zxzs2rshGF4hF7aMFgPNuHtVLXl7
	SC5g8bfeyRkFeSuyob4qEaGQBt79arBQ=
X-Google-Smtp-Source: AGHT+IG7XzLriJJDxti4WCeIyZqCbp7IJ2wjld9yaoPJNtGQuTuKHIfgD/v32caY4BObbIP3IC6kx5ThRh1gk5Vcww0=
X-Received: by 2002:a05:6808:3006:b0:43f:6790:f150 with SMTP id
 5614622812f47-44f6b9c7ff8mr445463b6e.9.1761595095640; Mon, 27 Oct 2025
 12:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024183824.5656-1-W_Armin@gmx.de>
In-Reply-To: <20251024183824.5656-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 20:58:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0juvqnn0A7pwpijhWkLDZB8U31T3J96a_Cr_RPN8C88iw@mail.gmail.com>
X-Gm-Features: AWmQ_bkk3K32kC2ieLv1aZ8czfnAIizdnOXET_I2Hmzs7y-FnaivqLxBwSS5abE
Message-ID: <CAJZ5v0juvqnn0A7pwpijhWkLDZB8U31T3J96a_Cr_RPN8C88iw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ACPI fan _DSM support
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:38=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Microsoft has designed a _DSM interface for the ACPI fan device [1]
> that allows the OS to set fan speed trip points. The ACPI firmware
> will notify the ACPI fan device when said trip points are triggered.
>
> Unfortunately some device manufacturers (like HP) blindly assume that
> the OS will use this _DSM interface and thus only update the fan speed
> value returned by the _FST control method when sending a notification
> to the ACPI fan device. This results in stale fan speed values being
> reported by the ACPI fan driver [2].
>
> The first two patches add support for the ACPI fan notifications as
> specified in ACPI 11.2.3. The last patch finally adds support for the
> Microsoft _DSM interface.
>
> All patches where tested with a custom SSDT [3] and the acpi_call [4]
> kernel module and appear to work just fine.
>
> [1] https://learn.microsoft.com/en-us/windows-hardware/design/device-expe=
riences/design-guide
> [2] https://github.com/lm-sensors/lm-sensors/issues/506
> [3] https://github.com/Wer-Wolf/acpi-fan-ssdt/blob/master/ssdt-dsm.asl
> [4] https://github.com/nix-community/acpi_call
>
> Changes since v2:
> - drop already merged patches
> - add links to the MSFT documentation in patch 3
>
> Changes since v1:
> - use acpi_evaluate_dsm_typed() during _DSM initialization
> - send ACPI netlink event when after handling a ACPI notification
>
> Armin Wolf (3):
>   ACPI: fan: Add basic notification support
>   ACPI: fan: Add hwmon notification support
>   ACPI: fan: Add support for Microsoft fan extensions

All applied as 6.19 material, thanks!

