Return-Path: <linux-acpi+bounces-17121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B303EB871CB
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 23:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF4C7C144A
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0C92EC09C;
	Thu, 18 Sep 2025 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD7PB1mr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7272820DB
	for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230589; cv=none; b=bZIFTub4PPvEHjo0YwkIU6OPKTC0xQ+91AWVRTF51NhnFJZ87OVGbo6X7CVALVfky0DdiibGNjbG9kh3hc7xjoC5ykitySI2YXQs59gHbQ+RRqLSqRfF2+TvookUJeNaqb7sKUQko/BdKkXtmKrS0C70Q79Hs42seHZ2/Ns4D3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230589; c=relaxed/simple;
	bh=VbZkG/v70rqi7z7N1pTVa6zRe4mCzIPmWrbfM/43Ga8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L24osg8EEfnXFJDgHliEz3hSHTMxl5WOidvWvh/EUWmKx3iqXY3rgE9jTb55RzAVQ7m4Xl3kEgJuLZLw0RIjP4TpMwDmQCTt3zSlht0Iul+tNIYWmS0xslKHV0bLGoWMQnpD5AuwMk0wZc0jSC8lz/yTjSpUvK7MOtQZWwJYTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD7PB1mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87878C4CEF1
	for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 21:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758230589;
	bh=VbZkG/v70rqi7z7N1pTVa6zRe4mCzIPmWrbfM/43Ga8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kD7PB1mrg7Lj9Q/x6Ti3nSbl5JpNit+fFaNf0iUUnADKMg8mg1NpPZiNkYTwacwpM
	 pnZhkZfSppkG0+B+cZ/MDVGpurtzHl+G+5QziXg9jHB2EKf1dMUs8VJX6VPgsDtSGo
	 Im6rpb72KFYtVC8tgP/FvJ5DEFAuGCiKlmGrP9jHj3fMSOueHIDPcHayX03QutHP5A
	 jJIER18oVP4EgGGv2ii6BUHZ9+7NYJR2AirmfuGO6zqq2JoT+7p2gGJny2j20ZQsau
	 ghlpBjFXfTHvh5ty0lvkh7w02rq0T31hHEW9tcx97JANcvZ6+3n20Q1zYWVmi4eicG
	 RekwjXjiHp1AQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-621cecfcc04so752729eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 14:23:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnjkiUSUTMrNVjFp0RI1HYwSexVa1NkxygXMPzZT7rkSFbknykoKn7hiQ2PNTfJGIHfcSpUPvxEkf4@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkoU17VB/J3zyTlQNhMrzwG42g/bwNAAJLZqrdfQVII8FkdLR
	fJytaBrGsBb8OxwLOGeEbyIDbttET8rCbQqZqCBRblgVHbRMBmInuhNDsXZVFEYd/DTVSBSUYCR
	/W48G5OWw29w8giutG2QXbV82hBimlD4=
X-Google-Smtp-Source: AGHT+IHGQ2i97wKX3gGqiDAvr3Z/2v5iTYlX3GIRgXjB46LU8qnsydsr7tA4O+HPeCIBF3QAZ1x9ll/9mdEUb463CA0=
X-Received: by 2002:a05:6808:1803:b0:438:3b96:7cf9 with SMTP id
 5614622812f47-43d6c178dc6mr407863b6e.15.1758230588842; Thu, 18 Sep 2025
 14:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911112408.1668431-1-lihuisong@huawei.com>
 <20250911112408.1668431-4-lihuisong@huawei.com> <CAJZ5v0hb19Xy8dOP4itU-F5F7OjDXBVNGYiwoxAVc_yGuUv=Aw@mail.gmail.com>
 <1e55d104-9746-4b37-8663-12714cc00026@huawei.com>
In-Reply-To: <1e55d104-9746-4b37-8663-12714cc00026@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Sep 2025 23:22:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAYpBWTpfJV6ZVX0tLiZZ-S5ABxpmqckxYcPyMyZrJfA@mail.gmail.com>
X-Gm-Features: AS18NWCxfAR6ZAMzg47DHou5V_ImLvRX3FXur0VvcmlaJgffPfwtobWxuLqYeJk
Message-ID: <CAJZ5v0hAYpBWTpfJV6ZVX0tLiZZ-S5ABxpmqckxYcPyMyZrJfA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ACPI: processor: Do not expose the global
 acpi_idle_driver variable
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:23=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2025/9/18 4:01, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Thu, Sep 11, 2025 at 1:24=E2=80=AFPM Huisong Li <lihuisong@huawei.co=
m> wrote:
> >> Currently, processor_driver just use the global acpi_idle_driver varia=
ble
> >> to check if the cpuidle driver is acpi_idle_driver. Actually, there is=
 no
> >> need to expose this global variable defined in processor_idle.c to out=
side.
> >> So move the related logical to acpi_processor_power_init() and do not
> >> expose it.
> > And it can also be made static, can't it?
> ok, will do it in next version. Thanks.

You may as well rebase it on top of this one:

https://lore.kernel.org/linux-acpi/5044465.31r3eYUQgx@rafael.j.wysocki/

