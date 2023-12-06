Return-Path: <linux-acpi+bounces-2186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF1807969
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 21:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084E01F215B9
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3734B14E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:34:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF3AD59;
	Wed,  6 Dec 2023 11:55:30 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58de9deec94so14890eaf.0;
        Wed, 06 Dec 2023 11:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892530; x=1702497330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmG3e05eNFihieNPUsvLP7f1xh7CG0y4yEuuvc3VlKM=;
        b=e4LN0OsZ1tGS6Rl/y2UzAcA3qZR5KZyP+bd0zdVHjC4Qq4QBrmwQ4vTDRFUD170HQG
         EDuFnaEXg3KU//AIw49RpC8RIEgBBgK0G7m1+0YTH7CPSLBTWWZeVSkcP+jvf1JwHPFg
         WQ43FzRJ3sPqEWNxdc58askBvAujkGCiC2QtrsuYAvyvte3vdp8XxtdTHmCUtuoT8uOa
         QgsiXs3cEEJWZe30Xtq+ZQGVC86dhxKUaFukN4tcOmyOB38FVymes+BXYrAzy2pbaQig
         tNPWPs89/BJW+Z6cACsDrf8XGfAxGsxugvzJ1CR1ys/tRXkiVImBftrfoYyeimV8BWm5
         8J5g==
X-Gm-Message-State: AOJu0YySb+hViqm7aOQEoK8aKKAFpJP/LBdPwYL6CTgcYWfpFFUqKjQb
	ZGH90HWSx3CaVo2WJkXAybpaXwAedUGpFwEVDk0=
X-Google-Smtp-Source: AGHT+IHyMr6+r2/YoZz+Q/+3l39D/TqgGUhDcKK/J1NR/8Y83aGeWBBEn45qmiPhezI2B8cFg2pz0AlRT0bKlqXr6BY=
X-Received: by 2002:a05:6870:b69a:b0:1fb:9b:3d4c with SMTP id
 cy26-20020a056870b69a00b001fb009b3d4cmr2806323oab.0.1701892529801; Wed, 06
 Dec 2023 11:55:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123121433.12089-1-sumitg@nvidia.com> <ZV9bGtUsjF1v1oIW@bogus>
 <6ccd1598-3c8b-1290-9494-01a3cdbb3003@huawei.com>
In-Reply-To: <6ccd1598-3c8b-1290-9494-01a3cdbb3003@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 20:55:19 +0100
Message-ID: <CAJZ5v0jT=xhTcAHKUMPJR2VbpFNLm1aX-CrcB70Man+VbQX-yQ@mail.gmail.com>
Subject: Re: [Patch v7] ACPI: processor: reduce CPUFREQ thermal reduction pctg
 for Tegra241
To: Hanjun Guo <guohanjun@huawei.com>, Sumit Gupta <sumitg@nvidia.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, rafael@kernel.org, rui.zhang@intel.com, 
	lenb@kernel.org, lpieralisi@kernel.org, linux-acpi@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, treding@nvidia.com, 
	jonathanh@nvidia.com, bbasu@nvidia.com, sanjayc@nvidia.com, 
	ksitaraman@nvidia.com, srikars@nvidia.com, jbrasen@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 3:32=E2=80=AFPM Hanjun Guo <guohanjun@huawei.com> w=
rote:
>
> On 2023/11/23 22:00, Sudeep Holla wrote:
> > On Thu, Nov 23, 2023 at 05:44:33PM +0530, Sumit Gupta wrote:
> >> From: Srikar Srimath Tirumala <srikars@nvidia.com>
> >>
> >> Current implementation of processor_thermal performs software throttli=
ng
> >> in fixed steps of "20%" which can be too coarse for some platforms.
> >> We observed some performance gain after reducing the throttle percenta=
ge.
> >> Change the CPUFREQ thermal reduction percentage and maximum thermal st=
eps
> >> to be configurable. Also, update the default values of both for Nvidia
> >> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "=
5%"
> >> and accordingly the maximum number of thermal steps are increased as t=
hey
> >> are derived from the reduction percentage.
> >>
> >> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> >> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
> >> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >> ---
> >>
> >> Sending this patch separately as the other patch in the series is
> >> applied by Rafael in v6[1]. Revision history before this version is
> >> in the cover letter of v6[1].
> >>
> >> Please review and provide ACK if looks fine.
> >>
> >
> > For arm64 specific changes(a minor nit below though),
> >
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Applied as 6.8 material, thanks!

