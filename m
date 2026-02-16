Return-Path: <linux-acpi+bounces-20996-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI9nBbJSk2nA3QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20996-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 18:24:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F1146B0B
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15F163007884
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220042DAFCA;
	Mon, 16 Feb 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbXL59ov"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B92D8780
	for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262639; cv=none; b=QDBNVJfxcgfLA9L59+GKgPAko8+IGtkscLWqzQ+Qqjue3KpUzpwe69iS+WSmvP4oQdp82kV+zJPCZ56RmUUrsVH6BY6a8da9G6HNCA6+2tApEulAJUwnkMng1F2QPj24QosKZqBkQ1onNYcZED4IE4GoLCOwckz2LuvsvsaXOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262639; c=relaxed/simple;
	bh=RINJtXiPmmUwqsBlwCjLXIf10CuuhqNUna2flXP8Uqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMqYk19ITl/ZwxHDeKRwjwLsCFRnpAV8+fkon663AAU0elFc66p8Fsy5/paJAnDksYsBTUX6STkCTpf0Pv4dZx2F6iKLNiMgS49E87vSji+PsIX3bGNrtxA4UKisg7T1CeYnvIlPZ9JEqbynt8io3VwFabkzeAGF6XJp38OcTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbXL59ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957C4C116C6
	for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771262638;
	bh=RINJtXiPmmUwqsBlwCjLXIf10CuuhqNUna2flXP8Uqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZbXL59ovSPS/DdOQFRIt1EehnZk4wsNRE0obRrJOoenTKAV4+wD+bp2m+P9daPXYL
	 +tzttrt96is53R89qgySTXo0ZQYdA3ixiZKm95JhDFgpFkGx4Udoy2od51FKqni/0c
	 E6UCvaA1T7PscnZEml3GK7+vkc6j2itvKZIQvnd6ZKctb8pMy/GgfHAf8joX/ReKZp
	 89dRuEy5byPPtuWCgptPSjpWMh6y+DJWqMNrkZ2URVelySZQ7HzCze11507d2L7jwE
	 RKrspltuPwU9SYU6HjVki/uZyFU8zJxyVWXlQajZZAcY4QOlRMl0kjr4bqcDGyu3lh
	 cMkvx5/9uhy1w==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c9537f90so1929303a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 09:23:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWEeLJgEYzFrHGlRV71SyVVzJ8S4jAcGdwuvG7MWujuaAdjaZlz8UnSDB21eCIRK/1+7eLr46JnTru@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXwLQNK4afmG+GdWVNl4l1zJ1mhTK/YNUFbfVydAETJ4z7BaE
	haQM1+PIM/4fDss4chhAo9FiP1N/GYQKkLzg/D+7AlzAkrPasU08HDMCFptV0Ae2bOjafCMC7VF
	H64mG9TtzltNHRxH0VLg6XflxgFIAZeM=
X-Received: by 2002:a05:6830:40c5:b0:7cf:d2f3:af8a with SMTP id
 46e09a7af769-7d4c4b0cd83mr6421985a34.28.1771262637703; Mon, 16 Feb 2026
 09:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0785a7c-7e4c-434b-af31-4ec6f690ed89@126.com> <20260214161452.2849346-1-bczhc0@126.com>
In-Reply-To: <20260214161452.2849346-1-bczhc0@126.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Feb 2026 18:23:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jQiE35RibRUnze7563Q_7RsQ=i3mzBSs1hPR15de8boA@mail.gmail.com>
X-Gm-Features: AaiRm51BAs5kVNc_Ik3zkjCNPSf-xV-CixVyraMuJyGiXz2VdBucG2puDG-aEaA
Message-ID: <CAJZ5v0jQiE35RibRUnze7563Q_7RsQ=i3mzBSs1hPR15de8boA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Add unused power resource quirk for THUNDEROBOT ZERO
To: Zhai Can <bczhc0@126.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20996-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD7F1146B0B
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 5:15=E2=80=AFPM Zhai Can <bczhc0@126.com> wrote:
>
> On the THUNDEROBOT ZERO laptop, the second NVMe slot and the discrete
> NVIDIA GPU are both controlled by power-resource PXP. Due to the SSDT tab=
le
> bug (lack of reference), PXP will be shut dow as an "unused" power resour=
ce
> during initialization, making the NVMe slot #2 + NVIDIA both inaccessible=
.
>
> This issue was introduced by commit a1224f34d72a ("ACPI: PM: Check states=
 of
> power resources during initialization"). Here are test results on
> the three consecutive commits:
>
> (bad again!) a1224f34d72a ACPI: PM: Check states of power resources durin=
g initialization
> (good) bc2836859643 ACPI: PM: Do not turn off power resources in unknown =
state
> (bad) 519d81956ee2 Linux 5.15-rc6
>
> On commit bc2836859643 ("ACPI: PM: Do not turn off power resources in unk=
nown state")
> this was not an issue because the power resource state left UNKNOWN thus =
being ignored.
>
> See also commit 9b04d99788cf ("ACPI: PM:
> Do not turn of unused power resources on the Toshiba Click Mini") which
> is another almost identical case to this one.
>
> Fixes: a1224f34d72a ("ACPI: PM: Check states of power resources during in=
itialization")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221087
> Signed-off-by: Zhai Can <bczhc0@126.com>
> ---
>  drivers/acpi/power.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 361a7721a6a8..7da5ae5594a7 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -1113,6 +1113,19 @@ static const struct dmi_system_id dmi_leave_unused=
_power_resources_on[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE Click Mini=
 L9W-B"),
>                 },
>         },
> +       {
> +               /*
> +                * THUNDEROBOT ZERO laptop: Due to its SSDT table bug, po=
wer
> +                * resource 'PXP' will be shut down on initialization, ma=
king
> +                * the NVMe #2 and the NVIDIA dGPU both unavailable (they=
're
> +                * both controlled by 'PXP').
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "THUNDEROBOT"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "ZERO"),
> +               }
> +
> +       },
>         {}
>  };
>
> --

Applied as 7.0-rc material, thanks!

