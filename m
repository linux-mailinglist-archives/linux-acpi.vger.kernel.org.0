Return-Path: <linux-acpi+bounces-19566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F2CBDB57
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 13:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D653060F08
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720383D3B3;
	Mon, 15 Dec 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnOzE8vr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA282C0F97
	for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799862; cv=none; b=Mnz+bMSkAXsvEi+/liflAiGEcorZNVQO7B1OWNbLZtVF8wrlxdbwJOP0pmiWnZ4baGBO6f6gIXwSBGN+1h3N8DwvHJa7FePW8oeEs3ZYvH+j3CpORVwHo7ox/1uHogCJWw6SjCalzY3/rLn+I9K4U+SfWXyiMjQooTYDSkussdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799862; c=relaxed/simple;
	bh=nONM6aBwOJ4qy0ihAUIUyALY8JxV7t9wDL5VQ/olz1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbMzcz8EbpsZs7aFDwQoELkgoYQvMuGvRJRNCSEmEnTPU9wNV9EpbhNPQ3xDZt+algWxUE+aybBzoPNO3nF0I62qAobg12818jjZRw/ymUNt0CYDgz3aaKK1o6pIqPiP4kMzSisJVIafEQXIO2bVzt/NwEl0e3mKOassOjiJoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnOzE8vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3D2C4CEFB
	for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765799861;
	bh=nONM6aBwOJ4qy0ihAUIUyALY8JxV7t9wDL5VQ/olz1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JnOzE8vrgDUlWmB1SDDzrYBEjiRZ/LPVHbizVYChFlBnvACFinYsatS6Gr483kFSb
	 NKaNg3tn4iCZANmyqGHT7Feq7l0iUDj/nST7btG4TLcD+esIuP1+2gV8sjPpfdMmDm
	 ThMf/iiAFWowLe7a+JiX0qJyc/IrZ0fqE2q5H8DZr6yWAl6CE2OmpuM0/Y6yBtf1Nq
	 Awpo8Lu65X7+IH7ouqntUbGti7k2WUTovfOY1cTxuK+kwiJqz8RJj6cOBmu17Qqc11
	 wrxRP0PjoNzdYUNWuQP+Ik7x5TI1VhfhBivsrQk2Jt3OHYt+d5R6sRcWvB/7t5Lkpf
	 vw3WzVoRZ0j5w==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-65b2cc63b0bso1944762eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 03:57:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOBEZiekId/aTJC6aJUhrfDj/NqTm+H+fUMqtyDPqj7PxmZYXCdq6YCWWS66IYmOpWAyeTWdW0c4f9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WpaShN+swYH819KSNqcQC7OuBDlK5tWLF9mxkkexD1+JCy/w
	22VNRYrOJYVxeeFwx1PdQhOUB6ikWuVP0OSL7gWc/SqCEd/J1NJnFNCJPt6GAFdds2AaPb4wTqK
	F+KNU1U2L4MxPk3htlxpP8zA18UP4Do4=
X-Google-Smtp-Source: AGHT+IGaTr/AyyXy8Zr8u3Eb/dznf5nGFmJZTO4pESJEDoGc7wALvM0p/PZFdfJdWOpzz/s7Vr5mWNXAtL0H+b2MCLo=
X-Received: by 2002:a05:6820:2299:b0:659:9a49:8efb with SMTP id
 006d021491bc7-65b4511f730mr5031013eaf.12.1765799861213; Mon, 15 Dec 2025
 03:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210132227.1988380-1-zhangpengjie2@huawei.com>
In-Reply-To: <20251210132227.1988380-1-zhangpengjie2@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 12:57:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hARyNh3FpfRNN0F=X1Yg0=3JS-yzC1ufkzt9i49nzfjQ@mail.gmail.com>
X-Gm-Features: AQt7F2rRMxdOZ-DhjBnsP4hVQttJ65lNvrE-nCh9ZWOMUo8RGWxlGmt4lW1plsI
Message-ID: <CAJZ5v0hARyNh3FpfRNN0F=X1Yg0=3JS-yzC1ufkzt9i49nzfjQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Fix missing PCC check for guaranteed
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, srinivas.pandruvada@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, linhongye@h-partners.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 2:22=E2=80=AFPM Pengjie Zhang <zhangpengjie2@huawei=
.com> wrote:
>
> the current implementation overlooks the 'guaranteed_perf'
> register in this check.
>
> If the Guaranteed Performance register is located in the PCC
> subspace, the function currently attempts to read it without
> acquiring the lock and without sending the CMD_READ doorbell
> to the firmware. This can result in reading stale data.
>
> Fixes: 29523f095397 ("ACPI / CPPC: Add support for guaranteed performance=
")
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3bdeeee3414e..e66e20d1f31b 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1366,7 +1366,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf=
_caps *perf_caps)
>         /* Are any of the regs PCC ?*/
>         if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
>                 CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_r=
eg) ||
> -               CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg)) {
> +               CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) ||
> +               CPC_IN_PCC(guaranteed_reg)) {
>                 if (pcc_ss_id < 0) {
>                         pr_debug("Invalid pcc_ss_id\n");
>                         return -ENODEV;
> --

Applied as 6.19-rc material, thanks!

