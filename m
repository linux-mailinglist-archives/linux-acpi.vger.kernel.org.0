Return-Path: <linux-acpi+bounces-18225-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AFBC0A745
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 13:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4E73AF00C
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9D2D9784;
	Sun, 26 Oct 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9a3wtPg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DD1DFCE
	for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482164; cv=none; b=WZloQlg7trxjiICb8tYzsbKKx6Ze7Gb9gqdnuUVJWBAN2XeUUaIKRkgHIaTrKaNIhG0P3dy+lJ3GGwu/oMvxmEq3e/px2WYMSxaW6RlYJ6VRsBbSuAdh0IuSnRrXGdg/54qeguzC2baERrxn9d+2w8nIApoNWbV+iPEoJ2+Xk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482164; c=relaxed/simple;
	bh=nNyhb3twy27BmGNthU5zy6KxlGrVekyWkJIA+zPIdVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7wKPVsoCK5yOtWIkUC67Sb4otN5p06NSFVFlSMZvg98ux4c0rmWd2NTbUdsyC7nH01tIvgvlEJSArCo9EeRmeM1ozKUQL9zuV0UXo0sN518R1gPC6eiJrGNPvgn1kP376XxqI/jY+lLY2WZMgGyXVTnilH3dVLgUYbP2UhkEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9a3wtPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE556C16AAE
	for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 12:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761482163;
	bh=nNyhb3twy27BmGNthU5zy6KxlGrVekyWkJIA+zPIdVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W9a3wtPgksrMCJiew0IRIHonN9dKDhc1dtECCdAJC1MD9NuAc3tIVUfDf54QZ/TZX
	 FKx+TRUpuIaBq8t2r6XWbQJQGSy9JrDe+10ecMpGi4tRpDmQHnyiSIPXa3qTn6Npxk
	 83kWQHNqxortJbW+aBfBdb9dxbt260y2S1g2TSw+JjHsSxLz6EuiNm/OdlcnDpsWsM
	 AJeuP03MVmgR+5jbDI+Q6BKVVYJvFCzwniGBzDytNUMLA/WWJ3FfqRRLnqZsD8j8U2
	 ZovcLpOS7G8lYoKadB0mpX99nKIYRf9zRLgAw2mmuY8sI3IZ62aZ6WAMOGpxF2UfGb
	 Emh1BkXQdWJRg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-654e25cc7d7so930170eaf.1
        for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 05:36:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJWj2rh4DHrRnh/utaIWaKTUPESrXIc+zAMZpon0lmchOLTFQP/FNT4NK57v4KjCE1tHUagGLu8auu@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgLRpGGC0Iu/DNTie4FNcgYl3KcN4t9cDHJO3JCVZWirXLR5b
	TcMlmxULSGrcZbxI90DHUzwZlVbSQf46DAw80wtXUOl321Q5aPCsVm29+pFm9v2HsBqoKK3fCob
	aA7IUf28y+ASkuRolcpSgTmhZFQbT2pA=
X-Google-Smtp-Source: AGHT+IGEYt7bmKDoEOnvnRFPgQ2ytPnAMlF0hK2Ah5RJ5EHcqtF0vC11phTUzK2NVa0DswTiL8lRVmmd2uBP8yDwHRs=
X-Received: by 2002:a05:6808:250b:b0:441:8f74:e95 with SMTP id
 5614622812f47-443a31757c6mr14561414b6e.63.1761482163037; Sun, 26 Oct 2025
 05:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-3-lihuisong@huawei.com> <CAJZ5v0ikPpwKA4WLvwon3p+e8+53fOQuudOioOr-KD-Ee-E0dA@mail.gmail.com>
 <8c0057a7-24a2-493a-8054-904a89ca9f6d@huawei.com> <CAJZ5v0jg5RGi-+i3LtwK6U8m+_C5Rs4OuRTBLTGi6g0aRq3LBQ@mail.gmail.com>
 <a577bfd3-a4b8-4d06-b95b-a78b2916b8a4@huawei.com>
In-Reply-To: <a577bfd3-a4b8-4d06-b95b-a78b2916b8a4@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 26 Oct 2025 13:35:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jyOM-DMAGi5MxdDxjZsgFWeSL_dqiZx3imAPShMyeoNQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl-ihU7D-Ks66qjjUi0zDtQsAsDtpAkVIY9dYWOo1ajrcDaXqyB0IvR2T4
Message-ID: <CAJZ5v0jyOM-DMAGi5MxdDxjZsgFWeSL_dqiZx3imAPShMyeoNQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] ACPI: processor: idle: Return failure if entry
 method is not buffer or integer type
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:25=E2=80=AFAM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> =E5=9C=A8 2025/10/23 18:07, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Thu, Oct 23, 2025 at 11:25=E2=80=AFAM lihuisong (C) <lihuisong@huawe=
i.com> wrote:
> >>
> >> =E5=9C=A8 2025/10/22 3:34, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>> On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei=
.com> wrote:
> >>>> According to ACPI spec, entry method in LPI sub-package must be buff=
er
> >>>> or integer. However, acpi_processor_evaluate_lpi() regeards it as su=
ccess
> >>>> and treat it as an effective LPI state.
> >>> Is that the case?  AFAICS, it just gets to the next state in this cas=
e
> >>> and what's wrong with that?
> >> The flatten_lpi_states() would consider the state with illegal entry
> >> method sub-package as a valid one
> >> if the flag of this state is enabled(ACPI_LPI_STATE_FLAGS_ENABLED is s=
et).
> >> And then cpuidle governor would use it because the caller of
> >> acpi_processor_ffh_lpi_probe() also don't see the return value.
> > So the problem appears to be that lpi_state increments in every step
> > of the loop, but it should only increment if the given state is valid.
> Yes,
> So set the flag of the state with illegal entry method sub-package to
> zero so that this invalid LPI state will be skiped in
> flatten_lpi_states(), ok?

Sounds reasonable.

