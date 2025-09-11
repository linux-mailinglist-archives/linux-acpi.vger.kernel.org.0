Return-Path: <linux-acpi+bounces-16653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01CFB52A63
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52976171E40
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE18C285C82;
	Thu, 11 Sep 2025 07:46:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5232B672;
	Thu, 11 Sep 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576761; cv=none; b=SUyk5nEDKyvElT8BVCSWjEBCn7V8CCputAi4qYyBcZB0fbMwxMuFnzhgcXggsLJsOcUgDZ9cHRosIWqGfdP0T9vLkJ0kvPbuXo0yUAsCgbkOWCHlSV8iqXt+jvrO+YDy+Z1kS4Mw3ELxk1Jpfjq4CJl0JAzcfJLSYWWdagLTuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576761; c=relaxed/simple;
	bh=vkIGQbHkugE0tGswCHkXzir8pJjgyHbVzjLHSc/Y/U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6IiXEZtpSs82/9yJ8jVex6xVii9S16JaRmA2MtFnR60p2J/rJ30tDtJEUl/sRk3WyFrw7C8VzFiwIUYmYKCmCTX97FgxtGpMRZomVxbVjHaJqOMV3tVDGyN9eUGBwJTzEOzyVkqUzBMmcojiHrTp5+ux/8mdCjTmmIth4fnCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 534404b48ee311f0b29709d653e92f7d-20250911
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c5962ed0-bfaf-437b-91dc-b5969a4463ea,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:c29d9a1ff7d9b3695e5edbfa991638e4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850,TC:nil,Content:-
	10|-8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 534404b48ee311f0b29709d653e92f7d-20250911
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 149988089; Thu, 11 Sep 2025 15:45:45 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2870BE009008;
	Thu, 11 Sep 2025 15:45:45 +0800 (CST)
X-ns-mid: postfix-68C27E29-117221580
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 29335E009007;
	Thu, 11 Sep 2025 15:45:44 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: hansg@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	rafael@kernel.org,
	stable@vger.kernel.org,
	zhangzihuan@kylinos.cn
Subject: Re: [PATCH v1] ACPI: video: Fix missing backlight node creation on
Date: Thu, 11 Sep 2025 15:45:43 +0800
Message-Id: <20250911074543.106620-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <de4b5ec6-1e42-44b8-b5d3-5a452d7401ef@kernel.org>
References: <de4b5ec6-1e42-44b8-b5d3-5a452d7401ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>  Oh wait, now I understand the trick is that you now return
>  acpi_backlight_video without setting *auto_detect =3D true.
> =20
>  Which in turn causes this code in drivers/acpi/acpi_video.c:
> =20
>          /*
>           * If backlight-type auto-detection is used then a native back=
light may
>           * show up later and this may change the result from video to =
native.
>           * Therefor normally the userspace visible /sys/class/backligh=
t device
>           * gets registered separately by the GPU driver calling
>           * acpi_video_register_backlight() when an internal panel is d=
etected.
>           * Register the backlight now when not using auto-detection, s=
o that
>           * when the kernel cmdline or DMI-quirks are used the backligh=
t will
>           * get registered even if acpi_video_register_backlight() is n=
ot called.
>           */
>          acpi_video_run_bcl_for_osi(video);
>          if (__acpi_video_get_backlight_type(false, &auto_detect) =3D=3D=
 acpi_backlight_video &&
>              !auto_detect)
>                  acpi_video_bus_register_backlight(video);
> =20
>  To immediately register the backlight rather then waiting for the nati=
ve
>  GPU driver to call acpi_video_register_backlight() after the native GP=
U
>  driver has completed probing for native GPU backlight control which is
>  often preferred.
> =20
>  So as you say the issue is that you have no native GPU driver calling
>  acpi_video_register_backlight().

I'm very happy that you got it.

> First of all I assume that there is some sort of builtin GPU on these
> Lenovo and Inspur machines with Zhaoxin CPUs. Even if the GPU driver
> is not in the mainline kernel then I assume there is some out of tree
> driver. Can that driver not call acpi_video_register_backlight() ?

We are currently working with Zhaoxin on this matter, and we expect to ha=
ve some results in a few days.
I will keep you updated once we have progress.

> If this is not possible then we will need to add some quirk based
> on CPUID matching e.g. something like this:
>=20
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index d507d5e08435..24dd79ec1b72 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -1011,6 +1011,18 @@ enum acpi_backlight_type __acpi_video_get_backli=
ght_type(bool native, bool *auto
>  	if (acpi_backlight_dmi !=3D acpi_backlight_undef)
>  		return acpi_backlight_dmi;
> =20
> +	/*
> +	 * ATM Zhaoxin CPU systems have no native GPU driver, instead ACPI vi=
deo
> +	 * should be used to control the backlight. The lack of a GPU driver
> +	 * means that acpi_video_register_backlight() will never get called
> +	 * causing things to not work.
> +	 * This special case for these systems returns acpi_backlight_video
> +	 * without setting auto_detect =3D true, causing acpi_video.c to
> +	 * immediately register the backlight, working around this issue.
> +	 */
> +	if ((video_caps & ACPI_VIDEO_BACKLIGHT) && cpu_is_zhaoxin())
> +		return acpi_backlight_video;
> +
>  	if (auto_detect)
>  		*auto_detect =3D true;
> =20
>=20
> Note you will need to provide a cpu_is_zhaoxin() helper for this.

Thanks a lot for your patch and for looking into this issue.

At the moment, we are still confirming with Zhaoxin whether this behavior=
 is consistent across all their platforms,
so we are not sure if the special handling should always apply.

Also, on kernel 5.4 these machines seem to work fine without requiring a =
native GPU driver, while on 6.6+ the backlight node is missing.=20
Could you please clarify what design change or intention caused this beha=
vioral difference between 5.4 and newer kernels?


