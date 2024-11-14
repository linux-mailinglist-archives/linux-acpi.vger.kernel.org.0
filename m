Return-Path: <linux-acpi+bounces-9587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DA9C895F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 13:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3F5B24B2F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 11:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC031F942E;
	Thu, 14 Nov 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enNXKEXn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9618C02F;
	Thu, 14 Nov 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585203; cv=none; b=ivX5TPQCvlKZ6VelZrioYfixjEu4154lKUSyOQKP6iTHi803AqqwXSWspnASEFtAKk5sSYf2xbpwBmGWmf/ghYl0skl/fVUdEtIsPMLvzgRFbRK/XtbdAM+FR8yN5N8KdDNJQcUK9c6h2IVh4z9mRWP2E3tngbVp/i3pmVHSfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585203; c=relaxed/simple;
	bh=qWwLPG9pXebEcq9tL/Q4X0ev8VL4ucNNaG+Wtthac/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/TOVEQ0Bo8iBkI1voUGGUV1eNspOtehFPBDNfxrwcj47gQGmzGFs4irhr6q5MHcHxFWJF1a4MathuHZ8xMeFlIOhkyJxvM4lyJRuxyT8w+OXkhdm9E1gfskVfbrbDh8CtJP2o94VwqRgIssz9bkeDEdmIU8u7yMh6PfvW65284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enNXKEXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F88C4CECF;
	Thu, 14 Nov 2024 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731585203;
	bh=qWwLPG9pXebEcq9tL/Q4X0ev8VL4ucNNaG+Wtthac/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=enNXKEXnshCqWXN0Xla+Sw+GL5l1yHlsoeH+hvs4L+LexbsGwD/6/W/4h8sMV/Fxb
	 RS2doPmpwErU4a13fzxt/vAwm7W9VZbiqu7M16y0ibqxBVBRoV69PGJk9INQdsi9YE
	 J8MGHRoX6qyJnTmeiZ/Tz5ppsANEvwzrBitaPZEcbayY2/h22HVJDLuWxp8BbMvVEV
	 wN5qKM3IWKB3KsLO+OZhYj735+6K56ogzI0eGvTkGOtdYz5hdI22IzHZc3RcpYDiE+
	 b/m1QVBHeHLuuRgTDbkNv4tArdfatrfXQ6TBbQoUPMnMozXFtRc5WA1Ndi4d/g4GCN
	 MghhfQcKgsFbg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e60825aa26so274355b6e.1;
        Thu, 14 Nov 2024 03:53:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUQPlyal33YMATM3Wqw4a7W36cdSOe38iYN9u3GlWQD2cvJ/VscSHKqI5iI8RwxHUWGT38zQW90ulr@vger.kernel.org, AJvYcCVKsgy+YQ1qOIKPNZR/fq+BjLfD6kaYoI8NlteF2+195hayWptsUBiroPO2TKY+SqpLF7QzdyS6DCk=@vger.kernel.org, AJvYcCVXYO6reFihL0FT0mq4Oj2/3o0hCuxKTq7QTWWfK9b2WL0maq6jqnXUI/k/LwomusKIpOJwTM1A787bneAX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eo0Pt5KXCIz0dh/vI8K4MiL/yWlQ1iefKtC0ko+ETpvhaMoB
	PKXpTPRi+Fg7NVFvwk/1U7+jCnRDKEi8HLHIuOuNevnFEcccY0h1JGQh9e6G7q7ANnjIIZYooAY
	rG9dmw1RCPd+Bd+uf+8D0aIxGHnU=
X-Google-Smtp-Source: AGHT+IFOKemSYfIbHZMXT8axUFu7GFjMcBgeKWROVECStLV3WuW+o26FNb92jmlQlKV53KLkdGaiK4uK9urnmYdkdls=
X-Received: by 2002:a05:6870:2045:b0:287:7695:6a87 with SMTP id
 586e51a60fabf-296102eb51dmr1939674fac.10.1731585202370; Thu, 14 Nov 2024
 03:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113085634.7657-1-lihuisong@huawei.com> <CAJZ5v0jTMg=Wipt2VPU1DDnnO7Rh5pu0VYvUjHRW5Nada--O8A@mail.gmail.com>
 <52539572-6128-8c87-84e6-3f539d887b34@huawei.com>
In-Reply-To: <52539572-6128-8c87-84e6-3f539d887b34@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Nov 2024 12:53:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0heL_wa=bimMDijn-x6G0SxsMf=yGhKZAe282P5+h2O3w@mail.gmail.com>
Message-ID: <CAJZ5v0heL_wa=bimMDijn-x6G0SxsMf=yGhKZAe282P5+h2O3w@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: thermal: Support for linking devices associated
 with the thermal zone
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rui.zhang@intel.com, liuyonglong@huawei.com, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 14, 2024 at 9:37=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
> Hi Rafael,
>
> =E5=9C=A8 2024/11/13 17:26, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Wed, Nov 13, 2024 at 10:07=E2=80=AFAM Huisong Li <lihuisong@huawei.c=
om> wrote:
> >> There are many 'cdevX' files which link cooling devices under
> >> '/sys/class/thermal/thermal_zoneX/'. These devices contain active cool=
ing
> >> devices and passive cooling devices. And user cann't directly know whi=
ch
> >> devices temperature is represented by the thermal zone.
> >>
> >> However, ACPI spec provides a '_TZD' object which evaluates to a packa=
ge
> >> of device names. Each name corresponds to a device in the ACPI namespa=
ce
> >> that is associated with the thermal zone. The temperature reported by =
the
> >> thermal zone is roughly correspondent to that of each of the devices.
> >>
> >> User can get all devices a thermal zone measured by the 'measures'
> >> directory under the thermal zone device.
> > Well, that's kind of clear, but what exactly is the use case?  Why
> > does the user need to know that?
> IMO, this makes thermal zone information more friendly.
> For instance, user can directly know the temperature of CPUs or other
> devices is roughly represented by which thermal zone.
> This may offer the convenience for further usersapce application.
>
> BTW, the '_TZD' method is similar to the '_PMD' in acpi power meter.
> Since ACPI spec provides them, they should also have a role in their
> existence.

So there is no specific use case, but it is possible that somebody may
want to use this information, IIUC.

Well, let's defer making kernel changes until there is a user
wanting/needing this information.  Then we'll decide how to expose it.

For one, I'm not convinced that exposing it under the ACPI
representation of a thermal zone is going to be really useful.

