Return-Path: <linux-acpi+bounces-18243-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DC0C0D9E7
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 13:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3AE4075D6
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD27C30E0CC;
	Mon, 27 Oct 2025 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS+n4OHs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835A301482
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568330; cv=none; b=hkCgJ+FhBJEym2k+7fiHAtzf5soSnaZ8SywFuPKXc1afx4Ap73IXxau2/iIDzUzHMTUkXKjD/SFQgrLwvvutiCDS3TJpX8usZlDn+cxwnMVLs6Qns3aSqopA12S0G3OmpC+AF3TopnEJSgrHOrhF8jMz0D1lTdb3UnRsujvb3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568330; c=relaxed/simple;
	bh=mDmD9CyR6cMWJ9wS3uq/s4uHP1OgDr+hdB3ljCkI/J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfESxtM/vPDCReVeHACpsMCnKaqMeC78KQTtWS3iqu6QG7rQ9OYHkCdQRPaaG3VPzOtJE/vKiUoEB7sAJS/1ceQC+55yt1Mp3Odtmg1jTj36qnj+/8O96mXW+Uz3ct17kevxuqQ9nklorjyGJIThbRumikkEq7q6IpqE+VTjHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS+n4OHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B248C116D0
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761568330;
	bh=mDmD9CyR6cMWJ9wS3uq/s4uHP1OgDr+hdB3ljCkI/J0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mS+n4OHsY/koiEJZ6cXNqN8ZJ/8VLKwJTvRvXqYS3ehXKti7XNu87rF5tmXJrikX6
	 KMRu7dwXdMBivAIkZ98Q14qX8D5ugbyK7dhvv+2EsMD+CmTd1P8UMN/xlQmSgiQg+a
	 y1bwRnmFvv3jBJgRjLlcMH6VV2fmMEr8Eakeok0HmAawUdkSv/gHn/xemb8T2IobMF
	 v6noBoq/rUVf5cE6FdtzMNpehzcCzXjLyj2Gp6V/nmeGDHEQKgwQlUvLCSAgx4Mwhb
	 XmO3e0ZPhZg68fRosPxHxF1ym++FmKWhLQYDJinDKwYPAz2wpmbH3ZoMY9rvwr3L4E
	 lI8AL9ItsqbFg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-654ec484418so1316816eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 05:32:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcg7JA2VWSRgeos3ftqZerBTAQCXKzD+0/QaLbyYGPGJOVhc1e4ran32qOppMObcZQKLK+YZFhMHjH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IKd3etQkUx9Btt/yelJnHV30qtC1oP7/D/JDD9rQ+6bqe3RI
	RChpdpOlKP8LTjNg29CX/gEpU3a31koIexAPa5NP+eBHsKZ3PFbsgk1pBn9BWSerCZDQjIxEc0N
	MhN30cgXHIoykV+6LO80C3UcoJypGL2Q=
X-Google-Smtp-Source: AGHT+IHd5RaOJ3DgUP90oI6gskusfu44eQQJeR5EvaYbEK9GuWZfbmgNKQSei4l959bhPObKTY9cxpmTqEf9k113vuk=
X-Received: by 2002:a05:6820:190a:b0:651:df15:8c61 with SMTP id
 006d021491bc7-651df159006mr11843730eaf.2.1761568329535; Mon, 27 Oct 2025
 05:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-7-lihuisong@huawei.com> <CAJZ5v0jBqPLjK2v7A-8Qd6ERhwz47jP3YCiTHJhD8vAgRHVjcQ@mail.gmail.com>
 <e1d440bd-23c0-434c-a771-5c0907c5d3ab@huawei.com> <CAJZ5v0h64UoWY=Zkpc4g2UH+ii8K6APDSV2qLp==yHuRQz+fsQ@mail.gmail.com>
 <dfd9a4a0-f74a-4359-b028-e8e3276769fd@huawei.com>
In-Reply-To: <dfd9a4a0-f74a-4359-b028-e8e3276769fd@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 13:31:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_7Q21LFpcquH-6aYGkC5rHP836Kv9QyczfsCNvfuC9Q@mail.gmail.com>
X-Gm-Features: AWmQ_bni0Y7gSbMInMg4FTy4o6bzMn_s9JUKWmtn_D4z3OatgyB3BaWQ_841aek
Message-ID: <CAJZ5v0j_7Q21LFpcquH-6aYGkC5rHP836Kv9QyczfsCNvfuC9Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] ACPI: processor: idle: Do not change power states
 if get power info failed
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:01=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2025/10/26 20:34, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Fri, Oct 24, 2025 at 11:10=E2=80=AFAM lihuisong (C) <lihuisong@huawe=
i.com> wrote:
> >>
> >> =E5=9C=A8 2025/10/22 3:49, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>> On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei=
.com> wrote:
> >>>> Driver will update power states when processor power states have bee=
n
> >>>> changed. To prevent any other abnormal issues, here add the verifica=
tion
> >>>> for the result of getting power information, don't change power stat=
es
> >>>> and one error log when get power information failed.
> >>> But the old states may not be usable any more in that case.
> >> Yes
> >>> If you want to check the acpi_processor_get_power_info(), it should
> >>> disable ACPi idle entirely on failures.
> >>   From the modification of this patch, this cpuidle device will be
> >> disabled if the acpi_processor_get_power_info(=EF=BC=89fails to get on=
 this device.
> >> And the cpuidle of the device will be disabled according to the
> >> definition of cpuidle_not_available().
> >> We should not call disable_cpuidle() to disable cpuidle of all CPUs.
> > Since the same idle state data is used for all CPUs, I'd say cpuidle
> Yes.
>  From the current implementation perspective, the idle state is
> initialized by the first available CPU.
> If there is one CPU get power management information failed later, the
> ACPI idle driver doesn't disable cpuidle of all CPUs and
> just doesn't register cpudile_device and enable cpuidle_device.
> > should be disabled for all of them in that case.
> I can understand this. I think it is reasonable.
> What do you think how to disable cpuidle of all CPUs here?
> How about call disable_cpuidle() and disable all cpuidle devices?
> >
> > Alternatively, check if it works for any of them and apply the data
> > from the CPU where it works to all of them.  If it doesn't work for
> > any of them, there's nothing to apply.
>
> How should we check if the idle states can work to all of CPUs?

I mean if there is a CPU with a valid list of idle states, that list
can be used for all of the other CPUs.

