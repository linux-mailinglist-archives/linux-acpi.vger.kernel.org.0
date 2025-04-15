Return-Path: <linux-acpi+bounces-13050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BFBA89F88
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A3517E246
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64056144304;
	Tue, 15 Apr 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUJM4pyE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81A1BC4E
	for <linux-acpi@vger.kernel.org>; Tue, 15 Apr 2025 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724082; cv=none; b=vGP6f8C/mnfX/7vzgfv+Mrn1t01FSrwnf0haHSZewePyHrwxSzGZSjrD2CdiCbs6r/1Xx1BRIUFJzoBGApAqUbitKboeyBiOJPpgqB3W8gfv+sBm4YN37yU0nUSCYolocv8cfV0rBxVfMqiARN2vII/7Fd367S+3zu3TRbaneAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724082; c=relaxed/simple;
	bh=OjK0XJ46y3jXAILf9s+jwpNgMQ658DzTtoQ7CdC3VPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLC5IBVndpapkOnWJvIYFyx1/WoNoBFSuCRHecoiLgelrjxdNx4ngZEgIyxXmXHl9C+XmnpP1JolFNM3+hOHAAkPIMZLTqkwh6LiTJ0Kqu9G6fpuLsmwFk3QBYuk9R4jE9hj6TPfgH7pQPQxLMa3voXxhC2R/d0CvTYuoYuWcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SUJM4pyE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54d3ee30af1so5427300e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 15 Apr 2025 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744724077; x=1745328877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRbWLe8uR6+Ruh67h/yoUWYHHmofvLoQK7bKV1fiz0s=;
        b=SUJM4pyEPzwHkAaUe8NOhwuoxMyJpfQ2ftc2ecJVQCWkVGXrozPU4vyeNkG7tdI1e0
         PlPRYs/VWnvxBa4Nh3SjpEZVxNUbGXZgzXszpL8BRv1jesfjJW+MJVg5e2Iau9EbsoDZ
         dFH+v+fNWSDE51GEsQjCpwSa2mplJnMXty06NRIUwO5Q53v+WHqXaH+Rtk71HzXplW68
         LcfgL70P4QdenulPlY+MPpYSqNsHkennGIEoYOMn5qL24SnPpA/YbUCiwSjAhfYPz6kn
         c/2pSW+eYmxOwm6OsCVTaJ3azB2jZRqDGTkY1fMTcSulEPPczfFAWjgGT0Q08fplb4wr
         8gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744724077; x=1745328877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRbWLe8uR6+Ruh67h/yoUWYHHmofvLoQK7bKV1fiz0s=;
        b=JlUD9z0KG+nzZF5XvE1XbvlwovFldGJCG1H9V8+Op8ugWo+SltmhdVEQQRs81R70ax
         HlMWvCtlG3E8MZ2XcG49fgqDesX0nDO0dHaNUP0cPoP2S4Xqnjy6iZCTVftdLRIatAHx
         g4qangKdsO4Q11RdMG4Hbh3ToDFwsp2DoRCa+4REjEuhPzNQCzpWnbTQOhTLfIeA+gGL
         L7CCPb33Ealj/xGBeEsiiz5Ueydoiw9yYqLdwh79I+sZ1FKH99VBmMKQaqljmgIaXCTE
         d3thocFBecDvtPXdWqMMSBjHlV4+vmWkm7yFlugBdeu085PR+i44M8F0+n5/cPM2xFBH
         mjjw==
X-Forwarded-Encrypted: i=1; AJvYcCUhatVoNLAzJ52Wu8hOKAyGqPgLjJAsdMGpQXzhDHM561fymfmeaFlU1xvOoBRRpuFm2SxCydMDx4N7@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMbDpxakIXTeRdLMF9z0WLS3closdnzMZ+lbqGS4EYYz69+Y+
	Aicnyt+J2L62pbJP7FwsK4ljKqPmx6QGj7fr4A7A/mHghnuKpeqD6Qc1MMeqdvFr9jFCzVg2pZ6
	jBtLrARIG01Lgv/Z/9oZBCBgxVO5mojsWO/Mmkw==
X-Gm-Gg: ASbGncuUlJBydW04AnoB0+aqxbUTBO5hTxhB4ag/csyj6xa11Hle7BibunDZQJWIuTG
	dnhdJ8lhDnZeEGebetcfOlgLWWcHpMLa7IJX+jcnnFzP1G+VZ3uAvVrEW+GWp4j7Te5j7EEQnh7
	Gx2sU5dCIhD/lKhRdpUGH4uQ==
X-Google-Smtp-Source: AGHT+IEqPbPcf25mevdtkKDV6Fu+XRejh24WiH4D40O8WO7gYV8t0TQe0MF4yA5cyBf8Yjg2SvmSG81yhNrMiWcs3lg=
X-Received: by 2002:a05:6512:1106:b0:545:2f97:f6e9 with SMTP id
 2adb3069b0e04-54d452ca7bcmr4104272e87.42.1744724077079; Tue, 15 Apr 2025
 06:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414203551.779320-1-superm1@kernel.org>
In-Reply-To: <20250414203551.779320-1-superm1@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Apr 2025 15:34:25 +0200
X-Gm-Features: ATxdqUGANNzFO3svuoLX47zpuOlc5Ol6z4O2iG_JyD2ta49DsLYE47fIs0OLH-k
Message-ID: <CACRpkdaHru55wo5MdVsRKRbfPS9Hv3vGxgXNi8eXGvAOQzyDww@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: amd: Fix use of undeclared identifier 'pinctrl_amd_s2idle_dev_ops'
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 10:35=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> `pinctrl_amd_s2idle_dev_ops` is hidden under both `CONFIG_ACPI` and
> `CONFIG_PM_SLEEP` so the functions that use it need the same scope.
>
> Adjust checks to look for both, and while updating make it CONFIG_SUSPEND
> instead as that's what the acpi header uses.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp@i=
ntel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  Use CONFIG_SUSPEND instead of CONFIG_PM_SLEEP

This seems to be based on the previous fixes merged by Rafael?

Do I need to rebase on -rc2 or something to merge this patch?

Or can Rafael queue this too?
In that case:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

